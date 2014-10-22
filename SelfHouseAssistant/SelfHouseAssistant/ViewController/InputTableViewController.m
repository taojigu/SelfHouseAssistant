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

#define LandCellHeight 132
#define LoanCellHeight 125
#define CalculateCellHeight 44


#define LandPriceCellIdentifer @"LandPriceCellIdentifer"
#define InterestCellIdentifer @"InterestCellIdentifer"
#define CalculateCellIdentifer @"CalculateCellIdentifer"

@interface InputTableViewController ()<LandPriceViewControllerDelegate,LoanViewControllerDelegate>

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
    cell.fundLabel.text=[NSString stringWithFormat:@"公积金贷款额度%.0f万 贷款利率 %.4f %%",self.loanObject.fundLoanAmount,self.loanObject.fundInterest];
    cell.bankLabel.text=[NSString stringWithFormat:@"商贷额度为%.0f万，贷款利率%.4f%%",self.loanObject.bankLoanAmount,self.loanObject.bankInterest];
    cell.interestLabel.text=[NSString stringWithFormat:@"贷款年限为%ld年，贷款方式为%@",(long)self.loanObject.cycleYear,NSStringFromReimbusermentStyle(self.loanObject.remimbusermentStyle)];
    
    return cell;
}

-(NSString*)landPriceText{
    
    return nil;
}
-(NSString*)interestText{
    return [[LoanObject instance] description];
;
}

@end
