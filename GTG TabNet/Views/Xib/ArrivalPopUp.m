//
//  ArrivalPopUp.m
//  GTG TabNet
//
//  Created by admin on 10/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "ArrivalPopUp.h"
#import "GTGTransportManager.h"


@implementation ArrivalPopUp

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 
 //its done by me
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    if ([[[GTGTransportManager sharedManager]isStayWithTag]isEqualToString:@"YES" ])
    {
        self.lblAddress.text=[[GTGTransportManager sharedManager]redirectYardAddress];
    }
    else
    {
        self.lblAddress.text=[[GTGTransportManager sharedManager]currentAddress];
    }

    
    
}



#pragma mark - Get Picker Value
-(void)changepickertitleValue
{
    [self.btnPicker setTitle:[[GTGTransportManager sharedManager]selectedTime] forState:UIControlStateNormal];
   
}


- (IBAction)btnConfirmArrivalTapped:(UIButton *)sender
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ConfirmArrivalTapped" object:self];
}

- (IBAction)btnDoneTapped:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ArrivalDoneTapped" object:self];
}
- (IBAction)btnPickerTapped:(id)sender {
    NSString *pickerText=self.btnPicker.titleLabel.text;
    [[GTGTransportManager sharedManager]pickerViewTapped:self fortext:pickerText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changepickertitleValue) name:@"PickerValueChanged" object:nil];
}
@end
