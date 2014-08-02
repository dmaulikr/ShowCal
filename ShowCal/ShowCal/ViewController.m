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
    self.navigationItem.title = @"ShowCal";
    
    //Add add button to bar to add a show
    UIBarButtonItem *addShow = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addShow:)];
    
    NSArray *actionButtonItems = @[addShow];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
   
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
@end
