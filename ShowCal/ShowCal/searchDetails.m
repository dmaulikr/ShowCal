//
//  searchDetails.m
//  ShowCal
//
//  Created by Sid Raheja on 8/2/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import "searchDetails.h"

@implementation searchDetails

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_position forKey:@"position"];
    [encoder encodeObject:_showName forKey:@"showName"];
    [encoder encodeObject:_startYear forKey:@"startYear"];
    [encoder encodeObject:_showID forKey:@"showID"];
    [encoder encodeObject:_imageData forKey:@"imageData"];
    [encoder encodeObject:_imageUrlString forKey:@"imageUrlString"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.position = [decoder decodeObjectForKey:@"position"];
        self.showName = [decoder decodeObjectForKey:@"showName"];
        self.startYear = [decoder decodeObjectForKey:@"startYear"];
        self.showID = [decoder decodeObjectForKey:@"showID"];
        self.imageData = [decoder decodeObjectForKey:@"imageData"];
        self.imageUrlString = [decoder decodeObjectForKey:@"imageUrlString"];
    }
    return self;
}

@end

