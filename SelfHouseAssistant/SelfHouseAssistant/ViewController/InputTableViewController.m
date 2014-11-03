//
//  InputTableViewController.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "InputTableViewController.h"
#import "LoanObject.h"
#import "LandCell.h"
#import "LoanCell.h"
#import "LandObject.h"
#import "LandPriceViewController.h"
#import "LoanViewController.h"
#import "Calculator.h"
#import "CalculateDetailViewController.h"

#define LandCellHeight 132
#define LoanCellHeight 125
#define CalculateCellHeight 44


#define LandPriceCellIdentifer @"LandPriceCellIdentifer"
#define InterestCellIdentifer @"InterestCellIdentifer"
#define CalculateCellIdentifer @"CalculateCellIdentifer"

#define ResultFormat @"经过对比计算，如果将来房价控制在%.1f内，自住房的收益较高，否则商品房的收益较高"
#define ErrorMessage @"输入参数有误，请从先检查"

@interface InputTableViewController ()<LandPriceViewControllerDelegate,LoanViewControllerDelegate,UIAlertViewDelegate>

@end

@implementation InputTableViewController

@synthesize landObject;
@synthesize loanObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell*cell=nil;

    if (indexPath.row==0) {
        
        return [self landCell];
        
        
    }
    if (indexPath.row==1) {
        return [self loanCell];
       
        
    }
    if (indexPath.row==2) {
        cell = [tableView dequeueReusableCellWithIdentifier:CalculateCellIdentifer forIndexPath:indexPath];
        return cell;
        
    }
   
    
    // Configure the cell...
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0==indexPath.row) {
        return LandCellHeight;
    }
    if (1==indexPath.row) {
        return LoanCellHeight;
    }
    if (2==indexPath.row) {
        return CalculateCellHeight;
    }
    return 0;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(2==indexPath.row){
        
        if([[UIDevice currentDevice].systemVersion floatValue]>=8.0){
            
            [self presentAltertControleller];
        }
        else{
            [self presentAlertView];
        }
        
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController*dstvc=[segue destinationViewController];
    if ([dstvc isKindOfClass:[LandPriceViewController class]]) {
        LandPriceViewController*lpvc=(LandPriceViewController*)dstvc;
        lpvc.delegate=self;
        lpvc.landObject=self.landObject;
        return;
    }
    if ([dstvc isKindOfClass:[LoanViewController class]]) {
        LoanViewController*lvc=(LoanViewController*)dstvc;
        lvc.loanObject=self.loanObject;
        lvc.delegate=self;
        return;
    }
}

#pragma mark -- action and delegate messages

-(void)loanViewControllerDidNavigateBack:(LoanViewController *)lvc{
    [self.tableView reloadData];
    
}
-(void)landViewControllerDidNavigateBack:(LandPriceViewController *)lvc{
    [self.tableView reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NSString*className=NSStringFromClass([CalculateDetailViewController class]);
        CalculateDetailViewController*cdvc=[storyboard instantiateViewControllerWithIdentifier:className];
        cdvc.landObject=self.landObject;
        cdvc.loanObject=self.loanObject;
        cdvc.calculator=[[Calculator alloc]initWithLandObject:self.landObject loanObject:self.loanObject];
        [self.navigationController pushViewController:cdvc animated:YES];
        return;
    }
}


#pragma mark -- private messages

-(UITableViewCell*)landCell{
    LandCell*cell = (LandCell*)[self.tableView dequeueReusableCellWithIdentifier:LandPriceCellIdentifer];
    cell.selfHouseLabel.text=[NSString stringWithFormat:@"自住房单价%.0f 每平方米",self.landObject.selfHousePrice];
    cell.commercialHouseLabel.text=[NSString stringWithFormat:@"商品房单价%.0f 每平方米",self.landObject.commercialHousePrice];
    cell.areaLabel.text=[NSString stringWithFormat:@"住房面积为%.2f平方米",self.landObject.area];
    
    
    return cell;
    
}
-(UITableViewCell*)loanCell{
   LoanCell* cell = (LoanCell*)[self.tableView dequeueReusableCellWithIdentifier:InterestCellIdentifer];
    cell.fundLabel.text=[NSString stringWithFormat:@"公积金默认%d%%首付 贷款利率 %.3f%%",30,self.loanObject.fundInterest];
    cell.bankLabel.text=[NSString stringWithFormat:@"商贷默认%d%%首付 贷款利率%.3f%%",30,self.loanObject.bankInterest];
    cell.interestLabel.text=[NSString stringWithFormat:@"贷款年限为%ld年，贷款方式为%@",(long)self.loanObject.cycleYear,NSStringFromReimbusermentStyle(self.loanObject.reimbusermentStyle)];
    
    return cell;
}

-(void)presentAltertControleller{
    Calculator*cal=[[Calculator alloc]initWithLandObject:self.landObject loanObject:self.loanObject];
    
    float price=[cal critcalPrice];
    UIAlertController*alert=nil;
    if (InvalidateFloat==price) {
        
        alert=[UIAlertController alertControllerWithTitle:@"结果" message:ErrorMessage preferredStyle:UIAlertControllerStyleAlert];
    }
    else{
        
        NSString*resultMessage=[NSString stringWithFormat:ResultFormat,price];
        alert=[UIAlertController alertControllerWithTitle:@"结果" message:resultMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*detailAction=[UIAlertAction actionWithTitle:@"详细信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alert dismissViewControllerAnimated:YES completion:^{
            
                UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NSString*className=NSStringFromClass([CalculateDetailViewController class]);
                CalculateDetailViewController*cdvc=[storyboard instantiateViewControllerWithIdentifier:className];
                cdvc.calculator=cal;
                cdvc.loanObject=self.loanObject;
                cdvc.landObject=self.landObject;
                [self showViewController:cdvc sender:self];
                return;
                
            }];
            return ;
        }];
        [alert addAction:detailAction];
    }

    UIAlertAction*okActon=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okActon];
    
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)presentAlertView{
    Calculator*cal=[[Calculator alloc]initWithLandObject:self.landObject loanObject:self.loanObject];
    
    float price=[cal critcalPrice];
    UIAlertView*alertView=nil;
    if (InvalidateFloat==price) {
        alertView=[[UIAlertView alloc]initWithTitle:@"结果" message:ErrorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else{
    
    NSString*resultMessage=[NSString stringWithFormat:ResultFormat,price];
    alertView=[[UIAlertView alloc]initWithTitle:@"结果" message:resultMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"详细信息",nil];
        [alertView show];
    }
    
}

-(NSString*)landPriceText{
    
    return nil;
}
-(NSString*)interestText{
    return [[LoanObject instance] description];
;
}

@end
