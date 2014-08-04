//
//  customCellTableViewCell.m
//  ShowCal
//
//  Created by Sid Raheja on 8/4/14.
//  Copyright (c) 2014 SidApps. All rights reserved.
//

#import "customCellTableViewCell.h"

@implementation customCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
