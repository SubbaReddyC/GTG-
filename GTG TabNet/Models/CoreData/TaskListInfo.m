//
//  TaskListInfo.m
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "TaskListInfo.h"

@implementation TaskListInfo

// Insert code here to add functionality to your managed object subclass


+(void)insertDataToTasklistInfo:(NSMutableArray *)tasKlistInfoArray
{
    
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    [self deleteAllRecords];
    
    
    NSEntityDescription *entityDesc=[NSEntityDescription entityForName:@"TaskListInfo" inManagedObjectContext:context];
    
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
                TaskListInfo  *tasklistInfo=[matchingData objectAtIndex:0];
                
                [tasklistInfo setLoadID:loadId];
                [tasklistInfo setTaskDetails:[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"task_details"]];
                [tasklistInfo setStatus:@"Progress"];
                
                NSError *error;
                if (![context save:NULL]) {
                    NSLog(@"Error:%@", error);
                }
               // NSLog(@"Data Updated into tasklist Info");
                
            }
        }
        else
        {
            TaskListInfo *tasklistInfo=(TaskListInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"TaskListInfo" inManagedObjectContext:context];
            NSArray *array=[[tasKlistInfoArray valueForKey:@"task_details"]objectAtIndex:i];
            NSPredicate *loadIdPredicate = [NSPredicate predicateWithFormat:@"label == %@", @"Load ID"];
            NSArray  *loadresult = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:loadIdPredicate]];
            NSString *loadId=[[loadresult objectAtIndex:0]objectForKey:@"value"];
            [tasklistInfo setLoadID:loadId];
            [tasklistInfo setTaskDetails:[[tasKlistInfoArray objectAtIndex:i]objectForKey:@"task_details"]];
            [tasklistInfo setStatus:@"Progress"];
            NSError *error;
            if (![context save:NULL]) {
                NSLog(@"Error:%@", error);
            }
            //NSLog(@"Data inserted into tasklist Info");
        }
        
        
    }
    
}


+(NSArray *)loadTaskListInfoData
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"TaskListInfo" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
   
    [fetchRequest setEntity:entityDescription];
  
    
    NSError * error;
    
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    return FetchedData;
}

+(NSArray *)loadTaskListInfoDataById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"TaskListInfo" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"loadID==%@",loadID];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entityDescription];
    
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    
    return FetchedData;
    
}

+(void)UpdateTaskListInfoById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"TaskListInfo" inManagedObjectContext:context];
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
            TaskListInfo  *taskListInfo=[FetchedData objectAtIndex:0];
            
            [taskListInfo setStatus:@"Active"];
            
            NSError *error;
            if (![context save:NULL]) {
                NSLog(@"Error:%@", error);
            }
            //NSLog(@"Data Updated into taskListInfo ");
            
        }
    }
    
    
}


+(void)deleteRecordById:(NSString *)loadID
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"TaskListInfo" inManagedObjectContext:context]];
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
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"TaskListInfo" inManagedObjectContext:context]];
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
