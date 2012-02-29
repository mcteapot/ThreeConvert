//
//  ThreeConvertAppDelegate.m
//  ThreeConvert
//
//  Created by arjun prakash on 2/10/12.
//  Copyright (c) 2012 CyborgDino. All rights reserved.
//

#import "ThreeConvertAppDelegate.h"
#import "ThreeConvertModle.h"


@interface ThreeConvertAppDelegate()

@property (nonatomic, strong) ThreeConvertModle *theConverter;
// Private methods
- (void)populateTable;
- (void)clearTable;
- (void)updateScriptTextLabel;

- (BOOL)checkToConvert;
- (void)fileConvertionCompleteAlert;
- (void)fbxFileAlert;

@end


@implementation ThreeConvertAppDelegate

@synthesize scriptTextLabel = _scriptTextLabel;
@synthesize outputTextLabel = _outputTextLabel;
@synthesize theTable = _theTable;
@synthesize arrayController = _arrayController;
@synthesize convertButton = _convertButton;


@synthesize window = _window;
@synthesize theConverter = _theConverter;

// Lazy instansation of our modle
- (ThreeConvertModle *)theConverter {
    
    if (!_theConverter) {
        _theConverter = [[ThreeConvertModle alloc] init];
    }
    return _theConverter;
}

// First method to run on startup
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.theConverter.fileType = 0;
    
    [self.theTable setAllowsColumnSelection:NO];
    [self.theTable setAllowsColumnReordering:NO];
    [self.theTable setAllowsMultipleSelection:NO];
    [self.theTable setEnabled:NO];
    
    [self checkToConvert];

}


// UIButton to open up files 
- (IBAction)linkScript:(id)sender {
    
    NSArray *fileTypesArray = [NSArray arrayWithObjects:@"py", nil];
    
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection options in the dialog.
    [openDlg setCanChooseFiles:YES];    
    [openDlg setAllowedFileTypes:fileTypesArray];
    
    // Display the dialog.  If the OK button was pressed,
    // Process the files.
    if ( [openDlg runModal] == NSOKButton ) {
        if (self.theConverter.fileType == 0) {
            self.theConverter.objScriptLocation = [openDlg URL];
            NSLog(@"Script is %@", [self.theConverter.objScriptLocation path]);
        } else if (self.theConverter.fileType == 1) {
            self.theConverter.fbxScriptLocation = [openDlg URL];
            NSLog(@"Script is %@", [self.theConverter.fbxScriptLocation path]);
        }
        [self updateScriptTextLabel];
        
    }
    
    [self checkToConvert];
}

// UI Checks the segmented controller
- (IBAction)setFileType:(id)sender {
    
    // Clears the arrays of files to convert
    [self.theConverter clearFileArray];
    
    // Clears the table view        
    [self clearTable];
    
    // Sets the file type with a (int)NSInteger
    self.theConverter.fileType = [sender selectedSegment];
    NSLog(@"%ld", self.theConverter.fileType);
    
    [self updateScriptTextLabel];
    
    [self checkToConvert];

}


// UI Sets folder to putput files
- (IBAction)setOutputFolder:(id)sender {
        
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection options in the dialog.
    [openDlg setCanChooseFiles:NO];
    [openDlg setCanChooseDirectories:YES];
    [openDlg setCanCreateDirectories:YES];
    

    // Display the dialog.  If the OK button was pressed,
    // Process the files.
    if ( [openDlg runModal] == NSOKButton ) {
        self.theConverter.outputFolderLocation = [openDlg URL];
        [self.outputTextLabel setTitleWithMnemonic:[self.theConverter.outputFolderLocation path]];
        
        NSLog(@"%@", [self.theConverter.outputFolderLocation path]);
        
    }
    
    [self checkToConvert];
    
}

// UIButton to choose files for conversion
- (IBAction)setFilesForConversion:(id)sender {
    
    NSArray *fileTypesArray;
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];

    // Enable the selection options in the dialog.
    [openDlg setCanChooseFiles:YES];    

    if (self.theConverter.fileType == 0) {
        fileTypesArray = [NSArray arrayWithObjects:@"obj", nil];
        NSLog(@"only obj file ones are choosen");
    } else if (self.theConverter.fileType == 1) {
        fileTypesArray = [NSArray arrayWithObjects:@"fbx", nil];
        NSLog(@"only fbx file ones are choosen");
    }
    [openDlg setAllowedFileTypes:fileTypesArray];
    [openDlg setAllowsMultipleSelection:TRUE];
    
    // Display the dialog.  If the OK button was pressed,
    // process the files.
    if ( [openDlg runModal] == NSOKButton ) {
        // Clears the arrays of files to convert
        [self.theConverter clearFileArray];
        
        // Clears the table view        
        [self clearTable];
        
        NSArray *files = [openDlg URLs];

        if (files) {
            self.theConverter.filesForConversion = files;
        }
        NSLog(@"New arry \n %@",files);
        NSLog(@"Old arry \n %@",self.theConverter.filesForConversion);
        
    }
    [self populateTable];
    
    [self checkToConvert];
    
}


// UIButton to covert selected files
- (IBAction)convertFiles:(id)sender {
    
    // Create the new files
    if (self.theConverter.fileType == 0) {
        [self.theConverter convertObjFiles];
    } else if (self.theConverter.fileType == 1) {
        [self fbxFileAlert];
        //[self.theConverter convertFbxFiles];
    }
    
    [self fileConvertionCompleteAlert];
    
    // Clears the arrays of files to convert
    [self.theConverter clearFileArray];
    
    // Clears the table view        
    [self clearTable];
    
    
    [self checkToConvert];
    
}


// Method to populate NSTableView with Arry or URLs
- (void)populateTable {
    
    int i;
    for (i = 0; i < [self.theConverter.filesForConversion count]; i++) {
        NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
        
        // Add some values to the dictionary
        // which match up to the NSTableView bindings
        [value setObject:[NSNumber numberWithInt:i] forKey:@"number"];
        [value setObject:[NSString stringWithFormat:@"%@",[[self.theConverter.filesForConversion objectAtIndex:i] path]]
                  forKey:@"file"];
        
        [self.arrayController addObject:value];

    }
    
    [self.theTable reloadData];
    [self.theTable deselectAll:nil];

}


// Method to clear NSTableview
- (void)clearTable {
    
    [[self.arrayController content] removeAllObjects];
    [self.theTable reloadData];
    [self.theTable deselectAll:nil];
}

// Method to script link in NSTextField
- (void)updateScriptTextLabel {

    if (self.theConverter.fileType == 0 && self.theConverter.objScriptLocation) {
        [self.scriptTextLabel setTitleWithMnemonic:[self.theConverter.objScriptLocation path]];
    } else if (self.theConverter.fileType == 1 && self.theConverter.fbxScriptLocation) {
        [self.scriptTextLabel setTitleWithMnemonic:[self.theConverter.fbxScriptLocation path]];
    } else {
        [self.scriptTextLabel setTitleWithMnemonic:@""];
    }
}

// Method to check to set enable state on convert button
- (BOOL)checkToConvert {
    
    if ((self.theConverter.fileType == 0 && self.theConverter.objScriptLocation) || (self.theConverter.fileType == 1 && self.theConverter.fbxScriptLocation)) {
        if (self.theConverter.outputFolderLocation && self.theConverter.filesForConversion) {
             [self.convertButton setEnabled:YES];
            NSLog(@"Convert button YES");
            return YES;
        } else {
            [self.convertButton setEnabled:NO];
            NSLog(@"Convert button NO");
            return NO;
        }
    } else {
        [self.convertButton setEnabled:NO];
        NSLog(@"Convert button NO");
        return NO;
    }
    
    return NO;
}

// Method to alert user of files complted
- (void)fileConvertionCompleteAlert {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Success!"];
    [alert setInformativeText:@"Files were converted."];
    [alert addButtonWithTitle:@"Ok"];
    [alert beginSheetModalForWindow:_window
                      modalDelegate:self
                     didEndSelector:nil
                        contextInfo:nil];
}

// Method to alert user of files complted
- (void)fbxFileAlert {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Fbx Warning!"];
    [alert setInformativeText:@"convert_fbx_three.py script is out of date, so conversion will not work."];
    [alert addButtonWithTitle:@"Lame"];
    [alert beginSheetModalForWindow:_window
                      modalDelegate:self
                     didEndSelector:nil
                        contextInfo:nil];
}

@end
