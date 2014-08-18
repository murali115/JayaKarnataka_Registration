//
//  ProfileViewController_iPad.m
//  Registration_Mock
//
//  Created by Mac1 on 8/7/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import "ProfileViewController_iPad.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "GetData.h"

@interface ProfileViewController_iPad ()

@end

@implementation ProfileViewController_iPad

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
        
        _scrollView.contentSize = CGSizeMake(1024, 1600);
        
        _imageViewTheme.frame = CGRectMake(0, 0, 1024, 300);
        _imageViewProfilePic.frame = CGRectMake(412, 220, 200, 200);
        _view1.frame = CGRectMake(5, 450, 1014, 160);
        _labelUserName.frame = CGRectMake(0, 0, 1004, 50);
        _imageViewEdit.frame = CGRectMake(970, 15, 20, 20);
        _labelLives.frame = CGRectMake(0, 50, 1004, 30);
        _labelStudy.frame = CGRectMake(0, 80, 1004, 30);
        _labelWork.frame = CGRectMake(0, 110, 1004, 30);
        _view2.frame = CGRectMake(5, 640, 1014, 270);
        _view3.frame = CGRectMake(5, 930, 1014, 270);
        _view4.frame = CGRectMake(5, 1220, 1014, 195);
        _view5.frame = CGRectMake(5, 1435, 1014, 80);
    }
    else{
        _scrollView.contentSize = CGSizeMake(768, 1600);
        
        _imageViewTheme.frame = CGRectMake(0, 0, 768, 280);
        _imageViewProfilePic.frame = CGRectMake(284, 220, 200, 200);
       _view1.frame = CGRectMake(5, 450, 758, 160);
        _view2.frame = CGRectMake(5, 640, 758, 270);
        _view3.frame = CGRectMake(5, 930, 758, 270);
        _view4.frame = CGRectMake(5, 1220, 758, 195);
        _view5.frame = CGRectMake(5, 1435, 758, 80);
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if([version hasPrefix:@"7."]){
        deltaY = 65;
    }
    else{
        deltaY = 0;
    }

    [self getToken];
    
//    [self loadUserInfo];
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
        _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, deltaY, 1024, 768)];

    }
    else{
        _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, deltaY, 768, 1024)];
 
    }

    [self.view addSubview:_scrollView];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _imageViewTheme = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 280)];
//    _imageViewTheme.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_scrollView addSubview:_imageViewTheme];
    
    if ([[_dictionaryUserDetails valueForKey:@"user_cover_picture_path"] isEqualToString:@""]) {
        
        [_imageViewTheme setImage:[UIImage imageNamed:@"no-cover.jpg"]];
        
    }
    else{
        
        [_imageViewTheme setImageWithURL:[NSURL URLWithString:[_dictionaryUserDetails valueForKey:@"user_cover_picture_path"]]];
    }
    
    _imageViewTheme.backgroundColor = [UIColor whiteColor];
    
    _imageViewProfilePic = [[UIImageView alloc] initWithFrame:CGRectMake(284, 220, 200, 200)];
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
    
    
    _imageViewProfilePic.layer.cornerRadius = 100.0f;
    _imageViewProfilePic.clipsToBounds = YES;
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(5, 450, 758, 160)];
    [_scrollView addSubview:_view1];
    _view1.backgroundColor = [UIColor whiteColor];
    
    
    _labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 748, 50)];
    _labelUserName.textAlignment = NSTextAlignmentCenter;
    _labelUserName.font = [UIFont systemFontOfSize:24];
    _labelUserName.text = [_dictionaryUserDetails valueForKey:@"firstname"];
    [_view1 addSubview:_labelUserName];
    
    
    _imageViewEdit = [[UIImageView alloc] initWithFrame:CGRectMake(715, 15, 20, 20)];
    _imageViewEdit.image = [UIImage imageNamed:@"edit.gif"];
    [_view1 addSubview:_imageViewEdit];
    _imageViewEdit.alpha = 0.5f;
    
    _labelLives = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 748, 30)];
    
    if ([_dictionaryUserDetails valueForKey:@"city_name"]  == (id)[NSNull null]) {
        _labelLives.text = [NSString stringWithFormat:@"LivesIn: NA"];
    }
    
    else{
        _labelLives.text = [NSString stringWithFormat:@"LivesIn: %@",[_dictionaryUserDetails valueForKey:@"city_name"]];
    }
    
    _labelLives.font = [UIFont systemFontOfSize:18];
    _labelLives.textAlignment = NSTextAlignmentCenter;
    [_view1 addSubview:_labelLives];
    _labelLives.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _labelStudy = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 748, 30)];
    
    
    if ([_dictionaryUserDetails valueForKey:@"edu"]  == (id)[NSNull null]) {
        _labelStudy.text = [NSString stringWithFormat:@"Studied At: NA"];
    }
    else{
        _labelStudy.text = [NSString stringWithFormat:@"Studied At: %@",[_dictionaryUserDetails valueForKey:@"edu"]];
    }
    
    
    _labelStudy.textAlignment = NSTextAlignmentCenter;
    _labelStudy.font = [UIFont systemFontOfSize:18];
    [_view1 addSubview:_labelStudy];
    _labelStudy.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _labelWork = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 748, 30)];
    
    if ([_dictionaryUserDetails valueForKey:@"work"]  == (id)[NSNull null]) {
        _labelWork.text = [NSString stringWithFormat:@"Works At: NA"];
    }
    else{
        _labelWork.text = [NSString stringWithFormat:@"Works At: %@",[_dictionaryUserDetails valueForKey:@"work"]];
    }
    
    _labelWork.textAlignment = NSTextAlignmentCenter;
    _labelWork.font = [UIFont systemFontOfSize:18];
    [_view1 addSubview:_labelWork];
    _labelWork.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(5, 640, 758, 270)];
    [_scrollView addSubview:_view2];
    _view2.backgroundColor = [UIColor whiteColor];
    
    _labelBasicInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 728, 30)];
    _labelBasicInfo.text = @"Basic Information";
    _labelBasicInfo.font = [UIFont systemFontOfSize:18];
    [_view2 addSubview:_labelBasicInfo];
    
    _labelGender = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, 728, 30)];
    _labelGender.text = @"Gender";
    _labelGender.font = [UIFont boldSystemFontOfSize:18];
    [_view2 addSubview:_labelGender];
    
    _labelGenderValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 728, 30)];
    _labelGenderValue.text = [_dictionaryUserDetails valueForKey:@"gendername"];
    _labelGenderValue.font = [UIFont systemFontOfSize:18];
    [_view2 addSubview:_labelGenderValue];
    _labelGenderValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    
    _labelBirthday = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 728, 30)];
    _labelBirthday.text = @"Birthday";
    _labelBirthday.font = [UIFont boldSystemFontOfSize:18];
    [_view2 addSubview:_labelBirthday];
    
    _labelBirthdayValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 155, 728, 30)];
    _labelBirthdayValue.text = [_dictionaryUserDetails valueForKey:@"dob"];
    _labelBirthdayValue.font = [UIFont systemFontOfSize:18];
    [_view2 addSubview:_labelBirthdayValue];
    _labelBirthdayValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _labelBloodGroup = [[UILabel alloc] initWithFrame:CGRectMake(5, 195, 728, 30)];
    _labelBloodGroup.text = @"Blood group";
    _labelBloodGroup.font = [UIFont boldSystemFontOfSize:18];
    [_view2 addSubview:_labelBloodGroup];
    
    _labelBloodGroupValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 230, 280, 30)];
    
    if ([_dictionaryUserDetails valueForKey:@"blood_group_name"]  == (id)[NSNull null]) {
        _labelBloodGroupValue.text = [NSString stringWithFormat:@"NA"];
    }
    else{
        _labelBloodGroupValue.text = [NSString stringWithFormat:@"%@",[_dictionaryUserDetails valueForKey:@"blood_group_name"]];
    }
    
    _labelBloodGroupValue.font = [UIFont systemFontOfSize:18];
    [_view2 addSubview:_labelBloodGroupValue];
    _labelBloodGroupValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    
    _view3 = [[UIView alloc] initWithFrame:CGRectMake(5, 930, 758, 270)];
    [_scrollView addSubview:_view3];
    _view3.backgroundColor = [UIColor whiteColor];
    
    _labelContactInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 280, 30)];
    
    _labelContactInfo.text = @"Contact Information";
    
    _labelContactInfo.font = [UIFont systemFontOfSize:18];
    [_view3 addSubview:_labelContactInfo];
    
    _labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, 280, 30)];
    _labelEmail.text = @"Email";
    _labelEmail.font = [UIFont boldSystemFontOfSize:18];
    [_view3 addSubview:_labelEmail];
    
    _labelEmailValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 280, 30)];
    if ([_dictionaryUserDetails valueForKey:@"email"]  == (id)[NSNull null]) {
        _labelEmailValue.text = @"NA";
    }
    else{
        _labelEmailValue.text = [_dictionaryUserDetails valueForKey:@"email"];
    }
    
    _labelEmailValue.font = [UIFont systemFontOfSize:18];
    [_view3 addSubview:_labelEmailValue];
    _labelEmailValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _labelMobile = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 280, 30)];
    _labelMobile.text = @"Mobile";
    _labelMobile.font = [UIFont boldSystemFontOfSize:18];
    [_view3 addSubview:_labelMobile];
    
    _labelMobileValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 155, 280, 30)];
    
    if ([_dictionaryUserDetails valueForKey:@"mobile"]  == (id)[NSNull null]) {
        _labelMobileValue.text = @"NA";
    }
    else{
        _labelMobileValue.text = [_dictionaryUserDetails valueForKey:@"mobile"];
    }
    
    _labelMobileValue.font = [UIFont systemFontOfSize:18];
    [_view3 addSubview:_labelMobileValue];
    _labelMobileValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    _labelCity = [[UILabel alloc] initWithFrame:CGRectMake(5, 195, 280, 30)];
    _labelCity.text = @"City";
    _labelCity.font = [UIFont boldSystemFontOfSize:18];
    [_view3 addSubview:_labelCity];
    
    _labelCityValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 230, 280, 30)];
    
    if ([_dictionaryUserDetails valueForKey:@"city_name"]  == (id)[NSNull null]) {
        _labelCityValue.text = @"NA";
    }
    else{
        _labelCityValue.text = [_dictionaryUserDetails valueForKey:@"city_name"];
    }
    
    
    _labelCityValue.font = [UIFont systemFontOfSize:18];
    [_view3 addSubview:_labelCityValue];
    _labelCityValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    
    
    _view4 = [[UIView alloc] initWithFrame:CGRectMake(5, 1220, 758, 195)];
    [_scrollView addSubview:_view4];
    _view4.backgroundColor = [UIColor whiteColor];
    
    _labelProffInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 728, 30)];
    _labelProffInfo.text = @"Professional Information";
    _labelProffInfo.font = [UIFont systemFontOfSize:18];
    [_view4 addSubview:_labelProffInfo];
    
    _labelStudiesAt = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, 728, 30)];
    _labelStudiesAt.text = @"Studies at";
    _labelStudiesAt.font = [UIFont boldSystemFontOfSize:18];
    [_view4 addSubview:_labelStudiesAt];
    
    _labelStudiesAtValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 728, 30)];
    
    if ([_dictionaryUserDetails valueForKey:@"edu"]  == (id)[NSNull null]) {
        _labelStudiesAtValue.text = @"NA";
    }
    else{
        _labelStudiesAtValue.text = [NSString stringWithFormat:@"Studied At: %@",[_dictionaryUserDetails valueForKey:@"edu"]];
    }
    
    _labelStudiesAtValue.font = [UIFont systemFontOfSize:18];
    [_view4 addSubview:_labelStudiesAtValue];
    _labelStudiesAtValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    
    _labelWorksAt = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 728, 30)];
    _labelWorksAt.text = @"Work";
    _labelWorksAt.font = [UIFont boldSystemFontOfSize:18];
    [_view4 addSubview:_labelWorksAt];
    
    _labelWorksAtValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 155, 728, 30)];
    
    if ([_dictionaryUserDetails valueForKey:@"work"]  == (id)[NSNull null]) {
        _labelWorksAtValue.text = @"NA";
    }
    else{
        _labelWorksAtValue.text = [NSString stringWithFormat:@"Works At: %@",[_dictionaryUserDetails valueForKey:@"work"]];
    }
    
    _labelWorksAtValue.font = [UIFont systemFontOfSize:18];
    [_view4 addSubview:_labelWorksAtValue];
    _labelWorksAtValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    
    _view5 = [[UIView alloc] initWithFrame:CGRectMake(5, 1435, 758, 80)];
    [_scrollView addSubview:_view5];
    _view5.backgroundColor = [UIColor whiteColor];
    
    _labelBio = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 728, 30)];
    _labelBio.text = @"Bio";
    _labelBio.font = [UIFont systemFontOfSize:18];
    [_view5 addSubview:_labelBio];
    
    _labelBioValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 728, 30)];
    
    if ([_dictionaryUserDetails valueForKey:@"bio"]  == (id)[NSNull null]) {
        _labelBioValue.text = @"NA";
    }
    
    else{
        _labelBioValue.text = [NSString stringWithFormat:@"%@",[_dictionaryUserDetails valueForKey:@"bio"]];
    }
    
    _labelBioValue.font = [UIFont systemFontOfSize:18];
    [_view5 addSubview:_labelBioValue];
    _labelBioValue.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    
    [self checkOrientation];
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//        _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, deltaY, 1024, 768)];
        _scrollView.contentSize = CGSizeMake(1024, 1600 - deltaY);
        
        _imageViewTheme.frame = CGRectMake(0, -deltaY, 1024, 300);
        _imageViewProfilePic.frame = CGRectMake(412, 220 - deltaY, 200, 200);
        
        _view1.frame = CGRectMake(5, 450 - deltaY, 1014, 160);
        
        _labelUserName.frame = CGRectMake(0, 0, 1004, 50);
        _imageViewEdit.frame = CGRectMake(970, 15, 20, 20);
        _labelLives.frame = CGRectMake(0, 50, 1004, 30);
        _labelStudy.frame = CGRectMake(0, 80, 1004, 30);
        _labelWork.frame = CGRectMake(0, 110, 1004, 30);
        
        _view2.frame = CGRectMake(5, 640 - deltaY, 1014, 270);
        _view3.frame = CGRectMake(5, 930 - deltaY, 1014, 270);
        _view4.frame = CGRectMake(5, 1220 - deltaY, 1014, 195);
        _view5.frame = CGRectMake(5, 1435 - deltaY, 1014, 80);
    }
    else{
//        _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, deltaY, 768, 1024)];
        
        _scrollView.contentSize = CGSizeMake(768, 1600 - deltaY);
//        _scrollView.contentOffset = CGPointZero;
        
        _imageViewTheme.frame = CGRectMake(0, -deltaY, 768, 280);
        _imageViewProfilePic.frame = CGRectMake(284, 220 - deltaY, 200, 200);
        
        _view1.frame = CGRectMake(5, 450 - deltaY, 758, 160);
        
        _labelUserName.frame = CGRectMake(0, 0, 748, 50);

        _imageViewEdit.frame = CGRectMake(715, 15, 20, 20);
        _labelLives.frame = CGRectMake(0, 50, 748, 30);
        _labelStudy.frame = CGRectMake(0, 80, 748, 30);
        _labelWork.frame = CGRectMake(0, 110, 748, 30);
        
        _view2.frame = CGRectMake(5, 640 - deltaY, 758, 270);
        _view3.frame = CGRectMake(5, 930 - deltaY, 758, 270);
        _view4.frame = CGRectMake(5, 1220 - deltaY, 758, 195);
        _view5.frame = CGRectMake(5, 1435 - deltaY, 758, 80);
        
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
