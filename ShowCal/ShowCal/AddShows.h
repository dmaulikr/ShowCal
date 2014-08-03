//
//  AddShows.h
//  ShowCal
//
//  Created by Sid Raheja on 8/3/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchDetails.h"

@interface AddShows : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *showLabel;
@property searchDetails *showDetails;
@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
