//
//  RedirectYardPopUp.m
//  
//
//  Created by admin on 15/12/15.
//
//

#import "RedirectYardPopUp.h"
#import "CustomerAddress.h"
#import "TaskListViewController.h"

@implementation RedirectYardPopUp
{
    NSArray *customerAddress;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

-(void)setup
{
   customerAddress= [CustomerAddress loadCustomerAddressById:[[GTGTransportManager sharedManager]loadId]];
    NSLog(@"%@",[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"is_stay_with"]);
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *YardDats=[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"yard"];
    return [YardDats count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier=@"Cell";
    
    UITableViewCell * cell=[self.tblView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"yard"]objectAtIndex:indexPath.row];
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[GTGTransportManager sharedManager]setIsStayWithTag:@"YES"];
    [[GTGTransportManager sharedManager]setRedirectYardAddress:[[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"yard"]objectAtIndex:indexPath.row]];
    //NSLog(@"%@",[[[[customerAddress objectAtIndex:0]valueForKey:@"customerAddress"]objectForKey:@"yard"]objectAtIndex:indexPath.row]);
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaskListViewController *taskListViewController=[storyBoard instantiateViewControllerWithIdentifier:@"tasklistController"];
    [(UINavigationController *)self.window.rootViewController pushViewController:taskListViewController animated:YES];

}

@end
