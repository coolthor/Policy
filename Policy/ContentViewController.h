//
//  ContentViewController.h
//  Policy
//
//  Created by Thor Lin on 2014/5/23.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "Post.h"

@interface ContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *BackgroundImage;
@property (strong, nonatomic) IBOutlet UITextView *Text;
@property (strong, nonatomic) IBOutlet UILabel *Label;

@property News * myNews;
@property NSTimer * timer;
@property Post * currentPost;
@property BOOL InitialContented;
@end
