//
//  YardName.m
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "YardName.h"

@implementation YardName

+(void)insertYardNameData:(NSMutableArray *)tasKlistInfoArray
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    [self deleteAllRecords];
    
    for (int i=0; i<[tasKlistInfoArray count]; i++)
    {
        
        NSArray *array=[[tasKlistInfoArray valueForKey:@"task_details"]objectAtIndex:i];
        NSPredicate *loadIdPredicate = [NSPredicate predicateWithFormat:@"label == %@", @"Load ID"];
        NSArray  *loadresult = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:loadIdPredicate]];
        NSString *loadId=[[loadresult objectAtIndex:0]objectForKey:@"value"];
        if (![[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"yard_name" ] isKindOfClass:[NSNull class]]) {
            
       
        if([[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"yard_name" ]count]>0){
        for (int j=0; j<[[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"yard_name" ]count]; j++)
        {
            YardName  *yardName=(YardName *)[NSEntityDescription insertNewObjectForEntityForName:@"YardName" inManagedObjectContext:context];
            
            [yardName setLoadID:loadId];
            [yardName setStatus:@"Progress"];
           // NSLog(@"%@",[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"yard_name"]objectAtIndex:j]);
            [yardName setAddress:[[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"yard_name"]objectAtIndex:j]objectForKey:@"name"]];
            
            if(![[[tasKlistInfoArray objectAtIndex:i]valueForKey:@"yard_name"] isKindOfClass:[NSNull class]] )
            {
                [yardName setYardName:[[[tasKlistInfoArray objectAtIndex:i] valueForKey:@"yard_name"]objectAtIndex:j]];
            }
            else
            {
                [yardName setYardName:@"NA"];
            }
            NSError *error;
            if (![context save:NULL]) {
                NSLog(@"Error:%@", error);
            }
            
        }
        
        }
        
        }
    }
    
}


+(NSArray *)loadYardAddresses:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"YardName" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    [fetchRequest setEntity:entityDescription];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@",loadID];
    [fetchRequest setPredicate:predicate];
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    return FetchedData;
}


+(NSArray *)loadYardNameDataById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"YardName" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ && status==%@",loadID,@"Progress"];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setFetchLimit:1];
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    return FetchedData;
    
}

+(void)UpdateYardNameById:(NSString *)loadID 
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"YardName" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@",loadID];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    if ([FetchedData count]>0)
    {
        
        if ([[[FetchedData objectAtIndex:0]valueForKey:@"loadID"] isEqualToString:loadID])
        {
            YardName  *yardName=[FetchedData objectAtIndex:0];
            
            [yardName setStatus:@"Active"];
            
            NSError *error;
            if (![context save:NULL]) {
                NSLog(@"Error:%@", error);
            }
            //NSLog(@"Data Updated into yardName Info");
            
        }
    }
    
    
}


+(void)deleteYardNameById:(NSString *)loadID forAddress:(NSString *)Address
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"YardName" inManagedObjectContext:context]];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ && address==%@",loadID,Address];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *FetchedData = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject *yard in FetchedData) {
        [context deleteObject:yard];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    
     //NSLog(@"Data Deleted into yardName Info");
}


+(void)deleteAllRecords
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"YardName" inManagedObjectContext:context]];
        NSError *error = nil;
    NSArray *FetchedData = [context executeFetchRequest:fetchRequest error:&error];
       //error handling goes here
    for (NSManagedObject *yard in FetchedData) {
        [context deleteObject:yard];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}





@end
