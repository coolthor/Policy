//
//  NewsDetailViewController.m
//  Policy
//
//  Created by Thor Lin on 2014/5/20.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController


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
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DismissClick:(id)sender {
    
    if ( self .delegate && [ self .delegate respondsToSelector: @selector (NewsDetailViewControllerDidClickDismissButton:)]) {
        [ self .delegate NewsDetailViewControllerDidClickDismissButton: self ];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _posts.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"NewDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    }

    Post *post=_posts[indexPath.row];
 
    UIImageView  * image = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 76, 76)];
    image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.picture]]];
    image.contentMode =UIViewContentModeScaleToFill;
    [cell addSubview:image];
    
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(80, 2 ,cell.frame.size.width-image.frame.size.width , 76)];
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    textView.text = post.message;
    textView.editable = NO;
    [cell addSubview:textView];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
        return _myTitle;
}
@end
