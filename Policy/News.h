//
//  News.h
//  Policy
//
//  Created by Thor Lin on 2014/5/19.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property NSString * uid;
@property NSString * name;
@property NSString * cover;
@property NSString * about;
@property NSString * picture;
@property NSMutableArray * posts;

@end
