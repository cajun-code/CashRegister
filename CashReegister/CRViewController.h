//
//  CRViewController.h
//  CashReegister
//
//  Created by Brad Wiederholt on 11/16/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRRegisterModel.h"

@interface CRViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextView *changeText;
@property (nonatomic, strong) IBOutlet UITextField *cashCollected;
@property (nonatomic, strong) IBOutlet UITextField *purchasePrice;
@property (nonatomic, strong) IBOutlet UIButton *changeButton;

@property (nonatomic, strong) CRRegisterModel *registerModel;

- (IBAction)makeChange:(id)sender;

@end
