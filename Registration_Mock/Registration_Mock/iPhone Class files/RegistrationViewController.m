//
//  RegistrationViewController.m
//  Registration_Mock
//
//  Created by Mac1 on 7/17/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "GetData.h"

@interface RegistrationViewController ()

@property (strong, nonatomic) UILabel *labelAlertTittle, *labelAlertMessage, *labelMembership, *labelMembershipType, *labelAmount, *labelMembershipFee;
@property (strong, nonatomic) UIButton *buttonAccept, *buttonCancel;
@property (strong, nonatomic) UIView *myAlertView;
@property int deltaY;
@property (strong, nonatomic) NSString *cityId, *genderId, *bloodGroupId;
@end

@implementation RegistrationViewController
UIBarButtonItem *barButtonMenu;

int direction;
int shakes;
UIView *statusView;
UILabel *statusViewLabel;
UIView *imageView;
UIButton *buttonOptions;
UIBarButtonItem *doneButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Registration";
        self.view.backgroundColor = [UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:35.0f/255.0f alpha:1.0f];
    }
    return self;
}

-(void) getToken{
    NSDictionary *parameters = @{@"username":@"ganesh",@"password":@"123456"};
    [GetData postDataToUrl:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/login" withParameters:parameters withHeader:nil WithCompletion:^(NSMutableArray *array) {
        int error = [[[array objectAtIndex:0] valueForKey:@"error"] intValue];
        if (error == 0) {
            AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
            appDelegate.xAuthToken = [[array objectAtIndex:0] valueForKey:@"csrf_token"];
            _token = appDelegate.xAuthToken;
            appDelegate.user_id = [[array objectAtIndex:0] valueForKey:@"user_id"];
        }
        else{
            
        }
    }];
}

-(void) checkOrientation{
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            imageView.frame = CGRectMake(412, 940, 200, 200);
            _buttonLifeTimeSub.frame = CGRectMake(230, 1290, 200, 100);
            _buttonYearlySub.frame = CGRectMake(560, 1290, 200, 100);
            
        }
        else{
            statusView.frame = CGRectMake(10, 5, 460, 40);
            imageView.frame = CGRectMake(190, 570, 100, 100);
            _buttonLifeTimeSub.frame = CGRectMake(130, 715, 80, 35);
            _buttonYearlySub.frame = CGRectMake(270, 715, 80, 35);
        }
    }
    else{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            imageView.frame = CGRectMake(284, 940, 200, 200);
            _buttonLifeTimeSub.frame = CGRectMake(160, 1290, 200, 100);
            _buttonYearlySub.frame = CGRectMake(390, 1290, 200, 100);
        }
        else{
            statusView.frame = CGRectMake(10, 25, 300, 40);
            imageView.frame = CGRectMake(110, 570, 100, 100);
            _buttonLifeTimeSub.frame = CGRectMake(80, 715, 80, 35);
            _buttonYearlySub.frame = CGRectMake(170, 715, 80, 35);
        }
    }
    
}


-(void) changeDevice{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        _scrollView.frame = CGRectMake(0, _deltaY, 768, self.view.frame.size.height-_deltaY);
        _scrollView.contentSize = CGSizeMake(768, 1500);
        
        buttonOptions.frame = CGRectMake(0, 0, 30, 30);
        _toolBar.frame = CGRectMake(0, 100, 768, 60);
        
        statusView.frame = CGRectMake(10, 25, 748, 40);
        statusViewLabel.frame = CGRectMake(10, 10, 300, 20);
        
        _labelNewMember.frame = CGRectMake(30, 10, 250, 150);
        _labelNewMember.font = [UIFont systemFontOfSize:60];
        
        _tfName.frame = CGRectMake(30, 160, 708, 60);
        _tfName.font = [UIFont systemFontOfSize:40];
        
        _tfPhone.frame = CGRectMake(30, 235, 708, 60);
        _tfPhone.font = [UIFont systemFontOfSize:40];
        
        _tfProfession.frame = CGRectMake(30, 310, 708, 60);
        _tfProfession.font = [UIFont systemFontOfSize:40];
        
        _tfEmail.frame = CGRectMake(30, 385, 708, 60);
        _tfEmail.font = [UIFont systemFontOfSize:40];
        
        _tfDOB.frame = CGRectMake(30, 460, 708, 60);
        _tfDOB.font = [UIFont systemFontOfSize:40];
        
        _buttonGender.frame = CGRectMake(30, 535, 708, 60);
        _buttonGender.titleLabel.font = [UIFont systemFontOfSize:40];
        
        _buttonBloodGroup.frame = CGRectMake(30, 610, 708, 60);
        _buttonBloodGroup.titleLabel.font = [UIFont systemFontOfSize:40];
        
        _tfAddress.frame = CGRectMake(30, 685, 708, 60);
        _tfAddress.font = [UIFont systemFontOfSize:40];
        
        _buttonLocation.frame = CGRectMake(30, 760, 708, 60);
        _buttonLocation.titleLabel.font = [UIFont systemFontOfSize:40];
        
        _tfPinCode.frame = CGRectMake(30, 835, 708, 60);
        _tfPinCode.font = [UIFont systemFontOfSize:40];
        
        imageView.frame = CGRectMake(284, 940, 200, 200);
        _profilePic.frame = CGRectMake(0, 0, 200, 200);
        _profilePic.layer.cornerRadius = 100;
        
        _buttonCheckBox.frame = CGRectMake(20, 1180, 40, 40);
        
        _labelTerms.frame = CGRectMake(100, 1180, 648, 60);
        _labelTerms.font = [UIFont systemFontOfSize:25];
        
        _buttonLifeTimeSub.frame = CGRectMake(160, 1290, 200, 100);
        _buttonLifeTimeSub.titleLabel.font = [UIFont systemFontOfSize:40];
        
        _buttonYearlySub.frame = CGRectMake(390, 1290, 200, 100);
        _buttonYearlySub.titleLabel.font = [UIFont systemFontOfSize:40];
        
        _tableGender.frame = CGRectMake(0, 0, 400, 240);
        _tableGender.center = self.view.center;
        
        _tableBloodGroup.frame = CGRectMake(0, 0, 500,300);
        _tableBloodGroup.center = self.view.center;
        
        _tableLocation.frame = CGRectMake(0, 0, 500, 600);
        _tableLocation.center = self.view.center;
        
        
        _tfName.borderStyle = UITextBorderStyleRoundedRect;
        _tfPhone.borderStyle = UITextBorderStyleRoundedRect;
        _tfProfession.borderStyle = UITextBorderStyleRoundedRect;
        _tfEmail.borderStyle = UITextBorderStyleRoundedRect;
        _tfDOB.borderStyle = UITextBorderStyleRoundedRect;
         _buttonGender.layer.cornerRadius = 7.5f;
        _buttonBloodGroup.layer.cornerRadius = 7.5f;
        _buttonLocation.layer.cornerRadius = 7.5f;
        _tfAddress.borderStyle = UITextBorderStyleRoundedRect;
        _tfPinCode.borderStyle = UITextBorderStyleRoundedRect;
    }
    else
    {
        _scrollView.frame = CGRectMake(0, _deltaY, 320, self.view.frame.size.height-_deltaY);
        _scrollView.contentSize = CGSizeMake(320, 780);
        buttonOptions.frame = CGRectMake(0, 0, 30, 30);
        _toolBar.frame = CGRectMake(0, 100, 320, 30);
        
         if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
             statusView.frame = CGRectMake(10, 25, 460, 40);
         }
         else{
            statusView.frame = CGRectMake(10, 25, 300, 40);
         }
        
        statusViewLabel.frame = CGRectMake(10, 0, 280, 40);
        _labelNewMember.frame = CGRectMake(10, 10, 150, 100);
        _tfName.frame = CGRectMake(10, 110, 300, 35);
        _tfPhone.frame = CGRectMake(10, 155, 300, 35);
        _tfProfession.frame = CGRectMake(10, 200, 300, 35);
        _tfEmail.frame = CGRectMake(10, 245, 300, 35);
        _tfDOB.frame = CGRectMake(10, 290, 300, 35);
        _buttonGender.frame = CGRectMake(10, 335, 300, 35);
        _buttonBloodGroup.frame = CGRectMake(10, 380, 300, 35);
        _tfAddress.frame = CGRectMake(10, 425, 300, 35);
        _buttonLocation.frame = CGRectMake(10, 470, 300, 35);
        _tfPinCode.frame = CGRectMake(10, 515, 300, 35);
        imageView.frame = CGRectMake(110, 570, 100, 100);
        _profilePic.frame = CGRectMake(0, 0, 100, 100);
        _buttonCheckBox.frame = CGRectMake(20, 680, 20, 20);
        _labelTerms.frame = CGRectMake(50, 675, 260, 30);
        _buttonLifeTimeSub.frame = CGRectMake(80, 715, 80, 35);
        _buttonYearlySub.frame = CGRectMake(170, 715, 80, 35);
        _tableGender.frame = CGRectMake(0, 0, 200, 120);
        _tableBloodGroup.frame = CGRectMake(0, 0, 250,150);
        _tableLocation.frame = CGRectMake(0, 0, 250, 300);
    }
    [self checkOrientation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    buttonOptions = [[UIButton alloc] init];
    [buttonOptions setBackgroundImage:[UIImage imageNamed:@"ic_menu.png"] forState:UIControlStateNormal];
    [buttonOptions addTarget:self action:@selector(displayOptionsMenu:) forControlEvents:UIControlEventTouchUpInside];
    [buttonOptions setShowsTouchWhenHighlighted:YES];
    barButtonMenu = [[UIBarButtonItem alloc] initWithCustomView:buttonOptions];
    
    self.navigationItem.rightBarButtonItem = barButtonMenu;
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if([version hasPrefix:@"7."]){
        _deltaY = 64;
    }
    else{
        _deltaY = 0;
    }
    
    [self getToken];
    [self createAlertView];
    
    _toolBar = [[UIToolbar alloc] init];
    _toolBar.hidden = YES;
    _toolBar.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(hideDatePicker)];
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [_toolBar setItems:[NSArray arrayWithObjects:flexiableItem, doneButton, nil]];
    
    
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    statusView = [[UIView alloc] init];
    statusViewLabel = [[UILabel alloc] init];
    statusViewLabel.text = @"hiiii";
    statusViewLabel.numberOfLines = 2;
    statusViewLabel.backgroundColor = [UIColor clearColor];
    statusViewLabel.textColor = [UIColor whiteColor];
    [statusView addSubview:statusViewLabel];
    statusView.backgroundColor = [UIColor redColor];
    statusView.hidden = YES;
    statusView.alpha = 0.0f;
    [self.view addSubview:statusView];
    
    _labelNewMember = [[UILabel alloc] init];
    _labelNewMember.text = @"New Member";
    _labelNewMember.numberOfLines = 2;
    _labelNewMember.textColor = [UIColor whiteColor];
    _labelNewMember.backgroundColor = [UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:0.0f];
    _labelNewMember.font = [UIFont fontWithName:@"Avenir-Light" size:35];
    [_scrollView addSubview:_labelNewMember];
    
    _tfName = [[UITextField alloc] init];
    _tfName.placeholder = @"Name";
    
    _tfName.delegate = self;
    _tfName.backgroundColor = [UIColor whiteColor];
    _tfName.tag = 0;
    [_scrollView addSubview:_tfName];
    _tfName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tfName.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _tfPhone = [[UITextField alloc] init];
    _tfPhone.placeholder = @"Phone";
    
    _tfPhone.delegate = self;
    _tfPhone.backgroundColor = [UIColor whiteColor];
    _tfPhone.tag = 1;
    _tfPhone.keyboardType = UIKeyboardTypeNumberPad;
    [_scrollView addSubview:_tfPhone];
    _tfPhone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_tfPhone setInputAccessoryView:_toolBar];
    _tfPhone.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _tfProfession = [[UITextField alloc] init];
    _tfProfession.placeholder = @"Profession";
    
    _tfProfession.delegate = self;
    _tfProfession.backgroundColor = [UIColor whiteColor];
    _tfProfession.tag = 2;
    [_scrollView addSubview:_tfProfession];
    _tfProfession.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tfProfession.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _tfEmail = [[UITextField alloc] init];
    _tfEmail.placeholder = @"Email";
    
    _tfEmail.delegate = self;
    _tfEmail.backgroundColor = [UIColor whiteColor];
    _tfEmail.tag = 3;
    [_scrollView addSubview:_tfEmail];
    _tfEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tfEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _tfEmail.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _tfDOB = [[UITextField alloc] init];
    _tfDOB.placeholder = @"Date Of Birth";
    
    _tfDOB.delegate = self;
    _tfDOB.backgroundColor = [UIColor whiteColor];
    _tfDOB.tag = 4;
    [_tfDOB setInputAccessoryView:_toolBar];
    [_scrollView addSubview:_tfDOB];
    _tfDOB.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tfDOB.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _buttonGender = [[UIButton alloc] init];
    [_buttonGender setTitle:@"Gender" forState:UIControlStateNormal];
    _buttonGender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_buttonGender addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchUpInside];
    _buttonGender.backgroundColor = [UIColor whiteColor];
    [_buttonGender setTitleColor:[UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:0.75f] forState:UIControlStateNormal];
    _buttonGender.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_scrollView addSubview:_buttonGender];
   
    
    _buttonBloodGroup = [[UIButton alloc] init];
    [_buttonBloodGroup setTitle:@"Blood Group" forState:UIControlStateNormal];
    _buttonBloodGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_buttonBloodGroup addTarget:self action:@selector(selectBloodGroup:) forControlEvents:UIControlEventTouchUpInside];
    _buttonBloodGroup.backgroundColor = [UIColor whiteColor];
    [_buttonBloodGroup setTitleColor:[UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:0.75f] forState:UIControlStateNormal];
    _buttonBloodGroup.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [_scrollView addSubview:_buttonBloodGroup];
    
    _tfAddress = [[UITextField alloc] init];
    _tfAddress.placeholder = @"Full Address";
    _tfAddress.delegate = self;
    _tfAddress.backgroundColor = [UIColor whiteColor];
    _tfAddress.tag = 5;
    [_scrollView addSubview:_tfAddress];
    _tfAddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tfAddress.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _buttonLocation = [[UIButton alloc] init];
    [_buttonLocation setTitle:@"Location" forState:UIControlStateNormal];
    _buttonLocation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_buttonLocation addTarget:self action:@selector(selectLocation:) forControlEvents:UIControlEventTouchUpInside];
    _buttonLocation.backgroundColor = [UIColor whiteColor];
    [_buttonLocation setTitleColor:[UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:0.75f] forState:UIControlStateNormal];
    _buttonLocation.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [_scrollView addSubview:_buttonLocation];
    
    //    [_buttonLocation.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    //    [_buttonLocation.layer setBorderWidth:2.0];
    
    _tfPinCode = [[UITextField alloc] init];
    _tfPinCode.placeholder = @"Pincode";
    
    _tfPinCode.delegate = self;
    _tfPinCode.backgroundColor = [UIColor whiteColor];
    _tfPinCode.tag = 6;
    [_scrollView addSubview:_tfPinCode];
    _tfPinCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tfPinCode.keyboardType = UIKeyboardTypeNumberPad;
    _tfPinCode.inputAccessoryView = _toolBar;
    _tfPinCode.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    
    imageView = [[UIView alloc] init];
    imageView.userInteractionEnabled = YES;
    [_scrollView addSubview:imageView];
    
    _profilePic = [[UIImageView alloc] init];
    [_profilePic setImage:[UIImage imageNamed:@"no-profile-pic.jpeg"]];
    _profilePic.userInteractionEnabled = YES;
    [_profilePic addGestureRecognizer:singleTap];
    _profilePic.layer.cornerRadius = 50.0f;
    _profilePic.layer.masksToBounds = YES;
    _profilePic.contentMode = UIViewContentModeScaleAspectFill;
    [imageView addSubview:_profilePic];

    _buttonCheckBox = [[UIButton alloc] init];
    [_buttonCheckBox setBackgroundImage:[UIImage imageNamed:@"Icon_Unchecked.png"] forState:UIControlStateNormal];
    _isChecked = NO;
    [_buttonCheckBox addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_buttonCheckBox];
    
    _labelTerms = [[UILabel alloc] init];
    _labelTerms.text = @"I have read, and accept terms of use and privacy statement/policy";
    _labelTerms.numberOfLines = 2;
    _labelTerms.textColor = [UIColor whiteColor];
    _labelTerms.backgroundColor = [UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:0.0f];
    _labelTerms.font = [UIFont fontWithName:@"Helvetica" size:10];
    _labelTerms.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_scrollView addSubview:_labelTerms];
    
    _buttonLifeTimeSub = [[UIButton alloc] init];
    [_buttonLifeTimeSub setTitle:@"LifeTime" forState:UIControlStateNormal];
    _buttonLifeTimeSub.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_buttonLifeTimeSub addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
    _buttonLifeTimeSub.backgroundColor = [UIColor whiteColor];
    [_buttonLifeTimeSub setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _buttonLifeTimeSub.tag = 0;
    [_scrollView addSubview:_buttonLifeTimeSub];
    
    _buttonYearlySub = [[UIButton alloc] init];
    [_buttonYearlySub setTitle:@"Yearly" forState:UIControlStateNormal];
    _buttonYearlySub.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_buttonYearlySub addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
    _buttonYearlySub.backgroundColor = [UIColor whiteColor];
    [_buttonYearlySub setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _buttonYearlySub.tag = 1;
    [_scrollView addSubview:_buttonYearlySub];
    
    
//    NSLayoutConstraint *lifetime = [NSLayoutConstraint constraintWithItem:_buttonLifeTimeSub attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:-30.0f];
//    
//    NSLayoutConstraint *yearly = [NSLayoutConstraint constraintWithItem:_buttonYearlySub attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:30.0f];
//    
//    [self.view addConstraints:[NSArray arrayWithObjects:lifetime,yearly, nil]];
    
//    _buttonYearlySub.translatesAutoresizingMaskIntoConstraints = NO;
//    _buttonLifeTimeSub.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self changeDevice];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            imageView.frame = CGRectMake(412, 940, 200, 200);
            _buttonLifeTimeSub.frame = CGRectMake(230, 1290, 200, 100);
            _buttonYearlySub.frame = CGRectMake(560, 1290, 200, 100);
            
        }
        else{
            statusView.frame = CGRectMake(10, 5, 460, 40);
            imageView.frame = CGRectMake(190, 570, 100, 100);
            _buttonLifeTimeSub.frame = CGRectMake(130, 715, 80, 35);
            _buttonYearlySub.frame = CGRectMake(270, 715, 80, 35);
        }
    }
    else{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            imageView.frame = CGRectMake(284, 940, 200, 200);
            _buttonLifeTimeSub.frame = CGRectMake(160, 1290, 200, 100);
            _buttonYearlySub.frame = CGRectMake(390, 1290, 200, 100);
        }
        else{
            statusView.frame = CGRectMake(10, 25, 300, 40);
            imageView.frame = CGRectMake(110, 570, 100, 100);
            _buttonLifeTimeSub.frame = CGRectMake(80, 715, 80, 35);
            _buttonYearlySub.frame = CGRectMake(170, 715, 80, 35);
        }
    }
}

-(void) selectGender:(id) sender{
    [_scrollView endEditing:YES];
    
    [GetData getDataFromUrl:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/gender" withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
        _arrayGenders = [[array objectAtIndex:0] objectForKey:@"gender"];
        if (_tableGender == nil) {
            _tableGender = [[UITableView alloc] init];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                _tableGender.frame = CGRectMake(0, 0, 400, 240);
            }
            else{
                _tableGender.frame = CGRectMake(0, 0, 200, 120);
            }
            //            [self changeDevice];
            _tableGender.center = self.view.center;
            _tableGender.tag = 0;
            _tableGender.dataSource = self;
            _tableGender.delegate = self;
            _tableGender.layer.cornerRadius = 10.0f;
            _scrollView.alpha = 0.3f;
            _tableGender.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:_tableGender];
            _scrollView.userInteractionEnabled = NO;
        }
        else{
            _tableGender.hidden = NO;
            _scrollView.alpha = 0.3f;
            _scrollView.userInteractionEnabled = NO;
        }


    }];
    //        [_scrollView setContentOffset:CGPointMake(0, _buttonGender.frame.origin.y) animated:YES];
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
//    [manager GET:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/gender" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //        NSLog(@"%@",responseObject);
//        _arrayGenders = [responseObject objectForKey:@"gender"];
//        //        [_scrollView setContentOffset:CGPointMake(0, _buttonGender.frame.origin.y) animated:YES];
//        if (_tableGender == nil) {
//            _tableGender = [[UITableView alloc] init];
//            
//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//            {
//                _tableGender.frame = CGRectMake(0, 0, 400, 240);
//            }
//            else{
//                _tableGender.frame = CGRectMake(0, 0, 200, 120);
//            }
////            [self changeDevice];
//            _tableGender.center = self.view.center;
//            _tableGender.tag = 0;
//            _tableGender.dataSource = self;
//            _tableGender.delegate = self;
//            _tableGender.layer.cornerRadius = 10.0f;
//            _scrollView.alpha = 0.3f;
//            _tableGender.backgroundColor = [UIColor whiteColor];
//            [self.view addSubview:_tableGender];
//            _scrollView.userInteractionEnabled = NO;
//        }
//        else{
//            _tableGender.hidden = NO;
//            _scrollView.alpha = 0.3f;
//            _scrollView.userInteractionEnabled = NO;
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    }];
}

-(void) selectBloodGroup:(id) sender{
    
    [_scrollView endEditing:YES];
        
        [GetData getDataFromUrl:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/blood_groups" withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
        
        _arrayBloodGroups = [[array objectAtIndex:0] objectForKey:@"bloodGroups"];
        if (_tableBloodGroup == nil) {
            _tableBloodGroup = [[UITableView alloc] init];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                _tableBloodGroup.frame = CGRectMake(0, 0, 500, 300);
            }
            else{
                _tableBloodGroup.frame = CGRectMake(0, 0, 250, 150);
            }
//            [self changeDevice];
            _tableBloodGroup.center = self.view.center;
            _tableBloodGroup.tag = 1;
            _tableBloodGroup.dataSource = self;
            _tableBloodGroup.delegate = self;
            _tableBloodGroup.layer.cornerRadius = 10.0f;
            
            _tableBloodGroup.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:_tableBloodGroup];
            _scrollView.alpha = 0.3f;
            _scrollView.userInteractionEnabled = NO;
        }
        else{
            _tableBloodGroup.hidden = NO;
            _scrollView.alpha = 0.3f;
            _scrollView.userInteractionEnabled = NO;
        }
    }];
}

-(void) selectLocation:(id) sender{
    
    [_scrollView endEditing:YES];
    
        [GetData getDataFromUrl:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/city" withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
        
        _arrayLocations = [[array objectAtIndex:0] objectForKey:@"cities"];
        if (_tableLocation == nil) {
            _tableLocation = [[UITableView alloc] init];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                _tableLocation.frame = CGRectMake(0, 0, 500, 600);
            }
            else{
                _tableLocation.frame = CGRectMake(0, 0, 250, 300);
            }
//            [self changeDevice];
            _tableLocation.center = self.view.center;
            _tableLocation.tag = 2;
            _tableLocation.dataSource = self;
            _tableLocation.delegate = self;
            _tableLocation.backgroundColor = [UIColor whiteColor];
            _tableLocation.layer.cornerRadius = 10.0f;
            [self.view addSubview:_tableLocation];
            _scrollView.alpha = 0.3f;
            _scrollView.userInteractionEnabled = NO;
        }
        else{
            _tableLocation.hidden = NO;
            _scrollView.alpha = 0.3f;
            _scrollView.userInteractionEnabled = NO;
        }
    }];
}

- (void) createAlertView{
    _myAlertView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 240)];
    _myAlertView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myAlertView];
    _myAlertView.hidden = YES;
    
    _labelAlertTittle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 30)];
    _labelAlertTittle.textColor = [UIColor colorWithRed:56.0f/255.0f green:168.0f/255.0f blue:223.0f/255.0f alpha:1.0f];
    _labelAlertTittle.backgroundColor = [UIColor whiteColor];
    [_myAlertView addSubview:_labelAlertTittle];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 300, 2)];
    [_myAlertView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithRed:56.0f/255.0f green:168.0f/255.0f blue:223.0f/255.0f alpha:1.0f];
    
    UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 47, 300, 193)];
    [_myAlertView addSubview:viewBackground];
    viewBackground.backgroundColor = [UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    
    _labelAlertMessage = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 300, 30)];
    _labelAlertMessage.text = @"Confirm Payment";
    [viewBackground addSubview:_labelAlertMessage];
    _labelAlertMessage.backgroundColor = viewBackground.backgroundColor = [UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    [_labelAlertMessage sizeToFit];
    
    
    UIView *subViewBackgroud = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 260, 85)];
    subViewBackgroud.backgroundColor = [UIColor whiteColor];
    [viewBackground addSubview:subViewBackgroud];
    
    _labelMembership = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    _labelMembership.text = @"Membership";
    [subViewBackgroud addSubview:_labelMembership];
    _labelMembership.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    
    _labelMembershipType = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 80, 30)];
    [subViewBackgroud addSubview:_labelMembershipType];
    _labelMembershipType.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
    
    
    _labelAmount = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 30)];
    _labelAmount.text = @"Amount";
    [subViewBackgroud addSubview:_labelAmount];
    _labelAmount.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    
    _labelMembershipFee = [[UILabel alloc] initWithFrame:CGRectMake(170, 50, 80, 30)];
    [subViewBackgroud addSubview:_labelMembershipFee];
    _labelMembershipFee.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
    
    _buttonAccept = [[UIButton alloc] initWithFrame:CGRectMake(50, 145, 80, 35)];
    [viewBackground addSubview:_buttonAccept];
    _buttonAccept.layer.cornerRadius = 10.0f;
    _buttonAccept.backgroundColor = [UIColor colorWithRed:48.0f/255.0f green:137.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
    [_buttonAccept setTitle:@"Accept" forState:UIControlStateNormal];
    [_buttonAccept addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonAccept setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _buttonAccept.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    _buttonCancel = [[UIButton alloc] initWithFrame:CGRectMake(150, 145, 80, 35)];
    _buttonCancel.layer.cornerRadius = 10.0f;
    [viewBackground addSubview:_buttonCancel];
    [_buttonCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    _buttonCancel.backgroundColor = [UIColor lightGrayColor];
    [_buttonCancel addTarget:self action:@selector(cancelAlertView:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _buttonCancel.titleLabel.font = [UIFont systemFontOfSize:14.0];
}

-(void) subscription:(id) sender{
    
    _scrollView.userInteractionEnabled = YES;
    _myAlertView.hidden = YES;
    _scrollView.alpha = 1.0f;
    
    direction = 1;
    shakes = 0;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    
    if (!_isChecked){
        statusViewLabel.text = @"Please Accept Terms";
        [self alert];
    }
    else if([_tfName.text length] == 0){
        statusViewLabel.text = @"Name is Mandatory";
        [_scrollView setContentOffset:CGPointZero];
        [self alert];
    }
    
    else if([_tfName.text length] < 5){
        statusViewLabel.text = @"Name length should be minmum 5";
        [_scrollView setContentOffset:CGPointZero];
        [self alert];
    }
    
    else if (_tfPhone.text.length != 10){
        _tfPhone.text = @"";
        statusViewLabel.text = @"Enter a valid phone number";
        direction = 1;
        shakes = 0;
        [_scrollView setContentOffset:CGPointZero];
        [self alert];
    }
    else if(![emailTest evaluateWithObject:_tfEmail.text]){
        _tfEmail.text = @"";
        statusViewLabel.text = @"Enter valid Email";
        [_scrollView setContentOffset:CGPointZero];
        [self alert];
    }
    else if (_tfDOB.text.length == 0){
        statusViewLabel.text = @"please select Date of Birth";
        [_scrollView setContentOffset:CGPointZero];
        [self alert];
    }
    else if ([_buttonGender.titleLabel.text isEqualToString:@"Gender"]){
        statusViewLabel.text = @"Select Gender";
        [_scrollView setContentOffset:CGPointZero];
        [self alert];
    }
    else if (_tfPinCode.text.length != 6 ){
        _tfPinCode.text = @"";
        statusViewLabel.text = @"Enter a Valid Pincode";
        [self alert];
    }
    
    else{
        if ([sender tag] == 0) {
            _scrollView.userInteractionEnabled = NO;
            _myAlertView.hidden = NO;
            _labelAlertTittle.text = @"LifeTime Payment";
            _scrollView.alpha = 0.05f;
            
            _labelMembershipType.text = @"LifeTime";
            _labelMembershipFee.text = @"Rs. 1100";
            
            
        }
        else if ([sender tag] == 1){
            _scrollView.userInteractionEnabled = NO;
            _myAlertView.hidden = NO;
            _labelAlertTittle.text = @"Yearly Payment";
            _scrollView.alpha = 0.05f;
            
            _labelMembershipType.text = @"Yearly";
            _labelMembershipFee.text = @"Rs. 400";
        }
    }
}

-(void) registerUser:(id)sender{
    
    NSDictionary *parameters = @{@"firstname": _tfName.text,@"email":_tfEmail.text,@"mobile":_tfPhone.text,@"dob":_tfDOB.text,@"gender_id":_genderId,@"address":[NSString stringWithFormat:@"%@",_tfAddress.text],@"blood_group_id":_bloodGroupId,@"pincode":_tfPinCode.text,@"current_city_id":_cityId,@"profession":[NSString stringWithFormat:@"%@",_tfProfession.text]};
    
    [GetData postDataToUrl:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/register" withParameters:parameters withHeader:_token WithCompletion:^(NSMutableArray *array) {
        _profileViewController = [[ProfileViewController alloc] init];
        _profileViewController.token = _token;
        _profileViewController.user_id = [[array objectAtIndex:0] objectForKey:@"user_id"];
        
        [UIView animateWithDuration:1 animations:^
         {
             statusView.backgroundColor = [UIColor colorWithRed:84.0f/255.0f green:138.0f/255.0f blue:6.0f/255.0f alpha:1.0f];
             statusViewLabel.text = @"Registered Successfully";
             
             statusView.frame = CGRectMake(10, 25+_deltaY, 300, 40);
         }
                         completion:^(BOOL finished)
         {
             [UIView animateWithDuration:1 delay:1.5 options:UIViewAnimationOptionTransitionNone animations:^
              {
                  statusView.frame = CGRectMake(10, 25, 300, 40);
              }
                              completion:^(BOOL finished){
                                  [self.navigationController pushViewController:_profileViewController animated:YES];
                              }];
         }];
        
        _scrollView.userInteractionEnabled = YES;
        _myAlertView.hidden = YES;
        _scrollView.alpha = 1.0f;
    }];

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
//    [manager POST:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/register" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        NSLog(@"%@",responseObject);
//        
//        
//        _profileViewController = [[ProfileViewController alloc] init];
//        _profileViewController.token = _token;
//        _profileViewController.user_id = [responseObject objectForKey:@"user_id"];
//        
//        [UIView animateWithDuration:1 animations:^
//         {
//             statusView.backgroundColor = [UIColor colorWithRed:84.0f/255.0f green:138.0f/255.0f blue:6.0f/255.0f alpha:1.0f];
//             statusViewLabel.text = @"Registered Successfully";
//             
//             statusView.frame = CGRectMake(10, 0+_deltaY, 300, 40);
//         }
//                         completion:^(BOOL finished)
//         {
//             [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionTransitionNone animations:^
//              {
//                  statusView.frame = CGRectMake(10, -50, 300, 40);
//              }
//                              completion:^(BOOL finished){
//                                  [self.navigationController pushViewController:_profileViewController animated:YES];
//                              }];
//         }];
//        
//        
//        _scrollView.userInteractionEnabled = YES;
//        _myAlertView.hidden = YES;
//        _scrollView.alpha = 1.0f;
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed");
//    }];
    
    
}

-(void) cancelAlertView :(id) sender{
    _scrollView.userInteractionEnabled = YES;
    _myAlertView.hidden = YES;
    _scrollView.alpha = 1.0f;
}

- (void) checkboxClicked:(id) sender{
    if (_isChecked == NO) {
        [_buttonCheckBox setBackgroundImage:[UIImage imageNamed:@"Icon_Checked.png"] forState:UIControlStateNormal];
        _isChecked = YES;
    }
    else{
        [_buttonCheckBox setBackgroundImage:[UIImage imageNamed:@"Icon_Unchecked.png"] forState:UIControlStateNormal];
        _isChecked = NO;
    }
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return [_arrayGenders count];
    }
    else if (tableView.tag == 1){
        return [_arrayBloodGroups count];
    }
    else{
        return [_arrayLocations count];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        static NSString *cellIdentifier = @"Cell";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [[_arrayGenders objectAtIndex:indexPath.row] valueForKey:@"gendername"];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:14.0f];
        return cell;
    }
    else if (tableView.tag == 1){
        static NSString *cellIdentifier = @"Cell";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [[_arrayBloodGroups objectAtIndex:indexPath.row] valueForKey:@"blood_group_name"];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:14.0f];
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"Cell";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [[_arrayLocations objectAtIndex:indexPath.row] valueForKey:@"city_name"];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:14.0f];
        return cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        //        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _tableGender.hidden = YES;
        _scrollView.alpha = 1.0f;
        _scrollView.userInteractionEnabled = YES;
        [_buttonGender setTitle:[[_arrayGenders objectAtIndex:indexPath.row] valueForKey:@"gendername"] forState:UIControlStateNormal];
        [_buttonGender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _genderId = [[_arrayGenders objectAtIndex:indexPath.row] valueForKey:@"gender_id"];
    }
    else if (tableView.tag == 1){
        //        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _tableBloodGroup.hidden = YES;
        _scrollView.alpha = 1.0f;
        _scrollView.userInteractionEnabled = YES;
        [_buttonBloodGroup setTitle:[[_arrayBloodGroups objectAtIndex:indexPath.row] valueForKey:@"blood_group_name"] forState:UIControlStateNormal];
        [_buttonBloodGroup setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _bloodGroupId = [[_arrayBloodGroups objectAtIndex:indexPath.row] valueForKey:@"blood_group_id"];
    }
    else{
        //        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _tableLocation.hidden = YES;
        _scrollView.alpha = 1.0f;
        _scrollView.userInteractionEnabled = YES;
        [_buttonLocation setTitle:[[_arrayLocations objectAtIndex:indexPath.row] valueForKey:@"city_name"] forState:UIControlStateNormal];
        [_buttonLocation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cityId = [[_arrayLocations objectAtIndex:indexPath.row] valueForKey:@"city_id"];
    }
}


-(void) textFieldDidBeginEditing:(UITextField *)textField{
    _tableGender.hidden = YES;
    _tableBloodGroup.hidden = YES;
    _tableLocation.hidden = YES;
    [_scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - 20) animated:YES];
    if (textField.tag == 4) {
        _datePicker = [[UIDatePicker alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
             _datePicker.frame = CGRectMake(0, 0, 768, 400);
        }
        else{
             _datePicker.frame = CGRectMake(0, 0, 320, 200);
        }
        
        _datePicker.maximumDate = [NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker setDate:[NSDate date]];
        [_datePicker addTarget:self action:@selector(updateTextFieldDates:) forControlEvents:UIControlEventValueChanged];
        [textField setInputView:_datePicker];
        _toolBar.hidden = NO;
    }
    else if (textField.tag == 1 || textField.tag == 6){
        _toolBar.hidden = NO;
    }
}


-(void) textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag < 5) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//        [_scrollView endEditing:YES];
    //    [super touchesBegan:touches withEvent:event];
    //    _tableGender.hidden = YES;
    //    _tableBloodGroup.hidden = YES;
    //    _tableLocation.hidden = YES;
    //    _scrollView.alpha = 1.0f;
    //    NSLog(@"Touched");
    if (_tableGender.hidden == NO) {
        _tableGender.hidden = YES;
    }
    if (_tableBloodGroup.hidden == NO) {
        _tableBloodGroup.hidden = YES;
    }
    if (_tableLocation.hidden == NO) {
        _tableLocation.hidden = YES;
    }
    _scrollView.userInteractionEnabled = YES;
    _scrollView.alpha = 1.0f;
}

-(void)updateTextFieldDates:(UITextField *)sender
{
    _dateFormatter = [[NSDateFormatter alloc] init];
    _datePicker = (UIDatePicker*)_tfDOB.inputView;
    NSString *date = [NSString stringWithFormat:@"%@",_datePicker.date];
    //_tfStartDate.text = [NSString stringWithFormat:@"%@",picker.date];
    
    _dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    _date = [_dateFormatter dateFromString:date];
    _dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    _tfDOB.text = [_dateFormatter stringFromDate:_date];
}

- (void) hideDatePicker{
    _toolBar.hidden = YES;
    [self.view endEditing:YES];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)tapDetected{
    //    static BOOL beenHereBefore = NO;
    //    if (beenHereBefore){
    //        /* Only display the picker once as the viewDidAppear: method gets
    //         called whenever the view of our view controller gets displayed */
    //        return; } else {
    //            beenHereBefore = YES;
    //        }
//    NSLog(@"here");
    if ([self isPhotoLibraryAvailable]){ UIImagePickerController *controller =
        [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
//        [controller setAllowsEditing:YES];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _profileImage = info[UIImagePickerControllerOriginalImage];
    
    NSData *data = UIImagePNGRepresentation(_profileImage);
    NSString *myGrabbedImage = @"myGrabbedImage.png";
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    
    [_profilePic setImage:_profileImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *fullPathToFile = [documentDirectory stringByAppendingPathComponent:myGrabbedImage];
    [data writeToFile:fullPathToFile atomically:YES];
}

-(void)alert{
//    [UIView animateWithDuration:0.03 animations:^
//     {
//         view.transform = CGAffineTransformMakeTranslation(5*direction, 0);
//     }
//                     completion:^(BOOL finished)
//     {
//         if(shakes >= 10)
//         {
//             view.transform = CGAffineTransformIdentity;
//             return;
//         }
//         shakes++;
//         direction = direction * -1;
//         [self shake:view];
//     }];
    
    _buttonLifeTimeSub.enabled = NO;
    _buttonYearlySub.enabled = NO;
    statusView.hidden = NO;
    
    [UIView animateWithDuration:1 animations:^
    {
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
        {
            statusView.frame = CGRectMake(10, 0+_deltaY-15, 460, 40);
            statusView.alpha = 1.0f;
        }
        else{
            statusView.frame = CGRectMake(10, 0+_deltaY, 300, 40);
            statusView.alpha = 1.0f;
        }
    }
     
completion:^(BOOL finished)
    {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionTransitionNone animations:^
         {
             if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
             {
                 statusView.frame = CGRectMake(10, 25, 460, 40);
                 statusView.alpha = 0.0f;
             }
             else{
                 statusView.frame = CGRectMake(10, 25, 300, 40);
                 statusView.alpha = 0.0f;
             }
         }
                         completion:^(BOOL finished) {
                             _buttonLifeTimeSub.enabled = YES;
                             _buttonYearlySub.enabled = YES;
                             statusView.hidden = YES;
                         }];
    }];
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:3];
//    statusView.frame = CGRectMake(0, 0, 300, 50);
//    [UIView commitAnimations];
}

-(void) displayOptionsMenu:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Members List"
                                                    otherButtonTitles:nil];
    actionSheet.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.0f];

    [actionSheet showFromBarButtonItem:barButtonMenu animated:YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        _membersViewController = [[MembersViewController alloc] init];
        _membersViewController.token = _token;
        [self.navigationController pushViewController:_membersViewController animated:YES];
    }
}

-(void) viewWillAppear:(BOOL)animated{
//    _tfName.text = @"";
//    _tfPhone.text = @"";
//    _tfEmail.text = @"";
//    _tfDOB.text = @"";
//    _tfAddress.text = @"";
//    _tfProfession.text = @"";
//    _tfPinCode.text = @"";
//    [_buttonGender setTitle:@"Gender" forState:UIControlStateNormal];
//    [_buttonGender setTitleColor:[UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:0.75f] forState:UIControlStateNormal];
//    [_buttonBloodGroup setTitle:@"Blood Group" forState:UIControlStateNormal];
//    [_buttonBloodGroup setTitleColor:[UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:0.75f] forState:UIControlStateNormal];
//    [_buttonLocation setTitle:@"Location" forState:UIControlStateNormal];
//    [_buttonLocation setTitleColor:[UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:0.75f] forState:UIControlStateNormal];
//    
//    [_buttonCheckBox setBackgroundImage:[UIImage imageNamed:@"Icon_Unchecked.png"] forState:UIControlStateNormal];
//    _isChecked = NO;
//    
//    [_scrollView setContentOffset:CGPointZero];
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if([version hasPrefix:@"7."]){
        _deltaY = 64;
    }
    else{
        _deltaY = 0;
    }

    
    [self checkOrientation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
