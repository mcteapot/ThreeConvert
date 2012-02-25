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
    task.launchPath = @"/usr/bin/python"; 
    
    // Set argumetn array for commands and arguments
    NSArray *arguments;
    NSString *pyScript = [NSString stringWithFormat:@"/Users/archieoi/Work/Testing/obj/convert_obj_three.py"];
    NSString *pyInputFlag = [NSString stringWithFormat:@"-i"];
    NSString *pyInputLocation = [NSString stringWithFormat:@"/Users/archieoi/Work/Testing/convert/ship01.obj"]; 
    NSString *pyOutputFlag = [NSString stringWithFormat:@"-o"]; 
    NSString *pyOutputLocation = [NSString stringWithFormat:@"/Users/archieoi/Work/Testing/convert/output/ship01.js"]; 

    //NSLog(@"shell script: %@ %@", pyScript, pyInputFlag);
    
    arguments = [NSArray arrayWithObjects:pyScript, pyInputFlag, pyInputLocation, pyOutputFlag, pyOutputLocation, nil];
    task.arguments = arguments;
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
    
    int i;

    for (i = 0; i < [self.filesForConversion count]; i++) {

        // Set directory to run command
        NSTask *task;
        task = [[NSTask alloc] init];
        task.launchPath = @"/usr/bin/python"; 
        
        // Set argumetn array for commands and arguments
        NSArray *arguments;
        NSLog(@"Script Path: %@", [self.objScriptLocation path]);
        NSString *pyScript = [NSString stringWithFormat:[self.objScriptLocation path]];
        
        NSString *pyInputFlag = [NSString stringWithFormat:@"-i"];
        NSLog(@"Obj Path: %@", [[self.filesForConversion objectAtIndex:i] path]);
        NSString *pyInputLocation = [NSString stringWithString:[[self.filesForConversion objectAtIndex:i] path]];
        
        NSString *pyOutputFlag = [NSString stringWithFormat:@"-o"];
        NSLog(@"Output Path: %@", [self jsPath:[self.filesForConversion objectAtIndex:i]]);
        NSString *pyOutputLocation = [self jsPath:[self.filesForConversion objectAtIndex:i]]; 
        
        //NSLog(@"shell script: %@ %@", pyScript, pyInputFlag);
        
        arguments = [NSArray arrayWithObjects:pyScript, pyInputFlag, pyInputLocation, pyOutputFlag, pyOutputLocation, nil];
        task.arguments = arguments;
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
        
    }

 
    
    return YES;
}

- (NSString*)jsPath:(NSURL*) aURL {
    
    NSString *convertFile = [aURL lastPathComponent];
    
    NSRange range;
    // Starting from the first character
    range.location = 0;
    // Excluding the last 4 characters or depended on the lenth of entention
    range.length = convertFile.length - 4;
    
    // Creat new string with .js entetnion
    NSString *jsFile = [NSString stringWithFormat:@"%@.js", [convertFile substringWithRange:range]];
    
    // Creat new string with file output and .js file
    NSString *jsOutputPath = [NSString stringWithFormat:@"%@/%@", [self.outputFolderLocation path], jsFile];
    //NSLog(@"OUT Path: %@", jsOutputPath);

    return jsOutputPath;
}

@end
