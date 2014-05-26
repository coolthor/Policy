//
//  EventTableViewCell.h
//  Policy
//
//  Created by Thor Lin on 2014/5/23.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@class EventTableViewCell;

@protocol EventTableViewCellDelegate<NSObject>
-(void)EventTableViewCellDelegateDidClickAddEventButton:(EventTableViewCell *)viewController;

-(void)EventTableViewCellDelegateDidClickDelEventButton:(EventTableViewCell *)viewController;
@end

@interface EventTableViewCell : UITableViewCell

@property (nonatomic,weak) id<EventTableViewCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIButton *DeleteEvent;

@property (strong, nonatomic) IBOutlet UIButton *AddEvent;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *start;
@property (strong, nonatomic) IBOutlet UILabel *End;
- (IBAction)AddEventToCalendar:(id)sender;
- (IBAction)DeleteEventFromCalendar:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *QuestIcon;
@property Event * event;
@end
