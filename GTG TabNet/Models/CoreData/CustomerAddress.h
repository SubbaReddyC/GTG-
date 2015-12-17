//
//  CustomerAddress.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GTGTransportManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomerAddress : NSManagedObject

+(void)insertCustomerAddressData:(NSMutableArray *)tasKlistInfoArray;
+(NSArray *)loadCustomerAddressData:(NSString *)loadID;
+(NSArray *)loadCustomerAddressById:(NSString *)loadID;
+(void)UpdateCustomerAddressById:(NSString *)loadID forAddress:(NSString *)Address;
+(void)deleteAllRecords;
//+(void)deleteCustomerAddressById:(NSString *)loadID;
+(void)deleteCustomerAddressById:(NSString *)loadID forAddress:(NSString *)Address;
@end

NS_ASSUME_NONNULL_END

#import "CustomerAddress+CoreDataProperties.h"
