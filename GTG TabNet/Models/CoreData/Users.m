//
//  Users.m
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "Users.h"

@implementation Users

#pragma mark - Delete whole data from Entity
+(void)deleteEntityObject:(NSString *)object
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDesc=[NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"userName==%@ ",object];
    [request setPredicate:predicate];
    NSError * error;
    
    
    NSArray *matchingData=[context executeFetchRequest:request error:&error];
    
    if (matchingData.count<=0) {
        //NSLog(@"No person is deleted");
    }
    else
    {
        int count=0;
        
        for (NSManagedObject *obj in  matchingData) {
            [context deleteObject:obj];
            count++;
        }
        [context save:&error];
        // NSLog(@" person is deleted %d",count);
        
        
    }
    
}

+(void)updateEntityObject:(NSMutableDictionary *)object
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDesc=[NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"userName==%@ ",[object valueForKey:@"username"]];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *matchingData=[context executeFetchRequest:request error:&error];
    
    if (matchingData.count<=0) {
        Users  *users=(Users*)[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
        [users setUserName:[object valueForKey:@"username"]];
        [users setPassWord:[object valueForKey:@"password"]];
        [users setAuthToken:[object valueForKey:@"authtoken"]];
        [users setStatusCode:[object valueForKey:@"status"]];
        [users setRememberMe:[object valueForKey:@"rememberme"]];
        
        NSError * error;
        if (![context save:&error]) {
            NSLog(@"Error:%@", error);
        }
        // NSLog(@"Data inserted");
    }
    else
    {
        Users  *users=[matchingData objectAtIndex:0];
        [users setPassWord:[object valueForKey:@"password"]];
        [users setAuthToken:[object valueForKey:@"authtoken"]];
        [users setStatusCode:[object valueForKey:@"status"]];
        [users setRememberMe:[object valueForKey:@"rememberme"]];
        
        NSError * error;
        if (![context save:&error]) {
            NSLog(@"Error:%@", error);
        }
        //NSLog(@"Data Updated");
        
    }
    
}

+(NSArray *)LoadDataFromUsers
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"userName==%@",[userDefaults objectForKey:@"UserName"]]];
    NSError *error;
    
    NSArray * fetchedObjects=[context executeFetchRequest:fetchRequest error:&error];
    
    //NSLog(@"%@",[[[[[fetchedObjects objectAtIndex:0]valueForKey:@"activities"]objectAtIndex:0]valueForKey:@"survey"]valueForKey:@"guid"]);
    
    return fetchedObjects;
    
}

+(NSArray *)loadUsersDataByUserName:(NSString *)userName
{
   
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"userName==%@",userName];
    [fetchRequest setPredicate:predicate];
      NSError *error;
    
    NSArray * fetchedObjects=[context executeFetchRequest:fetchRequest error:&error];
    
   
    
    return fetchedObjects;
    
}

@end
