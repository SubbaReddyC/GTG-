//
//  Constants.h
//  GTG TabNet
//
//  Created by admin on 03/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define CustomRGBColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:0.9]


#define IS_iPhone4S 480.0
#define IS_iPhone4SOR5 568.0
#define IS_iPhone6 667.0
#define IS_iPhone6Plus 736.0

extern NSString *const                  kBaseUrl;
extern NSString *const                  kContentType;
extern NSString *const                  kLogin;
extern NSString *const                  kTasksList;
extern NSString *const                  kUsername;
extern NSString *const                  kPassword;
@end
