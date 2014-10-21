//
//  InputTableViewController.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LandObject;
@class LoanObject;

@interface InputTableViewController : UITableViewController{
    
}

@property(nonatomic,strong)LoanObject*loanObject;
@property(nonatomic,strong)LandObject*landObject;



@end
