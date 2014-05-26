//
//  NewsPageViewController.h
//  Policy
//
//  Created by Thor Lin on 2014/5/23.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "News.h"
#import "Post.h"

@interface NewsPageViewController : UIPageViewController<UIPageViewControllerDataSource>

@property (nonatomic,strong)UIPageViewController *pageViewController;
@property (nonatomic,strong)NSMutableArray * Images;
@property (nonatomic,strong)NSMutableArray * Labels;
@property (nonatomic,strong)NSMutableArray * Texts;
@property NSMutableDictionary *dic;
@property NSMutableArray *NewsSourceArray;
@end
