//
//  RejectDocumentViewController.h
//  GTG TabNet
//
//  Created by admin on 09/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceViewController.h"
#import "ActivityIndicator.h"
#import "RejecteDocument.h"

@interface RejectDocumentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblView;
- (IBAction)btnBackTapped:(id)sender;

@end
