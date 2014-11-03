//
//  CalculateDetailViewController.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-24.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "CalculateDetailViewController.h"
#import "Calculator.h"
#import "LandObject.h"
#import "LoanObject.h"
#import "NSMutableString+Line.h"


#define WanUnit 10000

@interface CalculateDetailViewController (){

    @private
    IBOutlet UITextView*textView;
}

@end

@implementation CalculateDetailViewController

@synthesize calculator;
@synthesize landObject;
@synthesize loanObject;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self appendDetailString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 
 计算思路如下：
 自住房收益=（卖出单价-自住房单价）*0.7*建筑面积-贷款利息
 商品房收益=（卖出单价-商品房买入单价）*建筑面积-贷款利息
 保证自住房收益>=商品房收益
 
 本次计算中
 自住房单价=22000 建筑面积=88.3 总价=自住房单价*建筑面积=22000*88.3=194  首付款=总价*0.3=52
 贷款额度=总价*0.7=138
 
 贷款额度少于80万，默认使用公积金贷款，年利率=4.5%，月利率为4.5%/12=0.36% 贷款周期为24年 总利息=223311
 
 贷款额度大于80万，默认使用组合贷款，公积金贷款=80万（年利率4.5%），商业贷款=58万（年利率6.55%) 贷款周期=24年  总利息=公积金总利息+商业贷款总利息=211190
 
 商品房买入单价：35000 建筑面积=88.3 总价=商品房单价*建筑面积=35000*88.3=320万 首付款=总价*0.3=67  贷款额度=总价*0.7=253
 
 贷款额度大于80万，默认使用组合贷款，公积金贷款=80万（年利率4.5%），商业贷款=58万（年利率6.55%) 贷款周期=24年  总利息=公积金总利息+商业贷款总利息=211190
 
 附录计算公式：
 
 其他因素：政策成本，五年之后才能上市
 
 */


-(void)appendDetailString{
    NSMutableString*detailString=[[NSMutableString alloc]init];
    
    NSString*guideLine=[self guideLineString];
    [detailString appendStringLine:guideLine];
    NSString*calProcess=[self calculateProcessString];
    [detailString appendStringLine:calProcess];
    NSString*fomutaltionsString=[self formulationString];
    [detailString appendStringLine:fomutaltionsString];
    NSString*otherFactor=[self otherFactorString];
    [detailString appendStringLine:otherFactor];
    
    textView.text=detailString;
}

-(NSString*)guideLineString{
    NSMutableString*buffer=[[NSMutableString alloc]init];
    /*
     计算思路如下：
     自住房收益=（卖出单价-自住房单价）*0.7*建筑面积-贷款利息
     商品房收益=（卖出单价-商品房买入单价）*建筑面积-贷款利息
     保证自住房收益>=商品房收益
     */
    [buffer appendStringLine:@"计算思路如下:"];
    [buffer appendLine];
    [buffer appendStringLine:@"自住房收益=（卖出单价-自住房单价）*0.7*建筑面积-贷款利息"];
    [buffer appendStringLine:@"商品房收益=（卖出单价-商品房买入单价）*建筑面积-贷款利息"];
    [buffer appendStringLine:@"保证自住房收益>=商品房收益"];
    return buffer;
}
/*
 本次计算中
 自住房单价=22000 建筑面积=88.3 总价=自住房单价*建筑面积=22000*88.3=194  首付款=总价*0.3=52
 贷款额度=总价*0.7=138
 
 贷款额度少于80万，默认使用公积金贷款，年利率=4.5%，月利率为4.5%/12=0.36% 贷款周期为24年 总利息=223311
 
 贷款额度大于80万，默认使用组合贷款，公积金贷款=80万（年利率4.5%），商业贷款=58万（年利率6.55%) 贷款周期=24年  总利息=公积金总利息+商业贷款总利息=211190
 
 商品房买入单价：35000 建筑面积=88.3 总价=商品房单价*建筑面积=35000*88.3=320万 首付款=总价*0.3=67  贷款额度=总价*0.7=253
 
 贷款额度大于80万，默认使用组合贷款，公积金贷款=80万（年利率4.5%），商业贷款=58万（年利率6.55%) 贷款周期=24年  总利息=公积金总利息+商业贷款总利息=211190
 */

#define HouseFormat @"%@单价=%.0f \r\n 建筑面积=%.2f \r\n总价=房屋单价*建筑面积=%.2f万"
#define DownPaymentFormat @"首付款=总价*0.3=%.2f万 \r\n贷款额度=总价*0.7=%.2f万"

#define LessThan80Format @"贷款额度少于80万，默认使用公积金贷款\r\n年利率=%.2f%%\r\n月利率为%.2f%%/12=%.2f%% \r\n贷款周期为%d年 \r\n还款方式=%@ \r\n总利息=%.2f万"
#define MoreThan80Format @"贷款额度大于80万，默认使用组合贷款 \r\n公积金贷款=80万（年利率%.2f%%%%），商业贷款=%.2f万（年利率%.2f%%) \r\n贷款周期=%d年\r\n还款方式=%@  \r\n总利息=公积金总利息+商业贷款总利息=%.2f万"

-(NSString*)selfHouseDetailString{
    NSMutableString*result=[[NSMutableString alloc]init];

    float total=self.landObject.selfHousePrice*self.landObject.area;
  
    NSString*hosueFormat=[NSString stringWithFormat:HouseFormat,@"自住房",self.landObject.selfHousePrice,self.landObject.area,total/WanUnit];
    [result appendStringLine:hosueFormat];

    ;
    NSString*loanInfoString=[self loanInfoDetailString:total];
    
    
    [result appendLine];
    [result appendStringLine:loanInfoString];
    
    return result;
}
-(NSString*)commercialHouseDetailString{
    NSMutableString*result=[[NSMutableString alloc]init];
    float total=self.landObject.commercialHousePrice*self.landObject.area;
    
    NSString*hosueFormat=[NSString stringWithFormat:HouseFormat,@"商品房",self.landObject.commercialHousePrice,self.landObject.area,total/WanUnit];
    [result appendStringLine:hosueFormat];
    
    ;
    NSString*loanInfoString=[self loanInfoDetailString:total];
    
    [result appendLine];
    [result appendStringLine:loanInfoString];
    
    return result;
  
}
-(NSString*)calculateProcessString{
    NSMutableString*result=[[NSMutableString alloc]init];
    [result appendStringLine:@"本次计算中:"];
    NSString*selfHouseString=[self selfHouseDetailString];
    [result appendStringLine:selfHouseString];
    NSString*commercialHouseDetailString=[self commercialHouseDetailString];
    [result appendStringLine:commercialHouseDetailString];
    
    return result;
}
-(NSString*)loanInfoDetailString:(float)total{
    
    NSMutableString*detailString=[[NSMutableString alloc]init];
    float downPayAmount=total*0.3;
    float loanAmount=total-downPayAmount;
    NSString*dpformat=[NSString stringWithFormat:DownPaymentFormat,downPayAmount/WanUnit,loanAmount/WanUnit];
    [detailString appendStringLine:dpformat];
    float monthFundsRate=self.loanObject.fundInterest/12;
    float monthBankRate=self.loanObject.bankInterest/12;
    NSInteger monthCount=self.loanObject.cycleYear*12;

    NSString*loanInfoString=nil;
    if(loanAmount<=80*WanUnit){
        
        float fundsTotalInterest=[self.calculator totalInterest:loanAmount monthRate:monthFundsRate debtMonth:monthCount reimbuserStyle:self.loanObject.reimbusermentStyle];
        loanInfoString=[NSString stringWithFormat:LessThan80Format,self.loanObject.fundInterest,self.loanObject.fundInterest,monthFundsRate,self.loanObject.cycleYear,NSStringFromReimbusermentStyle(self.loanObject.reimbusermentStyle),fundsTotalInterest/WanUnit];
    }
    else{
        
        float fundsPrinciple=80*WanUnit;
        float bankPrinciple=loanAmount-fundsPrinciple;
        float fundsTotalInterest=[self.calculator totalInterest:fundsPrinciple monthRate:monthFundsRate debtMonth:monthCount reimbuserStyle:self.loanObject.reimbusermentStyle];
        float bankTotalInterest=[self.calculator totalInterest:bankPrinciple monthRate:monthBankRate debtMonth:monthCount reimbuserStyle:self.loanObject.reimbusermentStyle];
        NSAssert(0<bankPrinciple, @"Bank Principle should not less than 0");
        loanInfoString=[NSString stringWithFormat:MoreThan80Format,self.loanObject.fundInterest,bankPrinciple/WanUnit,self.loanObject.bankInterest,self.loanObject.cycleYear,NSStringFromReimbusermentStyle(self.loanObject.reimbusermentStyle),(fundsTotalInterest+bankTotalInterest)/WanUnit];
    }
    
    [detailString appendStringLine:loanInfoString];
    return detailString;

}
-(NSString*)formulationString{
    return @"";
}
-(NSString*)otherFactorString{
    return @" 其他因素：政策成本，五年之后才能上市";
}




@end
