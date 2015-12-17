//
//  DetailTaskListViewController.h
//  GTG TabNet
//
//  Created by admin on 02/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListInfo.h"
#import "PickUpDetailsController.h"
#import "TaskListViewController.h"
#import "NotePopUp.h"
#import "GTGTransportManager.h"
#import "ViewAllAddressPopUP.h"

@interface DetailTaskListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UITableView *tblView;

- (IBAction)btnNextTapped:(id)sender;
- (IBAction)btnNoteTapped:(id)sender;

- (IBAction)btnRejectTapped:(id)sender;

- (IBAction)btnSuccessTapped:(id)sender;
- (IBAction)btnViewAllAddressTapped:(id)sender;

@end
