//
//  GTGTransportManager.m
//  GTG TabNet
//
//  Created by admin on 06/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "GTGTransportManager.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "RejectDocumentViewController.h"
#import "AppDelegate.h"


@implementation GTGTransportManager
@synthesize selectedTime,taskListArray,acknowledgmentTask,currentAddress,finishedScreenFlow,currentScreenFlow,loadId,appDate,driver,equipment,address,singletonsize,railAddressCount,addressChange,addressToShow,chasisNumber,taskFinished,railCount,yardAddressCount,customerAddressCount,pcrAddressCount,rejectedDocumentCount,taskType,noteDesc,redirectYardAddress,isStayWithTag;



+(GTGTransportManager *)sharedManager{
    
    static GTGTransportManager  *sharedMyManager=nil;
    
    static  dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
            sharedMyManager=[[self alloc]init];
    });
    
    return sharedMyManager;
    
}



+(NSURLSession *)sharedSession
{
    static NSURLSession *session=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return session;
}

+(UIView *)bgTransparentView:(UIView *)View
{
    UIView *bgTransparentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, View.frame.size.width, View.frame.size.height)];
    bgTransparentView.alpha=0.3;
    bgTransparentView.backgroundColor=[UIColor blackColor];
    return bgTransparentView;
}



-(void)pickerViewTapped:(UIView *)View fortext:(NSString *)pickerText
{
    currentViewController=View;

    _blurView= [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_blurView setBackgroundColor:[UIColor lightGrayColor]];
    [_blurView setAlpha:0.3];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_blurView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAllViews:)];
    [_blurView addGestureRecognizer:tapGesture];
    
    CGRect pickerFrame = CGRectMake(30, 40, 0, 0);
    pickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    NSDate *date1 = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components= [gregorian components: NSUIntegerMax fromDate: date1];
    NSString *str=pickerText;
    NSArray *items = [str componentsSeparatedByString:@":"];
    NSString *hours=[items objectAtIndex:0];
    NSString *minutes=[items objectAtIndex:1];
    [components setHour:[hours intValue]];;
    [components setMinute:[minutes intValue]];
    
    NSDate *startDate = [gregorian dateFromComponents:components];
    [pickerView setDate:startDate animated:YES ];
    
    
    
    pickerView.datePickerMode = UIDatePickerModeTime;
  
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    [pickerView addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    pickerView.maximumDate = [NSDate date];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    [pickerView setLocale:locale];
    
    __block CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, 260);
    _viewForPicker = [[UIView alloc] initWithFrame:frame];
    [_viewForPicker setBackgroundColor:[UIColor whiteColor]];
    [_viewForPicker addSubview:pickerView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_viewForPicker];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //NSLog(@"x: %f",[[UIScreen mainScreen] bounds].size.width-75);
    [button setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-75, 15, 60, 30)];
    [button.layer setCornerRadius:5.0];
    [button.layer setBorderWidth:1.0];
    [_viewForPicker addSubview:button];
    [_viewForPicker.layer setCornerRadius:8.0];
    
    float animationDuration = 0.25;
    [UIView animateWithDuration:animationDuration animations:^{
        frame.origin.y -= (180+40+35);
        [_viewForPicker setFrame:frame];
    }];
   
}

-(IBAction)doneButtonPressed:(id)sender
{
    currentViewController.userInteractionEnabled=YES;
    [_blurView removeFromSuperview];
    [_viewForPicker removeFromSuperview];
    [pickerView removeFromSuperview];

}

-(IBAction)pickerChanged:(UIDatePicker *)sender
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
     selectedTime = [dateFormat stringFromDate:sender.date];
    NSLog(@"%@",selectedTime);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PickerValueChanged" object:self];

}


-(void)removeAllViews:(UITapGestureRecognizer *)gesture
{
     currentViewController.userInteractionEnabled=YES;
    [_blurView removeFromSuperview];
    [_viewForPicker removeFromSuperview];
    [pickerView removeFromSuperview];


}

+(NSManagedObjectContext *)contextWithName
{
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context=[appDelegate managedObjectContext];
    return context;
}



#pragma  mark count of Address methods
-(void)railAddresses
{
    if ([[[GTGTransportManager sharedManager]currentScreenFlow] isEqualToString:RailAddressFlag])
    {
        NSArray *railAddress=[RailAddress loadRailAddressById:loadId];
        [RailAddress loadRailAddresscount:loadId];
        
        if ((![railAddress isKindOfClass:[NSNull class]]) && ([[railAddress valueForKey:@"railAddress"] count]))
        {
            NSLog(@"railCount %lu",(long)[[GTGTransportManager sharedManager]railCount]);
            [[GTGTransportManager sharedManager]setRailAddressCount:[[railAddress valueForKey:@"railAddress"] count]] ;
            
        }
        else if([railAddress isKindOfClass:[NSNull class]])
        {
            [[GTGTransportManager sharedManager]setRailAddressCount:0] ;
        }
        else
        {
        
        [[GTGTransportManager sharedManager]setRailAddressCount:0] ;
        }
    }
}




-(void)yardAddresses
{
    if ([[[GTGTransportManager sharedManager]currentScreenFlow] isEqualToString:YardAddressFlag])
    {
        NSArray *yardAddress=[YardName loadYardNameDataById:loadId];
        
        if ((![yardAddress isKindOfClass:[NSNull class]]) && ([[yardAddress valueForKey:@"yardName"] count]))
        {
           
            [[GTGTransportManager sharedManager]setYardAddressCount:[[yardAddress valueForKey:@"yardName"] count]] ;
            
        }
        else if([yardAddress isKindOfClass:[NSNull class]])
        {
            [[GTGTransportManager sharedManager]setYardAddressCount:0] ;
        }
        else
        {
            [[GTGTransportManager sharedManager]setYardAddressCount:0] ;
        }
    }
}

-(void)customerAddresses
{
    if ([[[GTGTransportManager sharedManager]currentScreenFlow] isEqualToString:CustomerAddressFlag])
    {
        NSArray *customerAddress=[CustomerAddress loadCustomerAddressById:loadId];
        
        if ((![customerAddress isKindOfClass:[NSNull class]]) && ([[customerAddress valueForKey:@"customerAddress"] count]))
        {
           
            [[GTGTransportManager sharedManager]setCustomerAddressCount:[[customerAddress valueForKey:@"customerAddress"] count]] ;
            
        }
        else if([customerAddress isKindOfClass:[NSNull class]])
        {
            [[GTGTransportManager sharedManager]setCustomerAddressCount:0] ;
        }
        else
        {
            [[GTGTransportManager sharedManager]setCustomerAddressCount:0] ;
        }
    }
}

-(void)pcrAddresses
{
    if ([[[GTGTransportManager sharedManager]currentScreenFlow] isEqualToString:PcrAddressFlag])
    {
        NSArray *pcrAddresss=[PcrAddress loadPcrAddressById:loadId];
        
        if ((![pcrAddresss isKindOfClass:[NSNull class]]) && ([[pcrAddresss valueForKey:@"pcrAddress"] count]))
        {
           
            [[GTGTransportManager sharedManager]setPcrAddressCount:[[pcrAddresss valueForKey:@"pcrAddress"] count]] ;
            
        }
        else if([pcrAddresss isKindOfClass:[NSNull class]])
        {
            [[GTGTransportManager sharedManager]setPcrAddressCount:0] ;
        }
        else
        {
            [[GTGTransportManager sharedManager]setPcrAddressCount:0] ;
        }
    }
}

-(void)rejectDocumentButton:(UIViewController *)vc
{
    
    _btnreject = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnreject setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-70, 30, 25, 25)];
    [_btnreject setImage:[UIImage imageNamed:@"doc-notify"] forState:UIControlStateNormal];
    [_btnreject addTarget:self action:@selector(rejectDocumentButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    _rejectLabel=[[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-52, 20, 16, 25)];
    _rejectLabel.textColor=[UIColor whiteColor];
    _rejectLabel.font=[UIFont fontWithName:@"Regular" size:13];
    _rejectLabel.textAlignment=NSTextAlignmentCenter;
    [self getRejectedDocumentCount];
    _rejectLabel.text=[NSString stringWithFormat:@"%ld",(long)[[GTGTransportManager sharedManager]rejectedDocumentCount]];
    _rejectLabel.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _rejectLabel.layer.borderWidth=1;
    _rejectLabel.layer.cornerRadius=6;
    _rejectLabel.layer.backgroundColor=CustomRGBColor(255, 42, 51).CGColor;
    

     [vc.view addSubview:_btnreject];
     [vc.view addSubview:_rejectLabel];
    
}
-(void)getRejectedDocumentCount
{
    
   NSArray * rejectDoc=[RejecteDocument loadRejectedDoc];
   
     NSUInteger count=0;
    for (int i=0; i<[rejectDoc count]; i++)
    {
        count+=[[[rejectDoc objectAtIndex:i]valueForKey:@"rejectedDoc" ]count];
     
    }
    [[GTGTransportManager sharedManager]setRejectedDocumentCount:count];
}

-(IBAction)rejectDocumentButtonTapped:(id)sender
{
    UIStoryboard * story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
     RejectDocumentViewController * rejectDocumentViewController=[story instantiateViewControllerWithIdentifier:@"RejectedDocuments"];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];
    [(UINavigationController *)vc pushViewController:rejectDocumentViewController animated:YES];
   
}






@end
