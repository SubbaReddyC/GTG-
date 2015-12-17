//
//  ActivityIndicator.m
//  GTG TabNet
//
//  Created by admin on 04/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "ActivityIndicator.h"


@implementation ActivityIndicator

static UIActivityIndicatorView* activityIndicator;

+(void)showActivityIndicator:(UIView *)view
{
    [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    if (activityIndicator==nil) {
        activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.color = [UIColor grayColor];
        CGRect rect = CGRectMake([[UIScreen mainScreen]bounds].size.width/3, 240, 130, 170);
        activityIndicator.frame = rect;
        [view addSubview:activityIndicator];
        [activityIndicator setHidden:NO];
        [activityIndicator startAnimating];
    }

}
+(void)removeActivityIndicator
{
   [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;

}

@end
