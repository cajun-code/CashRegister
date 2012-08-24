//
//  DFViewController.h
//  cashRegister
//
//  Created by unbounded solutions on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pathField;
@property (weak, nonatomic) IBOutlet UITextView *outputField;

@end
