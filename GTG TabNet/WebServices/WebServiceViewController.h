//
//  WebServiceViewController.h
//  GTG TabNet
//
//  Created by admin on 04/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GTGTransportManager.h"
#import "AppDelegate.h"
#import "ActivityIndicator.h"
#import "CommonMacro.h"
#import "ActivityIndicator.h"
#import "Users.h"
@class WebServiceViewController;
@protocol WebServiceViewControllerDelegate <NSObject,NSURLConnectionDelegate,NSURLConnectionDataDelegate>

- (void)receivedResponse:(id)response;
- (void)failedWithError:(NSString*)errorTitle description:(NSString*)errorDescription;

@end


@interface WebServiceViewController : UIViewController


@property(nonatomic,retain)id<WebServiceViewControllerDelegate>delegate;

-(void)loginusername:(NSString *)userName passWord:(NSString *)passWord withHttpMethod:(NSString*)httpType;
-(void)getTaskListDataWithUserName:(NSString *)UserName;
-(void)getRejectedDocumentList:(NSString *)UserName;
@end
