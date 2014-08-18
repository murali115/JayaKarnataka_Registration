//
//  ProfileViewController.m
//  Registration_Mock
//
//  Created by Mac1 on 7/17/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "GetData.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

int deltaY;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) checkOrientation{
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        
         _scrollView.frame = CGRectMake(0, deltaY, self.view.frame.size.width, self.view.frame.size.height);
        _scrollView.contentSize = CGSizeMake(480, 855+deltaY);
        
        _imageViewTheme.frame = CGRectMake(0, 0, 480, 180);
        _imageViewProfilePic.frame = CGRectMake(195, 140, 90, 90);
        
        _view1.frame = CGRectMake(5, 250, 470, 90);
        
        _labelUserName.frame = CGRectMake(0, 0, 460, 30);
        _imageViewEdit.frame = CGRectMake(440, 5, 15, 15);
        _labelLives.frame = CGRectMake(0, 30, 460, 15);
        _labelStudy.frame = CGRectMake(0, 45, 460, 15);
        _labelWork.frame = CGRectMake(0, 60, 460, 15);
        
        
        _view2.frame = CGRectMake(5, 350, 470, 150);
        _view3.frame = CGRectMake(5, 510, 470, 150);
        _view4.frame = CGRectMake(5, 670, 470, 110);
        _view5.frame = CGRectMake(5, 790, 470, 55);
    }
    else{
        _scrollView.frame = CGRectMake(0, deltaY, self.view.frame.size.width, self.view.frame.size.height);
        _scrollView.contentSize = CGSizeMake(320, 855+deltaY);
        
        _imageViewTheme.frame = CGRectMake(0, 0, 320, 180);
        _imageViewProfilePic.frame = CGRectMake(110, 140, 90, 90);
        
        _view1.frame = CGRectMake(5, 250, 310, 90);
        
        _labelUserName.frame = CGRectMake(0, 0, 300, 30);
        _imageViewEdit.frame = CGRectMake(285, 5, 15, 15);
        _labelLives.frame = CGRectMake(0, 30, 300, 15);
        _labelStudy.frame = CGRectMake(0, 45, 300, 15);
        _labelWork.frame = CGRectMake(0, 60, 300, 15);
        
        
        _view2.frame = CGRectMake(5, 350, 310, 150);
        _view3.frame = CGRectMake(5, 510, 310, 150);
        _view4.frame = CGRectMake(5, 670, 310, 110);
        _view5.frame = CGRectMake(5, 790, 310, 55);
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem.title = @"Back";
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if([version hasPrefix:@"7."]){
        deltaY = 65;
        
    }
    else{
        deltaY = 0;
    }
    
//    [self getToken];
    
    [self loadUserInfo];
}

-(void) getToken{
    NSDictionary *parameters = @{@"username":@"ganesh",@"password":@"123456"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int error = [[responseObject valueForKey:@"error"] intValue];
        if (error == 0) {
            AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
            appDelegate.xAuthToken = [responseObject valueForKey:@"csrf_token"];
            _token = appDelegate.xAuthToken;
            [self loadUserInfo];
        }
        else{
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void) loadUserInfo{
        
        [GetData getDataFromUrl:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user/%@",_user_id] withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {

        _arrayProfile = [[array objectAtIndex:0] objectForKey:@"userDet"];
        
        if ([_arrayProfile count] != 0) {
            _dictionaryUserDetails = [_arrayProfile objectAtIndex:0];
            
            [self loadProfileView];
        }
        else{
            NSLog(@"error loading");
        }
        
    }];
    
}

-(void) loadProfileView{
    self.view.backgroundColor = [UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, deltaY, 480, 320)];
        
    }
    else{
        _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, deltaY, 320, 480)];
        
    }
    
    [self.view addSubview:_scrollView];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _imageViewTheme = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [_scrollView addSubview:_imageViewTheme];
    
    if ([[_dictionaryUserDetails valueForKey:@"user_cover_picture_path"] isEqualToString:@""]) {
        [_imageViewTheme setImage:[UIImage imageNamed:@"no-cover.jpg"]];
        
    }
    else{
        [_imageViewTheme setImageWithURL:[NSURL URLWithString:[_dictionaryUserDetails valueForKey:@"user_cover_picture_path"]]];
    }
    
    _imageViewTheme.backgroundColor = [UIColor whiteColor];
    
    _imageViewProfilePic = [[UIImageView alloc] initWithFrame:CGRectMake(110, 140, 90, 90)];
    [_scrollView addSubview:_imageViewProfilePic];
    _imageViewProfilePic.backgroundColor = [UIColor grayColor];
    
    if ([[_dictionaryUserDetails valueForKey:@"user_profile_picture_path"] isEqualToString:@""]) {
        [_imageViewProfilePic setImage:[UIImage imageNamed:@"no-profile-pic.jpeg"]];
        
        [_imageViewProfilePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[[_dictionaryUserDetails valueForKey:@"firstname"] substringToIndex:1] uppercaseString]]]];
    }
    else{
        NSString *imageUrl = [_dictionaryUserDetails valueForKey:@"user_profile_picture_path"];
        imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        [_imageViewProfilePic setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
    
//    [_imageViewProfilePic setImageWithURL:[NSURL URLWithString:[_dictionaryUserDetails valueForKey:@"user_profile_picture_path"]]];
    
    
    _imageViewProfilePic.layer.cornerRadius = 45.0f;
    _imageViewProfilePic.clipsToBounds = YES;
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(5, 250, 310, 90)];
    [_scrollView addSubview:_view1];
    _view1.backgroundColor = [UIColor whiteColor];

    
    _labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    _labelUserName.textAlignment = NSTextAlignmentCenter;
    _labelUserName.font = [UIFont systemFontOfSize:14];
    _labelUserName.text = [_dictionaryUserDetails valueForKey:@"firstname"];
    [_view1 addSubview:_labelUserName];
    
    
    _imageViewEdit = [[UIImageView alloc] initWithFrame:CGRectMake(285, 5, 15, 15)];
    _imageViewEdit.image = [UIImage imageNamed:@"edit.gif"];
    [_view1 addSubview:_imageViewEdit];
    _imageViewEdit.alpha = 0.5f;
    
    _labelLives = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 300, 15)];
    
    if ([_dictionaryUserDetails valueForKey:@"city_name"]  == (id)[NSNull null]) {
        _labelLives.text = [NSString stringWithFormat:@"LivesIn: NA"];
    }
    
    else{
    _labelLives.text = [NSString stringWithFormat:@"LivesIn: %@",[_dictionaryUserDetails valueForKey:@"city_name"]];
    }
    
    _labelLives.font = [UIFont systemFontOfSize:12];
    _labelLives.textAlignment = NSTextAlignmentCenter;
    [_view1 addSubview:_labelLives];
    _labelLives.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _labelStudy = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 300, 15)];
    _labelStudy.adjustsLetterSpacingToFitWidth = YES;
    
    
    if ([_dictionaryUserDetails valueForKey:@"edu"]  == (id)[NSNull null]) {
        _labelStudy.text = [NSString stringWithFormat:@"Studied At: NA"];
    }
    else{
        _labelStudy.text = [NSString stringWithFormat:@"Studied At: %@",[_dictionaryUserDetails valueForKey:@"edu"]];
    }
    
    
    _labelStudy.textAlignment = NSTextAlignmentCenter;
    _labelStudy.font = [UIFont systemFontOfSize:12];
    [_view1 addSubview:_labelStudy];
    _labelStudy.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _labelWork = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, 300, 15)];
    
    if ([_dictionaryUserDetails valueForKey:@"work"]  == (id)[NSNull null]) {
       _labelWork.text = [NSString stringWithFormat:@"Works At: NA"];
    }
    else{
    _labelWork.text = [NSString stringWithFormat:@"Works At: %@",[_dictionaryUserDetails valueForKey:@"work"]];
    }
    
    _labelWork.textAlignment = NSTextAlignmentCenter;
    _labelWork.font = [UIFont systemFontOfSize:12];
    [_view1 addSubview:_labelWork];
    _labelWork.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(5, 340, 310, 150)];
    [_scrollView addSubview:_view2];
    _view2.backgroundColor = [UIColor whiteColor];
    
    _labelBasicInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 280, 20)];
    _labelBasicInfo.text = @"Basic Information";
    _labelBasicInfo.font = [UIFont systemFontOfSize:12];
    [_view2 addSubview:_labelBasicInfo];
    
    _labelGender = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 280, 15)];
    _labelGender.text = @"Gender";
    _labelGender.font = [UIFont boldSystemFontOfSize:12];
    [_view2 addSubview:_labelGender];
    
    _labelGenderValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 280, 15)];
    _labelGenderValue.text = [_dictionaryUserDetails valueForKey:@"gendername"];
    _labelGenderValue.font = [UIFont systemFontOfSize:12];
    [_view2 addSubview:_labelGenderValue];
    _labelGenderValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    
    _labelBirthday = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, 280, 15)];
    _labelBirthday.text = @"Birthday";
    _labelBirthday.font = [UIFont boldSystemFontOfSize:12];
    [_view2 addSubview:_labelBirthday];
    
    _labelBirthdayValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 280, 15)];
    _labelBirthdayValue.text = [_dictionaryUserDetails valueForKey:@"dob"];
    _labelBirthdayValue.font = [UIFont systemFontOfSize:12];
    [_view2 addSubview:_labelBirthdayValue];
    _labelBirthdayValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _labelBloodGroup = [[UILabel alloc] initWithFrame:CGRectMake(5, 105, 280, 15)];
    _labelBloodGroup.text = @"Blood group";
    _labelBloodGroup.font = [UIFont boldSystemFontOfSize:12];
    [_view2 addSubview:_labelBloodGroup];
    
    _labelBloodGroupValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 280, 15)];
    
    if ([_dictionaryUserDetails valueForKey:@"blood_group_name"]  == (id)[NSNull null]) {
        _labelBloodGroupValue.text = [NSString stringWithFormat:@"NA"];
    }
    else{
        _labelBloodGroupValue.text = [NSString stringWithFormat:@"%@",[_dictionaryUserDetails valueForKey:@"blood_group_name"]];
    }
    
    _labelBloodGroupValue.font = [UIFont systemFontOfSize:12];
    [_view2 addSubview:_labelBloodGroupValue];
    _labelBloodGroupValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];

    
    _view3 = [[UIView alloc] initWithFrame:CGRectMake(5, 500, 310, 150)];
    [_scrollView addSubview:_view3];
    _view3.backgroundColor = [UIColor whiteColor];
    
    _labelContactInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 280, 20)];
    
    _labelContactInfo.text = @"Contact Information";
    
    _labelContactInfo.font = [UIFont systemFontOfSize:12];
    [_view3 addSubview:_labelContactInfo];
    
    _labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 280, 15)];
    _labelEmail.text = @"Email";
    _labelEmail.font = [UIFont boldSystemFontOfSize:12];
    [_view3 addSubview:_labelEmail];
    
    _labelEmailValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 280, 15)];
    if ([_dictionaryUserDetails valueForKey:@"email"]  == (id)[NSNull null]) {
        _labelEmailValue.text = @"NA";
    }
    else{
        _labelEmailValue.text = [_dictionaryUserDetails valueForKey:@"email"];
    }
    
    _labelEmailValue.font = [UIFont systemFontOfSize:12];
    [_view3 addSubview:_labelEmailValue];
    _labelEmailValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];

    _labelMobile = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, 280, 15)];
    _labelMobile.text = @"Mobile";
    _labelMobile.font = [UIFont boldSystemFontOfSize:12];
    [_view3 addSubview:_labelMobile];
    
    _labelMobileValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 280, 15)];
    
    if ([_dictionaryUserDetails valueForKey:@"mobile"]  == (id)[NSNull null]) {
        _labelMobileValue.text = @"NA";
    }
    else{
        _labelMobileValue.text = [_dictionaryUserDetails valueForKey:@"mobile"];
    }
    
    _labelMobileValue.font = [UIFont systemFontOfSize:12];
    [_view3 addSubview:_labelMobileValue];
    _labelMobileValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];

    _labelCity = [[UILabel alloc] initWithFrame:CGRectMake(5, 105, 280, 15)];
    _labelCity.text = @"City";
    _labelCity.font = [UIFont boldSystemFontOfSize:12];
    [_view3 addSubview:_labelCity];
    
    _labelCityValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 280, 15)];
    
    if ([_dictionaryUserDetails valueForKey:@"city_name"]  == (id)[NSNull null]) {
        _labelCityValue.text = @"NA";
    }
    else{
        _labelCityValue.text = [_dictionaryUserDetails valueForKey:@"city_name"];
    }
    
    
    _labelCityValue.font = [UIFont systemFontOfSize:12];
    [_view3 addSubview:_labelCityValue];
    _labelCityValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];

    
    
    _view4 = [[UIView alloc] initWithFrame:CGRectMake(5, 660, 310, 110)];
    [_scrollView addSubview:_view4];
    _view4.backgroundColor = [UIColor whiteColor];
    
    _labelProffInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 280, 20)];
    _labelProffInfo.text = @"Professional Information";
    _labelProffInfo.font = [UIFont systemFontOfSize:12];
    [_view4 addSubview:_labelProffInfo];
    
    _labelStudiesAt = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 280, 15)];
    _labelStudiesAt.text = @"Studies at";
    _labelStudiesAt.font = [UIFont boldSystemFontOfSize:12];
    [_view4 addSubview:_labelStudiesAt];
    
    _labelStudiesAtValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 280, 15)];
    
    if ([_dictionaryUserDetails valueForKey:@"edu"]  == (id)[NSNull null]) {
        _labelStudiesAtValue.text = @"NA";
    }
    else{
    _labelStudiesAtValue.text = [NSString stringWithFormat:@"Studied At: %@",[_dictionaryUserDetails valueForKey:@"edu"]];
    }
    
    _labelStudiesAtValue.font = [UIFont systemFontOfSize:12];
    [_view4 addSubview:_labelStudiesAtValue];
    _labelStudiesAtValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];

    
    _labelWorksAt = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, 280, 15)];
    _labelWorksAt.text = @"Work";
    _labelWorksAt.font = [UIFont boldSystemFontOfSize:12];
    [_view4 addSubview:_labelWorksAt];
    
    _labelWorksAtValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 280, 15)];
    
    if ([_dictionaryUserDetails valueForKey:@"work"]  == (id)[NSNull null]) {
        _labelWorksAtValue.text = @"NA";
    }
    else{
        _labelWorksAtValue.text = [NSString stringWithFormat:@"Works At: %@",[_dictionaryUserDetails valueForKey:@"work"]];
    }
    
    _labelWorksAtValue.font = [UIFont systemFontOfSize:12];
    [_view4 addSubview:_labelWorksAtValue];
    _labelWorksAtValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];

    
    _view5 = [[UIView alloc] initWithFrame:CGRectMake(5, 780, 310, 55)];
    [_scrollView addSubview:_view5];
    _view5.backgroundColor = [UIColor whiteColor];
    
    _labelBio = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 280, 20)];
    _labelBio.text = @"Bio";
    _labelBio.font = [UIFont systemFontOfSize:12];
    [_view5 addSubview:_labelBio];
    
    _labelBioValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 280, 15)];
    
    if ([_dictionaryUserDetails valueForKey:@"bio"]  == (id)[NSNull null] || [[_dictionaryUserDetails valueForKey:@"bio"] isEqualToString:@""]) {
        _labelBioValue.text = @"NA";
    }
    
    else{
    _labelBioValue.text = [NSString stringWithFormat:@"%@",[_dictionaryUserDetails valueForKey:@"bio"]];
    }
    
    _labelBioValue.font = [UIFont systemFontOfSize:12];
    [_view5 addSubview:_labelBioValue];
    _labelBioValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    [self checkOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        
        _scrollView.frame = CGRectMake(0, deltaY, self.view.frame.size.width, self.view.frame.size.height);
//        _scrollView.contentOffset = CGPointZero;
        _scrollView.contentSize = CGSizeMake(480, 855);
        
        _imageViewTheme.frame = CGRectMake(0, 0-deltaY, 480, 180);
        _imageViewProfilePic.frame = CGRectMake(195, 140-deltaY, 90, 90);
        
        _view1.frame = CGRectMake(5, 250-deltaY, 470, 90);
        
        _labelUserName.frame = CGRectMake(0, 0, 460, 30);
        _imageViewEdit.frame = CGRectMake(440, 5, 15, 15);
        _labelLives.frame = CGRectMake(0, 30, 460, 15);
        _labelStudy.frame = CGRectMake(0, 45, 460, 15);
        _labelWork.frame = CGRectMake(0, 60, 460, 15);

        
        _view2.frame = CGRectMake(5, 350-deltaY, 470, 150);
        _view3.frame = CGRectMake(5, 510-deltaY, 470, 150);
        _view4.frame = CGRectMake(5, 670-deltaY, 470, 110);
        _view5.frame = CGRectMake(5, 790-deltaY, 470, 55);

    }
    else{
//        _scrollView.contentOffset = CGPointZero;
        _scrollView.frame = CGRectMake(0, deltaY, self.view.frame.size.width, self.view.frame.size.height);
        _scrollView.contentSize = CGSizeMake(320, 855);
        
        _imageViewTheme.frame = CGRectMake(0, 0-deltaY, 320, 180);
        _imageViewProfilePic.frame = CGRectMake(110, 140-deltaY, 90, 90);
        
        _view1.frame = CGRectMake(5, 250-deltaY, 310, 90);
        
        _labelUserName.frame = CGRectMake(0, 0, 300, 30);
        _imageViewEdit.frame = CGRectMake(285, 5, 15, 15);
        _labelLives.frame = CGRectMake(0, 30, 300, 15);
        _labelStudy.frame = CGRectMake(0, 45, 300, 15);
        _labelWork.frame = CGRectMake(0, 60, 300, 15);
        
        
        _view2.frame = CGRectMake(5, 350-deltaY, 310, 150);
        _view3.frame = CGRectMake(5, 510-deltaY, 310, 150);
        _view4.frame = CGRectMake(5, 670-deltaY, 310, 110);
        _view5.frame = CGRectMake(5, 790-deltaY, 310, 55);
        
    }
}

-(void) viewWillAppear:(BOOL)animated{
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if([version hasPrefix:@"7."]){
        deltaY = 65;
    }
    else{
        deltaY = 0;
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

