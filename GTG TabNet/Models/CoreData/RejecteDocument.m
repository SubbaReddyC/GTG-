//
//  RejecteDocument.m
//  GTG TabNet
//
//  Created by admin on 10/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "RejecteDocument.h"

@implementation RejecteDocument


+(void)insertRejectedDocumetData:(NSMutableArray *)rejectedDocArray
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    
    [self deleteAllRecords];
    NSLog(@"rejectedDocArray %ld",(unsigned long)[rejectedDocArray count]);
    for (int i=0; i<[rejectedDocArray count]; i++)
    {
        
    RejecteDocument  *rejecteDocument=(RejecteDocument *)[NSEntityDescription insertNewObjectForEntityForName:@"RejecteDocument" inManagedObjectContext:context];
        [rejecteDocument setLoadID:[[rejectedDocArray objectAtIndex:i]valueForKey:@"load_id"]];
        [rejecteDocument setDocType:[[rejectedDocArray objectAtIndex:i]valueForKey:@"doc_type"]];
        [rejecteDocument setAddress:[[rejectedDocArray objectAtIndex:i]valueForKey:@"address"]];
        [rejecteDocument setRejectedDoc:[[rejectedDocArray objectAtIndex:i]valueForKey:@"rejected_docs"]];
        
        NSError *error;
        if (![context save:NULL]) {
            NSLog(@"Error:%@", error);
        }
        NSLog(@"rejectedDocs inserted ");
    
    }
    
}

+(NSArray *)loadRejectedDoc
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"RejecteDocument" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc ]init];
    [fetchRequest setEntity:entityDescription];
   
    NSError * error;
    NSArray * FetchedData=[context executeFetchRequest:fetchRequest error:&error];
    return FetchedData;
    
}


+(void)deleteAllRecords
{
    NSManagedObjectContext *context=[GTGTransportManager contextWithName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"RejecteDocument" inManagedObjectContext:context]];
    
    NSError *error = nil;
    NSArray *FetchedData = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject *rejectedDoc in FetchedData) {
        [context deleteObject:rejectedDoc];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}
@end
