//
//  Calculator.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-23.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "Calculator.h"
#import "LandObject.h"
#import "LoanObject.h"
#import <math.h>

#define FundsMaxAmount 80*10000



@implementation Calculator

@synthesize landObject;
@synthesize loanObject;


-(instancetype)initWithLandObject:(LandObject*)land loanObject:(LoanObject*)loan{
    self=[super init];
    self.loanObject=loan;
    self.landObject=land;
    return self;
}


//(x-selfHosuePrice)*area*0.7-seflHouseInterestTotal>=(x-commercailHousePrice)*area-commercialHouseInterestTotal

-(float)critcalPrice{
    
    if (0>=self.landObject.selfHousePrice||0>=self.landObject.commercialHousePrice) {
        return InvalidateFloat;
    }
    
    
    //NO loan
    if (self.loanObject.cycleYear==0) {
        float result=(self.landObject.commercialHousePrice-0.7*self.landObject.selfHousePrice)/0.3;
        return result;
    }
    
    float selfHouseInterestTotal=0;
    float commercialHouseInterestTotal=0;
    if (ReimbursementStyleEAPEM==self.loanObject.reimbusermentStyle) {

        selfHouseInterestTotal=[self houseInterestTotalEAPM:YES];
        commercialHouseInterestTotal=[self houseInterestTotalEAPM:NO];
    }
    else{
        selfHouseInterestTotal=[self houseInterestTotalMMR:YES];
        commercialHouseInterestTotal=[self houseInterestTotalMMR:NO];
    }
    NSAssert(commercialHouseInterestTotal>selfHouseInterestTotal, @"Wrong interest");
        
    float resultPrice=(self.landObject.area*(self.landObject.commercialHousePrice-0.7*self.landObject.selfHousePrice)+(commercialHouseInterestTotal-selfHouseInterestTotal))/(0.3*self.landObject.area);
        return resultPrice;
    
}
/*
 计算公式：
 等额本息还款法:
 每月月供额=〔贷款本金×月利率×(1＋月利率)＾还款月数〕÷〔(1＋月利率)＾还款月数-1〕
 每月应还利息=贷款本金×月利率×〔(1+月利率)^还款月数-(1+月利率)^(还款月序号-1)〕÷〔(1+月利率)^还款月数-1〕
 每月应还本金=贷款本金×月利率×(1+月利率)^(还款月序号-1)÷〔(1+月利率)^还款月数-1〕
 总利息=还款月数×每月月供额-贷款本金
 
 等额本金还款法:
 每月月供额=(贷款本金÷还款月数)+(贷款本金-已归还本金累计额)×月利率
 每月应还本金=贷款本金÷还款月数
 每月应还利息=剩余本金×月利率=(贷款本金-已归还本金累计额)×月利率
 每月月供递减额=每月应还本金×月利率=贷款本金÷还款月数×月利率
 总利息=〔(总贷款额÷还款月数+总贷款额×月利率)+总贷款额÷还款月数×(1+月利率)〕÷2×还款月数-总贷款额
 */


//等额本息
-(float)totalInterestEAPEM:(float)principle monthRate:(float)monthRate debtMonth:(NSInteger)debtMonth{
    float rate=monthRate/100;
    float monthPay=principle*rate*powf(1+rate, debtMonth)/(powf(1+rate, debtMonth)-1);
    float result=monthPay*debtMonth-principle;
   
    return result;
}
//等额本金
-(float)totalInterestMMR:(float)principle monthRate:(float)monthRate debtMonth:(NSInteger)debtMonth{
    float realRate=monthRate/100;
    float result=((principle/debtMonth+principle*realRate)+principle/debtMonth*(1+realRate))/2*debtMonth-principle;
    return result;
}

-(float)houseInterestTotalEAPM:(BOOL)isSelfHouse{
    
    //应当默认三层首付=area*price*0.3，自动计算贷款额度，而不是手动输入
    
    float totalPrice=0;
    if (isSelfHouse) {
        totalPrice=self.landObject.selfHousePrice*self.landObject.area;
    }
    else{
        totalPrice=self.landObject.commercialHousePrice*self.landObject.area;
    }
    float pricipal=totalPrice*0.7;
    float fundInterest=0;
    if (totalPrice<=FundsMaxAmount) {
        fundInterest=[self totalInterestEAPEM:pricipal monthRate:self.loanObject.fundInterest/12 debtMonth:self.loanObject.cycleYear*12];
        return fundInterest;
    }
    
    fundInterest=[self totalInterestEAPEM:FundsMaxAmount monthRate:self.loanObject.fundInterest/12 debtMonth:self.loanObject.cycleYear*12];
    
    float commercialIntetrest=[self totalInterestEAPEM:pricipal-FundsMaxAmount monthRate:self.loanObject.bankInterest/12 debtMonth:self.loanObject.cycleYear*12];
    
    return fundInterest+commercialIntetrest;
    
}
-(float)houseInterestTotalMMR:(BOOL)isSelfHouse{
    float totoalPrice=0;
    if (isSelfHouse) {
        totoalPrice=self.landObject.selfHousePrice*self.landObject.area;
    }
    else{
        totoalPrice=self.landObject.commercialHousePrice*self.landObject.area;
    }
    float fundsInterest=0;
    float pricipal=totoalPrice*0.7;
    if (totoalPrice<=FundsMaxAmount) {
        fundsInterest=[self totalInterestMMR:pricipal
                                   monthRate:self.loanObject.fundInterest/12 debtMonth:self.loanObject.cycleYear*12];
        return fundsInterest;
    }
    fundsInterest=[self totalInterestMMR:FundsMaxAmount monthRate:self.loanObject.fundInterest/12 debtMonth:self.loanObject.cycleYear*12];
    float bankInterest=[self totalInterestMMR:pricipal-FundsMaxAmount monthRate:self.loanObject.bankInterest/12 debtMonth:self.loanObject.cycleYear*12];
    return fundsInterest+bankInterest;
}

-(float)totalInterest:(float)principle monthRate:(float)monthRate debtMonth:(NSInteger)debtMonth reimbuserStyle:(ReimbursementStyle)reimbuserStyle{
    if (ReimbursementStyleEAPEM==reimbuserStyle) {
        return [self totalInterestEAPEM:principle monthRate:monthRate debtMonth:debtMonth];
    }
    if (ReimbursementStyleMMR==reimbuserStyle) {
        return [self totalInterestMMR:principle monthRate:monthRate debtMonth:debtMonth];
    }
    NSAssert(NO, @"Not this reimburse style");
    return -1;
}


@end
