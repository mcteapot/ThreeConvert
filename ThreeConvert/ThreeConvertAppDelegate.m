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

@synthesize window = _window;
@synthesize theConverter = _theConverter;

// Lady instansation of our modle
- (ThreeConvertModle *)theConverter {
    if (!_theConverter) {
        _theConverter = [[ThreeConvertModle alloc] init];
    }
    return _theConverter;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)linkScript:(id)sender {
    int i; // Loop counter.
    
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:YES];
    
    // Enable the selection of directories in the dialog.
    [openDlg setCanChooseDirectories:YES];
    
    // Display the dialog.  If the OK button was pressed,
    // process the files.
    if ( [openDlg runModalForDirectory:nil file:nil] == NSOKButton )
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        //filePath = [[zOpenPanel URL] retain]
        NSArray* files = [openDlg filenames];
        
        // Loop through all the files and process them.
        for( i = 0; i < [files count]; i++ )
        {
            NSString* fileName = [files objectAtIndex:i];
            
            // Do something with the filename.
        }
    }
}
@end
