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
    futureEpisodes *Episodes;
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
    Episodes = [[futureEpisodes alloc] init];
    _futureEpisodes = [[NSMutableArray alloc] init];

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
    NSString *search = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
    NSString *apiString;
    apiString = [NSString stringWithFormat:@"http://www.omdbapi.com/?s=%@", search];
    NSLog(@"%@",apiString);
    NSURL *url = [[NSURL alloc]initWithString:apiString];
    NSLog((@"url is: %@"), url);
    //NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    //[parser setDelegate:self];
    //NSLog(@"%hhd",[parser parse]);
    NSError *error;
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
    NSLog(@"object is: %@", jsonObj);
    if (error)
    {
        NSLog(@"Fail to parse json data!");
    }
    NSDictionary *searchResults = [jsonObj objectForKey:@"Search"];
    NSDictionary *title = [[NSDictionary alloc] init];
    NSString *series;
    for(title in searchResults)
    {
        series = [title objectForKey:@"Type"];
        if([series isEqualToString:@"series"])
        {
            shows.showID =  [title objectForKey:@"imdbID"];
            shows.showName = [title objectForKey:@"Title"];
            shows.startYear = [title objectForKey:@"Year"];
            NSString *apiString2;
            apiString2 = [NSString stringWithFormat:@"http://www.omdbapi.com/?i=%@", shows.showID];
            NSURL *url2 = [[NSURL alloc]initWithString:apiString2];
           // NSLog((@"url is: %@"), url);
            //NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
            //[parser setDelegate:self];
            //NSLog(@"%hhd",[parser parse]);
            NSError *error2;
            NSURLRequest *urlRequest2 = [[NSURLRequest alloc] initWithURL:url2];
            NSData *jsonData2 = [NSURLConnection sendSynchronousRequest:urlRequest2
                                                      returningResponse:nil
                                                                  error:&error2];
            if (error2)
            {
                NSLog(@"Fail to connect to the server!");
            }
            id jsonObj2 = [NSJSONSerialization JSONObjectWithData:jsonData2
                                                          options:NSJSONReadingMutableLeaves
                                                            error:&error];
            //NSLog(@"testtsts: %@", [jsonObj objectForKey:@"Poster"]);
            // NSLog(@"object is: %@", jsonObj);
            if (error2)
            {
                NSLog(@"Fail to parse json data!");
            }
            NSURL *imageURL = [NSURL URLWithString:[jsonObj2 objectForKey:@"Poster"]];
            shows.imageUrlString = imageURL;
            shows.imageData = [NSData dataWithContentsOfURL:imageURL];
            [_showSearchResults addObject:shows];
            shows = [[searchDetails alloc] init];
        }
    }
    
    
    
     [_table reloadData];
    // _table = [[UITableView alloc] init];
    _table.delegate = self;
    _table.dataSource = self;
    // _table.rowHeight = self.view.frame.size.height * 0.1;
    _table.backgroundView = nil;
    _table.backgroundColor = [UIColor clearColor];
    _table.rowHeight = 80;
    _table.separatorColor = [UIColor clearColor];
    //NSDictionary *title = [searchResults objectForKey:@"Title"];
    //NSLog(@"STring is: %@", title);
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count is: %lu", (unsigned long)[_showSearchResults count]);
    return [_showSearchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    searchDetails *temp = [[searchDetails alloc] init];
    temp = [_showSearchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = temp.showName;
    cell.textLabel.font = [UIFont systemFontOfSize:24];
    cell.textLabel.numberOfLines = 2;
    if([temp.startYear length] == 5)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@Present", temp.startYear];
        }
    else
        {
             cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", temp.startYear];
        }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
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
     ViewController *homeScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"home"];
    searchDetails *temp = [[searchDetails alloc] init];
    temp = [_showSearchResults objectAtIndex:indexPath.row];
    if([temp.startYear length] == 5)
    {
        NSLog(@"Adding!");
        NSString *search = [temp.showName stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *apiString;
        apiString = [NSString stringWithFormat:@"http://api.trakt.tv/search/shows.json/bb9fd567df5f4903cbed444881f93251?query=%@", search];
        NSURL *url = [[NSURL alloc]initWithString:apiString];
        NSError *error;
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
        NSDictionary *showMatch = [[NSDictionary alloc] init];
        for(showMatch in jsonObj)
        {
            NSString *matchName = [showMatch objectForKey:@"title"];
            bool ended  = [showMatch objectForKey:@"ended"];
            if([matchName isEqualToString:temp.showName] && ended)
            {
                NSLog(@"Found");
                temp.showID = [showMatch objectForKey:@"tvrage_id"];
                NSLog(@"ID IS: %@", temp.showID);
                temp.network = [showMatch objectForKey:@"network"];
                temp.time = [showMatch objectForKey:@"air_time"];
                break;
            }
        }
        NSString *apiString2;
        apiString2 = [NSString stringWithFormat:@"http://services.tvrage.com/feeds/episode_list.php?sid=%@", temp.showID];
        NSURL *url2 = [[NSURL alloc]initWithString:apiString2];
        NSLog(@"url is: %@", url2);
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url2];
        [parser setDelegate:self];
        [parser parse];
        NSLog(@"Future episodes are: %lu", (unsigned long)[_futureEpisodes count]);

        savedShows *s = [[savedShows alloc] init];
        NSMutableArray *s2 = [[NSMutableArray alloc] init];
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
            s2 = [NSKeyedUnarchiver unarchiveObjectWithData:databuffer];
        }
        temp.futureEpisodesDate = [[NSMutableArray alloc] init];
        temp.futureEpisodesTitle = [[NSMutableArray alloc] init];
        temp.calendarList = [[NSMutableArray alloc] init];

        for(int i = 0; i < _futureEpisodes.count; ++i)
        {
            futureEpisodes *temp2 = [[futureEpisodes alloc] init];
            temp2 = [_futureEpisodes objectAtIndex:i];
            [temp.futureEpisodesTitle addObject:temp2.episodeTitle];
            [temp.futureEpisodesDate addObject:temp2.episodeDate];
        }
        s.showSaved = temp;
       //homeScreen.saved = s;
        [s2 addObject:s];
        homeScreen.allSavedShows = s2;
        
        
            filemgr = [NSFileManager defaultManager];
            
            dirPaths = NSSearchPathForDirectoriesInDomains(
                                                           NSDocumentDirectory, NSUserDomainMask, YES);
            
            docsDir = dirPaths[0];
            dataFile = [docsDir
                        stringByAppendingPathComponent: @"datafile.dat"];
            NSData *databuffer = [NSKeyedArchiver archivedDataWithRootObject:homeScreen.allSavedShows];
            [filemgr createFileAtPath: dataFile
                             contents: databuffer attributes:nil];

        NSLog(@"Data Saved");
        
        

        

        
    }
    else
    {
        NSLog(@"Show cannot be added! It is over!");
    }
   
    [self.navigationController pushViewController:homeScreen animated:NO];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSString *tagName = elementName;
    if ([tagName isEqualToString:@"airdate"])
    {
        _episodeDate = true;
    }
    if ([tagName isEqualToString:@"title"])
    {
        _episodeTitle = true;
    }
    if(Episodes.episodeDate && Episodes.episodeTitle)
    {
        //NSLog(@"title is: %@", Episodes.episodeDate);
        [_futureEpisodes addObject: Episodes];
        Episodes = [[futureEpisodes alloc] init];
        
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Did end element");
    if(Episodes.episodeDate && Episodes.episodeTitle)
    {
        //NSLog(@"title is: %@", Episodes.episodeDate);
        [_futureEpisodes addObject: Episodes];
        Episodes = [[futureEpisodes alloc] init];
        
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if(_episodeDate)
    {
        
       // NSLog(@"airdate is: %@", string);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *todaysDate = [formatter stringFromDate:[NSDate date]];
        _result = [string compare:todaysDate];
        if(_result >= 0)
        {
            Episodes.episodeDate = string;
        }
        _episodeDate = false;
    }
    if(_episodeTitle)
    {
        if(_result >= 0)
        {
            Episodes.episodeTitle = string;
        }
        _episodeTitle = false;
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
