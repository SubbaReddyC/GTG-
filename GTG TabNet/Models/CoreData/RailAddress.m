//
//  RailAddress.m
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "RailAddress.h"

@implementation RailAddress

+(void)insertRailAddressData:(NSMutableArray *)tasKlistInfoArray
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    
    [self deleteAllRecords];
    for (int i=0; i<[tasKlistInfoArray count]; i++)
    {
        
        NSArray *array=[[tasKlistInfoArray valueForKey:@"task_details"]objectAtIndex:i];
        NSPredicate *loadIdPredicate = [NSPredicate predicateWithFormat:@"label == %@", @"Load ID"];
        NSArray  *loadresult = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:loadIdPredicate]];
        NSString *loadId=[[loadresult objectAtIndex:0]objectForKey:@"value"];
        
        
        
        if (![[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"rail_address" ] isKindOfClass:[NSNull class]]) {
            
            
            
            if ([[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"rail_address" ]count]>0)
            {
                
                
                for (int j=0; j<[[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"rail_address" ]count]; j++)
                {
                    
                    
                    
                    RailAddress  *railAddress=(RailAddress *)[NSEntityDescription insertNewObjectForEntityForName:@"RailAddress" inManagedObjectContext:context];
                    
                    [railAddress setLoadID:loadId];
                    [railAddress setStatus:@"Progress"];
                    // NSLog(@"Progress%@",[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:0]);
                    
                    // before removing check this
                    
                    //[railAddress setAddress:[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:j]objectForKey:@"address"]];
                    
                    
                    //            if(![[[tasKlistInfoArray objectAtIndex:i]valueForKey:@"rail_address"] isKindOfClass:[NSNull class]] )
                    //            {
                    //                [railAddress setRailAddress:[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:j]];
                    //            }
                    if ([[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"rail_address" ]count]==2) {
                        
                        //this loop is for inserting the condtion chasis =true and unit =false has to insert first  then another address
                        for (int k=0; k<1; k++)
                        {
                            if ([[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:j]objectForKey:@"is_chassis"]isEqualToString:@"true"] && [[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:j]objectForKey:@"is_unit"]isEqualToString:@"false"])
                            {
                                [railAddress setRailAddress:[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:0]];
                                //NSLog(@"railadreess%@",[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:0]);
                                [railAddress setAddress:[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:0]objectForKey:@"address"]];
                                // NSLog(@"adreess%@",[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:0]objectForKey:@"address"]);
                            }
                            else
                            {
                                [railAddress setRailAddress:[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:1]];
                                // NSLog(@"railadreess%@",[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:1]);
                                [railAddress setAddress:[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:1]objectForKey:@"address"]];
                            }
                        }
                    }
                    else if([[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"rail_address" ]count]==1)
                        
                    {
                        [railAddress setRailAddress:[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:j]];
                        [railAddress setAddress:[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"rail_address"]objectAtIndex:j]objectForKey:@"address"]];
                    }
                    
                    
                    NSError *error;
                    if (![context save:NULL]) {
                        NSLog(@"Error:%@", error);
                    }
                    
                   // NSLog(@"rail_address inserted ");
                    
                }
                
            }
            
        }
    }
    
}

+(NSArray *)loadRailAddressData:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"RailAddress" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    [fetchRequest setEntity:entityDescription];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ ",loadID];
    [fetchRequest setPredicate:predicate];
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    return FetchedData;
}

+(NSArray *)loadRailAddressById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"RailAddress" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ && status==%@",loadID,@"Progress"];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setFetchLimit:1];
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    return FetchedData;
    
}

+(void)loadRailAddresscount:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"RailAddress" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ ",loadID];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    [[GTGTransportManager sharedManager]setRailCount:[FetchedData count] ];
    
    
}

+(void)UpdateRailAddressById:(NSString *)loadID forAddress:(NSString *)Address
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"RailAddress" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ && address==%@",loadID,Address];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    if ([FetchedData count]>0)
    {
        
        if ([[[FetchedData objectAtIndex:0]valueForKey:@"loadID"] isEqualToString:loadID] && [[[FetchedData objectAtIndex:0]valueForKey:@"address"] isEqualToString:Address])
        {
            RailAddress  *railAddress=[FetchedData objectAtIndex:0];
            
            [railAddress setStatus:@"Active"];
            
            NSError *error;
            if (![context save:NULL]) {
                NSLog(@"Error:%@", error);
            }
           // NSLog(@"Data Updated into RailAddress Info");
            
        }
    }
    
    
}

+(void)deleteRailAddressOnlyById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"RailAddress" inManagedObjectContext:context]];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@",loadID];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *FetchedData = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject *Rail in FetchedData) {
        [context deleteObject:Rail];
    }
    NSError *saveError = nil;
    [context save:&saveError];

    
}



+(void)deleteAllRecords
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"RailAddress" inManagedObjectContext:context]];
    
    NSError *error = nil;
    NSArray *FetchedData = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject *Rail in FetchedData) {
        [context deleteObject:Rail];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}

@end
