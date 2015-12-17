//
//  UpLoadE-SignatureController.m
//  GTG TabNet
//
//  Created by admin on 11/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "UpLoadE-SignatureController.h"

@interface UpLoadE_SignatureController ()

@end

@implementation UpLoadE_SignatureController

#pragma  mark ViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _imgSignatureView.backgroundColor=[UIColor whiteColor];
    _imgSignatureView.layer.borderColor=[UIColor grayColor].CGColor;
    _imgSignatureView.layer.borderWidth=1;
    _txtViewComments.layer.borderColor=[UIColor grayColor].CGColor;
    _txtViewComments.layer.borderWidth=1;
    [_scView setCanCancelContentTouches:YES];
    [[GTGTransportManager sharedManager]rejectDocumentButton:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark CaptureSignature Methods

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.txtViewComments resignFirstResponder];
    self.fingerMoved=NO;
    
    UITouch * touch=[touches anyObject];
   
    
    _currentPoint=[touch locationInView:_imgSignatureView];
    _lastContactPoint1=[touch previousLocationInView:_imgSignatureView];
    _lastContactPoint2=[touch previousLocationInView:_imgSignatureView];
    
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _fingerMoved=YES;
    UITouch * touch=[touches anyObject];
    
    //save previous contact locations
    _lastContactPoint2 = _lastContactPoint1;
    _lastContactPoint1 = [touch previousLocationInView:_imgSignatureView];
    //save current location
    _currentPoint = [touch locationInView:_imgSignatureView];
    
    //find mid points to be used for quadratic bezier curve
    CGPoint midPoint1 = [self midPoint:_lastContactPoint1 withPoint:_lastContactPoint2];
    CGPoint midPoint2 = [self midPoint:_currentPoint withPoint:_lastContactPoint1];
    
    //create a bitmap-based graphics context and makes it the current context
    UIGraphicsBeginImageContext(_imgSignatureView.frame.size);
    
    //draw the entire image in the specified rectangle frame
    [_imgSignatureView.image drawInRect:CGRectMake(0, 0, _imgSignatureView.frame.size.width, _imgSignatureView.frame.size.height)];
    
    //set line cap, width, stroke color and begin path
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0f);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    //begin a new new subpath at this point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), midPoint1.x, midPoint1.y);
    //create quadratic Bézier curve from the current point using a control point and an end point
    CGContextAddQuadCurveToPoint(UIGraphicsGetCurrentContext(),
                                 _lastContactPoint1.x, _lastContactPoint1.y, midPoint2.x, midPoint2.y);
    
    //set the miter limit for the joins of connected lines in a graphics context
    CGContextSetMiterLimit(UIGraphicsGetCurrentContext(), 2.0);
    
    //paint a line along the current path
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    //set the image based on the contents of the current bitmap-based graphics context
    _imgSignatureView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //remove the current bitmap-based graphics context from the top of the stack
    UIGraphicsEndImageContext();
    
    //lastContactPoint = currentPoint;
    
    
    
}

- (CGPoint) midPoint:(CGPoint )p0 withPoint: (CGPoint) p1 {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}


#pragma  mark Action Methods
- (IBAction)btnUploadSignatureTapped:(id)sender
{
    
    NSString *customerName=[_txtCustomerName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *customerComments=[_txtViewComments.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
     NSData *imageData = UIImagePNGRepresentation(_imgSignatureView.image);
    
    if ([customerName isEqualToString:@""] && customerName.length==0 )
    {
        [self alertWithTitle:@"Alert" message:@"Please Enter customerName Field"];
        return;
    }
    else if ([customerComments isEqualToString:@""] && customerComments.length==0 )
    {
        [self alertWithTitle:@"Alert" message:@"Please Enter customerComments Field"];
        return;
    }
    else if ([imageData length]==0 ||[imageData isKindOfClass:[NSNull class]])
        
    {
        [self alertWithTitle:@"Alert" message:@"Please Enter Signature Field"];
        return;
    }
    NSString *name = _txtCustomerName.text;
    NSString *comments=_txtViewComments.text;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"MyFolder"];
    
    //if the folder doesn't exists then just create one
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
    
    //convert image into .png format.
       NSString *fileName = [filePath stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"%@.png", name]];
    
    NSLog(@"%@",comments);
    NSLog(@"%@",imageData);
    NSLog(@"%@",fileName);
  
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LeaveCustomerDeatailsController *leaveCustomerDeatailsController=[storyBoard instantiateViewControllerWithIdentifier:@"LeaveCustomer"];
    [self.navigationController pushViewController:leaveCustomerDeatailsController animated:YES];
    
    
    
}



- (IBAction)btnClearSignatureTapped:(id)sender {
    _imgSignatureView.image=nil;
}



#pragma  mark TextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return [textField resignFirstResponder];
    
}


#pragma  mark TextViewDelegates
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return [textView resignFirstResponder];
    
}


#pragma mark alertDisplay
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController * alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:NO completion:nil];
    
}







@end
