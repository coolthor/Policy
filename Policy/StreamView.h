//
//  StreamView.h
//  Policy
//
//  Created by Thor Lin on 2014/5/18.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"
#import "StreamViewDetail.h"

@interface StreamView : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property NSMutableArray *array;
@property NSMutableDictionary *dic;
@property NSMutableArray *channels;
@property UIProgressView *progress;
@end
