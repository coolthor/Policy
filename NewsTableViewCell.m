//
//  NewsTableViewCell.m
//  Policy
//
//  Created by Thor Lin on 2014/5/20.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(imageMove:) userInfo:nil repeats:YES];
}

-(void)imageMove:(NSTimer *)timer{
  
    int randomValue = arc4random() %4;
    [UIView beginAnimations:@"hide" context:nil];
    switch (randomValue) {
        case 0:
            [self rippleEffect];
            break;
        case 1:
            [self LeftInHide];
            break;
        case 2:
            [self UpOutHide];
            break;
//        case 3:
//            [self suckEffect];
//            break;
        default:
            break;
    }
    if(_myImageView.alpha >0)
        _myImageView.alpha = 0.85;

    [UIView commitAnimations];
    
//    NSLog(@"pic count:%d",_Posts.count);
    Post * p  = _Posts[arc4random()%_Posts.count];
    
    if (![p.picture isEqualToString:@""]) {
        UIImage * myImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:p.picture]]];
        
        _myImageView.image=myImg;
    }
    [UIView beginAnimations:@"textView" context:nil];
    [UIView setAnimationDuration:1];
    _myTextView.backgroundColor = [UIColor colorWithRed:1.000 green:0.995 blue:0.995 alpha:1.000];
    _myTextView.text = p.message;
    _myTextView.font = [UIFont fontWithName:@"Arial" size:12.0f];
    _myTextView.textColor = [UIColor colorWithRed:0.024 green:0.004 blue:0.005 alpha:1.000];
    _myTextView.layer.cornerRadius = 5.0f;
    [UIView commitAnimations];
}

-(void)LeftInHide{
    
    [UIView setAnimationDuration:1];
    CATransition *animation = [CATransition animation];
    animation. duration = 5.0f ;   //時間間隔
    animation. fillMode = kCAFillModeForwards ;
    animation. type = kCATransitionMoveIn ;   //動畫效果
    animation. subtype = kCATransitionFromRight ;   //動畫方向
    [_myImageView.layer addAnimation :animation forKey : @"animation" ];
}

-(void)rippleEffect{
//    [UIView beginAnimations:@"hide" context:nil];
    [UIView setAnimationDuration:1];
    CATransition *animation = [CATransition animation];
    animation.duration = 5.0f ;   //時間間隔
    animation.fillMode = kCAFillModeForwards ;
    animation.type = @"rippleEffect";   //動畫效果
    animation.subtype = kCATransitionFromTop ;   //動畫方向
    [_myImageView.layer addAnimation :animation forKey : @"animation" ];
}
-(void)UpOutHide{
    //    [UIView beginAnimations:@"hide" context:nil];
    [UIView setAnimationDuration:1];
    CATransition *animation = [CATransition animation];
    animation.duration = 5.0f ;   //時間間隔
    animation.fillMode = kCAFillModeForwards ;
    animation.type = kCATransitionPush;   //動畫效果
    animation.subtype = kCATransitionFromRight ;   //動畫方向
    [_myImageView.layer addAnimation :animation forKey : @"animation" ];
}
-(void)suckEffect{
    //    [UIView beginAnimations:@"hide" context:nil];
    [UIView setAnimationDuration:1];
    CATransition *animation = [CATransition animation];
    animation.duration = 5.0f ;   //時間間隔
    animation.fillMode = kCAFillModeForwards ;
    animation.type = @"suckEffect";   //動畫效果
    animation.subtype = kCATransitionFromRight ;   //動畫方向
    [_myImageView.layer addAnimation :animation forKey : @"animation" ];
}
//-(void)focusMove{
//    [UIView beginAnimations:@"" context:nil];
//    [UIView setAnimationDuration:4];
//    [_myImageView setFrame:CGRectMake(0, _myImageView.frame.origin.y+100.0f,_myImageView.frame.size.width, _myImageView.frame.size.height)];
//    [UIView commitAnimations];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
