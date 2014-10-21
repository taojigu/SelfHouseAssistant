//
//  LandPriceViewController.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LandPriceViewController;
@class LandObject;

@protocol LandPriceViewControllerDelegate <NSObject>

@required
-(void)viewControllerNavigateBack:(LandPriceViewController*)lvc;

@end



@interface LandPriceViewController : UIViewController{
    
}
@property(nonatomic,assign)id<LandPriceViewControllerDelegate>delegate;
@property(nonatomic,strong)LandObject*landObject;

@end

