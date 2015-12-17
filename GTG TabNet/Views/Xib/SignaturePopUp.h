//
//  SignaturePopUp.h
//  GTG TabNet
//
//  Created by admin on 11/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTGTransportManager.h"

@interface SignaturePopUp : UIView
- (IBAction)btnUploadSignatureTapped:(id)sender;
- (IBAction)btnBillingTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnBillingTaskType;
@property (weak, nonatomic) IBOutlet UIImageView *imgBorder;


@end
