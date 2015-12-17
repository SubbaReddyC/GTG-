//
//  UpLoadE-SignatureController.h
//  GTG TabNet
//
//  Created by admin on 11/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RejectDocumentViewController.h"
#import "GTGTransportManager.h"
#import "TaskListViewController.h"
#import "LeaveCustomerDeatailsController.h"

@interface UpLoadE_SignatureController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtCustomerName;
@property (weak, nonatomic) IBOutlet UITextView *txtViewComments;
- (IBAction)btnUploadSignatureTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgSignatureView;

- (IBAction)btnClearSignatureTapped:(id)sender;
@property (nonatomic, assign) BOOL fingerMoved;
@property (nonatomic, assign) CGPoint lastContactPoint1, lastContactPoint2, currentPoint;
@property (weak, nonatomic) IBOutlet UIScrollView *scView;

@end
