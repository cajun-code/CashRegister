//
//  ViewController.h
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *productPrice;
@property (weak, nonatomic) IBOutlet UITextField *cashRecived;
- (IBAction)getChange:(id)sender;

@end
