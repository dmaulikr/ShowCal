//
//  AddShows.h
//  ShowCal
//
//  Created by Sid Raheja on 8/3/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchDetails.h"
#import "futureEpisodes.h"

@interface AddShows : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *showLabel;
@property searchDetails *showDetails;
@property NSMutableArray *futureEpisodesArray;
@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property BOOL episodeDate;
@property BOOL episodeNumber;
@property BOOL episodeTitle;
@property NSComparisonResult result;
- (IBAction)reminderAdd:(id)sender;
- (IBAction)calendarAdd:(id)sender;
@end
