//
//  TaskFlags.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GTGTransportManager.h"

@class TaskListInfo;

NS_ASSUME_NONNULL_BEGIN

@interface TaskFlags : NSManagedObject

+(void)insertDataToTasklistFlags:(NSMutableArray *)tasKlistInfoArray;
+(NSArray *)loadTaskFlagsData;
+(void)UpdateTaskFlagsById:(NSString *)loadID;
+(void)deleteTaskFlagsRecordById:(NSString *)loadID;
+(void)deleteAllRecords;
@end

NS_ASSUME_NONNULL_END

#import "TaskFlags+CoreDataProperties.h"
