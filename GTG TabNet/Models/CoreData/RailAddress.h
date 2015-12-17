//
//  RailAddress.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GTGTransportManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface RailAddress : NSManagedObject

+(void)insertRailAddressData:(NSMutableArray *)tasKlistInfoArray;
+(NSArray *)loadRailAddressData:(NSString *)loadID;
+(NSArray *)loadRailAddressById:(NSString *)loadID;
+(void)UpdateRailAddressById:(NSString *)loadID forAddress:(NSString *)Address;
+(void)deleteAllRecords;

+(void)loadRailAddresscount:(NSString *)loadID;
+(void)deleteRailAddressOnlyById:(NSString *)loadID;
@end

NS_ASSUME_NONNULL_END

#import "RailAddress+CoreDataProperties.h"
