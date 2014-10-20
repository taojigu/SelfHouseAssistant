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
    self.remimbusermentStyle=[stand integerForKey:ReimbusermentStyleKey];
}

/*
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    
}*/




@end
