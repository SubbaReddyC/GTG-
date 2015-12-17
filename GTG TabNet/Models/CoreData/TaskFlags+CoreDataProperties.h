//
//  TaskFlags+CoreDataProperties.h
//  GTG TabNet
//
//  Created by admin on 01/12/15.
//  Copyright © 2015 admin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TaskFlags.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskFlags (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *loadID;
@property (nullable, nonatomic, retain) id taskFlags;
@property (nullable, nonatomic, retain) TaskListInfo *newRelationship;
@property (nullable, nonatomic, retain) NSString *status;

@end

NS_ASSUME_NONNULL_END
