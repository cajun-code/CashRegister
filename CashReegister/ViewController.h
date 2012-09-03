//
//  ViewController.h
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic,strong) IBOutlet UITextField *PP;
@property (nonatomic,strong) IBOutlet UITextField *CH;
@property (nonatomic,strong) IBOutlet UITextView *resultView;
-(IBAction)change:(id)sender;
@end
