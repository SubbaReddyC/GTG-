//
//  TaskListViewController.h
//  GTG TabNet
//
//  Created by admin on 04/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceViewController.h"
#import "DetailTaskListViewController.h"
#import "GTGTransportManager.h"
#import "ArrivalPopUp.h"
#import "LoginViewController.h"
#import "TaskListInfo.h"
#import "TaskFlags.h"
#import "RailAddress.h"
#import "CustomerAddress.h"
#import "YardName.h"
#import "PcrAddress.h"
#import "TaskListTableViewCell.h"
#import "RejectDocumentViewController.h"
#import "SignaturePopUp.h"



@interface TaskListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
   
    
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIButton *btnLogoutTapped;
@property(strong,nonatomic) NSString *userName;




-(IBAction)logoutBtnTapped:(id)sender;


@end
