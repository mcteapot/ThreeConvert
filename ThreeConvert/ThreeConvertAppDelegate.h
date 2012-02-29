//
//  ThreeConvertAppDelegate.h
//  ThreeConvert
//
//  Created by arjun prakash on 2/10/12.
//  Copyright (c) 2012 CyborgDino. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ThreeConvertAppDelegate : NSObject <NSApplicationDelegate>



@property (assign) IBOutlet NSWindow *window;

- (IBAction)linkScript:(id)sender;
- (IBAction)setFileType:(id)sender;
- (IBAction)setOutputFolder:(id)sender;
- (IBAction)setFilesForConversion:(id)sender;
- (IBAction)convertFiles:(id)sender;





@property (weak) IBOutlet NSTextField *scriptTextLabel;
@property (weak) IBOutlet NSTextField *outputTextLabel;
@property (weak) IBOutlet NSTableView *theTable;
@property (weak) IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet NSButton *convertButton;

@end
