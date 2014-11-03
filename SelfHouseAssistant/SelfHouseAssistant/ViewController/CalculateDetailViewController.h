//
//  CalculateDetailViewController.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-24.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Calculator;
@class LoanObject;
@class LandObject;

@interface CalculateDetailViewController : UIViewController{
    
}

@property(nonatomic,strong)Calculator*calculator;
@property(nonatomic,strong)LoanObject*loanObject;
@property(nonatomic,strong)LandObject*landObject;



@end
