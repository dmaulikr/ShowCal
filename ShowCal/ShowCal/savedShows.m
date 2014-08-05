//
//  savedShows.m
//  ShowCal
//
//  Created by Sid Raheja on 8/5/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import "savedShows.h"

@implementation savedShows
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_showSaved forKey:@"showSaved"];
   
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.showSaved = [decoder decodeObjectForKey:@"showSaved"];
        
    }
    return self;
}
@end
