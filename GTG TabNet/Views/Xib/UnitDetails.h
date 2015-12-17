//
//  UnitDetails.h
//  GTG TabNet
//
//  Created by admin on 18/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTGTransportManager.h"

@interface UnitDetails : UIView
@property (weak, nonatomic) IBOutlet UITextField *txtPieces;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;
@property (weak, nonatomic) IBOutlet UITextField *txtSeal;
@property (weak, nonatomic) IBOutlet UITextField *txtUnitNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnTimer;
- (IBAction)btnTimerTapped:(id)sender;

@end
