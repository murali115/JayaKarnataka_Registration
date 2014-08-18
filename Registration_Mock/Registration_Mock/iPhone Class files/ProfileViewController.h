//
//  ProfileViewController.h
//  Registration_Mock
//
//  Created by Mac1 on 7/17/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSString *token, *user_id;
@property (strong, nonatomic) NSMutableArray *arrayProfile;
@property (strong, nonatomic) NSMutableDictionary *dictionaryUserDetails;
@property (strong, nonatomic) UIImageView *imageViewTheme, *imageViewProfilePic, *imageViewEdit;
@property (strong, nonatomic) UIView *view1, *view2, *view3, *view4, *view5;
@property (strong, nonatomic) UILabel *labelUserName, *labelLives, *labelStudy, *labelWork, *labelBasicInfo, *labelGender, *labelGenderValue, *labelBirthday, *labelBirthdayValue, *labelBloodGroup, *labelBloodGroupValue, *labelContactInfo, *labelEmail, *labelEmailValue, *labelMobile, *labelMobileValue, *labelCity, *labelCityValue, *labelProffInfo, *labelStudiesAt, *labelStudiesAtValue, *labelWorksAt, *labelWorksAtValue, *labelBio, *labelBioValue;

@end
