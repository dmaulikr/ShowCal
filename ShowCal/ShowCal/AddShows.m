//
//  AddShows.m
//  ShowCal
//
//  Created by Sid Raheja on 8/3/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import "AddShows.h"

@interface AddShows ()

@end

@implementation AddShows
{
    futureEpisodes *Episodes;
}

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
    _showLabel.text = _showDetails.showName;
    _showLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _showLabel.numberOfLines = 0;
    NSString *temp = _showDetails.showName;
    NSString *name = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *apiString = [NSString stringWithFormat:@"http://www.omdbapi.com/?i=&t=%@", name];
    apiString = [apiString lowercaseString];
    NSError *error;
    NSURL *url = [[NSURL alloc] initWithString:apiString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:urlRequest
                                             returningResponse:nil
                                                         error:&error];
    if (error)
    {
        NSLog(@"Fail to connect to the server!");
    }
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableLeaves
                                                   error:&error];
    //NSLog(@"testtsts: %@", [jsonObj objectForKey:@"Poster"]);
    if (error)
    {
        NSLog(@"Fail to parse json data!");
    }
    NSURL *imageURL = [NSURL URLWithString:[jsonObj objectForKey:@"Poster"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    [_showImage setImage:image];
    _descriptionLabel.text = [jsonObj objectForKey:@"Plot"];
   
    _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.minimumScaleFactor = 0.1;
    _descriptionLabel.adjustsFontSizeToFitWidth = YES;
    Episodes = [[futureEpisodes alloc] init];
    _futureEpisodesArray = [[NSMutableArray alloc] init];
    
    if(![_showDetails.status isEqualToString:@"Returning Series"] && ![_showDetails.endYear isEqual: @"0"])
    {
        _statusLabel.text = @"Show has Ended";
    }
    else
    {
        NSString *apiString;
        apiString = [NSString stringWithFormat:@"http://services.tvrage.com/feeds/episode_list.php?sid=%@", _showDetails.showID];
        NSLog(@"%@",apiString);
        NSURL *url = [[NSURL alloc]initWithString:apiString];
        NSLog((@"url is: %@"), url);
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
        [parser setDelegate:self];
        NSLog(@"%hhd",[parser parse]);
        if([_futureEpisodesArray count])
        {
           futureEpisodes *temp = [[futureEpisodes alloc] init];
            temp = [_futureEpisodesArray objectAtIndex:0];
            NSLog(@"Count is: %lu", (unsigned long)[_futureEpisodesArray count]);
            NSString *statusText = [NSString stringWithFormat:@"%@\nAir Date: %@",
                                    temp.episodeTitle, temp.episodeDate];
            _statusLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _statusLabel.numberOfLines = 0;
            _statusLabel.text =statusText;
        }
        else
        {
            _statusLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _statusLabel.numberOfLines = 0;
            _statusLabel.text =@"No further dates announced! Check again later!";
        }
    }
    
    //NSLog(@"todays date is: %@", todaysDate);
    //NSLog(@"Status: %@", _showDetails.status);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSString *tagName = elementName;
    if ([tagName isEqualToString:@"airdate"])
    {
        _episodeDate = true;
    }
    if ([tagName isEqualToString:@"epnum"])
    {
        _episodeNumber = true;
    }
    if ([tagName isEqualToString:@"title"])
    {
        _episodeTitle = true;
    }
    if(Episodes.episodeDate && [tagName isEqualToString:@"episode"])
    {
        NSLog(@"title is: %@", Episodes.episodeDate);
        [_futureEpisodesArray addObject: Episodes];
        Episodes = [[futureEpisodes alloc] init];

    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Did end element");
    
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if(_episodeDate)
    {
        
        //NSLog(@"airdate is: %@", string);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *todaysDate = [formatter stringFromDate:[NSDate date]];
        _result = [string compare:todaysDate];
        if(_result == 1)
        {
            //NSLog(@"Future air date is: %@", string);
            Episodes.episodeDate = string;
        }
        _episodeDate = false;
    }
    if(_episodeTitle)
    {
        Episodes.episodeTitle = string;
        _episodeTitle = false;
    }
    if(_episodeNumber)
    {
        Episodes.episodeNumber = string;
        _episodeNumber = false;
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

- (IBAction)calendarAdd:(id)sender
{
    if(_result)
    {
        NSLog(@"C");
    }
}

- (IBAction)reminderAdd:(id)sender
{
    if(_result)
    {
        NSLog(@"R");
    }
}
@end
