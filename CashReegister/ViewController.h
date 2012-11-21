//
//  ViewController.h
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
}

@property   (strong, nonatomic) IBOutlet    UITextField     *purchasePriceText;
@property   (strong, nonatomic) IBOutlet    UITextField     *amountTenderedText;
@property   (strong, nonatomic) IBOutlet    UILabel         *summaryLabel;
@property   (strong, nonatomic) IBOutlet    UILabel         *answerLabel;

- (IBAction)buttonHandler:(id)sender;

@end
