//
//  NotePopUp.m
//  
//
//  Created by admin on 14/12/15.
//
//

#import "NotePopUp.h"
#import "GTGTransportManager.h"

@implementation NotePopUp

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];

}
-(void)setup
{
    _imgBorder.layer.borderWidth=1;
    _imgBorder.layer.borderColor=[UIColor blackColor].CGColor;
    _txtViewNote.text=[[GTGTransportManager sharedManager]noteDesc];
   // _txtViewNote.layer.borderWidth=1;
    //_txtViewNote.layer.borderColor=[UIColor blackColor].CGColor;
    
    
}

- (IBAction)btnCloseActionTapped:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CloseNoteTapped" object:self];
}
@end
