//
//  YardName.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GTGTransportManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YardName : NSManagedObject

+(void)insertYardNameData:(NSMutableArray *)tasKlistInfoArray;
+(NSArray *)loadYardAddresses:(NSString *)loadID;
+(NSArray *)loadYardNameDataById:(NSString *)loadID;
+(void)UpdateYardNameById:(NSString *)loadID ;
+(void)deleteAllRecords;
+(void)deleteYardNameById:(NSString *)loadID forAddress:(NSString *)Address;
@end

NS_ASSUME_NONNULL_END

#import "YardName+CoreDataProperties.h"
