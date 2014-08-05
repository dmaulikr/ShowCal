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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString* docFile = [docDir stringByAppendingPathComponent: @"Storage"];
    _allSavedShows = [NSKeyedUnarchiver unarchiveObjectWithFile:docFile];

    NSLog(@"TESTING: %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    NSLog(@"Count of array is: %lu", (unsigned long)_allSavedShows.count);
    NSLog(@"INT: %d", _test);
    NSArray *path = NSSearchPathForDirectoriesInDomains(
                                                       NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *folder = [path objectAtIndex:0];
    NSLog(@"Your NSUserDefaults are stored in this folder: %@/Preferences", folder);
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   

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
    cell.textLabel.font = [UIFont systemFontOfSize:24];
    cell.textLabel.numberOfLines = 0;
    NSData *showImage = [NSData dataWithContentsOfURL:temp.imageUrlString];
    cell.imageView.image = [UIImage imageWithData:showImage];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Delete!");
        [_allSavedShows removeObjectAtIndex:indexPath.row];
        [_savedTableShows reloadData];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex: 0];
        NSString* docFile = [docDir stringByAppendingPathComponent: @"Storage"];
        [NSKeyedArchiver archiveRootObject:_allSavedShows toFile:docFile];
        
    }
}



@end
