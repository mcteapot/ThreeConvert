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
    if (self.theConverter.fileType == 0) {
        NSLog(@"only obj file ones are choosen");
    } else if (self.theConverter.fileType == 1) {
        NSLog(@"only fbx file ones are choosen");
    }
}
@end
