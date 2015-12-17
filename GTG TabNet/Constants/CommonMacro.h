//
//  CommonMacro.h
//  GTG TabNet
//
//  Created by admin on 20/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define CustomRGBColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:0.9]
#define loginUrl @"https://jettestdrvr.gtgs.net/json/login"
#define TASKLISTURL @"http://www.mocky.io/v2/565eb3c60f00006721577278"
#define REJECTEDDOCUMENETURL @"http://www.mocky.io/v2/566136e2100000a4148d9162"
#define IS_iPhone4S 480.0
#define IS_iPhone4SOR5 568.0
#define IS_iPhone6 667.0
#define IS_iPhone6Plus 736.0
#define AUTHORIZATION   @"Authorization"
#define CONTENTTYPE   @"application/x-www-form-urlencoded"
#define RailAddressFlag  @"Rail"
#define YardAddressFlag  @"Yard"

#define CustomerAddressFlag  @"Customer"
#define PcrAddressFlag  @"Pcr"
#define KTerminated   @"Terminated"
#define kLogin @"Login"
#define kTasksList @"TasksList"
#define kREJECTEDDOCUMENTAPI @"REJECTEDDOCUMENT"
#define kUsername @"111JD"
#define kPassword @"10j444"

