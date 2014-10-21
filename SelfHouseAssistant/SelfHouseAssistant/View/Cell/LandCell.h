//
//  LandCell.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-21.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel*selfHouseLabel;
@property(nonatomic,strong)IBOutlet UILabel*commercialHouseLabel;
@property(nonatomic,strong)IBOutlet UILabel*areaLabel;

@end
