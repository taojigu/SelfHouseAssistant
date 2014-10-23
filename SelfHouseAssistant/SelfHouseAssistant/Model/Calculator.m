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
    if (ReimbursementStyleEAPEM==self.loanObject.remimbusermentStyle) {

        selfHouseInterestTotal=[self selfHouseInterestTotalEAPM];
        commercialHouseInterestTotal=[self commercialHouseInterestTotalEAPM];
    }
    else{
        selfHouseInterestTotal=[self selfHouseIntererstTotalMMR];
        commercialHouseInterestTotal=[self commercialHouseInterestTotalMMR];
        
    }
    NSAssert(commercialHouseInterestTotal>selfHouseInterestTotal, @"Wrong interest");
        
    float resultPrice=(self.landObject.area*(self.landObject.commercialHousePrice-0.7*self.landObject.selfHousePrice)+(commercialHouseInterestTotal-selfHouseInterestTotal))/0.3*self.landObject.area;
        return resultPrice;
    
}

//等额本息
-(float)totalInterestEAPEM:(float)principle monthRate:(float)monthRate debtMonth:(NSInteger)debtMonth{
    
    return 0;
}
//等额本金
-(float)totalInterestMMR:(float)principle monthRate:(float)monthRate debtMonth:(NSInteger)debtMonth{
    return 0;
}

-(float)selfHouseInterestTotalEAPM{
    
    //应当默认三层首付=area*price*0.3，自动计算贷款额度，而不是手动输入
    float selfHouseTotal=[self totalInterestEAPEM:self.loanObject.fundLoanAmount monthRate:self.loanObject.fundInterest/12 debtMonth:self.loanObject.cycleYear*12];
    float com=[self totalInterestEAPEM:self.loanObject.bankLoanAmount monthRate:self.loanObject.bankLoanAmount/12 debtMonth:self.loanObject.cycleYear*12];
    return 1;
}
-(float)commercialHouseInterestTotalEAPM{
    return 2;
}
-(float)selfHouseIntererstTotalMMR{
    return 1;
}
-(float)commercialHouseInterestTotalMMR {
    return 2;
}

@end
