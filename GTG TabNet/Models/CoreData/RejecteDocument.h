//
//  RejecteDocument.h
//  GTG TabNet
//
//  Created by admin on 10/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GTGTransportManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface RejecteDocument : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(void)insertRejectedDocumetData:(NSMutableArray *)rejectedDocArray;
+(NSArray *)loadRejectedDoc;
@end

NS_ASSUME_NONNULL_END

#import "RejecteDocument+CoreDataProperties.h"
