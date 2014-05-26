//
//  NewsTableViewCell.h
//  Policy
//
//  Created by Thor Lin on 2014/5/20.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"


@interface NewsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@property (strong, nonatomic) IBOutlet UITextView *myTextView;
@property UIImage * img;
@property NSTimer * timer;
@property NSMutableArray * Posts;
@end
