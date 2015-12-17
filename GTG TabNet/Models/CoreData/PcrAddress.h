//
//  PcrAddress.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GTGTransportManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PcrAddress : NSManagedObject

+(void)insertPcrAddressData:(NSMutableArray *)tasKlistInfoArray;
+(NSArray *)loadPcrAddressData;
+(NSArray *)loadPcrAddressById:(NSString *)loadID;
+(void)UpdatePcrAddressById:(NSString *)loadID forAddress:(NSString *)Address;
+(void)deleteAllRecords;
+(void)deletePcrAddressById:(NSString *)loadID forAddress:(NSString *)Address;
@end

NS_ASSUME_NONNULL_END

#import "PcrAddress+CoreDataProperties.h"
