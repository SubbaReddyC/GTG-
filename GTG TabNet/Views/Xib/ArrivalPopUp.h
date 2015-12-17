//
//  ArrivalPopUp.h
//  GTG TabNet
//
//  Created by admin on 10/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArrivalPopUp : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

- (IBAction)btnConfirmArrivalTapped:(id)sender;
- (IBAction)btnDoneTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
- (IBAction)btnPickerTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPicker;

@end
