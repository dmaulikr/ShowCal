//
//  searchDetails.h
//  ShowCal
//
//  Created by Sid Raheja on 8/2/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchDetails : NSObject
@property   NSNumber *position;
@property  NSString *showName;
@property  NSString *startYear;
@property  NSURL *imageUrlString;
@property  NSString *showID;
@property NSString *network;
@property NSString *time;
@property NSData *imageData;
@property NSMutableArray *futureEpisodesDate;
@property NSMutableArray *futureEpisodesTitle;
@property NSMutableArray *calendarList;
@end

