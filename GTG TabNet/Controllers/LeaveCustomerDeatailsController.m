//
//  LeaveCustomerDeatailsController.m
//  GTG TabNet
//
//  Created by admin on 15/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "LeaveCustomerDeatailsController.h"

@interface LeaveCustomerDeatailsController ()
{
    NSString *redirectYardValue;
    UIView *bgTransparentView;
    UIView *redirectYardPopUp;
}
@end

@implementation LeaveCustomerDeatailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[GTGTransportManager sharedManager]rejectDocumentButton:self];
    [self redirectYardAdress];
    
    NSArray *customerAddress= [CustomerAddress loadCustomerAddressById:[[GTGTransportManager sharedManager]loadId]];
    NSLog(@"%@",[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"is_stay_with"]);
    if ([[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"is_stay_with"]isEqualToString:@"false"])
    {
        _btnCheckBox.enabled=false;
        _btnCheckBox.alpha=0.5;
        
        
    }
    else
    {
        _btnCheckBox.enabled=true;;
       _btnCheckBox.alpha=1;
    }
    
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)redirectYardAdress
{
    redirectYardValue=@"NO";
}

- (IBAction)btnTimerTapped:(id)sender {
    NSString *pickerText=_btnPicker.titleLabel.text;
    [[GTGTransportManager sharedManager]pickerViewTapped:self.view fortext:pickerText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changepickertitleValue) name:@"PickerValueChanged" object:nil];
}

-(void)changepickertitleValue
{
    [self.btnPicker setTitle:[[GTGTransportManager sharedManager]selectedTime] forState:UIControlStateNormal];
    
}
- (IBAction)btnCheckBoxTapped:(id)sender
{
    if ([redirectYardValue isEqualToString:@"NO"]) {
        [_ImgCheckBox setImage:[UIImage imageNamed:@"checkBlueImg"]];
        redirectYardValue=@"YES";
        
        
    }
    else if ([redirectYardValue isEqualToString:@"YES"])
    {
        [_ImgCheckBox setImage:[UIImage imageNamed:@"uncheckBlueImg"]];
        redirectYardValue=@"NO";
    }
    
    
}


-(void)removeBGTrasparent:(UITapGestureRecognizer *)sender
{
    [self removeTransparentMethods];
    [_ImgCheckBox setImage:[UIImage imageNamed:@"uncheckBlueImg"]];
    redirectYardValue=@"NO";
    
}

-(void)removeTransparentMethods
{
    [bgTransparentView removeFromSuperview];
    [redirectYardPopUp removeFromSuperview];
    
}

- (IBAction)btnNextButtonTapped:(id)sender
{
    
    NSString *Pieces=[_txtPieces.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *Weight=[_txtWeight.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *Seal=[self.txtSeal.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
    if ([Pieces isEqualToString:@""] && Pieces.length==0 )
    {
        [self alertWithTitle:@"Alert" message:@"Please Enter Pieces Field"];
        return;
    }
    else if ([Weight isEqualToString:@""] && Weight.length==0 )
    {
        [self alertWithTitle:@"Alert" message:@"Please Enter Weight Field"];
        return;
    }
    else if ([Seal isEqualToString:@""] && Seal.length==0 )
    {
        [self alertWithTitle:@"Alert" message:@"Please Enter Seal Field"];
        return;
    }
    
    
    if ([redirectYardValue isEqualToString:@"YES"])
    {
        
        bgTransparentView=[GTGTransportManager bgTransparentView:self.view];
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBGTrasparent:)];
        [bgTransparentView addGestureRecognizer:tapGesture];
        
        redirectYardPopUp = [[[NSBundle mainBundle] loadNibNamed:@"RedirectYardPopUp" owner:self options:nil] objectAtIndex:0];
        CGRect rect = CGRectMake([[UIScreen mainScreen]bounds].size.width/12, [[UIScreen mainScreen]bounds].size.height/4, 280, 180);
        
        redirectYardPopUp.frame=rect;
        
        [self.view addSubview:bgTransparentView];
        [self.view addSubview:redirectYardPopUp];
        
    }
    else
    {
        [[GTGTransportManager sharedManager]setIsStayWithTag:nil];
        [CustomerAddress deleteCustomerAddressById:[[GTGTransportManager sharedManager]loadId ] forAddress:[[GTGTransportManager sharedManager]currentAddress]];
        NSLog(@"%@",[[GTGTransportManager sharedManager]loadId ]);
        NSLog(@"%@",[[GTGTransportManager sharedManager]currentAddress]);
        
        [[GTGTransportManager sharedManager]customerAddresses];
        
        if ([[GTGTransportManager sharedManager]customerAddressCount]==0)
        {
            
            [[GTGTransportManager sharedManager]setFinishedScreenFlow:[NSString stringWithFormat:@"%@,%@,%@",RailAddressFlag,YardAddressFlag,CustomerAddressFlag]];
            
        }
        
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TaskListViewController *taskListViewController=[storyBoard instantiateViewControllerWithIdentifier:@"tasklistController"];
        [self.navigationController pushViewController:taskListViewController animated:NO];
    
    
    
    }
    
  

    
    
  
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}



#pragma mark alertDisplay
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController * alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:NO completion:nil];
    
    
}
@end
