//
//  TxnResultViewController.h
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSTransaction.h"

@interface TxnResultViewController : UITableViewController
@property(nonatomic, strong) KSTransaction *transaction;
@end
