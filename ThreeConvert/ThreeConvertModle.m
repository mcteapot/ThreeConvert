//
//  ThreeConvertModle.m
//  ThreeConvert
//
//  Created by arjun prakash on 2/10/12.
//  Copyright (c) 2012 CyborgDino. All rights reserved.
//

#import "ThreeConvertModle.h"

@interface ThreeConvertModle()
//private variables
@end


@implementation ThreeConvertModle

@synthesize fbxScriptLocation;
@synthesize objScriptLocation;
@synthesize outputFolderLocation;
@synthesize filesForConversion;
@synthesize fileType;


// Method to clear files in filesForConversion array
- (void)clearFileArray {
    self.filesForConversion = nil;
}

// Method to convert stored fbx files
- (BOOL)convertFbxFiles {
    
    // Set directory to run command
    NSTask *task;
    task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/grep"; 
    //[task setLaunchPath: @"/Users/archieoi/Documents/Software"];
    
    // Set argumetn array for commands and arguments
    NSArray *arguments;
    NSString *pyScript = [NSString stringWithFormat:@"LIFE"];
    NSString *pyVariables = [NSString stringWithFormat:@"/Users/archieoi/Desktop/openclasses.txt"]; 
    NSLog(@"shell script: %@ %@", pyScript, pyVariables);
    
    arguments = [NSArray arrayWithObjects:pyScript, pyVariables, nil];
    [task setArguments: arguments];
    //The magic line that keeps your log where it belongs
    [task setStandardInput:[NSPipe pipe]];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    NSLog (@"script returned:\n%@", string);    
    
    return YES;
}

// Method to convert stored obj files
- (BOOL)convertObjFiles {
    
    //NSString *scriptPath = [[NSBundle mainBundle] pathForResource: @"your_script" ofType: @"scpt" inDirectory: @"Scripts"];
    //NSAppleScript *theScript = [[NSAppleScript alloc] initWithContentsOfURL: [NSURL fileURLWithPath: scriptPath] error: nil];
    
    
    //NSAppleScript *playScript;
    //playScript = [[NSAppleScript alloc] initWithSource:@"beep 3"];
    //[playScript executeAndReturnError:nil];

    return YES;
}

@end
