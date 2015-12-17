//
//  LeaveCustomerDeatailsController.h
//  GTG TabNet
//
//  Created by admin on 15/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RejectDocumentViewController.h"
#import "GTGTransportManager.h"
#import "TaskListViewController.h"
#import "RedirectYardPopUp.h"

@interface LeaveCustomerDeatailsController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtPieces;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;
@property (weak, nonatomic) IBOutlet UITextField *txtSeal;
@property (weak, nonatomic) IBOutlet UIButton *btnPicker;
- (IBAction)btnTimerTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ImgCheckBox;
- (IBAction)btnCheckBoxTapped:(id)sender;
- (IBAction)btnNextButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckBox;

@end
