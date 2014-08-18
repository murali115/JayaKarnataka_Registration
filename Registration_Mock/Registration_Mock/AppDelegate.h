//
//  AppDelegate.h
//  Registration_Mock
//
//  Created by Mac1 on 7/17/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
#import "RegistrationViewController_iPad.h"
#import "ProfileViewController_iPad.h"
#import "MembersViewController_iPad.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RegistrationViewController *registrationViewController;
@property (strong, nonatomic) RegistrationViewController_iPad *registrationViewControllerIpad;
@property (strong, nonatomic) ProfileViewController_iPad *profileViewController;
@property (strong, nonatomic) MembersViewController_iPad *membersViewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSString *xAuthToken,*user_id;
@end
