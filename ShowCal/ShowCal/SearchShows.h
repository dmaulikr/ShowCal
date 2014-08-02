//
//  SearchShows.h
//  ShowCal
//
//  Created by Sid Raheja on 8/2/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchDetails.h"

@interface SearchShows : UIViewController
@property (strong, nonatomic) IBOutlet UISearchBar *searchShow;
@property  NSString *showName;
@property  NSString *startYear;
@property  NSString *endYear;
@property  NSString *status;
@property  NSString *seasons;
@property  NSString *country;
@property  NSString *imageUrlString;
@property  NSString *showID;
@property BOOL boolshowID;
@property BOOL boolName;
@property BOOL boolStart;
@property BOOL boolEnd;
@property BOOL boolStatus;
@property BOOL boolSeasons;
@property BOOL boolCountry;
@property NSArray *showSearchResults;
@end

