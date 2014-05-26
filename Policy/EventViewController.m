//
//  EventViewController.m
//  Policy
//
//  Created by Thor Lin on 2014/5/23.
//  Copyright (c) 2014年 Thor Lin. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController


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
    [self ParseJSON];
    _eventStore=[[EKEventStore alloc] init];

}



-(void)ParseJSON{
    
    _Events = [[NSMutableArray alloc]init];
    
    NSURL *jsonUrl =[NSURL URLWithString:@"https://livelink.firebaseio.com/event/.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:jsonUrl];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error;
    _dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(error == nil)
    {
        for (NSObject * key  in _dic.allKeys) {
            
            NSDictionary * event  = _dic[key];
            Event * myEvent = [[Event alloc]init];

            myEvent.location  = event[@"location"];
            myEvent.type = event[@"type"];
            myEvent.link  = event[@"link"];
            myEvent.title = event[@"title"];
            myEvent.start  = event[@"start"];
            myEvent.end = event[@"end"];
            myEvent.day  = event[@"day"];
            
            [_Events addObject:myEvent];
        }
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _Events.count;
}

-(NSString *)ParseDatetime:(NSString *)rawDateTime{
    NSString * str;
    if([rawDateTime rangeOfString:@"undefined"].location == NSNotFound){
        str = [rawDateTime stringByReplacingOccurrencesOfString:@"+08:00" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }else{
        str = @"未定";
    }
        
    return str;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];

    
    EventTableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    Event * myEvent = _Events[indexPath.row];
    cell.title.text = myEvent.title;
    cell.start.text = [self ParseDatetime:myEvent.start];
    if(myEvent.start > myEvent.end){
        cell.End.text = cell.start.text;
    }else{
        cell.End.text = [self ParseDatetime:myEvent.end];
    }
    cell.event = myEvent;
    cell.delegate =self;
    
    if([self checkEventStart:cell.start.text End:cell.End.text Title:cell.title.text]){
        cell.QuestIcon.image = [UIImage imageNamed:@"messagebox_warning"];
        cell.AddEvent.enabled = NO;
    }else{
        cell.QuestIcon.image = [UIImage imageNamed:@"messagebox_warning_Yellow"];
        cell.AddEvent.enabled = YES;
    }
    return  cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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

-(void)EventTableViewCellDelegateDidClickAddEventButton:(EventTableViewCell *)viewController{
    _selectedCell =viewController;
    UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"新增事件" message:@"確認新增事件到行事曆中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"新增", nil];
    
    [alert show];
}

-(void)updateUITableViewCell{
    [_myTableView beginUpdates];
    
    NSIndexPath *_indexPath = [_myTableView indexPathForCell:_selectedCell];//[[NSIndexPath alloc] initWithIndexes:_path length:2];
    NSLog(@"update section: %ld Row: %ld",(long)_indexPath.section,(long)_indexPath.row);
    NSArray *_indexPaths = [[NSArray alloc] initWithObjects:_indexPath, nil];
    [_myTableView reloadRowsAtIndexPaths:_indexPaths withRowAnimation:UITableViewRowAnimationRight];
    [_myTableView endUpdates];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self addEventToCalender];
            break;
        default:
            break;
    }
}

-(BOOL)checkEventStart:(NSString *)startDate End:(NSString *)endDate Title:(NSString *)title{
    BOOL isEvented =NO;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *SDate = [dateFormatter dateFromString:startDate];
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:SDate
                                                 options:0];
    
    //增加前後各一天的Range，避免找不到event
    NSDateComponents *oneDayLeftComponents = [[NSDateComponents alloc] init];
    oneDayLeftComponents.day = 1;
    
    
    NSDate *EDate;
    if(![endDate isEqualToString:@"未定"]){
        
        EDate = [dateFormatter dateFromString:endDate];
        EDate = [calendar dateByAddingComponents:oneDayLeftComponents
                                          toDate:EDate
                                         options:0];
    }else{
        EDate = [calendar dateByAddingComponents:oneDayLeftComponents
                                          toDate:SDate
                                         options:0];
    }
    
    NSPredicate *predicate = [_eventStore predicateForEventsWithStartDate:oneDayAgo endDate:EDate calendars:nil];
    NSArray * events = [_eventStore eventsMatchingPredicate:predicate];
//    for(EKEvent * e in events){
//        NSLog(@"Remove Event:%@",e);
//        [_eventStore removeEvent:e span:EKSpanFutureEvents error:nil];
//    }
    for (EKEvent * o in events) {
        NSLog(@"Title      : %@",title);
        NSLog(@"event title: %@",o.title);
        if([o.title rangeOfString:title].location != NSNotFound){
            isEvented =YES;
            break;
        }
    }
    
    return isEvented;
}

-(void)addEventToCalender{
    
    [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             EKEvent *event  = [EKEvent eventWithEventStore:_eventStore];

             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
             [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
             NSDate *SDate = [dateFormatter dateFromString:_selectedCell.start.text];
             
             NSDate *EDate;
             if(![_selectedCell.End.text isEqualToString:@"未定"]){
                 EDate = [dateFormatter dateFromString:_selectedCell.End.text];
             }else{
                 EDate = SDate;
             }

             event.location = _selectedCell.event.location;
             event.title =_selectedCell.title.text;
             event.startDate=SDate;
             event.endDate=EDate;
             event.notes = _selectedCell.title.text;
             event.allDay=YES;
             
             NSLog(@"Add EVnet: %@",event);
             [event setCalendar:[_eventStore defaultCalendarForNewEvents]];
             
             NSError *err;
             [_eventStore saveEvent:event span:EKSpanThisEvent error:&err];
             _selectedCell.QuestIcon.image = [UIImage imageNamed:@"messagebox_warning"];

         }
         else
         {
             NSLog(@"NoPermission to access the calendar");
         }
         
     }];
}
@end
