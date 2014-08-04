//
//  customCellTableViewCell.h
//  ShowCal
//
//  Created by Sid Raheja on 8/4/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *customImage;
@property (strong, nonatomic) IBOutlet UILabel *customLabelShowName;
@property (strong, nonatomic) IBOutlet UILabel *customDescriptionLabel;

@end
