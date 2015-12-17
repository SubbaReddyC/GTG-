//
//  PickUpDetailsController.h
//  GTG TabNet
//
//  Created by admin on 25/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTGTransportManager.h"
#import "CommonMacro.h"
#import "TaskListViewController.h"
#import "RailAddress.h"
#import "RejectDocumentViewController.h"

@interface PickUpDetailsController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtChasisNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtPieces;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;
@property (weak, nonatomic) IBOutlet UITextField *txtSeal;

- (IBAction)btnNextTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *chasisView;
@property (weak, nonatomic) IBOutlet UIView *unitView;
@property (weak, nonatomic) IBOutlet UIView *shipMentView;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UITextField *txtUnitID;

- (IBAction)btnChasisPickUpTimerTapped:(id)sender;

- (IBAction)btnUnitPickUpTimerTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnChasis;
@property (weak, nonatomic) IBOutlet UIButton *btnUnit;
@property (weak, nonatomic) IBOutlet UIScrollView *scView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property(nonatomic) int count;
@end
