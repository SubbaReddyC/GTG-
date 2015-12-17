//
//  NotePopUp.h
//  
//
//  Created by admin on 14/12/15.
//
//

#import <UIKit/UIKit.h>

@interface NotePopUp : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgBorder;
@property (weak, nonatomic) IBOutlet UILabel *lblNote;
@property (weak, nonatomic) IBOutlet UITextView *txtViewNote;
- (IBAction)btnCloseActionTapped:(id)sender;

@end
