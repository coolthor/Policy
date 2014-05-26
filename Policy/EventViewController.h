//
//  EventViewController.h
//  Policy
//
//  Created by Thor Lin on 2014/5/23.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventTableViewCell.h"
#import <EventKit/EventKit.h>

@interface EventViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,EventTableViewCellDelegate>
@property NSMutableArray *Events;
@property NSMutableDictionary * dic;
@property EKEventStore *eventStore;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property EventTableViewCell * selectedCell;
@end
