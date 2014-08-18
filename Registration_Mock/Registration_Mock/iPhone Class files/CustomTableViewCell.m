//
//  CustomTableViewCell.m
//  JK_Mock
//
//  Created by Mac1 on 7/3/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _myView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
        _imageViewProfilePic =[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 20)];
        
        //        [_myView addSubview:_themeImageView];
        //        [_myView addSubview:_profilePicImageView];
        //        [_myView addSubview:_buttonGoing];
        //        [_myView addSubview:_lineView];
        //        [_myView addSubview:_participants];
        //        [_myView addSubview:_eventName];
        //        [_myView addSubview:_startTime];
        //        [_myView addSubview:_cityName];
        //        [_myView addSubview:_timeImageView];
        //        [_myView addSubview:_locationImageView];
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
