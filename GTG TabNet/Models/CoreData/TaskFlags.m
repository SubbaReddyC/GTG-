//
//  TaskFlags.m
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "TaskFlags.h"


@implementation TaskFlags

+(void)insertDataToTasklistFlags:(NSMutableArray *)tasKlistInfoArray
{
    
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    [self deleteAllRecords];
    NSEntityDescription *entityDesc=[NSEntityDescription entityForName:@"TaskFlags" inManagedObjectContext:context];
    
    for (int i=0; i<[tasKlistInfoArray count]; i++)
    {
        NSFetchRequest *request=[[NSFetchRequest alloc]init];
        [request setEntity:entityDesc];
        NSArray *array=[[tasKlistInfoArray valueForKey:@"task_details"]objectAtIndex:i];
        NSPredicate *loadIdPredicate = [NSPredicate predicateWithFormat:@"label == %@", @"Load ID"];
        NSArray  *loadresult = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:loadIdPredicate]];
        NSString *loadId=[[loadresult objectAtIndex:0]objectForKey:@"value"];
        
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@ ",loadId];
        [request setPredicate:predicate];
        NSError * error;
        NSArray *matchingData=[context executeFetchRequest:request error:&error];
        
        if ([matchingData count]>0)
        {
            
            if ([[[matchingData objectAtIndex:0]valueForKey:@"loadID"] isEqualToString:loadId])
            {
                TaskFlags  *taskFlags=[matchingData objectAtIndex:0];
                
                [taskFlags setLoadID:loadId];
                [taskFlags setTaskFlags:[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"task_flags"]];
                [taskFlags setStatus:@"Progress"];
                
                NSError *error;
                if (![context save:NULL]) {
                    NSLog(@"Error:%@", error);
                }
                //NSLog(@"Data Updated into TaskFlags ");
                
            }
        }
        else
        {
            TaskFlags *taskFlags=(TaskFlags *)[NSEntityDescription insertNewObjectForEntityForName:@"TaskFlags" inManagedObjectContext:context];
            NSArray *array=[[tasKlistInfoArray valueForKey:@"task_details"]objectAtIndex:i];
            NSPredicate *loadIdPredicate = [NSPredicate predicateWithFormat:@"label == %@", @"Load ID"];
            NSArray  *loadresult = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:loadIdPredicate]];
            NSString *loadId=[[loadresult objectAtIndex:0]objectForKey:@"value"];
            [taskFlags setLoadID:loadId];
            [taskFlags setTaskFlags:[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"task_flags"]];
            [taskFlags setStatus:@"Progress"];
            
            NSError *error;
            if (![context save:NULL]) {
                NSLog(@"Error:%@", error);
            }
            //NSLog(@"Data inserted into TaskFlags");
        }
        
        
    }
    
}


+(NSArray *)loadTaskFlagsData
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"TaskFlags" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    
    [fetchRequest setEntity:entityDescription];
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    return FetchedData;
}



+(void)UpdateTaskFlagsById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"TaskFlags" inManagedObjectContext:context];
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
            TaskFlags  *taskFlags=[FetchedData objectAtIndex:0];
            
            [taskFlags setStatus:@"Active"];
            
            NSError *error;
            if (![context save:NULL]) {
                NSLog(@"Error:%@", error);
            }
            //NSLog(@"Data Updated into taskListInfo ");
            
        }
    }
    
    
}

+(void)deleteTaskFlagsRecordById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"TaskFlags" inManagedObjectContext:context]];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@",loadID];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *FetchedData = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject *yard in FetchedData) {
        [context deleteObject:yard];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}

+(void)deleteAllRecords
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"TaskFlags" inManagedObjectContext:context]];
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
