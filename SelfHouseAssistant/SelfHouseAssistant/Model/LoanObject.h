//
//  LoanObject.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

static  NSString* const LoanObjectKey=@"LoanObjectKey";

typedef enum {
    ReimbursementStyleMMR=1,//等额本金，Matching monthly repayment
    ReimbursementStyleEAPEM=0//等额本息 ，Equal Amount of Payment Each Month
} ReimbursementStyle;

NSString* NSStringFromReimbusermentStyle(ReimbursementStyle reimbusermentStyle);

@interface LoanObject : NSObject{
}

@property(nonatomic,assign)float fundInterest;
@property(nonatomic,assign)float fundLoanAmount;
@property(nonatomic,assign)float bankInterest;
@property(nonatomic,assign)float bankLoanAmount;
@property(nonatomic,assign)float downPaymentRatio;
@property(nonatomic,assign)NSInteger cycleYear;
@property(nonatomic,assign)ReimbursementStyle reimbusermentStyle;


+(LoanObject*)instance;
-(void)saveUserDefaults;


@end
