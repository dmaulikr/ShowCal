//
//  ViewController.h
//  ShowCal
//
//  Created by Sid Raheja on 8/2/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchShows.h"
#import "savedShows.h"
#import "futureEpisodes.h"


@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *savedTableShows;
@property savedShows *saved;
@property NSMutableArray *allSavedShows;
@property NSString *fileName;
@property NSMutableArray *futureEpisodesArray;
@end


