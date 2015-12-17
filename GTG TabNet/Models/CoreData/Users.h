//
//  Users.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GTGTransportManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface Users : NSManagedObject

+(void)deleteEntityObject:(NSString *)object;

+(void)updateEntityObject:(NSMutableDictionary *)object;

+(NSArray *)LoadDataFromUsers;
+(NSArray *)loadUsersDataByUserName:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END

#import "Users+CoreDataProperties.h"
