//
//  StreamViewDetail.m
//  Policy
//
//  Created by Thor Lin on 2014/5/18.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "StreamViewDetail.h"

@interface StreamViewDetail ()

@end

@implementation StreamViewDetail

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
    
    // Do any additional setup after loading the view.
    
    NSURL * NSurl = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:NSurl];
    [_myWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressForBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
