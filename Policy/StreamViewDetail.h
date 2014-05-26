//
//  StreamViewDetail.h
//  Policy
//
//  Created by Thor Lin on 2014/5/18.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreamViewDetail : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
- (IBAction)pressForBack:(id)sender;
@property NSString * url;
@end
