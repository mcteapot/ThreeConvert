//
//  ThreeConvertModle.h
//  ThreeConvert
//
//  Created by arjun prakash on 2/10/12.
//  Copyright (c) 2012 CyborgDino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreeConvertModle : NSObject

//CHANGE NSString TO NSURL!!!!
@property (strong, nonatomic) NSURL *fbxScriptLocation;
@property (strong, nonatomic) NSURL *objScriptLocation;
@property (strong, nonatomic) NSURL *outputFolderLocation;
@property (strong, nonatomic) NSArray *filesForConversion;
@property  NSInteger fileType;

- (void)clearFileArray;


- (BOOL)convertFbxFiles;

- (BOOL)convertObjFiles;

- (NSString*)jsPath:(NSURL*) aURL;

@end
