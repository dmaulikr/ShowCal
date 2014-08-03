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
    
    // Do any additional setup after loading the view.
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
