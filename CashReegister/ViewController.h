//
//  ViewController.h
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "CashReegisterCalculator.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (retain, nonatomic) CashReegisterCalculator *cashregister;
@property (retain, nonatomic) NSArray *arrCashback;

@property (weak, nonatomic) IBOutlet UITextField *uitxtPurchasePrice;
@property (weak, nonatomic) IBOutlet UITextField *uitxtCashGiven;
@property (weak, nonatomic) IBOutlet UITableView *tableviewChange;
@property (weak, nonatomic) IBOutlet UILabel *uilblCashInRegister;

@end
