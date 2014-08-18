//
//  MySearchDisplayController.m
//  Registration_Mock
//
//  Created by Mac1 on 8/11/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import "MySearchDisplayController.h"

@implementation MySearchDisplayController

- (void)setActive:(BOOL)visible animated:(BOOL)animated
{
    if(self.active == visible)
        return;
    
    [self.searchContentsController.navigationController setNavigationBarHidden:YES animated:NO];
    [super setActive:visible animated:animated];
    [self.searchContentsController.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (visible)
        [self.searchBar becomeFirstResponder];
    else{
        [self.searchBar resignFirstResponder];
    }
}

@end
