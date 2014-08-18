//
//  RegistrationViewController_iPad.h
//  Registration_Mock
//
//  Created by Mac1 on 8/7/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController_iPad.h"
#import "MembersViewController_iPad.h"

@interface RegistrationViewController_iPad : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) UILabel *labelNewMember, *labelTerms;
@property (strong, nonatomic) UITextField *tfName, *tfPhone, *tfProfession, *tfEmail, *tfDOB, *tfAddress, *tfPinCode;
@property (strong, nonatomic) UIButton *buttonGender, *buttonBloodGroup, *buttonLocation  , *buttonLifeTimeSub, *buttonYearlySub, *buttonCheckBox, *buttonProfilePic;
@property BOOL isChecked;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSDateFormatter* dateFormatter;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) UITableView *tableGender, *tableBloodGroup, *tableLocation;
@property (strong, nonatomic) NSMutableArray *arrayGenders, *arrayBloodGroups, *arrayLocations;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) UIImageView *profilePic;

@property (strong, nonatomic) ProfileViewController_iPad *profileViewController;
@property (strong, nonatomic) MembersViewController_iPad *membersViewController;

@property (strong, nonatomic) UITableViewController *tablePopup;

@end
