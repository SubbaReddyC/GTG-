//
//  GTGTransportManager.h
//  GTG TabNet
//
//  Created by admin on 06/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RailAddress.h"
#import "CommonMacro.h"
#import "YardName.h"
#import "CustomerAddress.h"
#import "PcrAddress.h"
#import "RejecteDocument.h"

@interface GTGTransportManager : NSObject
{
    UIView *currentViewController;
    UIDatePicker *pickerView;
}


@property(nonatomic,strong) UIView * blurView;
@property(nonatomic,strong) UIView * viewForPicker;
@property (nonatomic,strong)UIButton *btnreject;
@property (nonatomic,strong)UILabel *rejectLabel;
@property(nonatomic,strong) NSString *selectedTime;
@property(nonatomic,strong) NSMutableArray *taskListArray;
@property(nonatomic,strong) NSString *acknowledgmentTask;

@property (nonatomic, strong) NSString *finishedScreenFlow;
@property (nonatomic, strong) NSString *currentScreenFlow;
@property (nonatomic, strong) NSString *loadId;
@property (nonatomic, strong) NSString *appDate;
@property (nonatomic, strong) NSString *driver;
@property (nonatomic, strong) NSString *equipment;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *singletonsize;
@property (nonatomic, strong) NSString *currentAddress;
@property (nonatomic) NSInteger railAddressCount;
@property (nonatomic) NSInteger yardAddressCount;
@property (nonatomic) NSInteger customerAddressCount;
@property (nonatomic) NSInteger pcrAddressCount;
@property (nonatomic) NSInteger railCount;
@property (nonatomic, strong) NSString *addressChange;
@property (nonatomic, strong) NSString *addressToShow;
@property (nonatomic, strong) NSString *chasisNumber;
@property (nonatomic, strong) NSString *taskFinished;
@property (nonatomic) NSInteger rejectedDocumentCount;
@property(nonatomic,weak) UINavigationController * navigationController;
@property (nonatomic, strong) NSString *taskType;
@property (nonatomic, strong) NSString *noteDesc;
@property (nonatomic, strong) NSString *redirectYardAddress;
@property (nonatomic, strong) NSString *isStayWithTag;
+(id)sharedManager;
+(NSURLSession *)sharedSession;

+(UIView *)bgTransparentView:(UIView *)View;
+(NSManagedObjectContext *)contextWithName;
//-(void)pickerViewTapped:(UIView *)View;
-(void)pickerViewTapped:(UIView *)View fortext:(NSString *)pickerText;
-(void)rejectDocumentButton:(UIViewController *)view;
-(void)getRejectedDocumentCount;
-(void)railAddresses;


-(void)yardAddresses;
-(void)customerAddresses;
-(void)pcrAddresses;



@end
