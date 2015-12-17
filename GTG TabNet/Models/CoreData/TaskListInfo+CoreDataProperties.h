//
//  TaskListInfo+CoreDataProperties.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TaskListInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskListInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *loadID;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) id taskDetails;

@end

NS_ASSUME_NONNULL_END
