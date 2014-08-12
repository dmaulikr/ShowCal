//
//  ViewController.m
//  ShowCal
//
//  Created by Sid Raheja on 8/2/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSFileManager *filemgr;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Identify the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the data file
    dataFile = [docsDir stringByAppendingPathComponent:
                @"datafile.dat"];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFile])
    {
        // Read file contents and display in textBox
        NSData *databuffer;
        databuffer = [filemgr contentsAtPath: dataFile];
       _allSavedShows = [NSKeyedUnarchiver unarchiveObjectWithData:databuffer];
    }
    

    


    //Table deletion method
    self.savedTableShows.allowsMultipleSelectionDuringEditing = NO;
    
    //Set title of bar
    self.navigationItem.title = @"My Shows";
    [self.navigationItem setHidesBackButton:YES];
    
    //Add add button to bar to add a show
    UIBarButtonItem *addShow = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addShow:)];
    
    NSArray *actionButtonItems = @[addShow];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
   // savedShows *temp = [[savedShows alloc] init];
  //  _saved = [_allSavedShows objectAtIndex:0];
   // searchDetails *temp = [[searchDetails alloc] init];
    //temp = _saved.showSaved;
    //NSLog(@"Value is: %@", temp.showName);
    
    
    


   // _allSavedShows = [NSKeyedUnarchiver unarchiveObjectWithFile:_fileName];
    
    _savedTableShows.delegate = self;
    _savedTableShows.dataSource = self;
    // _table.rowHeight = self.view.frame.size.height * 0.1;
    _savedTableShows.backgroundView = nil;
    _savedTableShows.backgroundColor = [UIColor clearColor];
    _savedTableShows.rowHeight = 80;
    _savedTableShows.separatorColor = [UIColor clearColor];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addShow:(id)sender
{
    NSLog(@"Add!");
    //SearchShows *nextScreen = [[SearchShows alloc] init];
    //[self presentViewController:nextScreen animated:NO completion:nil];
    SearchShows *searchScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
   // SearchShows *searchScreen = [[SearchShows alloc] init];
    [self.navigationController pushViewController:searchScreen animated:NO];


    
   // [self presentModalViewController:vc animated:YES];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_allSavedShows count]; //array count returns 10
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;// this should be one because it will create space between two cells if you want space between 4 cells you can modify it.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _saved = [_allSavedShows objectAtIndex:indexPath.section];
    searchDetails *temp = [[searchDetails alloc] init];
    temp = _saved.showSaved;
    cell.textLabel.text = temp.showName;
    cell.textLabel.font = [UIFont systemFontOfSize:24];
    cell.textLabel.numberOfLines = 0;
    NSData *showImage = [NSData dataWithContentsOfURL:temp.imageUrlString];
    cell.imageView.image = [UIImage imageWithData:showImage];
    cell.detailTextLabel.numberOfLines = 0;
    if(temp.futureEpisodesDate.count)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ airs on %@ on %@ at %@", [temp.futureEpisodesTitle objectAtIndex:0], temp.network, [temp.futureEpisodesDate objectAtIndex:0], temp.time];
    }
    else
    {
        cell.detailTextLabel.text = @"No future episodes announced!";
    }

    return cell;
    
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
     cell.selectionStyle = UITableViewCellSelectionStyleDefault;
     cell.textLabel.text = [_showSearchResults objectAtIndex:[indexPath row]];
     UILabel *textLabel = [[UILabel alloc] init];
     textLabel.text = cell.textLabel.text;
     // [cell.textLabel setHidden:YES];
     
     textLabel.textColor = [UIColor whiteColor];
     textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
     [textLabel sizeToFit];
     [cell.contentView addSubview:textLabel];
     [textLabel setCenter:CGPointMake(self.view.center.x, 40)];
     UIView *selectedView =  [[UIView alloc] init];
     selectedView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.2 alpha:0.4];
     [cell setSelectedBackgroundView:selectedView];
     return cell;*/
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _saved = [_allSavedShows objectAtIndex:indexPath.section];
    searchDetails *temp = [[searchDetails alloc] init];
    temp = _saved.showSaved;
    if(temp.futureEpisodesDate.count)
    {
         EKEventStore *store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            if(temp.calendarList.count)
            {
                //notification show is already added to calendar
                NSLog(@"Show already added!");
                return;
            }
        for(int i = 0; i < temp.futureEpisodesDate.count; ++i)
        {
            NSString *str = [NSString stringWithFormat:@"%@ %@",
                             [temp.futureEpisodesDate objectAtIndex:i], temp.time];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd hh:mma"];
            NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
            [formatter setTimeZone:zone];
            NSDate *date = [formatter dateFromString:str];
            EKEvent *event = [EKEvent eventWithEventStore:store];
                event.title = [NSString stringWithFormat:@"New episode of %@ on %@ today", temp.showName, temp.network];
                event.startDate = [date dateByAddingTimeInterval:-60*15];
                event.endDate = [event.startDate dateByAddingTimeInterval:60*15];
                [event setCalendar:[store defaultCalendarForNewEvents]];
                [event addAlarm:[EKAlarm alarmWithAbsoluteDate:event.startDate]];
                NSError *err = nil;
                [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                if(err)
                {
                    //notification to let user no not added
                }
                else
                {
                    //notification successfuly added
                    NSLog(@"ADDED!");
                }
            [temp.calendarList addObject:event.eventIdentifier];
            NSFileManager *filemgr;
            NSString *dataFile;
            NSString *docsDir;
            NSArray *dirPaths;
            
            filemgr = [NSFileManager defaultManager];
            
            dirPaths = NSSearchPathForDirectoriesInDomains(
                                                           NSDocumentDirectory, NSUserDomainMask, YES);
            
            docsDir = dirPaths[0];
            dataFile = [docsDir
                        stringByAppendingPathComponent: @"datafile.dat"];
            NSData *databuffer = [NSKeyedArchiver archivedDataWithRootObject:_allSavedShows];
            [filemgr createFileAtPath: dataFile
                             contents: databuffer attributes:nil];
            
            NSLog(@"Data Saved");

                //NSLog(@"identifier: %@",event.eventIdentifier);  //this is so you can access this event later
            }
        }];
    }
    else
    {
        //add notification for no announced dates!
    }
  
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Delete!");
        NSLog(@"true: %@", [_allSavedShows objectAtIndex:indexPath.section]);
        _saved = [_allSavedShows objectAtIndex:indexPath.section];
        EKEventStore* store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            searchDetails *temp = [[searchDetails alloc] init];
            temp = _saved.showSaved;
            for(int i = 0; i < temp.calendarList.count; ++i)
            {
                EKEvent* eventToRemove = [store eventWithIdentifier:[temp.calendarList objectAtIndex:i]];
                if (eventToRemove) {
                    NSError* error = nil;
                    [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
                    if(error)
                    {
                        //notification to let know user data has been deleted from calednar
                    }
                    else
                    {
                        //notification deleted from calendar
                    }
                }
            }
        }];
        [_allSavedShows removeObjectAtIndex:indexPath.section];
        [_savedTableShows reloadData];
        NSFileManager *filemgr;
        NSString *dataFile;
        NSString *docsDir;
        NSArray *dirPaths;
        
        filemgr = [NSFileManager defaultManager];
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = dirPaths[0];
        dataFile = [docsDir
                    stringByAppendingPathComponent: @"datafile.dat"];
        NSData *databuffer = [NSKeyedArchiver archivedDataWithRootObject:_allSavedShows];
        [filemgr createFileAtPath: dataFile
                         contents: databuffer attributes:nil];
        
        NSLog(@"Data Saved");


        
    }
}



@end
