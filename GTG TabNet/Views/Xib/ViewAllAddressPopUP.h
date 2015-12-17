//
//  ViewAllAddressPopUP.h
//  GTG TabNet
//
//  Created by admin on 10/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RailAddress.h"
#import "YardName.h"
#import "PcrAddress.h"
#import "CustomerAddress.h"

@interface ViewAllAddressPopUP : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblView;



@end
