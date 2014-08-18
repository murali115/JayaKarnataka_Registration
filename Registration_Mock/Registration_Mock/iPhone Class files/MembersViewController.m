//
//  MembersViewController.m
//  Registration_Mock
//
//  Created by Mac1 on 7/22/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import "MembersViewController.h"
#import "GetData.h"
#import "AppDelegate.h"
#import "CustomTableViewCell.h"
//#import <QuartzCore/QuartzCore.h>

@interface MembersViewController ()

@end

@implementation MembersViewController

int i = 5;
int totalRows,deltaY;
int selectedTable, bkp;
UIToolbar *myToolBar;
NSString *day, *week, *month, *year, *monthYear;
UIView *tabView;
UIView *view;

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
        _buttonAll.frame = CGRectMake(0, 0, 96, 34);
        _buttonDay.frame = CGRectMake(96, 0, 96, 34);
        _buttonWeek.frame = CGRectMake(192, 0, 96, 34);
        _buttonMonth.frame = CGRectMake(288, 0, 96, 34);
        _buttonYear.frame = CGRectMake(384, 0, 96, 34);
        _tabBar.frame = CGRectMake(0, 0+deltaY, 480, 34);
        view.frame = CGRectMake(0, 21+deltaY, 480, 5);
        
        _tableMembers.frame = CGRectMake(0, 84+deltaY, 480, 236-deltaY);
        _searchBar.frame = CGRectMake(0, 40 + deltaY, 480.0, 44.0);
        
        _weekPicker.frame = CGRectMake(0, 80+deltaY, 480, 180);
        _monthPicker.frame = CGRectMake(0, 80+deltaY, 480, 180);
        _yearPicker.frame = CGRectMake(0, 80+deltaY, 480, 180);
        _dayPicker.frame = CGRectMake(0, 80+deltaY, 480, 180);
        
        myToolBar.frame = CGRectMake(0, 50+deltaY, 480, 30);
        
        _activityIndicator.center = _indicatorview.center;
    }
    else{
        _buttonAll.frame = CGRectMake(0, 0, 64, 34);
        _buttonDay.frame = CGRectMake(64, 0, 64, 34);
        _buttonWeek.frame = CGRectMake(128, 0, 64, 34);
        _buttonMonth.frame = CGRectMake(192, 0, 64, 34);
        _buttonYear.frame = CGRectMake(256, 0, 64, 34);
        _tabBar.frame = CGRectMake(0, 0+deltaY, 320, 34);
        view.frame = CGRectMake(0, 21+deltaY, 320, 5);
        
        _tableMembers.frame = CGRectMake(0, 84+deltaY, 320, 396-deltaY);
        _searchBar.frame = CGRectMake(0, 40 + deltaY, 320.0, 44.0);
        
        _weekPicker.frame = CGRectMake(0, 235+deltaY, 320, 180);
        _monthPicker.frame = CGRectMake(0, 235+deltaY, 320, 180);
        _yearPicker.frame = CGRectMake(0, 235+deltaY, 320, 180);
        _dayPicker.frame = CGRectMake(0, 235+deltaY, 320, 180);
        
        myToolBar.frame = CGRectMake(0, 205+deltaY, 320, 30);
        
        _activityIndicator.center = _indicatorview.center;
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _user_id = appDelegate.user_id;
    
    self.navigationItem.title = @"Members";
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if([version hasPrefix:@"7."]){
        deltaY = 65;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    else{
        deltaY = 0;
    }
    
    
    _activityIndicator = [[UIActivityIndicatorView alloc] init];
//    _activityIndicator.frame = CGRectMake(145, 270, 30, 30);
    _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    [self.view addSubview:_activityIndicator];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 40 + deltaY, 320.0, 44.0)];
    _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _searchBar.delegate = self;
    
    
    _searchDisplayCon = [[MySearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayCon.delegate = self;
    _searchDisplayCon.searchResultsDataSource = self;
    _searchDisplayCon.searchResultsDelegate = self;
    _searchBar.placeholder = @"Search Member by Name";
    
    [self.navigationItem setHidesBackButton:YES];
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"Done"
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(goBack)];
    [self.navigationItem setRightBarButtonItem:btnBack];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 21+deltaY, 320, 5)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = 8; // if you like rounded corners
    view.layer.shadowOffset = CGSizeMake(2,5);
    view.layer.shadowRadius = 5;
    view.layer.shadowOpacity = 0.7;
    
    _arrayUsers = [[NSMutableArray alloc] init];
    
    [self initPickers];
    _dayPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200+deltaY, 320, 200)];
    _dayPicker.datePickerMode = UIDatePickerModeDate;
    
    myToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 170+deltaY, 320, 30)];
    myToolBar.hidden = YES;
    myToolBar.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(hideDatePicker)];
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [myToolBar setItems:[NSArray arrayWithObjects:flexiableItem, doneButton, nil]];
    
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, 55, 5)];
    tabView.backgroundColor = [UIColor colorWithRed:44.0f/255.0f green:131.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
//    [self.view addSubview:tabView];
    
    _tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0+deltaY, 320, 34)];
    [self.view addSubview:_tabBar];
    _tabBar.backgroundColor = [UIColor whiteColor];
//    _tabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    _buttonAll = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 34)];
    [_buttonAll setTitle:@"All" forState:UIControlStateNormal];
    _buttonAll.backgroundColor = [UIColor whiteColor];
    [_buttonAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_buttonAll addTarget:self action:@selector(viewAll:) forControlEvents:UIControlEventTouchUpInside];
    _buttonAll.tag = 0;
    [_buttonAll setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
    [_tabBar addSubview:_buttonAll];
    _buttonAll.adjustsImageWhenHighlighted = NO;
//    _buttonAll.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    _buttonDay = [[UIButton alloc] initWithFrame:CGRectMake(64, 0, 64, 34)];
    [_buttonDay setTitle:@"Day" forState:UIControlStateNormal];
    [_buttonDay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _buttonDay.backgroundColor = [UIColor whiteColor];
    [_buttonDay addTarget:self action:@selector(viewDaywise:) forControlEvents:UIControlEventTouchUpInside];
    _buttonDay.tag = 1;
    [_tabBar addSubview:_buttonDay];
    _buttonDay.adjustsImageWhenHighlighted = NO;
//    _buttonDay.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    _buttonWeek = [[UIButton alloc] initWithFrame:CGRectMake(128, 0, 64, 34)];
    [_buttonWeek setTitle:@"Week" forState:UIControlStateNormal];
    [_buttonWeek setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _buttonWeek.backgroundColor = [UIColor whiteColor];
    [_buttonWeek addTarget:self action:@selector(viewWeekwise:) forControlEvents:UIControlEventTouchUpInside];
    _buttonWeek.tag = 2;
    [_tabBar addSubview:_buttonWeek];
    _buttonWeek.adjustsImageWhenHighlighted = NO;
//    _buttonWeek.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    _buttonMonth = [[UIButton alloc] initWithFrame:CGRectMake(192, 0, 64, 34)];
    [_buttonMonth setTitle:@"Month" forState:UIControlStateNormal];
    [_buttonMonth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _buttonMonth.backgroundColor = [UIColor whiteColor];
    [_buttonMonth addTarget:self action:@selector(viewMonthWise:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMonth.tag = 3;
    [_tabBar addSubview:_buttonMonth];
    _buttonMonth.adjustsImageWhenHighlighted = NO;
//    _buttonMonth.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    _buttonYear = [[UIButton alloc] initWithFrame:CGRectMake(256, 0, 64, 34)];
    [_buttonYear setTitle:@"Year" forState:UIControlStateNormal];
    [_buttonYear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _buttonYear.backgroundColor = [UIColor whiteColor];
    [_buttonYear addTarget:self action:@selector(viewYearwise:) forControlEvents:UIControlEventTouchUpInside];
    _buttonYear.tag = 4;
    [_tabBar addSubview:_buttonYear];
    _buttonYear.adjustsImageWhenHighlighted = NO;
//    _buttonYear.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40+deltaY, 320, self.view.frame.size.height - 40)];
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    
    
    for (int j = 0; j < i; j++) {
        CGFloat xOrigin = j * self.view.frame.size.width;
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
        aView.backgroundColor = [UIColor colorWithRed:223 green:223 blue:223 alpha:1];
//        [_scrollView addSubview:aView];
    }
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * i, self.view.frame.size.height-40);
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _indicatorview = [[UIView alloc] initWithFrame:self.view.frame];
    _indicatorview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_indicatorview];
    _indicatorview.hidden = YES;
    _indicatorview.backgroundColor = [UIColor clearColor];
    [_indicatorview addSubview:_activityIndicator];
    _activityIndicator.center = _indicatorview.center;
    [self.view addSubview:_searchBar];
    [self checkOrientation];
    [self loadAllMembers];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        _buttonAll.frame = CGRectMake(0, 0, 96, 34);
        _buttonDay.frame = CGRectMake(96, 0, 96, 34);
        _buttonWeek.frame = CGRectMake(192, 0, 96, 34);
        _buttonMonth.frame = CGRectMake(288, 0, 96, 34);
        _buttonYear.frame = CGRectMake(384, 0, 96, 34);
        _tabBar.frame = CGRectMake(0, 0+deltaY, 480, 34);
        view.frame = CGRectMake(0, 21+deltaY, 480, 5);
        _tableMembers.frame = CGRectMake(0, 84+deltaY, 480, 236-deltaY);
        
        _weekPicker.frame = CGRectMake(0, 80+deltaY, 480, 180);
        _monthPicker.frame = CGRectMake(0, 80+deltaY, 480, 180);
        _yearPicker.frame = CGRectMake(0, 80+deltaY, 480, 180);
        _dayPicker.frame = CGRectMake(0, 80+deltaY, 480, 180);
        
        myToolBar.frame = CGRectMake(0, 50+deltaY, 480, 30);
        _activityIndicator.center = _indicatorview.center;
        
    }
    else{
        _buttonAll.frame = CGRectMake(0, 0, 64, 34);
        _buttonDay.frame = CGRectMake(64, 0, 64, 34);
        _buttonWeek.frame = CGRectMake(128, 0, 64, 34);
        _buttonMonth.frame = CGRectMake(192, 0, 64, 34);
        _buttonYear.frame = CGRectMake(256, 0, 64, 34);
        _tabBar.frame = CGRectMake(0, 0+deltaY, 320, 34);
        view.frame = CGRectMake(0, 21+deltaY, 320, 5);
        _tableMembers.frame = CGRectMake(0, 84+deltaY, 320, 396-deltaY);
        
        _weekPicker.frame = CGRectMake(0, 235+deltaY, 320, 180);
        _monthPicker.frame = CGRectMake(0, 235+deltaY, 320, 180);
        _yearPicker.frame = CGRectMake(0, 235+deltaY, 320, 180);
        _dayPicker.frame = CGRectMake(0, 235+deltaY, 320, 180);
        
        myToolBar.frame = CGRectMake(0, 205+deltaY, 320, 30);
        _activityIndicator.center = _indicatorview.center;
    }
}

-(void) viewAll:(id)sender{
    
    [_buttonAll setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
    [_buttonDay setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonWeek setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonMonth setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonYear setBackgroundImage:nil forState:UIControlStateNormal];
    
    
    _labelStatus.hidden = YES;
    _dayPicker.hidden = YES;
    _monthPicker.hidden = YES;
    _weekPicker.hidden = YES;
    _yearPicker.hidden = YES;
    myToolBar.hidden = YES;
    [_searchBar endEditing:YES];
    
    selectedTable = 0;
    bkp = 0;
    
    tabView.frame = CGRectMake(0, 35, 55, 5);
    
    [_scrollView setContentOffset:CGPointMake([sender tag] * 320, 0)];
    [self loadAllMembers];
    
}
-(void) viewDaywise:(id)sender{
    
    [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonDay setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
    [_buttonWeek setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonMonth setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonYear setBackgroundImage:nil forState:UIControlStateNormal];
    
    _labelStatus.hidden = YES;
    _dayPicker.hidden = NO;
    _monthPicker.hidden = YES;
    _weekPicker.hidden = YES;
    _yearPicker.hidden = YES;
    [_searchBar endEditing:YES];
    
    selectedTable = 1;
    bkp = 1;
    _tableMembers.hidden = YES;
    
   tabView.frame = CGRectMake(56, 35, 55, 5);
    
    [_scrollView setContentOffset:CGPointMake([sender tag] * 320, 0)];
    
    myToolBar.hidden = NO;
    _dayPicker.hidden = NO;

    [_dayPicker setDate:[NSDate date]];
    [_dayPicker addTarget:self action:@selector(updateTextFieldDates:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_dayPicker];
    [self.view addSubview:myToolBar];
    
}
-(void) viewWeekwise:(id)sender{
    
    [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonDay setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonWeek setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
    [_buttonMonth setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonYear setBackgroundImage:nil forState:UIControlStateNormal];

    selectedTable = 2;
    bkp = 2;
    _tableMembers.hidden = YES;
    
    _labelStatus.hidden = YES;
    _dayPicker.hidden = YES;
    _monthPicker.hidden = YES;
    _weekPicker.hidden = NO;
    _yearPicker.hidden = YES;
    [_searchBar endEditing:YES];
    
    tabView.frame = CGRectMake(124, 35, 58, 5);
    
    [_scrollView setContentOffset:CGPointMake([sender tag] * 320, 0)];
    
    [self.view addSubview:_weekPicker];
    _weekPicker.hidden = NO;
    myToolBar.hidden = NO;
    _weekPicker.showsSelectionIndicator = YES;
    [self.view addSubview:myToolBar];
}
-(void) viewMonthWise:(id)sender{
    
    [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonDay setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonWeek setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonMonth setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
    [_buttonYear setBackgroundImage:nil forState:UIControlStateNormal];

    _labelStatus.hidden = YES;
    _dayPicker.hidden = YES;
    _monthPicker.hidden = NO;
    _weekPicker.hidden = YES;
    _yearPicker.hidden = YES;
    [_searchBar endEditing:YES];
    
    selectedTable = 3;
    bkp = 3;
    _tableMembers.hidden = YES;
    tabView.frame = CGRectMake(192, 35, 63, 5);
    
    [_scrollView setContentOffset:CGPointMake([sender tag] * 320, 0)];
    
    [self.view addSubview:_monthPicker];
    _monthPicker.hidden = NO;
    myToolBar.hidden = NO;
    _monthPicker.showsSelectionIndicator = YES;
    [self.view addSubview:myToolBar];
}
-(void) viewYearwise:(id)sender{
    
    [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonDay setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonWeek setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonMonth setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonYear setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
    
    _labelStatus.hidden = YES;
    _dayPicker.hidden = YES;
    _monthPicker.hidden = YES;
    _weekPicker.hidden = YES;
    _yearPicker.hidden = NO;
    [_searchBar endEditing:YES];
    
    selectedTable = 4;
    bkp = 4;
    _tableMembers.hidden = YES;
  
    tabView.frame = CGRectMake(258, 35, 63, 5);
    
    [_scrollView setContentOffset:CGPointMake([sender tag] * 320, 0) animated:YES];
//    
//    NSDate *today = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"yyyy";
//    NSString *year = [NSString stringWithFormat:@"%@",today];
//    today =
//    for (int i = 0; i<[_arrayYears count]; i++) {
//        
//    }
    
    
    [self.view addSubview:_yearPicker];
    _yearPicker.hidden = NO;
    myToolBar.hidden = NO;
    _yearPicker.showsSelectionIndicator = YES;
    [self.view addSubview:myToolBar];
}

-(void)updateTextFieldDates:(UITextField *)sender
{
    _dateFormatter = [[NSDateFormatter alloc] init];
    
        NSString *date = [NSString stringWithFormat:@"%@",_dayPicker.date];
        NSDate *dateValue;
        _dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
        dateValue = [_dateFormatter dateFromString:date];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
//    NSLog(@"%@",[_dateFormatter stringFromDate:dateValue]);
    day = [_dateFormatter stringFromDate:dateValue];
}

- (void) hideDatePicker{
    myToolBar.hidden = YES;
    _dayPicker.hidden = YES;
    _monthPicker.hidden = YES;
    _weekPicker.hidden = YES;
    _yearPicker.hidden = YES;
    
    if (selectedTable == 0) {
        _urlAll = [NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@",_user_id];
        [self loadAllMembers];
    }
    else if (selectedTable == 1) {
        _urlDay = [NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&day=%@",_user_id,day];
        [self loadDaywise];
    }
    else if (selectedTable == 2) {
        _urlWeek = [NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&week=%@",_user_id, week];
        [self loadWeekwise];
    }
    
    else if (selectedTable == 3) {
        _urlMonth = [NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&month=%@", _user_id, month];
        [self loadMonthwise];
    }
    else{
        _urlYear = [NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&year=%@",_user_id, year];
        [self loadYearwise];
    }
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _dayPicker.hidden = YES;
    _monthPicker.hidden = YES;
    _weekPicker.hidden = YES;
    _yearPicker.hidden = YES;
    myToolBar.hidden = YES;
    
//    [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
//    [_buttonDay setBackgroundImage:nil forState:UIControlStateNormal];
//    [_buttonWeek setBackgroundImage:nil forState:UIControlStateNormal];
//    [_buttonMonth setBackgroundImage:nil forState:UIControlStateNormal];
//    [_buttonYear setBackgroundImage:nil forState:UIControlStateNormal];
    
    tabView.frame = CGRectMake(0, 0, 0, 0);
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchDisplayCon.searchResultsTableView setHidden:YES];
//    [_tableMembers setHidden:NO];
    
//    [self.searchDisplayCon setActive:NO];
    
    selectedTable = 5;
    
    _dayPicker.hidden = YES;
    _monthPicker.hidden = YES;
    _weekPicker.hidden = YES;
    _yearPicker.hidden = YES;
    myToolBar.hidden = YES;
    
    [searchBar endEditing:YES];
    
    [GetData getDataFromUrl:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&search_text=%@",_user_id,searchBar.text] withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
        _arrayUsers = [[[array objectAtIndex:0] objectForKey:@"users"] mutableCopy];
        
        if ([_arrayUsers count] == 0) {
            _tableMembers.hidden = YES;
            _labelStatus.hidden = NO;
        }
        else{
//            self.searchDisplayCon.searchResultsTableView.hidden = YES;
            [self createTable];
            //[_tableMembers reloadData];
        }
    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
//    [manager GET:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=1&search_text=%@",searchBar.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        _arrayUsers = [[responseObject objectForKey:@"users"] mutableCopy];
//        [self createTable];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed");
//    }];
//    searchBar.text = @"";
}


-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    selectedTable = bkp;

    if (selectedTable == 0) {
        [self viewAll:nil];
    }
    else if (selectedTable == 1)
    {
        [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonDay setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
        [_buttonWeek setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonMonth setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonYear setBackgroundImage:nil forState:UIControlStateNormal];
        _arrayUsers = _arrayDaywise;
        
        if ([_arrayUsers count] == 0) {
            _tableMembers.hidden = YES;
            _labelStatus.hidden = NO;
        }
        else{
            _tableMembers.hidden = NO;
            _labelStatus.hidden = YES;
        }
        
        [_tableMembers reloadData];
        
        
    }
    else if (selectedTable == 2)
    {
        [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonDay setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonWeek setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
        [_buttonMonth setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonYear setBackgroundImage:nil forState:UIControlStateNormal];
        _arrayUsers = _arrayWeekwise;
        
        if ([_arrayUsers count] == 0) {
            _tableMembers.hidden = YES;
            _labelStatus.hidden = NO;
        }
        else{
            _tableMembers.hidden = NO;
            _labelStatus.hidden = YES;
        }
        
        [_tableMembers reloadData];
    }
    else if (selectedTable == 3)
    {
        [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonDay setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonWeek setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonMonth setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
        [_buttonYear setBackgroundImage:nil forState:UIControlStateNormal];
        _arrayUsers = _arrayMonthwise;
        
        if ([_arrayUsers count] == 0) {
            _tableMembers.hidden = YES;
            _labelStatus.hidden = NO;
        }
        else{
            _tableMembers.hidden = NO;
            _labelStatus.hidden = YES;
        }
        
        [_tableMembers reloadData];
    }
    else if (selectedTable == 4)
    {
        [_buttonAll setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonDay setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonWeek setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonMonth setBackgroundImage:nil forState:UIControlStateNormal];
        [_buttonYear setBackgroundImage:[UIImage imageNamed:@"tab.png"] forState:UIControlStateNormal];
        _arrayUsers = _arrayYearwise;
        
        if ([_arrayUsers count] == 0) {
            _tableMembers.hidden = YES;
            _labelStatus.hidden = NO;
        }
        else{
            _tableMembers.hidden = NO;
            _labelStatus.hidden = YES;
        }
        
        [_tableMembers reloadData];
    }
    else{
//        [self viewAll:nil];
    }
}

-(void) loadAllMembers{
    if (_arrayAll == nil) {
        
        _indicatorview.hidden = NO;
        [_activityIndicator startAnimating];
        _urlAll = [NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@",_user_id];
        
        [GetData getDataFromUrl:_urlAll withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
            _arrayAll = [[[array objectAtIndex:0] objectForKey:@"users"] mutableCopy];
            _arrayUsers = _arrayAll;
            
            _indicatorview.hidden = YES;
            [_activityIndicator stopAnimating];
            
            if ([_arrayUsers count] != 0) {
                [self createTable];
            }
            else{
                _tableMembers.hidden = YES;
                _labelStatus.hidden = NO;
            }
        }];

    }
    else{
        _arrayUsers = _arrayAll;
        [self createTable];
    }
}

-(void) loadDaywise{
    
    _indicatorview.hidden = NO;
    [_activityIndicator startAnimating];
    
    [GetData getDataFromUrl:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&day=%@",_user_id, day] withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
        _arrayDaywise = [[[array objectAtIndex:0] objectForKey:@"users"] mutableCopy];
        _arrayUsers = _arrayDaywise;
        _indicatorview.hidden = YES;
        [_activityIndicator stopAnimating];
        
        if ([_arrayUsers count] != 0) {
            [self createTable];
        }
        else{
            _labelStatus.hidden = NO;
            _tableMembers.hidden = YES;
            
        }
    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
//    [manager GET:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=1&day=%@",day] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        _arrayUsers = [[responseObject objectForKey:@"users"] mutableCopy];
//        if ([_arrayUsers count] != 0) {
//            [self createTable];
//        }
//        else{
//            _labelStatus.hidden = NO;
//            _tableMembers.hidden = YES;
//            
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed");
//    }];
}

-(void) loadWeekwise{
    
    _indicatorview.hidden = NO;
    [_activityIndicator startAnimating];
    
    [GetData getDataFromUrl:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&week=%@",_user_id, week] withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
        _arrayWeekwise = [[[array objectAtIndex:0] objectForKey:@"users"] mutableCopy];
        _arrayUsers = _arrayWeekwise;
        
        _indicatorview.hidden = YES;
        [_activityIndicator stopAnimating];
        
        if ([_arrayUsers count] != 0) {
            [self createTable];
        }
        else{
            _tableMembers.hidden = YES;
            _labelStatus.hidden = NO;
        }

    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
//    [manager GET:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=1&week=%@",week] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        _arrayUsers = [[responseObject objectForKey:@"users"] mutableCopy];
//        if ([_arrayUsers count] != 0) {
//            [self createTable];
//        }
//        else{
//            _tableMembers.hidden = YES;
//            _labelStatus.hidden = NO;
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed");
//    }];
}

-(void) loadMonthwise{
    month = [NSString stringWithFormat:@"%@&year=%@",month,monthYear];
    
    _indicatorview.hidden = NO;
    [_activityIndicator startAnimating];
    
    [GetData getDataFromUrl:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&month=%@",_user_id, month] withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
        _arrayMonthwise = [[[array objectAtIndex:0] objectForKey:@"users"] mutableCopy];
        _arrayUsers = _arrayMonthwise;
        _indicatorview.hidden = YES;
        [_activityIndicator stopAnimating];
        
        if ([_arrayUsers count] != 0) {
            [self createTable];
        }
        else{
            _tableMembers.hidden = YES;
            _labelStatus.hidden = NO;
        }
    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
//    [manager GET:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=1&month=%@",month] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        _arrayUsers = [[responseObject objectForKey:@"users"] mutableCopy];
//        if ([_arrayUsers count] != 0) {
//            [self createTable];
//        }
//        else{
//            _tableMembers.hidden = YES;
//            _labelStatus.hidden = NO;
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed");
//    }];
}

-(void) loadYearwise{
    _indicatorview.hidden = NO;
    [_activityIndicator startAnimating];
    
    [GetData getDataFromUrl:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=%@&year=%@",_user_id, year] withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
        _arrayYearwise = [[[array objectAtIndex:0] objectForKey:@"users"] mutableCopy];
        _arrayUsers = _arrayYearwise;
        _indicatorview.hidden = YES;
        [_activityIndicator stopAnimating];
        
        if ([_arrayUsers count] != 0) {
            [self createTable];
        }
        else{
            _tableMembers.hidden = YES;
            _labelStatus.hidden = NO;
        }
    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
//    [manager GET:[NSString stringWithFormat:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/user?created_by=1&year=%@",year] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        _arrayUsers = [[responseObject objectForKey:@"users"] mutableCopy];
//        if ([_arrayUsers count] != 0) {
//            [self createTable];
//        }
//        else{
//            _tableMembers.hidden = YES;
//            _labelStatus.hidden = NO;
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed");
//    }];

}



-(void) createTable{
    [_tableMembers removeFromSuperview];
        if (_tableMembers == nil) {
            _tableMembers = [[UITableView alloc] initWithFrame:CGRectMake(0, 84+deltaY, 320, self.view.frame.size.height-84-deltaY)];
            _tableMembers.dataSource = self;
            _tableMembers.delegate = self;
            
            [self.view addSubview:_tableMembers];
//            [self.view addSubview:_searchBar];
            
            _labelStatus = [[UILabel alloc] initWithFrame:CGRectMake(100, 250, 300, 30)];
            _labelStatus.text = @"No Members";
            _labelStatus.center = self.view.center;
            [self.view addSubview:_labelStatus];
            _labelStatus.hidden = YES;
            
        }
        else{
           _labelStatus.hidden = YES;
            _tableMembers.hidden = NO;
            //[_tableMembers reloadData];
            //[_tableMembers setContentOffset:CGPointZero];
            
            _tableMembers = [[UITableView alloc] initWithFrame:CGRectMake(0, 84+deltaY, 320, self.view.frame.size.height-40-deltaY)];
            _tableMembers.dataSource = self;
            _tableMembers.delegate = self;
            
            [self.view addSubview:_tableMembers];
        }
    [self checkOrientation];
}

-(void) getToken{
    NSDictionary *parameters = @{@"username":@"ganesh",@"password":@"123456"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.youflik.cc/jkapi/public/index.php/Api/v1/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int error = [[responseObject valueForKey:@"error"] intValue];
        if (error == 0) {
            _token = [responseObject valueForKey:@"csrf_token"];
            [self loadAllMembers];
        }
        else{
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayCon.searchResultsTableView) {
        return [_arraySearchedData count];
    }
    return [_arrayUsers count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    CustomTableViewCell *cell =(CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (tableView == self.searchDisplayCon.searchResultsTableView) {
        _user = [_arraySearchedData objectAtIndex:indexPath.row];
    }
    else{
        _user = [_arrayUsers objectAtIndex:indexPath.row];
    }
    
    [cell.contentView addSubview:cell.myView];
    
    
    if ([[_user valueForKey:@"user_profile_photo"] isEqualToString:@""]) {
        [cell.imageViewProfilePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[[_user valueForKey:@"firstname"] substringToIndex:1] uppercaseString]]]];
    }
    else{
        NSString *imageUrl = [_user valueForKey:@"user_profile_photo"];;
        imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        [cell.imageViewProfilePic setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
    
    cell.imageViewProfilePic.layer.cornerRadius = 15.0f;
    cell.imageViewProfilePic.clipsToBounds = YES;
    
    [cell.myView addSubview:cell.imageViewProfilePic];
    
    
    
    if ([_user valueForKey:@"lastname"] == (id)[NSNull null] || [[_user valueForKey:@"lastname"] isEqualToString:@""]) {
        cell.labelName.text = [NSString stringWithFormat:@"%@",[_user valueForKey:@"firstname"]];
    }
    else{
       cell.labelName.text = [NSString stringWithFormat:@"%@ %@",[_user valueForKey:@"firstname"],[_user valueForKey:@"lastname"]];
    }
    
    [cell.myView addSubview:cell.labelName];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.textLabel.text =[NSString stringWithFormat:@"%@  %@",[_user valueForKey:@"user_id"],[_user valueForKey:@"firstname"]] ;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Joined %@",[_user valueForKey:@"joined_date"]];
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.searchDisplayCon.searchResultsTableView && self.searchDisplayCon.searchResultsTableView.hidden == NO) {
        _profileViewController = [[ProfileViewController alloc] init];
        _profileViewController.token = _token;
        _profileViewController.user_id = [[_arraySearchedData objectAtIndex:indexPath.row] valueForKey:@"user_id"];
        [self.navigationController pushViewController:_profileViewController animated:YES];
    }
    else{
        _profileViewController = [[ProfileViewController alloc] init];
        _profileViewController.token = _token;
        _profileViewController.user_id = [[_arrayUsers objectAtIndex:indexPath.row] valueForKey:@"user_id"];
        [self.navigationController pushViewController:_profileViewController animated:YES];
    }
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedTable != 5) {
        if (selectedTable == 0) {
            _url = _urlAll;
        }
        else if (selectedTable == 1) {
            _url = _urlDay;
        }
        else if (selectedTable == 2) {
            _url = _urlWeek;
        }
        
        else if (selectedTable == 3) {
            _url = _urlMonth;
            
        }
        else {
            _url = _urlYear;
        }
        
        if([indexPath row] == [_arrayUsers count]-1){
            NSString *url = [NSString stringWithFormat:@"%@&last_date=%@",_url,[[_arrayUsers lastObject] valueForKey:@"joined_date"]];
            url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            _indicatorview.hidden = NO;
            [_activityIndicator startAnimating];
            
            [GetData getDataFromUrl:url withParameters:nil withHeader:_token WithCompletion:^(NSMutableArray *array) {
                _indicatorview.hidden = YES;
                [_activityIndicator stopAnimating];
                
                NSArray *newlist = [[[array objectAtIndex:0] objectForKey:@"users"] mutableCopy];
                
                if ([newlist count] != 0) {
                    [_arrayUsers addObjectsFromArray:newlist];
                    [_tableMembers reloadData];
                }

            }];
            
//            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
//            [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
//            [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                
//                _indicatorview.hidden = YES;
//                [_activityIndicator stopAnimating];
//                
//                NSArray *newlist = [[responseObject objectForKey:@"users"] mutableCopy];
//                
//                if ([newlist count] != 0) {
//                    [_arrayUsers addObjectsFromArray:newlist];
//                    [_tableMembers reloadData];
//                }
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                
//            }];
        }
    }
}
-(void) initPickers{
    
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekOfYearCalendarUnit fromDate:currentDate];
    
//    [components month]; //gives you month
//    [components day]; //gives you day
//    [components year]; // gives you year
    
    _arrayWeeks = [[NSMutableArray alloc] init];
    
    for (int i = 1; i<54; i++) {
        [_arrayWeeks addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _arrayMonths = [[NSMutableArray alloc] initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    
    _arrayYears = [[NSMutableArray alloc] init];
    for (int i = 1900; i<2051; i++) {
        [_arrayYears addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _weekPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200+deltaY, 320, 240)];
    _weekPicker.tag = 0;
    _weekPicker.dataSource = self;
    _weekPicker.delegate = self;
    [self.view addSubview:_weekPicker];
    _weekPicker.hidden = YES;
    
    [_weekPicker selectRow:[components weekOfYear]-1 inComponent:0 animated:YES];
    [self pickerView:_weekPicker didSelectRow:[components weekOfYear]-1 inComponent:0];
    
    
    _monthPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200+deltaY, 320, 240)];
    _monthPicker.tag = 1;
    _monthPicker.dataSource = self;
    _monthPicker.delegate = self;
    [self.view addSubview:_monthPicker];
    _monthPicker.hidden = YES;
    
    [_monthPicker selectRow:114 inComponent:1 animated:YES];
    [_monthPicker selectRow:[components month]-1 inComponent:0 animated:YES];
    
    [self pickerView:_monthPicker didSelectRow:114 inComponent:1];
    [self pickerView:_monthPicker didSelectRow:[components month]-1 inComponent:0];
    
    _yearPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200+deltaY, 320, 240)];
    _yearPicker.tag = 2;
    _yearPicker.dataSource = self;
    _yearPicker.delegate = self;
    [self.view addSubview:_yearPicker];
    _yearPicker.hidden = YES;
    [_yearPicker selectRow:114 inComponent:0 animated:YES];
    [self pickerView:_yearPicker didSelectRow:114 inComponent:0];

}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView.tag == 1) {
        return 2;
    }
    else{
        return 1;
    }
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (pickerView.tag == 0) {
        return [_arrayWeeks count];
    }
    else if (pickerView.tag == 1){
        if (component == 0) {
            return [_arrayMonths count];
        }
        else{
            return [_arrayYears count];
        }
    }
    else{
        return [_arrayYears count];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 150.0f;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (pickerView.tag == 0) {
        return [_arrayWeeks objectAtIndex:row];
    }
    else if (pickerView.tag == 1){
        if (component == 0) {
            return [_arrayMonths objectAtIndex:row];
        }
        else{
            return [_arrayYears objectAtIndex:row];
        }
    }
    else{
        return [_arrayYears objectAtIndex:row];
    }
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    NSLog(@"%@",[_arrayMonths objectAtIndex:row]);
    
    
    if (pickerView.tag == 0) {
        week = [_arrayWeeks objectAtIndex:row];
        
    }
    else if (pickerView.tag == 1){
        if (component == 0) {
            month = [NSString stringWithFormat:@"%d",row+1];
        }
        else{
            monthYear = [_arrayYears objectAtIndex:row];
        }
    }
    else{
        year = [_arrayYears objectAtIndex:row];
    }
    
}



-(void) goBack{
    [_searchBar endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    [self checkOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    [_filteredArray removeAllObjects];
    
    _arraySearchedData = [[NSMutableArray alloc] init];
    
   _arrayMembers = [[NSMutableArray alloc] init];
    _arrayNames = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_arrayUsers count]; i++) {
        [_arrayMembers addObject:[_arrayUsers objectAtIndex:i]];
        [_arrayNames addObject:[[_arrayMembers objectAtIndex:i] valueForKey:@"firstname"]];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [c] %@",searchText];
    _filteredArray = [NSMutableArray arrayWithArray:[_arrayNames filteredArrayUsingPredicate:predicate]];
    
    if ([_filteredArray count] == 0) {

    }
    else{
//        [self.searchDisplayCon setActive:YES];
//        self.searchDisplayCon.searchResultsTableView.hidden = NO;
        for (int i =0 ; i < [_filteredArray count]; i++) {
            NSString *firstname = [_filteredArray objectAtIndex:i];
            NSInteger index = [_arrayNames indexOfObject:firstname];
            [_arraySearchedData addObject:[_arrayUsers objectAtIndex:index]];
        }
    }
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
//    [_tableMembers reloadData];
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
