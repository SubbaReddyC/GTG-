//
//  TaskListInfo.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GTGTransportManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskListInfo : NSManagedObject

+(void)insertDataToTasklistInfo:(NSMutableArray *)tasKlistInfoArray;
+(NSArray *)loadTaskListInfoData;
+(NSArray *)loadTaskListInfoDataById:(NSString *)loadID;
+(void)UpdateTaskListInfoById:(NSString *)loadID;
+(void)deleteRecordById:(NSString *)loadID;
+(void)deleteAllRecords;
@end

NS_ASSUME_NONNULL_END

#import "TaskListInfo+CoreDataProperties.h"
