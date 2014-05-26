//
//  EventTableViewCell.m
//  Policy
//
//  Created by Thor Lin on 2014/5/23.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "EventTableViewCell.h"

@implementation EventTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)AddEventToCalendar:(id)sender {
    if ( self .delegate && [ self .delegate respondsToSelector: @selector (EventTableViewCellDelegateDidClickAddEventButton:)]){
        [ self .delegate EventTableViewCellDelegateDidClickAddEventButton: self ];
    }
}
@end
