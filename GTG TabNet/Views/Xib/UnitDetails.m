//
//  UnitDetails.m
//  GTG TabNet
//
//  Created by admin on 18/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "UnitDetails.h"

@implementation UnitDetails

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

- (IBAction)btnTimerTapped:(id)sender {
    [[GTGTransportManager sharedManager]pickerViewTapped:self];
}
@end
