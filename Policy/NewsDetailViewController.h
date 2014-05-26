//
//  NewsDetailViewController.h
//  Policy
//
//  Created by Thor Lin on 2014/5/20.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "NewDetailTableViewCell.h"

@class NewsDetailViewController;

@protocol NewsDetailViewControllerDelegate<NSObject>
-(void)NewsDetailViewControllerDidClickDismissButton:(NewsDetailViewController *)viewController;

@end

@interface NewsDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,weak) id<NewsDetailViewControllerDelegate> delegate;

@property NSMutableArray * posts;
@property NSString * myTitle;
- (IBAction)DismissClick:(id)sender;

@end
