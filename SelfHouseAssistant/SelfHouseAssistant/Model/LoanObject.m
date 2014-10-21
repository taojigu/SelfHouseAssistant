//
//  LoanObject.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "LoanObject.h"



static LoanObject*instanceLoadObject=nil;

#define FundInterestKey @"FundInterestKey"
#define FundLoanAmountKey @"FundLoanAmountKey"
#define BankInterestKey @"BankInterestKey"
#define BankLoanAmountKey @"BankLoanABankLoanAmountKeymount"
#define CyclyeYeasKey @"CyclyeYeasKey"
#define ReimbusermentStyleKey @"ReimbusermentStyleKey"

@implementation LoanObject{
    
}

@synthesize fundInterest;
@synthesize fundLoanAmount;
@synthesize bankInterest;
@synthesize bankLoanAmount;
@synthesize cycleYear;
@synthesize remimbusermentStyle;


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
    [stand setFloat:self.fundLoanAmount  forKey:FundInterestKey];
    [stand setFloat:self.bankInterest forKey:BankInterestKey];
    [stand setFloat:self.bankLoanAmount forKey:BankLoanAmountKey];
    [stand setInteger:self.cycleYear forKey:CyclyeYeasKey];
    [stand setInteger:self.remimbusermentStyle forKey:ReimbusermentStyleKey];
}
-(void)synchronizeFromUserDefaults{
    NSUserDefaults*stand=[NSUserDefaults standardUserDefaults];
    self.fundInterest=[stand floatForKey:FundInterestKey];
    self.fundLoanAmount=[stand floatForKey:FundLoanAmountKey];
    self.bankLoanAmount=[stand floatForKey:BankLoanAmountKey];
    self.bankInterest=[stand floatForKey:BankInterestKey];
    self.cycleYear=[stand integerForKey:CyclyeYeasKey];
    self.remimbusermentStyle=(ReimbursementStyle)[stand integerForKey:ReimbusermentStyleKey];
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
        [desp appendFormat:@"贷款年限 %d 年",self.cycleYear];
    }
    
    //[desp appendFormat:@""];
    

    
    return desp;
}




@end
