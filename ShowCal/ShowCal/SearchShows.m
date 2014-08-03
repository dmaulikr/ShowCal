//
//  SearchShows.m
//  ShowCal
//
//  Created by Sid Raheja on 8/2/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import "SearchShows.h"

@interface SearchShows ()

@end

@implementation SearchShows
{
    searchDetails *shows;
}

int counter = 0;

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
    _searchShow.delegate = self;
    _searchShow.showsCancelButton = YES;
    _searchShow.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchShow.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _showSearchResults = [[NSMutableArray alloc] init];
    shows = [[searchDetails alloc] init];

    //[_showSearchResults addObject:shows];

    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];

}

- (void)handleSearch:(UISearchBar *)searchBar {
    
    _showSearchResults = [[NSMutableArray alloc] init];
    shows = [[searchDetails alloc] init];
    NSLog(@"User searched for %@", searchBar.text);
    NSString *search = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
    NSString *apiString;
    apiString = [NSString stringWithFormat:@"http://services.tvrage.com/feeds/search.php?show=%@", search];
    NSLog(@"%@",apiString);
    NSURL *url = [[NSURL alloc]initWithString:apiString];
    NSLog((@"url is: %@"), url);
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser setDelegate:self];
    NSLog(@"%hhd",[parser parse]);
    
    [_table reloadData];
   // _table = [[UITableView alloc] init];
    _table.delegate = self;
    _table.dataSource = self;
    // _table.rowHeight = self.view.frame.size.height * 0.1;
    _table.backgroundView = nil;
    _table.backgroundColor = [UIColor clearColor];
    _table.rowHeight = 80;
    _table.separatorColor = [UIColor clearColor];

}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSString *tagName = elementName;
    if ([tagName isEqualToString:@"classification"])
    {
        NSLog(@"Show Name is: %@", shows.showID);
        if(shows.showName)
        {
            //Add to Array and table for search results
            NSLog(@"Show Name is: %@", shows.showID);
            [_showSearchResults addObject:shows];
        }
        shows = [[searchDetails alloc] init];

    }
    if([tagName isEqualToString:@"showid"])
    {
        _boolshowID = TRUE;
        
    }
    if([tagName isEqualToString:@"name"])
    {
        _boolName = TRUE;
    }
    if([tagName isEqualToString:@"country"])
    {
        _boolCountry = TRUE;
    }
    if([tagName isEqualToString:@"started"])
    {
        _boolStart = TRUE;
    }
    if([tagName isEqualToString:@"ended"])
    {
        _boolEnd = TRUE;
    }
    if([tagName isEqualToString:@"status"])
    {
        _boolStatus = TRUE;
    }
    
    if ([elementName isEqualToString:@"Results"])
    {
        NSLog(@"found Results");
       // _showSearchResults = [[NSMutableArray alloc] init];
        return;
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Did end element");
    
    if ([elementName isEqualToString:@"Results"])
    {
        NSLog(@"Results end");
       
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSString *x = string;
    //NSLog(@"value2 is: %@", x);
   // NSLog(@"bool show id is: %d", _boolshowID);
    
    if(_boolshowID)
    {
        //_showID = string;
        shows.showID = string;
        //NSLog(@"Show id: %@", shows.showID);
        _boolshowID = false;
        return;
    }
    if(_boolName)
    {
        //_showName = string;
        shows.showName = string;
        //NSLog(@"Show Name: %@",shows.showName);
        _boolName = false;
        return;
    }
    if(_boolCountry)
    {
        //_country = string;
        shows.country = string;
        //NSLog(@"Show Country: %@", shows.country);
        _boolCountry = false;
        return;
    }
    if(_boolStart)
    {
        //_startYear = string;
        shows.startYear = string;
        //NSLog(@"Show Start: %@", shows.startYear);
        _boolStart = false;
        return;
    }
    if(_boolEnd)
    {
        shows.endYear = string;
       // NSLog(@"Show End: %@", shows.endYear);
        _boolEnd = false;
        return;
    }
    if(_boolStatus)
    {
        shows.status = string;
        //NSLog(@"Show Status: %@", shows.status);
        _boolStatus = false;
        return;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count is: %lu", (unsigned long)[_showSearchResults count]);
    return [_showSearchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    searchDetails *temp = [_showSearchResults objectAtIndex:[indexPath row]];
    cell.textLabel.text = temp.showName;
    NSLog((@"name is: %@", temp.showName));
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
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    AddShows *addScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"add"];
    addScreen.showDetails = [_showSearchResults objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:addScreen animated:NO];

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
