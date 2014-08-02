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
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSString *tagName = elementName;
    if ([tagName isEqualToString:@"show"])
    {
        counter++;
        if(shows.showName)
        {
            NSLog(@"Show Name is: %@", shows.showID);
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
    }
    if(_boolName)
    {
        //_showName = string;
        shows.showName = string;
        //NSLog(@"Show Name: %@",shows.showName);
        _boolName = false;
    }
    if(_boolCountry)
    {
        //_country = string;
        shows.country = string;
        //NSLog(@"Show Country: %@", shows.country);
        _boolCountry = false;
    }
    if(_boolStart)
    {
        //_startYear = string;
        shows.startYear = string;
        //NSLog(@"Show Start: %@", shows.startYear);
        _boolStart = false;
    }
    if(_boolEnd)
    {
        shows.endYear = string;
       // NSLog(@"Show End: %@", shows.endYear);
        _boolEnd = false;
    }
    if(_boolStatus)
    {
        shows.status = string;
        //NSLog(@"Show Status: %@", shows.status);
        _boolStatus = false;
        counter = -1;
    }
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
