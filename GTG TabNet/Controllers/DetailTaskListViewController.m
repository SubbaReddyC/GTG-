//
//  DetailTaskListViewController.m
//  GTG TabNet
//
//  Created by admin on 02/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "DetailTaskListViewController.h"


@interface DetailTaskListViewController ()
{
    NSMutableArray *detailsArray;
      UIView *bgTransparentView;
      UIView *notePopUpView;
     UIView *viewAllAddressPopUP;
    
}
@end

@implementation DetailTaskListViewController


#pragma mark View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSArray *matchingData=[TaskListInfo loadTaskListInfoDataById:[[GTGTransportManager sharedManager]loadId]];
    
    
    detailsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[matchingData count]; i++) {
        
        
        NSArray *originalArray = [[matchingData objectAtIndex:i]valueForKey:@"taskDetails"];
        
        NSSortDescriptor *alphaNumSD = [NSSortDescriptor sortDescriptorWithKey:@"sort_order"
                                                                     ascending:YES
                                                                    comparator:^(NSString *string1, NSString *string2)
                                        {
                                            return [string1 compare:string2 options:NSNumericSearch];
                                        }];
        NSArray *sortedArray = [originalArray sortedArrayUsingDescriptors:@[alphaNumSD]];
        for (int i=0; i<[sortedArray count]; i++) {
            if ([[[sortedArray objectAtIndex:i]valueForKey:@"visibility"]isEqualToString:@"true"]) {
                [detailsArray addObject:[sortedArray objectAtIndex:i]];
            }
        }
    }
    
    NSMutableDictionary *addressDictionary=[[NSMutableDictionary alloc]init];
    [addressDictionary setObject:@"Address" forKey:@"label"];
    [addressDictionary setObject:[NSNumber numberWithInt:50] forKey:@"sort_order"];
    [addressDictionary setObject:[[GTGTransportManager sharedManager]currentAddress] forKey:@"value"];
    [addressDictionary setObject:[NSNumber numberWithBool:true] forKey:@"visibility"];
    [detailsArray addObject:addressDictionary];
    
    
 
    
    [self.tblView reloadData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeTransparentMethods) name:@"CloseNoteTapped" object:nil ];
    
}
-(void)viewWillDisappear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"CloseNoteTapped" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView Delagete methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [detailsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"DetailCell";
    UITableViewCell * cell=[self.tblView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UILabel *lblTaskName=(UILabel *)[cell viewWithTag:1];
    UILabel *lblTaskValue=(UILabel *)[cell viewWithTag:2];
    lblTaskName.text=[[detailsArray objectAtIndex:indexPath.row]objectForKey:@"label"];
    lblTaskValue.text=[[detailsArray objectAtIndex:indexPath.row]objectForKey:@"value"];
    return cell;
    
}

#pragma  mark ButtonActions

- (IBAction)btnNextTapped:(id)sender
{
    
    
    [[GTGTransportManager sharedManager]setAcknowledgmentTask:@"NO"];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaskListViewController *taskListViewController=[storyBoard instantiateViewControllerWithIdentifier:@"tasklistController"];
    [self.navigationController pushViewController:taskListViewController animated:NO];
    
    
}

- (IBAction)btnNoteTapped:(id)sender
{

    bgTransparentView=[GTGTransportManager bgTransparentView:self.view];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBGTrasparent:)];
    [bgTransparentView addGestureRecognizer:tapGesture];
    notePopUpView = [[[NSBundle mainBundle] loadNibNamed:@"NotePopUp" owner:self options:nil] objectAtIndex:0];
    CGRect rect = CGRectMake([[UIScreen mainScreen]bounds].size.width/12, [[UIScreen mainScreen]bounds].size.height/4, 280, 180);
    
    notePopUpView.frame=rect;
    
    [self.view addSubview:bgTransparentView];
    [self.view addSubview:notePopUpView];
    
}
-(void)removeBGTrasparent:(UITapGestureRecognizer *)sender
{
    [self removeTransparentMethods];

}

-(void)removeTransparentMethods
{
    [bgTransparentView removeFromSuperview];
    [notePopUpView removeFromSuperview];
    
}
- (IBAction)btnRejectTapped:(id)sender {
    
}

- (IBAction)btnSuccessTapped:(id)sender {
}

- (IBAction)btnViewAllAddressTapped:(id)sender
{
    
    bgTransparentView=[GTGTransportManager bgTransparentView:self.view];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBGTrasparent:)];
    [bgTransparentView addGestureRecognizer:tapGesture];
    viewAllAddressPopUP = [[[NSBundle mainBundle] loadNibNamed:@"ViewAllAddressPopUP" owner:self options:nil] objectAtIndex:0];
    CGRect rect = CGRectMake([[UIScreen mainScreen]bounds].size.width/12, [[UIScreen mainScreen]bounds].size.height/4, 280, 260);
    
    viewAllAddressPopUP.frame=rect;
    
    [self.view addSubview:bgTransparentView];
    [self.view addSubview:viewAllAddressPopUP];
    
}
@end
