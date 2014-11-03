//
//  LoanObject.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "LoanObject.h"



NSString* NSStringFromReimbusermentStyle(ReimbursementStyle reimbusermentStyle){
    if (ReimbursementStyleEAPEM==reimbusermentStyle) {
        return @"等额本息";
    }
    if (ReimbursementStyleMMR==reimbusermentStyle) {
        return @"等额本金";
    }
    
    return nil;
}

static LoanObject*instanceLoadObject=nil;

#define FundInterestKey @"FundInterestKey"
#define FundLoanAmountKey @"FundLoanAmountKey"
#define BankInterestKey @"BankInterestKey"
#define BankLoanAmountKey @"BankLoanABankLoanAmountKeymount"
#define CyclyeYeasKey @"CyclyeYeasKey"
#define ReimbusermentStyleKey @"ReimbusermentStyleKey"
#define DownPaymentRationKey @"DownPaymentRationKey"

@implementation LoanObject{
    
}

@synthesize fundInterest;
@synthesize fundLoanAmount;
@synthesize bankInterest;
@synthesize bankLoanAmount;
@synthesize cycleYear;
@synthesize reimbusermentStyle;
@synthesize downPaymentRatio;



+(LoanObject*)instance{
    if (nil==instanceLoadObject) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            instanceLoadObject=[[LoanObject alloc]init];
        });
        
        [instanceLoadObject synchronizeFromUserDefaults];
        
    }

    return instanceLoadObject;
}

-(void)saveUserDefaults{
    NSUserDefaults*stand=[NSUserDefaults standardUserDefaults];
    [stand setFloat:self.fundInterest forKey:FundInterestKey];
    [stand setFloat:self.fundLoanAmount  forKey:FundLoanAmountKey];
    [stand setFloat:self.bankInterest forKey:BankInterestKey];
    [stand setFloat:self.bankLoanAmount forKey:BankLoanAmountKey];
    [stand setInteger:self.cycleYear forKey:CyclyeYeasKey];
    [stand setInteger:self.reimbusermentStyle forKey:ReimbusermentStyleKey];
    [stand setFloat:self.downPaymentRatio forKey:DownPaymentRationKey];
}
-(void)synchronizeFromUserDefaults{
    NSUserDefaults*stand=[NSUserDefaults standardUserDefaults];
    self.fundInterest=[stand floatForKey:FundInterestKey];
    self.fundLoanAmount=[stand floatForKey:FundLoanAmountKey];
    self.bankLoanAmount=[stand floatForKey:BankLoanAmountKey];
    self.bankInterest=[stand floatForKey:BankInterestKey];
    self.cycleYear=[stand integerForKey:CyclyeYeasKey];
    self.reimbusermentStyle=(ReimbursementStyle)[stand integerForKey:ReimbusermentStyleKey];
    self.downPaymentRatio=[stand floatForKey:DownPaymentRationKey];
}

/*
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    
}*/
-(NSString*)description{
    if (0==self.fundLoanAmount&&0==self.bankLoanAmount&&0==self.cycleYear) {
        return @"无贷款信息";
    }
    NSMutableString*desp=[[NSMutableString alloc]init];
    if (0!=self.fundLoanAmount) {
        [desp appendFormat:@"公积金贷款 %.0f万 利率 %.4f",self.fundLoanAmount,self.fundInterest];
    }
    if (0!=self.bankLoanAmount) {
        [desp appendFormat:@"商业贷款 %.0f万 利率 %.4f",self.bankLoanAmount,self.bankInterest];
    }
    if (0!=self.cycleYear) {
        [desp appendFormat:@"贷款年限 %ld 年",(long)self.cycleYear];
    }
    
    //[desp appendFormat:@""];
    

    
    return desp;
}



@end
