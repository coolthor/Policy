//
//  StreamView.m
//  Policy
//
//  Created by Thor Lin on 2014/5/18.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "StreamView.h"

@interface StreamView ()

@end

@implementation StreamView

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
//    UIView * LoadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    LoadingView.backgroundColor = [UIColor colorWithRed:0.111 green:0.854 blue:0.979 alpha:1.000];
//
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 60)];
//
//    [LoadingView addSubview:btn];
//                     
//    [self.collectionView addSubview:LoadingView];
//
//    _progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
//    _progress.frame = CGRectMake(0,0, 280, 20);
//    _progress.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
//    _progress.progress = 0;
//    [self.view addSubview:_progress];
    
    [self ParseJSON];
    //[self ParseJSON];
    
    
//    if (progress.progress ==1) {
//        [LoadingView removeFromSuperview];
//    }
//    
}

-(void)ParseJSON{
    
    _channels = [[NSMutableArray alloc]init];
    //先用JSON去抓取CHANNEL的資料。
    
    NSURL *jsonUrl =[NSURL URLWithString:@"https://livelink.firebaseio.com/channel/.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:jsonUrl];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error;
    //    NSLog(@"%@",data);
    _dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(error == nil)
    {
        NSInteger i = 0;
        for (NSObject * key  in _dic.allKeys) {
            i++;
            NSDictionary * stream  = _dic[key];
            
            Channel * myChannel = [[Channel alloc]init];
            myChannel.cid  = stream[@"cid"];
            myChannel.type = stream[@"type"];
            myChannel.url  = stream[@"url"];
            myChannel.logo = stream[@"logo"];

            myChannel.title  = [stream[@"title"] stringByReplacingOccurrencesOfString:@"[不要再新增頻道-請使用另一個頻道]" withString:@" "];
            [_channels addObject:myChannel];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UICollectionView Delegate

#pragma UICollectionView DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _channels.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    //UILabel *label = (UILabel *)[cell viewWithTag:100];
    UITextView *title =  [[UITextView alloc]initWithFrame:CGRectMake(0, 85, 100, 150-85)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width-80)/2, 5, 80 ,80)];//= (UIImageView *)[cell viewWithTag:200];
    [cell addSubview:image];
    [cell addSubview:title];
    
    Channel * myChannel  =[_channels objectAtIndex:indexPath.row];
    title.text= myChannel.title;
    title.editable = NO;
    title.font = [UIFont fontWithName:@"Arial" size:10.0f];
    title.textAlignment  = UIControlContentVerticalAlignmentCenter;
    NSURL *url = [NSURL URLWithString:myChannel.logo];
    image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    //image.frame = CGRectMake((cell.frame.size.width-image.frame.size.width)/2, 5, 80 ,80);
//    image.clipsToBounds=YES;
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = image.frame.size.width/2;
    image.layer.borderWidth = 2.0f;
    image.layer.borderColor = [UIColor colorWithRed:0.510 green:0.914 blue:0.543 alpha:1.000].CGColor;
    //image.userInteractionEnabled = YES;
//    cell.layer.shadowOffset = CGSizeMake(2, 2);
//    cell.layer.shadowColor = [UIColor blackColor].CGColor;
//    [cell.layer setBorderWidth:0.1f];
//    cell.layer.shadowOpacity = 0.75f;
//    cell.layer.shadowRadius = 5.0f;
//    cell.layer.shadowOffset = CGSizeZero;
//    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
//    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    
//    [cell.layer setCornerRadius:2.0f];

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    StreamViewDetail * svd = [[StreamViewDetail alloc]init];
    svd = segue.destinationViewController;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    Channel * ch = _channels[indexPath.row];
    
    svd.url = ch.url;
    
    [segue destinationViewController];
    
    //NSLog(@"%@",sender);
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
