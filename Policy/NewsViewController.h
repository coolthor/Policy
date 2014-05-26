//
//  NewsViewController.h
//  Policy
//
//  Created by Thor Lin on 2014/5/19.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "Post.h"
#import "NewsTableViewCell.h"
#import "NewsDetailViewController.h"

@interface NewsViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,NewsDetailViewControllerDelegate>
@property NSMutableDictionary * dic;
@property NSMutableArray *array;

@end
