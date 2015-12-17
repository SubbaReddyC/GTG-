//
//  RejectDocumentViewController.m
//  GTG TabNet
//
//  Created by admin on 09/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "RejectDocumentViewController.h"
#import "RejectedDocumentTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "GTGTransportManager.h"


@interface RejectDocumentViewController ()
{
    NSMutableArray * rejecteddocsArray;
    WebServiceViewController *serviceController;
}
@end

@implementation RejectDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rejecteddocsArray=[[RejecteDocument loadRejectedDoc]mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [rejecteddocsArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier=@"rejectDocumentCell";
    RejectedDocumentTableViewCell * rejectedCell=(RejectedDocumentTableViewCell *)[self.tblView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (rejectedCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RejectedDocumentTableViewCell" owner:self options:nil];
        rejectedCell = [nib objectAtIndex:0];
    }
    UILabel *lblLoadId=(UILabel *)[rejectedCell viewWithTag:100];
    UILabel *lblDocType=(UILabel *)[rejectedCell viewWithTag:101];
    UILabel *lblPagesRejected=(UILabel *)[rejectedCell viewWithTag:102];
    UILabel *lblLocation=(UILabel *)[rejectedCell viewWithTag:103];
    UIButton *btnPreview=(UIButton *)[rejectedCell viewWithTag:104];
    UIButton *btnUpload=(UIButton *)[rejectedCell viewWithTag:105];
    
   // NSLog(@"%@",[[rejecteddocsArray objectAtIndex:indexPath.section]valueForKey:@"loadID"]);
    lblLoadId.text=[[rejecteddocsArray objectAtIndex:indexPath.section]valueForKey:@"loadID"];
    
    lblDocType.text=[[rejecteddocsArray objectAtIndex:indexPath.section]valueForKey:@"docType"];
    
    NSArray *rejecteddocs = [[rejecteddocsArray objectAtIndex:indexPath.section]valueForKey:@"rejectedDoc"];
    for (int i=0; i<[rejecteddocs count]; i++) {
        NSString *greeting = [[rejecteddocs valueForKey:@"page_id"]componentsJoinedByString:@"," ];
        lblPagesRejected.text=greeting;
    }
    
    
    lblLocation.text=[[rejecteddocsArray objectAtIndex:indexPath.section]valueForKey:@"address"];
    rejectedCell.layer.borderColor=[UIColor grayColor].CGColor;
    rejectedCell.layer.borderWidth=1;
    rejectedCell.layer.cornerRadius=5;
    btnPreview.layer.cornerRadius=5;
    btnUpload.layer.cornerRadius=5;
    
    return  rejectedCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}





- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
