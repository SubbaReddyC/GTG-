
//
//  ViewController.m
//  GTG TabNet
//
//  Created by admin on 03/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<WebServiceViewControllerDelegate>
{
    NSString *remembermeValue;
    NSManagedObjectContext * context;
    AppDelegate *appDelegate;
    WebServiceViewController *webServiceViewController;
    NSArray *fetchCoredataObjects;
    NSString * PresentAPI;

}
@end

@implementation LoginViewController


#pragma mark viewlifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self userNameTextField];
    [self passWordTextField];
    [self rememeberMeCheckMark];
    
    UITapGestureRecognizer *hideKeyBoard=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.scView addGestureRecognizer:hideKeyBoard];
    
    appDelegate=[[UIApplication sharedApplication]delegate];
    context=[appDelegate managedObjectContext];
  
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSArray *users=[Users LoadDataFromUsers];
    if (users.count>0) {
        Users *usersList=[users objectAtIndex:0];
        if ([[usersList rememberMe] isEqualToString:@"YES"]) {
            self.txtUserName.text=usersList.userName;
            self.txtPassWord.text=usersList.passWord;
            self.rememberMeImg.image=[UIImage imageNamed:@"checkBlueImg"];
            remembermeValue=@"YES";

        }
        else
         {
             self.txtUserName.text=@"";
             self.txtPassWord.text=@"";
             self.rememberMeImg.image=[UIImage imageNamed:@"uncheckBlueImg"];
             remembermeValue=@"NO";
         }
    
    }
    [self.navigationController setNavigationBarHidden:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark userNameTextField UI

-(void)userNameTextField
{
    UIImageView *imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userImg"]];
    imgView.frame=CGRectMake(0, 0, 25, 25);
    self.txtUserName.leftView=imgView;
    self.txtUserName.leftViewMode=UITextFieldViewModeAlways;
    self.txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  UserName " attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    webServiceViewController=[[WebServiceViewController alloc]init];
    webServiceViewController.delegate=self;
    
}

#pragma mark userNameTextField UI

-(void)passWordTextField
{
    UIImageView *imgview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"passwordImg"]];
    imgview.frame=CGRectMake(0, 0, 25, 25);
    self.txtPassWord.leftView=imgview;
    self.txtPassWord.leftViewMode=UITextFieldViewModeAlways;
    self.txtPassWord.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  PassWord " attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

#pragma mark rememeberMeImage UI

-(void)rememeberMeCheckMark
{
remembermeValue=@"NO";
    
}

# pragma mark UiTouchEvent

-(void)hideKeyBoard
{
    [self.view endEditing:YES];
     [self.scView setContentOffset:CGPointMake(0,0) animated:YES];
}



#pragma mark textfielddelegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.view.frame.size.height==IS_iPhone4S) {
        
        self.scView.contentSize=CGSizeMake(self.scView.bounds.size.width, self.scView.frame.size.height+200);
        self.scView.contentOffset=CGPointMake(0, textField.center.y-160);
    }
    
    else if (self.view.frame.size.height==IS_iPhone4SOR5) {
        self.scView.contentSize=CGSizeMake(self.scView.bounds.size.width, self.scView.frame.size.height+100);
        self.scView.contentOffset=CGPointMake(0, textField.center.y-200);
    }
    else if(self.view.frame.size.height==IS_iPhone6)
    {
        self.scView.contentSize=CGSizeMake(self.scView.bounds.size.width, self.scView.frame.size.height+50);
        self.scView.contentOffset=CGPointMake(0, textField.center.y-380);
        
    }
    
    else if(self.view.frame.size.height==IS_iPhone6Plus)
    {
        self.scView.contentSize=CGSizeMake(self.scView.bounds.size.width, self.scView.frame.size.height+50);
        self.scView.contentOffset=CGPointMake(0, textField.center.y-400);
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.scView setContentOffset:CGPointMake(0,0) animated:YES];
    return YES;
}


#pragma mark Button Actions

- (IBAction)btnRememberMeTapped:(id)sender {
    
    if ([remembermeValue isEqualToString:@"YES"]) {
        remembermeValue=@"NO";
        self.rememberMeImg.image=[UIImage imageNamed:@"uncheckBlueImg"];
       
    }
    else if([remembermeValue isEqualToString:@"NO"])
    {
        remembermeValue=@"YES";
         self.rememberMeImg.image=[UIImage imageNamed:@"checkBlueImg"];
    
    }
 
}

- (IBAction)btnLoginTapped:(id)sender {
   
    [self.view endEditing:YES];
    [self.scView setContentOffset:CGPointMake(0,0) animated:YES];
    NSString *userName=[self.txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passWord=[self.txtPassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([userName isEqualToString:@""] && userName.length==0 && [passWord isEqualToString:@""] && passWord.length==0) {
        [self alertWithTitle:@"Alert" message:@"Plese enter UserName and PassWord"];
        return;
    }
    
    else if ([userName isEqualToString:@""] && userName.length==0 ) {
        [self alertWithTitle:@"Alert" message:@"Plese enter UserName"];
        return;
    }
    else if([passWord isEqualToString:@""] && passWord.length==0)
    {
        [self alertWithTitle:@"Alert" message:@"Plese enter PassWord"];
        return;
    
    }
    else if([appDelegate internetStatus]!=0 && userName.length>0 && passWord.length>0)
    {
        [ActivityIndicator showActivityIndicator:self.view];
         PresentAPI=@"LoginAPI";
        [webServiceViewController loginusername:userName passWord:passWord withHttpMethod:@"POST"];
    
    }

}


-(void)receivedResponse:(id)response
{
    
        if ([PresentAPI isEqualToString:@"LoginAPI"]&&[[response objectForKey:@"statuscode"] isEqualToString:@"Login Successful"])
        {
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setValue:self.txtUserName.text forKey:@"UserName"];
            [userDefaults synchronize];
            NSMutableDictionary *loginUserDictionary = [[NSMutableDictionary alloc]init];
            [loginUserDictionary setObject:[response objectForKey:@"authtoken"] forKey:@"authtoken"];
            [loginUserDictionary setObject:[response objectForKey:@"statuscode"] forKey:@"status"];
            [loginUserDictionary setObject:self.txtUserName.text forKey:@"username"];
            [loginUserDictionary setObject:self.txtPassWord.text forKey:@"password"];
            [loginUserDictionary setObject:remembermeValue forKey:@"rememberme"];
            [Users updateEntityObject:loginUserDictionary];
           
            PresentAPI=@"RejectedDocumentAPI";
            [webServiceViewController getRejectedDocumentList:self.txtUserName.text];

    }
    
        else if ([PresentAPI isEqualToString:@"RejectedDocumentAPI"])
        {
            [RejecteDocument insertRejectedDocumetData:[response objectForKey:@"docs"]];
             PresentAPI=@"TaskListAPI";
            [webServiceViewController getTaskListDataWithUserName:self.txtUserName.text];
           
        
        
        }
    
        else if([PresentAPI isEqualToString:@"TaskListAPI"])
        {
            self.txtUserName.text=@"";
            self.txtPassWord.text=@"";
            
            
            UIStoryboard * storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TaskListViewController *taskListContoller=[storyBoard instantiateViewControllerWithIdentifier:@"tasklistController"];
            [ActivityIndicator removeActivityIndicator];
            [[GTGTransportManager sharedManager]setAcknowledgmentTask:@"YES"];
            [[GTGTransportManager sharedManager]setTaskListArray:[response objectForKey:@"tasklist"]];
           
            [self.navigationController pushViewController:taskListContoller animated:YES];
            
        }
}



#pragma mark alertDisplay
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController * alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:NO completion:nil];


}
-(void)failedWithError:(NSString *)errorTitle description:(NSString *)errorDescription
{
    
    UIAlertController * alertController=[UIAlertController alertControllerWithTitle:errorTitle message:errorDescription preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:NO completion:nil];
     [self.scView setContentOffset:CGPointMake(0,0) animated:YES];

}





@end
