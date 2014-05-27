//
//  UserViewController.h
//  citizenship_event
//
//  Created by Thor Lin on 2014/5/26.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface UserViewController : UIViewController<FBLoginViewDelegate>
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
//@property (strong,nonatomic) FBProfilePictureView * profilePictureView;
//@property (strong,nonatomic) UILabel *namLabel;
//@property (strong,nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet FBLoginView *loginView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end
