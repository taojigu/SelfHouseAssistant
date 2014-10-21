//
//  LoanCell.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-21.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanCell : UITableViewCell{
    
}

@property(nonatomic,strong)IBOutlet UILabel*fundLabel;
@property(nonatomic,strong)IBOutlet UILabel*bankLabel;
@property(nonatomic,strong)IBOutlet UILabel*interestLabel;

@end
