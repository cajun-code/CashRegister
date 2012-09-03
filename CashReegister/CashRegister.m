//
//  CashRegister.m
//  CashReegister
//
//  Created by Mac Owner on 8/31/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "CashRegister.h"

@implementation CashRegister
-(NSMutableString *)first:(float) purchasePrice second:(float) cash
{
    NSMutableString *resultString=[[NSMutableString alloc] init];
     
    if(cash<purchasePrice)
    {
        resultString=nil;
        [resultString appendString:@"ERROR"];
        return resultString;
    }
    else if(cash==purchasePrice)
    {
        resultString=nil;
        [resultString appendString:@"ZERO"];
        return resultString;
    }
    else {
        //Approach: Get number of each type (dollar....cent) then store them in key and value...
        //Later we just short by Key...which is (dallor...cent)
        float value=(cash - purchasePrice)*100;
        int valueInCent=0;
        if(value<1.0)
        {
            valueInCent=1;
        }
        else {
            valueInCent=(int)value;
        }
        
        
        NSMutableDictionary *result =[[NSMutableDictionary alloc] init];
        NSArray *array =[[NSArray alloc] initWithObjects:@"100.0",@"50.0",@"25.0",@"10.0",@"5.0",@"2.0",@"1.0",@"0.50",@"0.25",@"0.10",@"0.05",@"0.01",nil];
    
        for (int x=0; x<[array count]; x++) {
            int numberOfCurrentValue=0;
            float currentValueFloat =[[array objectAtIndex:x] floatValue]*100;
            int currentValueInt=(int)currentValueFloat;
          
            if (valueInCent>0) {
            
                numberOfCurrentValue=(int)(valueInCent/currentValueInt);
    
                valueInCent=valueInCent%currentValueInt;
            }
            
            if(numberOfCurrentValue>0)
            {   
                NSString *numberOfCurrentValueString = [NSString stringWithFormat:@"%d",numberOfCurrentValue];
                switch (x) {
                    case 0:
                        [result setValue:numberOfCurrentValueString forKey:@"ONE HUNRED"];
                        break;
                    case 1:
                         [result setValue:numberOfCurrentValueString forKey:@"FIFTY"];
                        break;
                    case 2:
                         [result setValue:numberOfCurrentValueString forKey:@"TWENTY FIVE"];
                        break;
                    case 3:
                        [result setValue:numberOfCurrentValueString forKey:@"TEN"];
                        break;
                    case 4:
                        [result setValue:numberOfCurrentValueString forKey:@"FIVE"];
                        break;
                    case 5:
                        [result setValue:numberOfCurrentValueString forKey:@"TWO"];
                        break;
                    case 6:
                        [result setValue:numberOfCurrentValueString forKey:@"ONE"];
                        break;
                    case 7:
                        [result setValue:numberOfCurrentValueString forKey:@"HALF DOLLAR"]; 
                        break;
                    case 8:
                        [result setValue:numberOfCurrentValueString forKey:@"QUARTER"];
                        break;
                    case 9:
                        [result setValue:numberOfCurrentValueString forKey:@"DIME"];
                        break;
                    case 10:
                        [result setValue:numberOfCurrentValueString forKey:@"NICKLE"];
                        break;
                    case 11:
                        [result setValue:numberOfCurrentValueString forKey:@"PENNY"];
                        break;
                    default:
                        break;
                }
            }
        }
        NSMutableArray *keyArray =[[NSMutableArray alloc] init];
        //Store keys in keyArray for sorting 
        for (NSString *key in result) {
            [keyArray addObject:key];
        }
        //Sort the array
        [keyArray sortUsingSelector:@selector(caseInsensitiveCompare:)];
  
        for (NSString *key in keyArray) {
            //NSLog(@"%@:%@", key, [result objectForKey:key]);
            [resultString appendFormat:@"%@:%@ \n", key, [result objectForKey:key]];
           
        } 
       // NSLog(@"%@",resultString);
        return resultString;
    }
    
    
}
@end
