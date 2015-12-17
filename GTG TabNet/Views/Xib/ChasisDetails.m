//
//  ChasisDetails.m
//  GTG TabNet
//
//  Created by admin on 18/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "ChasisDetails.h"

@implementation ChasisDetails

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

-(void)setup
{
    self.btnTimer.layer.cornerRadius=5;
    self.btnTimer.layer.borderWidth=1;
    self.btnTimer.layer.borderColor=[UIColor lightGrayColor].CGColor;

}
- (IBAction)btnTimerTapped:(id)sender
{
   //[[GTGTransportManager sharedManager]pickerViewTapped:self];
    
}

//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    NSString *chasisnumber=[self.txtChasisNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    
//    
//    if ([self.txtChasisNumber.text length]>0 && ![chasisnumber isEqualToString:@""])
//    {
//        [[GTGTransportManager sharedManager]setChasisNumber:chasisnumber];
//        
//    }
//
//    return YES;
//}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if ([self.txtChasisNumber.text length]>0 && ![self.txtChasisNumber.text isEqualToString:@""])
    {
        [[GTGTransportManager sharedManager]setChasisNumber:self.txtChasisNumber.text];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ChasesNumberEntered" object:self];
        self.txtChasisNumber.text=[[GTGTransportManager sharedManager]chasisNumber];
    }
    else if ([self.txtChasisNumber.text length]==0)
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Alert" message:@"please Enter Chasis Number" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
       
        return;
    
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
@end
