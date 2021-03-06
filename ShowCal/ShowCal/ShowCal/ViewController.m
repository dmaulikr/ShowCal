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
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *encodedObject = [defaults objectForKey:@"save"];
        _allSavedShows = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        NSLog(@"Count of array is: %lu", (unsigned long)_allSavedShows.count);
    


   // _allSavedShows = [NSKeyedUnarchiver unarchiveObjectWithFile:_fileName];
    
    _savedTableShows.delegate = self;
    _savedTableShows.dataSource = self;
    // _table.rowHeight = self.view.frame.size.height * 0.1;
    _savedTableShows.backgroundView = nil;
    _savedTableShows.backgroundColor = [UIColor clearColor];
    _savedTableShows.rowHeight = 180;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allSavedShows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _saved = [_allSavedShows objectAtIndex:indexPath.row];
    searchDetails *temp = [[searchDetails alloc] init];
    temp = _saved.showSaved;
    cell.textLabel.text = temp.showName;
    cell.textLabel.font = [UIFont systemFontOfSize:34];
    cell.textLabel.numberOfLines = 0;
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
@end
