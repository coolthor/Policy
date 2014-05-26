//
//  NewsPageViewController.m
//  Policy
//
//  Created by Thor Lin on 2014/5/23.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "NewsPageViewController.h"


@interface NewsPageViewController ()

@end

@implementation NewsPageViewController

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
    
    [self ParseJSON];
    
    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    [_pageViewController setDataSource:self];
    
    ContentViewController * initialVC = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
    
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [_pageViewController.view setFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-50)];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

-(ContentViewController *)viewControllerAtIndex:(NSUInteger)index{
    if(index > _NewsSourceArray.count -1){
        return nil;
    }
    ContentViewController * cVC = [[ContentViewController alloc]init];
    
    [cVC setMyNews:[_NewsSourceArray objectAtIndex:index]];
    return cVC;
}

-(NSInteger)indexOfViewController:(ContentViewController *)viewController{
    return [_NewsSourceArray indexOfObject:viewController.myNews];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if(index == 0 || index == NSNotFound ){
        return  nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if(index == NSNotFound ){
        return  nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}

-(void)ParseJSON{
    
    NSURL *jsonUrl =[NSURL URLWithString:@"https://livelink.firebaseio.com/news/.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:jsonUrl];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error;
    _dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(error == nil)
    {
        _NewsSourceArray = [[NSMutableArray alloc]init];
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
            
            for (NSDictionary * post in subdic[@"post"]) {
                Post * myPost = [[Post alloc]init];
                myPost.datetime =post[@"datetime"];
                myPost.type =post[@"type"];
                myPost.picture =post[@"picture"];
                myPost.message =post[@"message"];
                myPost.link =post[@"link"];
                
                [myNews.posts addObject:myPost];
            }
            
            [_NewsSourceArray addObject:myNews];
        }
    }
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

@end
