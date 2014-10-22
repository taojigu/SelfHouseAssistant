//
//  LandPriceViewController.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "LandPriceViewController.h"
#import "LandObject.h"

@interface LandPriceViewController ()<UITextFieldDelegate>{
    @private
    IBOutlet UITextField*tfCommercialLandPrice;
    IBOutlet UITextField*tfSelfHosueLandPrice;
    IBOutlet UITextField*tfArea;
}

@end

@implementation LandPriceViewController

@synthesize delegate;
@synthesize landObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshValueSubviews];
    UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnView:)];
    [self.view
     addGestureRecognizer:tapGesture];
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



#pragma delegate and action messages
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==tfSelfHosueLandPrice) {
        self.landObject.selfHousePrice=[tfSelfHosueLandPrice.text floatValue];
    }
    if (textField==tfCommercialLandPrice) {
        self.landObject.commercialHousePrice=[tfCommercialLandPrice.text floatValue];
    }
    if (textField==tfArea) {
        self.landObject.area=[tfArea.text floatValue];
    }
    return YES;
}
-(IBAction)navigationBack:(id)sender{
    if ([self.delegate respondsToSelector:@selector(landViewControllerDidNavigateBack:)]) {
        [self.delegate landViewControllerDidNavigateBack:self];
    }
    [self resignAllInputControls];
    
    [self.landObject saveUserDefaults];
    [self.navigationController popViewControllerAnimated:YES];

}
-(IBAction)tapOnView:(id)sender{
    [self resignAllInputControls];
}
#pragma mark -- private messages
-(void)resignAllInputControls{
    [tfArea resignFirstResponder];
    [tfCommercialLandPrice resignFirstResponder];
    [tfSelfHosueLandPrice resignFirstResponder];
}
-(void)refreshValueSubviews{
    
    tfSelfHosueLandPrice.text=[NSString stringWithFormat:@"%.0f",self.landObject.selfHousePrice];
    tfCommercialLandPrice.text=[NSString stringWithFormat:@"%.0f",self.landObject.commercialHousePrice];
    tfArea.text=[NSString stringWithFormat:@"%.2f",self.landObject.area];
}



@end
