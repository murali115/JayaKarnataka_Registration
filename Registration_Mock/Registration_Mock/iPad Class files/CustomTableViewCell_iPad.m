//
//  CustomTableViewCell_iPad.m
//  Registration_Mock
//
//  Created by Mac1 on 8/14/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import "CustomTableViewCell_iPad.h"

@implementation CustomTableViewCell_iPad

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _myView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 60)];
        _imageViewProfilePic =[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 60)];
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 40)];
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
