//
//  SignaturePopUp.m
//  GTG TabNet
//
//  Created by admin on 11/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "SignaturePopUp.h"
#import "CommonMacro.h"
#import "UpLoadE-SignatureController.h"

@implementation SignaturePopUp

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

-(void)setUp
{
    _imgBorder.layer.borderColor=CustomRGBColor(11, 50, 102).CGColor;
    _imgBorder.layer.borderWidth=1;
    [self.btnBillingTaskType setTitle:[[GTGTransportManager sharedManager]taskType ] forState:UIControlStateNormal];


}
- (IBAction)btnUploadSignatureTapped:(id)sender {
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UpLoadE_SignatureController *upLoadE_SignatureController=[storyBoard instantiateViewControllerWithIdentifier:@"UpLoadSignature"];
    //[self.navigationController pushViewController:pickUpDetailsContoller animated:NO];
    
    [(UINavigationController *)self.window.rootViewController pushViewController:upLoadE_SignatureController animated:YES];
}

- (IBAction)btnBillingTapped:(id)sender {
}
@end
