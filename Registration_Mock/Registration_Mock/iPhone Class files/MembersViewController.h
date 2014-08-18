//
//  MembersViewController.h
//  Registration_Mock
//
//  Created by Mac1 on 7/22/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "ProfileViewController.h"
#import "MySearchDisplayController.h"

@interface MembersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) UITableView *tableMembers;
@property (strong, nonatomic) UIView *cellView, *indicatorview;
@property (strong, nonatomic) NSString *token, *user_id,*urlAll,*urlDay,*urlWeek,*urlMonth,*urlYear,*url;
@property (strong, nonatomic) NSMutableArray *arrayUsers, *arrayDaywise, *arrayWeekwise, *arrayMonthwise, *arrayYearwise;
@property (strong, nonatomic) NSMutableDictionary *user;

@property (strong, nonatomic) UIButton *buttonAll, *buttonDay, *buttonWeek, *buttonMonth, *buttonYear;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIDatePicker *dayPicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPickerView *weekPicker, *monthPicker, *yearPicker;
@property (strong, nonatomic) NSMutableArray *arrayMonths, *arrayYears, *arrayWeeks,*arrayDays, *arrayAll;
@property (strong, nonatomic) UILabel *labelStatus;
@property (strong, nonatomic) UIView *tabBar;
@property (strong, nonatomic) ProfileViewController *profileViewController;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) MySearchDisplayController *searchDisplayCon;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *filteredArray,*arrayMembers, *arrayNames, *arraySearchedData;
@end
