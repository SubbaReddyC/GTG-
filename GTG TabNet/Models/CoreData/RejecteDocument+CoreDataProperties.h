//
//  RejecteDocument+CoreDataProperties.h
//  GTG TabNet
//
//  Created by admin on 10/12/15.
//  Copyright © 2015 admin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RejecteDocument.h"

NS_ASSUME_NONNULL_BEGIN

@interface RejecteDocument (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *loadID;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *docType;
@property (nullable, nonatomic, retain) id rejectedDoc;

@end

NS_ASSUME_NONNULL_END
