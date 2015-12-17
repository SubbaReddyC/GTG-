//
//  TaskListViewController.m
//  GTG TabNet
//
//  Created by admin on 04/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "TaskListViewController.h"
#import "CommonMacro.h"
#import "AppDelegate.h"

@interface TaskListViewController ()
{
    WebServiceViewController *serviceController;
    AppDelegate *appDelagate;
    NSMutableArray *taskListArrayData;
    NSMutableArray *taskListInfoRecords;
    NSMutableArray *taskFlags;
    ArrivalPopUp *arrivalPopUpView;
    SignaturePopUp *signatuerPopUpView;
    UIView *bgTransparentView;
    UIView *logoutView;
    UILabel *lbl;
    
}

@end

@implementation TaskListViewController


#pragma mark ViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelagate=[[UIApplication sharedApplication] delegate];
    lbl = [[UILabel alloc]init];
    lbl.frame = CGRectMake(5, -8, 300, 30);
    lbl.text = @"Start acknowledging first task";
    lbl.tintColor=[UIColor blackColor];
    [self.tblView addSubview:lbl];
    
    taskListArrayData=[[NSMutableArray alloc]init];
    
    taskListArrayData=[[GTGTransportManager sharedManager]taskListArray];
    if ([[[GTGTransportManager sharedManager]acknowledgmentTask] isEqualToString:@"YES" ]) {
        [self SavetaskListInfo];
    }
    
    [[GTGTransportManager sharedManager]rejectDocumentButton:self];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ArriveNow"];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeBgTransparent) name:@"ConfirmArrivalTapped" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeArrivalPopUp) name:@"ArrivalDoneTapped" object:nil];
   
    
    
    if ([[[GTGTransportManager sharedManager]taskFinished] isEqualToString:@"YES"])
    {
       
        [[GTGTransportManager sharedManager]setFinishedScreenFlow:nil];
        
        [[GTGTransportManager sharedManager]setCurrentScreenFlow:nil];
        [[GTGTransportManager sharedManager]setTaskFinished:nil];
        lbl.hidden=FALSE;
    }
    
    if ([[[GTGTransportManager sharedManager]acknowledgmentTask] isEqualToString:@"NO"]) {
        lbl.hidden=TRUE;
        [[NSUserDefaults standardUserDefaults]setObject:@"ArriveNow" forKey:@"ArriveNow"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ArriveNow"];
        
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:KTerminated] isEqualToString:@"YES"])
    {
        [self LoadLocalData];
        
    }
    else if([appDelagate internetStatus]==0)
    {
        [self LoadLocalData];
        
    }
    else
        [self LoadLocalData];
    
    
    [self screenFlowandCurrentAddress];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ConfirmArrivalTapped" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ArrivalDoneTapped" object:nil];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma RetriveData From Core Data

-(void)LoadLocalData
{
    
    if ([[[GTGTransportManager sharedManager]taskFinished] isEqualToString:@"YES"])
    {
        lbl.hidden=FALSE;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ArriveNow"];
        
    }
    
}



#pragma mark store Response Data

-(void)SavetaskListInfo
{
    [TaskListInfo insertDataToTasklistInfo:taskListArrayData];
    [RailAddress insertRailAddressData:taskListArrayData];
    [CustomerAddress insertCustomerAddressData:taskListArrayData];
    [TaskFlags insertDataToTasklistFlags:taskListArrayData];
    
    [PcrAddress insertPcrAddressData:taskListArrayData];
    [YardName insertYardNameData:taskListArrayData];
    
}

#pragma mark screen flow

-(void)screenFlowandCurrentAddress
{
    
    taskListInfoRecords=[[TaskListInfo loadTaskListInfoData]mutableCopy];
    
    NSArray  *Driver =  [self predicateValues:@"Driver" withSection:0];
    NSString *driverName=[[Driver objectAtIndex:0]objectForKey:@"value"];
    NSArray  *Note =  [self predicateValues:@"Note" withSection:0];
    NSString *NoteDesc=[[Note objectAtIndex:0]objectForKey:@"value"];
    [[GTGTransportManager sharedManager]setNoteDesc:NoteDesc];
    NSArray  *taskType =  [self predicateValues:@"Task Type" withSection:0];
    NSString *taskStatus=[[taskType objectAtIndex:0]objectForKey:@"value"];
    [[GTGTransportManager sharedManager]setTaskType:taskStatus];
    if([driverName isEqualToString:@"null"])
    {
        self.navigationBar.topItem.title=[NSString stringWithFormat:@"%@",@"Tasklist"];
        
    }
    else
    {
        self.navigationBar.topItem.title=[NSString stringWithFormat:@"%@-%@",@"Tasklist",driverName];
        
    }
    
    if(taskListInfoRecords.count>0)
    {
        [[GTGTransportManager sharedManager]setLoadId:[[taskListInfoRecords objectAtIndex:0]valueForKey:@"loadID"]];
    }
    
    
    NSArray *loadTaskFlagInfo=[[TaskFlags loadTaskFlagsData]mutableCopy];
    
    // for setting each flow
    if(loadTaskFlagInfo.count>0)
    {
        if ([[[[[loadTaskFlagInfo objectAtIndex:0]valueForKey:@"taskFlags"]valueForKey:@"rail"]uppercaseString]isEqualToString:@"TRUE"] && [[[GTGTransportManager sharedManager]finishedScreenFlow]length]==0)
        {
            [[GTGTransportManager sharedManager]setCurrentScreenFlow:RailAddressFlag];
            [self railFlow];
        }
        
        else if([[[[[loadTaskFlagInfo objectAtIndex:0]valueForKey:@"taskFlags"]valueForKey:@"rail"]uppercaseString] isEqualToString:@"FALSE"] && [[[GTGTransportManager sharedManager]finishedScreenFlow]length]==0 )
        {
            [[GTGTransportManager sharedManager]setFinishedScreenFlow:RailAddressFlag];
        }
        
        if([[[GTGTransportManager sharedManager]finishedScreenFlow]isEqualToString:RailAddressFlag]&&[[[[[loadTaskFlagInfo objectAtIndex:0]valueForKey:@"taskFlags"]valueForKey:@"yard"]uppercaseString]isEqualToString:@"TRUE"])
        {
            [[GTGTransportManager sharedManager]setCurrentScreenFlow:YardAddressFlag];
            [self yardFlow];
        }
        
        else if([[[GTGTransportManager sharedManager]finishedScreenFlow]isEqualToString:RailAddressFlag]&&[[[[[loadTaskFlagInfo objectAtIndex:0]valueForKey:@"taskFlags"]valueForKey:@"yard"]uppercaseString]isEqualToString:@"FALSE"])
        {
            [[GTGTransportManager sharedManager]setFinishedScreenFlow:[NSString stringWithFormat:@"%@,%@",RailAddressFlag,YardAddressFlag]];
        }
        
        if ([[[[loadTaskFlagInfo objectAtIndex:0]valueForKey:@"taskFlags"]valueForKey:@"customer"]isEqualToString:@"true"] && [[[GTGTransportManager sharedManager]finishedScreenFlow]isEqualToString:[NSString stringWithFormat:@"%@,%@",RailAddressFlag,YardAddressFlag]])
        {
            [[GTGTransportManager sharedManager]setCurrentScreenFlow:CustomerAddressFlag];
            [self customerFlow];
            
        }
        
        else if ([[[[[loadTaskFlagInfo objectAtIndex:0]valueForKey:@"taskFlags"]valueForKey:@"customer"]uppercaseString]isEqualToString:@"FALSE"] && [[[GTGTransportManager sharedManager]finishedScreenFlow]isEqualToString:[NSString stringWithFormat:@"%@,%@",RailAddressFlag,YardAddressFlag]])
        {
            
            [[GTGTransportManager sharedManager]setFinishedScreenFlow:[NSString stringWithFormat:@"%@,%@,%@",RailAddressFlag,YardAddressFlag,CustomerAddressFlag]];
            
        }
        
        if ([[[[[loadTaskFlagInfo objectAtIndex:0]valueForKey:@"taskFlags"]valueForKey:@"pcr"]uppercaseString]isEqualToString:@"TRUE"] && [[[GTGTransportManager sharedManager]finishedScreenFlow]isEqualToString:[NSString stringWithFormat:@"%@,%@,%@",RailAddressFlag,YardAddressFlag,CustomerAddressFlag]])
        {
            
            [[GTGTransportManager sharedManager]setCurrentScreenFlow:PcrAddressFlag];
            [self pcrFlow];
            
        }
        
        else if ([[[[[loadTaskFlagInfo objectAtIndex:0]valueForKey:@"taskFlags"]valueForKey:@"pcr"]uppercaseString]isEqualToString:@"FALSE"] && [[[GTGTransportManager sharedManager]finishedScreenFlow]isEqualToString:[NSString stringWithFormat:@"%@,%@,%@",RailAddressFlag,YardAddressFlag,CustomerAddressFlag]])
        {
            [[GTGTransportManager sharedManager]setCurrentScreenFlow:[NSString stringWithFormat:@"%@,%@,%@,%@",RailAddressFlag,YardAddressFlag,CustomerAddressFlag,PcrAddressFlag]];
            
            [[GTGTransportManager sharedManager]setTaskFinished:@"YES"];
            
            
        }
    }
    if ([[[GTGTransportManager sharedManager]taskFinished]isEqualToString:@"YES"])
    {
        
        [TaskListInfo deleteRecordById:[[GTGTransportManager sharedManager]loadId]];
        [TaskFlags deleteTaskFlagsRecordById:[[GTGTransportManager sharedManager]loadId]];
        [RailAddress deleteRailAddressOnlyById:[[GTGTransportManager sharedManager]loadId]];
        taskListInfoRecords=nil;
        [[GTGTransportManager sharedManager]setFinishedScreenFlow:nil];
        
        [[GTGTransportManager sharedManager]setCurrentScreenFlow:nil];
        [[GTGTransportManager sharedManager]setTaskFinished:nil];
        [[GTGTransportManager sharedManager]setLoadId:nil];
        [[GTGTransportManager sharedManager]setYardAddressCount:0];
        [[GTGTransportManager sharedManager]setRailAddressCount:0];
        [[GTGTransportManager sharedManager]setCustomerAddressCount:0];
        [[GTGTransportManager sharedManager]setPcrAddressCount:0];
        [self screenFlowandCurrentAddress];
        lbl.hidden=FALSE;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ArriveNow"];
        
    }
    
    if ([taskListInfoRecords count]==0) {
        lbl.text=@"No Records";
        
    }
    
    [self reloadData];
    
}

-(void)railFlow
{
    [[GTGTransportManager sharedManager]railAddresses];
}

-(void)yardFlow
{
    [[GTGTransportManager sharedManager]yardAddresses];
    
}
-(void)customerFlow
{
    [[GTGTransportManager sharedManager]customerAddresses];
    
}
-(void)pcrFlow
{
    [[GTGTransportManager sharedManager]pcrAddresses];
    
}

#pragma mark TableViewDelegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([taskListInfoRecords count]>0)
    {
        return [taskListInfoRecords count];
    }
    else
        return 0;
    return 0;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([taskListInfoRecords count]>0)
    {
        return 1;
    }
    else
        return 0;
    return 0;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier=@"TaskListCell";
    TaskListTableViewCell * TaskListCell=(TaskListTableViewCell *)[self.tblView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (TaskListCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TaskListTableViewCell" owner:self options:nil];
        TaskListCell = [nib objectAtIndex:0];
    }
    
    UILabel *lblLoadId=(UILabel *)[TaskListCell viewWithTag:1];
    UILabel *lblApptDate=(UILabel *)[TaskListCell viewWithTag:2];
    UILabel *lblUnitID=(UILabel *)[TaskListCell viewWithTag:3];
    UILabel *lblSizeEquip=(UILabel *)[TaskListCell viewWithTag:4];
    UILabel *lblLine=(UILabel *)[TaskListCell viewWithTag:5];
    UILabel *lblAddress=(UILabel *)[TaskListCell viewWithTag:6];
    UIButton *btnArriveNow=(UIButton *)[TaskListCell viewWithTag:7];
    UIButton *btnDeliveryStatus=(UIButton *)[TaskListCell viewWithTag:8];
    
    
    
    [btnArriveNow addTarget:self action:@selector(ArrivalPopUpTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray  *loadID =  [self predicateValues:@"Load ID" withSection:indexPath.section];
    lblLoadId.text=[[loadID objectAtIndex:0]objectForKey:@"value"];
    
    
    NSArray  *unitID =  [self predicateValues:@"Unit ID" withSection:indexPath.section];
    lblUnitID.text=[[unitID objectAtIndex:0]objectForKey:@"value"];
    
    NSArray  *appt = [self predicateValues:@"Appt" withSection:indexPath.section];
    lblApptDate.text=[[appt objectAtIndex:0]objectForKey:@"value"];
    
    NSArray  *sizeEquip = [self predicateValues:@"Size/Equip" withSection:indexPath.section];
    lblSizeEquip.text=[[sizeEquip objectAtIndex:0]objectForKey:@"value"];
    
    NSArray  *line = [self predicateValues:@"Line" withSection:indexPath.section];
    lblLine.text=[[line objectAtIndex:0]objectForKey:@"value"];
    
    NSArray  *deliveryType = [self predicateValues:@"Task Type" withSection:indexPath.section];
    NSString *delivery=[[deliveryType objectAtIndex:0]objectForKey:@"value"];
    
    
    if ([[delivery uppercaseString]isEqualToString:@"DELIVERY"])
    {
        [btnDeliveryStatus setBackgroundImage:[UIImage imageNamed:@"deliveryImg"] forState:UIControlStateNormal];
    }
    else  if([[delivery uppercaseString]isEqualToString:@"PICKUP"])
    {
        [btnDeliveryStatus setBackgroundImage:[UIImage imageNamed:@"pickupImg"] forState:UIControlStateNormal];
    }
    if (indexPath.section==0)
    {
        TaskListCell.backgroundColor=[UIColor clearColor];
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"ArriveNow"]length]>0) {
            btnArriveNow.hidden=FALSE;
            [btnArriveNow setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"ArriveNow"] forState:UIControlStateNormal];
            
        }
        else
        {
            btnArriveNow.hidden=TRUE;
        }
        
        
    }
    else
    {
        btnArriveNow.hidden=TRUE;
        TaskListCell.backgroundColor=[UIColor lightGrayColor];
        TaskListCell.alpha=0.2;
    }
    [self setAddressToLabelBySection:indexPath.section forLabel:lblAddress forloadID:lblLoadId.text];
    
    
    
    return TaskListCell;
    
}

-(void)setAddressToLabelBySection:(NSInteger)section forLabel:(UILabel*)lblAddress forloadID:(NSString *)loadID
{
    
    taskFlags=[[TaskFlags loadTaskFlagsData]mutableCopy];
    
    NSArray *railAddress=[RailAddress loadRailAddressById:loadID];
    NSArray *yardAddress=[YardName loadYardNameDataById:loadID];
    
    NSArray *customerAddress=[CustomerAddress loadCustomerAddressById:loadID];
    NSArray *pcrAddress=[PcrAddress loadPcrAddressById:loadID];
    
    if (section==0)
        
    {
        if ([[[GTGTransportManager sharedManager]currentScreenFlow] isEqualToString:RailAddressFlag])
        {
            if ([[[[[taskFlags objectAtIndex:section]valueForKey:@"taskFlags"]valueForKey:@"rail"]uppercaseString] isEqualToString:@"TRUE"])
            {
                
                
                if ([[GTGTransportManager sharedManager]railAddressCount]==1 && [[GTGTransportManager sharedManager]railAddressCount]!=0)
                {
                    
                    NSArray *railAddress=[RailAddress loadRailAddressById:[[GTGTransportManager sharedManager]loadId]];
                    
                    lblAddress.text=[[[railAddress objectAtIndex:0]valueForKey:@"railAddress"]objectForKey:@"address"];
                    [[GTGTransportManager sharedManager]setCurrentAddress:lblAddress.text];
                }
            }
            
        }
        
        else if ([[[GTGTransportManager sharedManager]currentScreenFlow ] isEqualToString:YardAddressFlag])
        {
            if ([[[[[taskFlags objectAtIndex:section]valueForKey:@"taskFlags"]valueForKey:@"yard"]uppercaseString] isEqualToString:@"TRUE"])
            {
                if ([[GTGTransportManager sharedManager]yardAddressCount]==1 && [[GTGTransportManager sharedManager]yardAddressCount]!=0)
                {
                    NSArray *yardAddress=[YardName loadYardNameDataById:[[GTGTransportManager sharedManager]loadId]];
                    
                    lblAddress.text=[[[yardAddress objectAtIndex:0]valueForKey:@"yardName"]objectForKey:@"name"];
                    [[GTGTransportManager sharedManager]setCurrentAddress:lblAddress.text];
                }
                
                
            }
        }
        
        
        else if ([[[GTGTransportManager sharedManager]currentScreenFlow ] isEqualToString:CustomerAddressFlag])
        {
            if ([[[[[taskFlags objectAtIndex:section]valueForKey:@"taskFlags"]valueForKey:@"customer"]uppercaseString] isEqualToString:@"TRUE"])
            {
                
                if ([[[GTGTransportManager sharedManager]isStayWithTag]isEqualToString:@"YES" ]) {
                    lblAddress.text=[[GTGTransportManager sharedManager]redirectYardAddress];
                }
                
                else if ( ([[GTGTransportManager sharedManager]customerAddressCount]==1 && [[GTGTransportManager sharedManager]customerAddressCount]!=0))
                {
                    NSArray *customerAddress=[CustomerAddress loadCustomerAddressById:[[GTGTransportManager sharedManager]loadId]];
                    lblAddress.text=[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"address"];
                    [[GTGTransportManager sharedManager]setCurrentAddress:lblAddress.text];
                    
                }
                
                
            }
            
        }
        
        else if ([[[GTGTransportManager sharedManager]currentScreenFlow ] isEqualToString:PcrAddressFlag])
        {
            if ([[[[[taskFlags objectAtIndex:section]valueForKey:@"taskFlags"]valueForKey:@"pcr"]uppercaseString] isEqualToString:@"TRUE"])
            {
                if ([[GTGTransportManager sharedManager]pcrAddressCount]==1 && [[GTGTransportManager sharedManager]pcrAddressCount]!=0)
                {
                    NSArray *pcrAddress=[PcrAddress loadPcrAddressById:[[GTGTransportManager sharedManager]loadId]];
                    lblAddress.text=[[[pcrAddress objectAtIndex:0]valueForKey:@"pcrAddress"]objectForKey:@"address"];
                    [[GTGTransportManager sharedManager]setCurrentAddress:lblAddress.text];
                    
                }
            }
            
        }
        
        
    }
    
    else if(section!=0)
    {
        if ([[[[taskFlags objectAtIndex:section]valueForKey:@"taskFlags"]valueForKey:@"rail"] isEqualToString:@"true"])
        {
            if ([railAddress count]==1)
            {
                
                lblAddress.text=[[[railAddress valueForKey:@"railAddress"]objectAtIndex:0]objectForKey:@"address"];
            }
            
            
        }
        else if ([[[[taskFlags objectAtIndex:section]valueForKey:@"taskFlags"]valueForKey:@"yard"] isEqualToString:@"true"])
        {
            
            
            lblAddress.text=[[[yardAddress objectAtIndex:0]valueForKey:@"yardName"]objectForKey:@"name"];
            
        }
        else if ([[[[taskFlags objectAtIndex:section]valueForKey:@"taskFlags"]valueForKey:@"customer"] isEqualToString:@"true"])
        {
            
            
            lblAddress.text=[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"address"];
            
        }
        else if ([[[[taskFlags objectAtIndex:section]valueForKey:@"taskFlags"]valueForKey:@"pcr"] isEqualToString:@"true"])
        {
            lblAddress.text=[[[pcrAddress objectAtIndex:0]valueForKey:@"pcrAddress"]objectForKey:@"address"];
            
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        if ([[[GTGTransportManager sharedManager]acknowledgmentTask] isEqualToString:@"NO"]) {
            return 10;
        }
        else
            
            return 30;
    }
    
    else
    {
        return 10;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"ArriveNow"]length]>0) {
                
                return 200;
                
            }
            else
            {
                return 165;
            }
            
            
        }
        
    }
    
    else
    {
        return 165;
    }
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailTaskListViewController *detailTaskListController=[storyBoard instantiateViewControllerWithIdentifier:@"DetailTaskList"];
        UITableViewCell *cell = [self.tblView cellForRowAtIndexPath:indexPath];
        UILabel *lblAddress = (UILabel *)[cell viewWithTag:6];
        [[GTGTransportManager sharedManager]setCurrentAddress:lblAddress.text];
        [self.navigationController pushViewController:detailTaskListController animated:YES];
        
    }
    
}

#pragma mark TableViewCell ButtonActions
- (IBAction)ArrivalPopUpTapped:(id)sender {
    bgTransparentView=[GTGTransportManager bgTransparentView:self.view];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBGTrasparent:)];
    [bgTransparentView addGestureRecognizer:tapGesture];
    arrivalPopUpView = [[[NSBundle mainBundle] loadNibNamed:@"ArrivalPopUp" owner:self options:nil] objectAtIndex:0];
    CGRect rect = CGRectMake([[UIScreen mainScreen]bounds].size.width/12, [[UIScreen mainScreen]bounds].size.height/4, 280, 180);
    
    arrivalPopUpView.frame=rect;
    
    [self.view addSubview:bgTransparentView];
    [self.view addSubview:arrivalPopUpView];
    
    
}

-(void)removeBGTrasparent:(UITapGestureRecognizer *)sender
{
    [self removeTransparentMethods];
  
}

-(void)removeArrivalPopUp
{
    [self removeTransparentMethods];
}
-(void)removeBgTransparent
{
    [self removeTransparentMethods];
    if ([[[GTGTransportManager sharedManager]currentScreenFlow]isEqualToString:RailAddressFlag])
    {
        if([[GTGTransportManager sharedManager]railCount]==2)
        {
            if (![[[GTGTransportManager sharedManager]addressToShow]isEqualToString:@"NextRailAdress"])
            {
                
                [[GTGTransportManager sharedManager]setAddressToShow:@"NextRailAdress"];
            }
            else
            {
                
                [[GTGTransportManager sharedManager]setAddressToShow:nil];
                
            }
            
            
            
        }
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PickUpDetailsController *pickUpDetailsContoller=[storyBoard instantiateViewControllerWithIdentifier:@"Pickupdetails"];
        [self.navigationController pushViewController:pickUpDetailsContoller animated:NO];
    }
    else if ([[[GTGTransportManager sharedManager]currentScreenFlow]isEqualToString:YardAddressFlag])
    {
        
        if ([[GTGTransportManager sharedManager]yardAddressCount]==1) {
            [YardName deleteYardNameById:[[GTGTransportManager sharedManager]loadId] forAddress:[[GTGTransportManager sharedManager]currentAddress]];
            
            [[GTGTransportManager sharedManager]yardAddresses];
            
            
            if ([[GTGTransportManager sharedManager]yardAddressCount]==0)
            {
                [[GTGTransportManager sharedManager]setFinishedScreenFlow:[NSString stringWithFormat:@"%@,%@",RailAddressFlag,YardAddressFlag]];
                
            }
            
            [self screenFlowandCurrentAddress];
            [self LoadLocalData];
        }
        
    }
    
    else if ([[[GTGTransportManager sharedManager]currentScreenFlow]isEqualToString:CustomerAddressFlag])
    {
        
        if ([[GTGTransportManager sharedManager]customerAddressCount]==1)
        {
            NSArray *customerAddress= [CustomerAddress loadCustomerAddressById:[[GTGTransportManager sharedManager]loadId]];
            //for (int i=0; i<[customerAddress count]; i++)
            ///{
                NSMutableDictionary *customeraddressDictionary=[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"];
                if ([[customeraddressDictionary objectForKey:@"is_stay_with"]isEqualToString:@"true"] && [[customeraddressDictionary objectForKey:@"proof_method"]isEqualToString:@"E-Signature"])
                {
                    bgTransparentView=[GTGTransportManager bgTransparentView:self.view];
                    
                    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBGTrasparent:)];
                    [bgTransparentView addGestureRecognizer:tapGesture];
                    
                    signatuerPopUpView = [[[NSBundle mainBundle] loadNibNamed:@"SignaturePopUp" owner:self options:nil] objectAtIndex:0];
                    CGRect rect = CGRectMake([[UIScreen mainScreen]bounds].size.width/12, [[UIScreen mainScreen]bounds].size.height/4, 280, 150);
                    
                    signatuerPopUpView.frame=rect;
                    
                    [self.view addSubview:bgTransparentView];
                    [self.view addSubview:signatuerPopUpView];
                    
                }
                else
                {
                
                    [CustomerAddress deleteCustomerAddressById:[[GTGTransportManager sharedManager]loadId ] forAddress:[[GTGTransportManager sharedManager]currentAddress]];
                    
                                [[GTGTransportManager sharedManager]customerAddresses];
                    
                                if ([[GTGTransportManager sharedManager]customerAddressCount]==0)
                                {
                    
                                    [[GTGTransportManager sharedManager]setFinishedScreenFlow:[NSString stringWithFormat:@"%@,%@,%@",RailAddressFlag,YardAddressFlag,CustomerAddressFlag]];
                                    
                                }
                                
                                [self screenFlowandCurrentAddress];
                                [self LoadLocalData];
                }
                
            //}
            
        }
        
    }
    
    else if ([[[GTGTransportManager sharedManager]currentScreenFlow]isEqualToString:PcrAddressFlag])
    {
        
        
        if ([[GTGTransportManager sharedManager]pcrAddressCount]==1)
        {
            [PcrAddress deletePcrAddressById:[[GTGTransportManager sharedManager]loadId] forAddress:[[GTGTransportManager sharedManager]currentAddress]];
            [[GTGTransportManager sharedManager]pcrAddresses];
            
            
            if ([[GTGTransportManager sharedManager]pcrAddressCount]==0)
            {
                [[GTGTransportManager sharedManager]setFinishedScreenFlow:[NSString stringWithFormat:@"%@,%@,%@,%@",RailAddressFlag,YardAddressFlag,CustomerAddressFlag,PcrAddressFlag]];
                
                [[GTGTransportManager sharedManager]setTaskFinished:@"YES"];
                
                
            }
            [self screenFlowandCurrentAddress];
            [self LoadLocalData];
            
        }
        
        
    }
    
}

-(IBAction)logoutBtnTapped:(id)sender
{
    UIButton *btnLogout=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLogout.frame = CGRectMake(self.view.frame.size.width-130, 64, 100, 35);
    [btnLogout setTitle:@"LogOut" forState:UIControlStateNormal];
    [btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogout setBackgroundColor:CustomRGBColor(4, 43, 94)];
    [btnLogout addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogout];
    
}
-(IBAction)logOut:(id)sender
{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController=[storyBoard instantiateViewControllerWithIdentifier:@"Login"];
    [self.navigationController pushViewController:loginViewController animated:NO];
    
}


-(NSArray *)predicateValues:(NSString *)predicateValue withSection:(NSInteger)section
{
    if(taskListInfoRecords.count>0)
    {
        taskListInfoRecords=[[TaskListInfo loadTaskListInfoData]mutableCopy];
        NSArray *array=[[taskListInfoRecords objectAtIndex:section]valueForKey:@"taskDetails"];
        NSPredicate *apptPredicate = [NSPredicate predicateWithFormat:@"label == %@", predicateValue];
        NSArray  *predicateData = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:apptPredicate]];
        return predicateData;
        
    }
    return nil;
  
}

-(void)reloadData
{
    [self.tblView reloadData];
}
-(void)removeTransparentMethods
{
    [bgTransparentView removeFromSuperview];
    [arrivalPopUpView removeFromSuperview];
    
}


@end
