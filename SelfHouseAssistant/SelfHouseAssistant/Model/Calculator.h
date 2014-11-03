//
//  Calculator.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-23.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoanObject.h"
@class LandObject;



static const float InvalidateFloat=0-MAXFLOAT;


@interface Calculator : NSObject{
    
}

@property(nonatomic,strong)LandObject*landObject;
@property(nonatomic,strong)LoanObject*loanObject;


-(instancetype)initWithLandObject:(LandObject*)landObject loanObject:(LoanObject*)loanObject;

-(float)critcalPrice;

//等额本息
-(float)totalInterestEAPEM:(float)principle monthRate:(float)monthRate debtMonth:(NSInteger)debtMonth;
//等额本金
-(float)totalInterestMMR:(float)principle monthRate:(float)monthRate debtMonth:(NSInteger)debtMonth;

-(float)totalInterest:(float)principle monthRate:(float)monthRate debtMonth:(NSInteger)debtMonth reimbuserStyle:(ReimbursementStyle)reimbuserStyle;

@end
