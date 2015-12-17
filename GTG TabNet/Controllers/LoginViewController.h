//
//  ViewController.h
//  GTG TabNet
//
//  Created by admin on 03/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users.h"
#import "WebServiceViewController.h"
#import "AppDelegate.h"
#import "ActivityIndicator.h"
#import "TaskListViewController.h"
#import "GTGTransportManager.h"
#import "CommonMacro.h"
#import "RejecteDocument.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassWord;
@property (weak, nonatomic) IBOutlet UIImageView *rememberMeImg;
@property (weak, nonatomic) IBOutlet UIScrollView *scView;
@property (weak, nonatomic) IBOutlet UIView *scContentView;


- (IBAction)btnRememberMeTapped:(id)sender;
- (IBAction)btnLoginTapped:(id)sender;


@end

