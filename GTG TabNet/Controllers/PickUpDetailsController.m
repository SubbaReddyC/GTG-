//
//  PickUpDetailsController.m
//  GTG TabNet
//
//  Created by admin on 25/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "PickUpDetailsController.h"

@interface PickUpDetailsController()
{
    UIView *UnitTransparentView;
    UIView *ShipmentTransparentView;
    UIView *ChasisTransparentView;
    NSString * currentButton;
    
}
@end

@implementation PickUpDetailsController

#pragma mark ViewLifeCycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    if ([[GTGTransportManager sharedManager]railCount]==1)
    {
        
    }
    else if([[GTGTransportManager sharedManager]railCount]==2)
    {
        if ([[[GTGTransportManager sharedManager]addressToShow]isEqualToString:@"NextRailAdress"])
        {
            [ChasisTransparentView removeFromSuperview];
            UnitTransparentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.unitView.bounds.size.width, self.unitView.bounds.size.height)];
            UnitTransparentView.alpha=0.3;
            UnitTransparentView.backgroundColor=[UIColor whiteColor];
            [self.unitView addSubview:UnitTransparentView];
            
            ShipmentTransparentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.shipMentView.bounds.size.width, self.shipMentView.bounds.size.height)];
            ShipmentTransparentView.alpha=0.3;
            ShipmentTransparentView.backgroundColor=[UIColor whiteColor];
            [self.shipMentView addSubview:ShipmentTransparentView];
        }
        else
        {
            [UnitTransparentView removeFromSuperview];
            [ShipmentTransparentView removeFromSuperview];
            ChasisTransparentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.shipMentView.bounds.size.width, self.shipMentView.bounds.size.height)];
            ChasisTransparentView.alpha=0.3;
            ChasisTransparentView.backgroundColor=[UIColor whiteColor];
            [self.chasisView addSubview:ChasisTransparentView];
            
        }
        
    }
    [[GTGTransportManager sharedManager]rejectDocumentButton:self];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setpickUPTime) name:@"PickerValueChanged" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PickerValueChanged" object:nil];
    
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma  mark ActionMthods
- (IBAction)btnNextTapped:(id)sender
{
    
    if ([[[GTGTransportManager sharedManager]currentScreenFlow] isEqualToString:RailAddressFlag])
    {
        if ([[[GTGTransportManager sharedManager]addressToShow]isEqualToString:@"NextRailAdress"])
        {
            NSString *chasisNumber=[self.txtChasisNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([chasisNumber isEqualToString:@""] && chasisNumber.length==0 )
            {
                [self alertWithTitle:@"Alert" message:@"Please Enter Chasis Field"];
                return;
            }
        }
        else if (![[[GTGTransportManager sharedManager]addressToShow]isEqualToString:@"NextRailAdress"])
        {
            NSString *unitID=[self.txtUnitID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *Pieces=[self.txtPieces.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *Weight=[self.txtWeight.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *Seal=[self.txtSeal.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            
            
            if ([unitID isEqualToString:@""] && unitID.length==0 )
            {
                [self alertWithTitle:@"Alert" message:@"Please Enter unitID Field"];
                return;
            }
            else if ([Pieces isEqualToString:@""] && Pieces.length==0 )
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
            
        }
        
        else
        {
            NSString *chasisNumber=[self.txtChasisNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *unitID=[self.txtUnitID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *Seal=[self.txtSeal.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *Pieces=[self.txtPieces.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *Weight=[self.txtWeight.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([chasisNumber isEqualToString:@""] && chasisNumber.length==0 )
            {
                [self alertWithTitle:@"Alert" message:@"Please Enter chasisNumber Field"];
                return;
            }
            else if ([unitID isEqualToString:@""] && unitID.length==0 )
            {
                [self alertWithTitle:@"Alert" message:@"Please Enter unitID Field"];
                return;
            }
            else if ([Pieces isEqualToString:@""] && Pieces.length==0 )
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
            
        }
        
        if ([[GTGTransportManager sharedManager]railAddressCount]==1) {
            
            
            [RailAddress UpdateRailAddressById:[[GTGTransportManager sharedManager]loadId ] forAddress:[[GTGTransportManager sharedManager]currentAddress]];
            
            [[GTGTransportManager sharedManager]railAddresses];
            
            if ([[GTGTransportManager sharedManager]railAddressCount]==0)
            {
                [[GTGTransportManager sharedManager]setFinishedScreenFlow:RailAddressFlag];
            }
            
            UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TaskListViewController *taskListViewController=[storyBoard instantiateViewControllerWithIdentifier:@"tasklistController"];
            [self.navigationController pushViewController:taskListViewController animated:YES];
            
            
        }
        
    }
    
    
}

- (IBAction)btnChasisPickUpTimerTapped:(id)sender
{
    NSString *pickerText=[self.btnChasis.titleLabel text];
    currentButton=@"Chasis";
    [[GTGTransportManager sharedManager]pickerViewTapped:self.view fortext:pickerText];
    
    
}

- (IBAction)btnUnitPickUpTimerTapped:(id)sender
{
    NSString *pickerText=[self.btnUnit.titleLabel text];
    currentButton=@"Unit";
    [[GTGTransportManager sharedManager]pickerViewTapped:self.view fortext:pickerText];
}


#pragma mark TextFieldDelegateMethods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.returnKeyType==UIReturnKeyNext) {
        UIView *next = [[textField superview] viewWithTag:textField.tag+1];
        [next becomeFirstResponder];
    } else if (textField.returnKeyType==UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    else
        return [textField resignFirstResponder];
    return YES;
    //return [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -70; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

#pragma mark customMethods
-(void)setpickUPTime
{
    if ([currentButton isEqualToString:@"Chasis"])
    {
        [self.btnChasis setTitle:[[GTGTransportManager sharedManager]selectedTime] forState:UIControlStateNormal];
        
    }
    else if ([currentButton isEqualToString:@"Unit"])
    {
        [self.btnUnit setTitle:[[GTGTransportManager sharedManager]selectedTime] forState:UIControlStateNormal];
        
    }
    
    
}



#pragma mark alertDisplay
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController * alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:NO completion:nil];
    
    
}

@end
