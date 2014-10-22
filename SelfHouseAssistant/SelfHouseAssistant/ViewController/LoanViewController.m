//
//  InterestViewController.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "LoanViewController.h"
#import "LoanObject.h"

@interface LoanViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    @private
    IBOutlet UITextField*tfFundAmount;
    IBOutlet UITextField*tfFundInterest;
    IBOutlet UITextField*tfBankAmount;
    IBOutlet UITextField*tfBankInterest;
    IBOutlet UISlider*sliderYear;
    IBOutlet UILabel*labelYear;
    IBOutlet UISegmentedControl*segmentReimbuserStyle;
    IBOutlet UIPickerView*pickerYear;
}

@end

@implementation LoanViewController

@synthesize delegate;
@synthesize loanObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];

    [self refreshValueSubViews];
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

#pragma action and delegate messages
-(IBAction)navigateBack:(id)sender{
    if ([self.delegate respondsToSelector:@selector(loanViewControllerDidNavigateBack:)]) {
        [self.delegate loanViewControllerDidNavigateBack:self];
    }
    [self resignAllInputViews];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sliderYearValueChanged{
    if (self.loanObject.cycleYear==sliderYear.value) {
        return;
    }
    self.loanObject.cycleYear=sliderYear.value;
    labelYear.text=[NSString stringWithFormat:@"%ld年",(long)self.loanObject.cycleYear];
    [self.loanObject saveUserDefaults];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==tfFundAmount) {
        self.loanObject.fundLoanAmount=tfFundAmount.text.floatValue;
    }
    if (textField==tfFundInterest) {
        self.loanObject.fundInterest=tfFundInterest.text.floatValue;
    }
    if (textField==tfBankAmount) {
        self.loanObject.bankLoanAmount=tfBankAmount.text.floatValue;
    }
    if (textField==tfBankInterest) {
        self.loanObject.bankInterest=tfBankInterest.text.floatValue;
    }
    [self.loanObject saveUserDefaults];
}
-(void)tapOnView{
    [self resignAllInputViews];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 31;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%ld",(long)row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (row==sliderYear.value) {
        return;
    }
    self.loanObject.cycleYear=row;
    labelYear.text=[NSString stringWithFormat:@"%ld年",(long)self.loanObject.cycleYear];
    [self.loanObject saveUserDefaults];
    sliderYear.value=row;
    
}
#pragma private messages
-(void)refreshValueSubViews{
    tfBankAmount.text=[NSString stringWithFormat:@"%.0f",self.loanObject.bankLoanAmount];
    tfBankInterest.text=[NSString stringWithFormat:@"%.4f",self.loanObject.bankInterest];
    tfFundAmount.text=[NSString stringWithFormat:@"%.0f",self.loanObject.fundLoanAmount];
    tfFundInterest.text=[NSString stringWithFormat:@"%.4f",self.loanObject.fundInterest];
    sliderYear.value=self.loanObject.cycleYear;
    labelYear.text=[NSString stringWithFormat:@"%ld年",(long)self.loanObject.cycleYear];

    
}
-(void)resignAllInputViews{
    [tfFundInterest resignFirstResponder];
    [tfFundAmount resignFirstResponder];
    [tfBankInterest resignFirstResponder];
    [tfBankAmount resignFirstResponder];
}
-(void)initSubViews{
    [sliderYear addTarget:self action:@selector(sliderYearValueChanged) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnView)];
    [self.view addGestureRecognizer:tapGesture];
    
    labelYear.text=[NSString stringWithFormat:@"%ld年",(long)self.loanObject.cycleYear];
    
    [pickerYear selectRow:self.loanObject.cycleYear inComponent:0 animated:NO];
    
    
}

@end
