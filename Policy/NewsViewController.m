//
//  NewsViewController.m
//  Policy
//
//  Created by Thor Lin on 2014/5/19.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView  *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    [background setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    [self.tableView setBackgroundView:background];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self ParseJSON];
}

-(void)ParseJSON{
    //新聞的部份之後再處理，先mark作記錄。
    NSURL *jsonUrl =[NSURL URLWithString:@"https://livelink.firebaseio.com/news/.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:jsonUrl];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error;
//    NSLog(@"%@",data);
    _dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(error == nil)
    {
        _array = [[NSMutableArray alloc]init];
        for (NSObject * key in _dic.allKeys) {
            
            //new.uid =
            NSDictionary * subdic = _dic[key];
            News * myNews = [[News alloc]init];
            myNews.uid =subdic[@"id"];
            myNews.name =subdic[@"name"];
            myNews.cover =subdic[@"cover"];
            myNews.about =subdic[@"about"];
            myNews.picture =subdic[@"picture"];
            myNews.posts = [[NSMutableArray alloc]init];
            
//            NSLog(@"%@",subdic[@"about"]);
            
            for (NSDictionary * post in subdic[@"post"]) {
                Post * myPost = [[Post alloc]init];
                myPost.datetime =post[@"datetime"];
                myPost.type =post[@"type"];
                myPost.picture =post[@"picture"];
                myPost.message =post[@"message"];
                myPost.link =post[@"link"];
                
                [myNews.posts addObject:myPost];
//                NSLog(@"%@",post[@"message"]);
            }
            
            [_array addObject:myNews];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    }
    News * myNews = [[News alloc]init];
    myNews = (News *)_array[indexPath.row];
    UIImage * img  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:myNews.cover]]];
    cell.myImageView.image = img;
    [cell.myImageView setFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    cell.myLabel.text = myNews.name;
    
    cell.Posts = [[NSMutableArray alloc]init];
//    NSLog(@"My News' POST count: %d", myNews.posts.count);
    for (Post * p in myNews.posts) {
        [cell.Posts addObject:p];
    }
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailViewController * detail = [[NewsDetailViewController alloc]initWithNibName:@"NewsDetailViewController" bundle:nil];
    detail.delegate = self;
    detail.posts = [[NSMutableArray alloc]init];
    News * new = (News *)_array[indexPath.row];
    detail.posts = new.posts;
    detail.myTitle = new.name;
    [self presentViewController:detail animated:YES completion:nil];
    
}

-(void)NewsDetailViewControllerDidClickDismissButton:(NewsDetailViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
