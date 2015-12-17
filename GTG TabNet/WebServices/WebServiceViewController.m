//
//  WebServiceViewController.m
//  GTG TabNet
//
//  Created by admin on 04/11/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "WebServiceViewController.h"



@interface WebServiceViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate>
{
    NSMutableData *responseData;
    NSURLConnection *urlConnection;
    NSMutableURLRequest *urlRequest;
    NSString *username;
    NSString *password;
    
}

@property (nonatomic, strong) NSString* mode;

@end

@implementation WebServiceViewController

-(void)loginusername:(NSString *)userName passWord:(NSString *)passWord withHttpMethod:(NSString*)httpType
{
    username = userName;
    password = passWord;
    //self.mode = kLogin;
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginUrl]];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", userName, passWord];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:httpType];
    [request setValue:CONTENTTYPE forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data == nil)
        {
            [ActivityIndicator removeActivityIndicator];
            [self.delegate failedWithError:@"Alert" description:@"Invalid Username/Password"];
        }
        
        else
        {
            
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            [self.delegate receivedResponse:json];
        }
        
    }];
        [dataTask resume];
   
 
}
-(void)getTaskListDataWithUserName:(NSString *)UserName
{
    username=UserName;
    //self.mode=kTasksList;
    
    NSArray *UserData=[Users loadUsersDataByUserName:username];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:TASKLISTURL]];
    [request setValue:[[UserData objectAtIndex:0]valueForKey:@"authToken"] forHTTPHeaderField:@"authtoken"];
    [request setValue:@"Basic MTExSkQ6MTBqNDQ0" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"GET"];
    [request setValue:CONTENTTYPE forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data == nil)
        {
            [ActivityIndicator removeActivityIndicator];
            [self.delegate failedWithError:@"Alert" description:@"No Data"];
        }
        
        else
        {
            
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            [self.delegate receivedResponse:json];
        }
        
    }];
    [dataTask resume];
}


-(void)getRejectedDocumentList:(NSString *)UserName
{
   // self.mode=kREJECTEDDOCUMENTAPI;
    
    NSArray *UserData=[Users loadUsersDataByUserName:username];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:REJECTEDDOCUMENETURL]];
    [request setValue:[[UserData objectAtIndex:0]valueForKey:@"authToken"] forHTTPHeaderField:@"authtoken"];
    [request setValue:@"Basic MTExSkQ6MTBqNDQ0" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"GET"];
    [request setValue:CONTENTTYPE forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data == nil)
        {
            [ActivityIndicator removeActivityIndicator];
            [self.delegate failedWithError:@"Alert" description:@"No Data"];
        }
        
        else
        {
            
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            [self.delegate receivedResponse:json];
        }
        
    }];
    [dataTask resume];




}


// for handling https request

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    if (challenge.previousFailureCount == 0)
    {
        NSURLCredential *credential = [NSURLCredential credentialWithUser:username password:password persistence:NSURLCredentialPersistenceForSession];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
    
    else
    {
        
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        
        
    }
}







@end
