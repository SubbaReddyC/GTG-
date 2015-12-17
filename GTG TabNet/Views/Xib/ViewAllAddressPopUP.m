//
//  ViewAllAddressPopUP.m
//  GTG TabNet
//
//  Created by admin on 10/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "ViewAllAddressPopUP.h"

@implementation ViewAllAddressPopUP
{

    NSMutableArray *allAddresses;
    NSArray *railAddress;
    NSArray *yardAddress;
    NSArray *cutomerAddress;
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    allAddresses=[[NSMutableArray alloc]init];
    
    [self setup];
}

-(void)setup
{
    railAddress=[RailAddress loadRailAddressData:[[GTGTransportManager sharedManager]loadId]];
    if ([railAddress count]>0) {
        for (int i=0; i<[railAddress count]; i++) {
            [allAddresses addObject:[[railAddress objectAtIndex:i]valueForKey:@"address"]];
        }
    }
   
    
    yardAddress=[YardName loadYardAddresses:[[GTGTransportManager sharedManager]loadId]];
    if ([yardAddress count]>0) {
        for (int i=0; i<[yardAddress count]; i++) {
            [allAddresses addObject:[[yardAddress objectAtIndex:i]valueForKey:@"address"]];
        }
    }
    
   cutomerAddress=[CustomerAddress loadCustomerAddressData:[[GTGTransportManager sharedManager]loadId]];
    if ([cutomerAddress count]>0) {
        for (int i=0; i<[cutomerAddress count]; i++) {
            [allAddresses addObject:[[cutomerAddress objectAtIndex:i]valueForKey:@"address"]];
        }
    }
    
    
   
   

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int sectionCount=0;
    if ([railAddress count]>0) {
        sectionCount++;
    }
    if ([yardAddress count]>0) {
        sectionCount++;
    }
    if ([cutomerAddress count]>0) {
        sectionCount++;
    }
    return sectionCount;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            [railAddress count];
            break;
        case 1:
            [yardAddress count];
            break;
            
        default:
            break;
    }
    return [allAddresses count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString * cellIdentifier=@"AddressCell";
    UITableViewCell * cell=[self.tblView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *lblCurrentStatusField;
    UILabel *lblNextStatusField;
    
    if (cell==nil) {
        cell=[[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        lblCurrentStatusField = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 7.0, 150.0, 30.0)];
                    //lblCurrentStatusField.text = @"Current";
                    lblCurrentStatusField.font=[UIFont fontWithName:@"Arial" size:12];
                    [cell.contentView addSubview:lblCurrentStatusField];
        
        lblNextStatusField = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 7.0, 150.0, 30.0)];
                    lblNextStatusField.font=[UIFont fontWithName:@"Arial" size:12];
        
                    [cell.contentView addSubview:lblNextStatusField];
    }
    if (indexPath.section==0) {
        //NSArray *railAddress=[RailAddress loadRailAddressData:[[GTGTransportManager sharedManager]loadId]];
        
        if ([railAddress count]>0) {
            for (int i=0; i<[railAddress count]; i++) {
              cell.textLabel.text=[[railAddress objectAtIndex:i]valueForKey:@"address"];
            }}
        
//        if (indexPath.row==0) {
//            UILabel *lblCurrentStatusField = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 7.0, 150.0, 30.0)];
//            lblCurrentStatusField.text = @"Current";
//            lblCurrentStatusField.font=[UIFont fontWithName:@"Arial" size:12];
//            [cell.contentView addSubview:lblCurrentStatusField];
//        }
    }
    if (indexPath.section==1) {
        //NSArray *cutomerAddress=[CustomerAddress loadCustomerAddressData:[[GTGTransportManager sharedManager]loadId]];
        if ([cutomerAddress count]>0) {
            for (int i=0; i<[cutomerAddress count]; i++) {
                 cell.textLabel.text=[[cutomerAddress objectAtIndex:i]valueForKey:@"address"];
                //[allAddresses addObject:[[cutomerAddress objectAtIndex:i]valueForKey:@"address"]];
            }
        }
//        if (indexPath.row==0) {
//            UILabel *lblNextStatusField = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 7.0, 150.0, 30.0)];
//            lblNextStatusField.text = @"Next";
//            lblNextStatusField.font=[UIFont fontWithName:@"Arial" size:12];
//
//            [cell.contentView addSubview:lblNextStatusField];
//        }
    }
    cell.textLabel.text=[allAddresses objectAtIndex:indexPath.row];
    
    NSUInteger indexOfTheObject = [allAddresses indexOfObject:[[GTGTransportManager sharedManager]currentAddress]];
    
    if (indexPath.row==indexOfTheObject)
    {
        lblCurrentStatusField.text = @"Current";
    }
    
    if (indexOfTheObject!=0) {
        
        if (indexPath.row==indexOfTheObject-1)
        {
            lblCurrentStatusField.text = @"Previous";
        }
    }
    if (![[[GTGTransportManager sharedManager]currentAddress] isEqualToString:[allAddresses lastObject]]) {
        
        if (indexPath.row==indexOfTheObject+1)
        {
            lblCurrentStatusField.text = @"Next";
        }
    }
    
    return cell;
    
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *headerLabel = [[UILabel alloc] init];
//    
//    headerLabel.font = [UIFont boldSystemFontOfSize:18];
//    headerLabel.frame = CGRectMake(70,18,200,1);
//    headerLabel.textColor = [UIColor redColor];
//    return headerLabel;
//}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Rail ", @"Rail ");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Customer", @"Customer");
            break;
           
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
    

}



@end
