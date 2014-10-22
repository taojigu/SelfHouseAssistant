//
//  InterestViewController.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoanViewController;
@class LoanObject;

@protocol LoanViewControllerDelegate <NSObject>


-(void)loanViewControllerDidNavigateBack:(LoanViewController*)lvc;


@end

@interface LoanViewController : UIViewController{
    
}

@property(nonatomic,assign)id<LoanViewControllerDelegate>delegate;
@property(nonatomic,strong)LoanObject*loanObject;

@end
