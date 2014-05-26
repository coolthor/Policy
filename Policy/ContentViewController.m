//
//  ContentViewController.m
//  Policy
//
//  Created by Thor Lin on 2014/5/23.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
        
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [_Label setText:_myNews.name];
    
    [self initialContent];
        
    _Text.font = [UIFont fontWithName:@"Arial" size:16.0f];
    _Text.textColor = [UIColor colorWithRed:0.024 green:0.004 blue:0.005 alpha:1.000];
    _Text.layer.cornerRadius = 5.0f;
    _Text.alpha =0.6;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(imageMove:) userInfo:nil repeats:YES];
}

-(void)initialContent{

    //由於翻頁後應該是都會重新跑viewDidLoad
    //避免第一筆資料出現太多次，先以random取頁
    //待改善。
    int randomValue = arc4random() % [_myNews.posts count];
    _currentPost = _myNews.posts[randomValue];
    
    if (![_currentPost.picture isEqualToString:@""]) {
        _BackgroundImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_currentPost.picture]]];
        _BackgroundImage.contentMode = UIViewContentModeScaleAspectFit;
    }else{
        _BackgroundImage.image = [UIImage imageNamed:@"background"];
        _BackgroundImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    _Text.text = _currentPost.message;
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
        default:
            break;
    }
    if(_BackgroundImage.alpha >0)
        _BackgroundImage.alpha = 0.85;
    
    [UIView commitAnimations];

    int iCurrentPost = [_myNews.posts indexOfObject:_currentPost];
    if(iCurrentPost == [_myNews.posts count]-1) {
        iCurrentPost =0;
    }else{
        iCurrentPost++;
    }
    _currentPost  = _myNews.posts[iCurrentPost];
    
    if (![_currentPost.picture isEqualToString:@""]) {
        UIImage * myImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_currentPost.picture]]];
        
        _BackgroundImage.image=myImg;
    }
    [UIView beginAnimations:@"textView" context:nil];
    [UIView setAnimationDuration:1];
    _Text.backgroundColor = [UIColor colorWithRed:1.000 green:0.995 blue:0.995 alpha:1.000];
    _Text.text = _currentPost.message;

    [UIView commitAnimations];
}

-(void)LeftInHide{
    
    [UIView setAnimationDuration:1];
    CATransition *animation = [CATransition animation];
    animation. duration = 5.0f ;   //時間間隔
    animation. fillMode = kCAFillModeForwards ;
    animation. type = kCATransitionMoveIn ;   //動畫效果
    animation. subtype = kCATransitionFromRight ;   //動畫方向
    [_BackgroundImage.layer addAnimation :animation forKey : @"animation" ];
}

-(void)rippleEffect{
    //    [UIView beginAnimations:@"hide" context:nil];
    [UIView setAnimationDuration:1];
    CATransition *animation = [CATransition animation];
    animation.duration = 5.0f ;   //時間間隔
    animation.fillMode = kCAFillModeForwards ;
    animation.type = @"rippleEffect";   //動畫效果
    animation.subtype = kCATransitionFromTop ;   //動畫方向
    [_BackgroundImage.layer addAnimation :animation forKey : @"animation" ];
}
-(void)UpOutHide{
    //    [UIView beginAnimations:@"hide" context:nil];
    [UIView setAnimationDuration:1];
    CATransition *animation = [CATransition animation];
    animation.duration = 5.0f ;   //時間間隔
    animation.fillMode = kCAFillModeForwards ;
    animation.type = kCATransitionPush;   //動畫效果
    animation.subtype = kCATransitionFromRight ;   //動畫方向
    [_BackgroundImage.layer addAnimation :animation forKey : @"animation" ];
}
-(void)suckEffect{
    //    [UIView beginAnimations:@"hide" context:nil];
    [UIView setAnimationDuration:1];
    CATransition *animation = [CATransition animation];
    animation.duration = 5.0f ;   //時間間隔
    animation.fillMode = kCAFillModeForwards ;
    animation.type = @"suckEffect";   //動畫效果
    animation.subtype = kCATransitionFromRight ;   //動畫方向
    [_BackgroundImage.layer addAnimation :animation forKey : @"animation" ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
