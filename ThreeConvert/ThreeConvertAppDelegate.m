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

@end


@implementation ThreeConvertAppDelegate
@synthesize theTable = _theTable;
@synthesize arrayController = _arrayController;
@synthesize linkScriptText = _linkScriptText;

@synthesize window = _window;
@synthesize theConverter = _theConverter;

// Lazy instansation of our modle
- (ThreeConvertModle *)theConverter {
    if (!_theConverter) {
        _theConverter = [[ThreeConvertModle alloc] init];
    }
    return _theConverter;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.theConverter.fileType = 0;
    [self.theTable setAllowsColumnSelection:NO];
    [self.theTable setAllowsColumnReordering:NO];
    [self.theTable setAllowsMultipleSelection:NO];
    [self.theTable setEnabled:NO];
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
    // process the files.
    if ( [openDlg runModal] == NSOKButton )
    {
        self.theConverter.fbxScriptLocation = [[openDlg URL] path];
        NSLog(@"%@", self.theConverter.fbxScriptLocation);
        
    }
}

// UI Checks the segmented controller
- (IBAction)setFileType:(id)sender {
    
    // Clears the array of files to convert
    [self.theConverter clearFileArray];
    
    // Sets the file type with a (int)NSInteger
    self.theConverter.fileType = [sender selectedSegment];
    NSLog(@"%d", self.theConverter.fileType);

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
    // process the files.
    if ( [openDlg runModal] == NSOKButton )
    {
        self.theConverter.outputFolderLocation = [[openDlg URL] path];
        NSLog(@"%@", self.theConverter.outputFolderLocation);
        
    }
    
    
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
    if ( [openDlg runModal] == NSOKButton )
    {
        NSArray *files = [openDlg URLs];

        if (files) {
            self.theConverter.filesForConversion = files;
        }
        NSLog(@"New arry \n %@",files);
        NSLog(@"Old arry \n %@",self.theConverter.filesForConversion);
        
  
    }
    [self populateTable];
    
}

// UIButton to clear all selected files
- (IBAction)clearFiles:(id)sender {
    
    // Clears the array of files to convert
    [self.theConverter clearFileArray];
    
    NSLog(@"File arry \n %@",self.theConverter.filesForConversion);
    
    [self clearTable];
}

- (IBAction)convertFiles:(id)sender {
}

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

- (void)clearTable {
    
    [[self.arrayController content] removeAllObjects];
    [self.theTable reloadData];
    [self.theTable deselectAll:nil];
}

@end
