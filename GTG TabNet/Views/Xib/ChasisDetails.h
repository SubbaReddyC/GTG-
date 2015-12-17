//
//  ChasisDetails.h
//  GTG TabNet
//
//  Created by admin on 18/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTGTransportManager.h"

@interface ChasisDetails : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtChasisNumber;

@property (weak, nonatomic) IBOutlet UIButton *btnTimer;
- (IBAction)btnTimerTapped:(id)sender;

@end
