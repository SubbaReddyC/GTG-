//
//  PcrAddress.m
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "PcrAddress.h"

@implementation PcrAddress

+(void)insertPcrAddressData:(NSMutableArray *)tasKlistInfoArray
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    
    [self deleteAllRecords];
    for (int i=0; i<[tasKlistInfoArray count]; i++)
    {
        
        NSArray *array=[[tasKlistInfoArray valueForKey:@"task_details"]objectAtIndex:i];
        NSPredicate *loadIdPredicate = [NSPredicate predicateWithFormat:@"label == %@", @"Load ID"];
        NSArray  *loadresult = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:loadIdPredicate]];
        NSString *loadId=[[loadresult objectAtIndex:0]objectForKey:@"value"];
        
        
        //NSLog(@"count %lu",[[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"pcr_address" ]count]);
        if (![[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"pcr_address" ] isKindOfClass:[NSNull class]]) {
            
            
            if ([[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"pcr_address" ]count]>0) {
                
                
                for (int j=0; j<[[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"pcr_address" ]count]; j++)
                {
                    PcrAddress  *pcrAddress=(PcrAddress *)[NSEntityDescription insertNewObjectForEntityForName:@"PcrAddress" inManagedObjectContext:context];
                    
                    [pcrAddress setLoadID:loadId];
                    [pcrAddress setStatus:@"Progress"];
                    [pcrAddress setAddress:[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"pcr_address"]objectAtIndex:j]objectForKey:@"address"]];
                    
                    if(![[[tasKlistInfoArray objectAtIndex:i]valueForKey:@"pcr_address"] isKindOfClass:[NSNull class]] )
                    {
                        [pcrAddress setPcrAddress:[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"pcr_address"]objectAtIndex:j]];
                    }
                    else
                    {
                        [pcrAddress setPcrAddress:@"NA"];
                    }
                    NSError *error;
                    if (![context save:NULL]) {
                        NSLog(@"Error:%@", error);
                    }
                    NSLog(@"Data inserted into pcrAddress Info");
                    
                }
            }
        } }
    
}






+(void)insertCustomerAddressData:(NSMutableArray *)tasKlistInfoArray
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    
    
    for (int i=0; i<[tasKlistInfoArray count]; i++)
    {
        
        NSArray *array=[[tasKlistInfoArray valueForKey:@"task_details"]objectAtIndex:i];
        NSPredicate *loadIdPredicate = [NSPredicate predicateWithFormat:@"label == %@", @"Load ID"];
        NSArray  *loadresult = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:loadIdPredicate]];
        NSString *loadId=[[loadresult objectAtIndex:0]objectForKey:@"value"];
        
        
        //NSLog(@"count %lu",[[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"customer_address" ]count]);
        if (![[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"customer_address" ] isKindOfClass:[NSNull class]]) {
            
            
            if ([[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"customer_address" ]count]>0) {
                for (int j=0; j<[[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"customer_address" ]count]; j++)
                {
                    CustomerAddress  *customerAddress=(CustomerAddress *)[NSEntityDescription insertNewObjectForEntityForName:@"CustomerAddress" inManagedObjectContext:context];
                    
                    [customerAddress setLoadID:loadId];
                    [customerAddress setStatus:@"Progress"];
                    [customerAddress setAddress:[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"customer_address"]objectAtIndex:j]objectForKey:@"address"]];
                    if(![[[tasKlistInfoArray objectAtIndex:i]valueForKey:@"customer_address"] isKindOfClass:[NSNull class]] )
                    {
                        [customerAddress setCustomerAddress:[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"customer_address"]objectAtIndex:j]];
                    }
                    else
                    {
                        [customerAddress setCustomerAddress:@"NA"];
                    }
                    NSError *error;
                    if (![context save:NULL]) {
                        NSLog(@"Error:%@", error);
                    }
                    
                }} }
    }
    
}


+(NSArray *)loadPcrAddressData
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"PcrAddress" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    [fetchRequest setEntity:entityDescription];
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    return FetchedData;
}

+(NSArray *)loadPcrAddressById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"PcrAddress" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ && status==%@",loadID,@"Progress"];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setFetchLimit:1];
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    return FetchedData;
    
}


+(void)UpdatePcrAddressById:(NSString *)loadID forAddress:(NSString *)Address
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"PcrAddress" inManagedObjectContext:context];
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
            PcrAddress  *pcrAddress=[FetchedData objectAtIndex:0];
            
            [pcrAddress setStatus:@"Active"];
            
            NSError *error;
            if (![context save:NULL]) {
                NSLog(@"Error:%@", error);
            }
            // NSLog(@"Data Updated into pcrAddress Info");
            
        }
    }
    
    
}

+(void)deletePcrAddressById:(NSString *)loadID forAddress:(NSString *)Address
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"PcrAddress" inManagedObjectContext:context]];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ && address==%@",loadID,Address];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *FetchedData = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject *pcr in FetchedData) {
        [context deleteObject:pcr];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}


+(void)deleteAllRecords
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"PcrAddress" inManagedObjectContext:context]];
    NSError *error = nil;
    NSArray *FetchedData = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject *pcr in FetchedData) {
        [context deleteObject:pcr];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}

@end
