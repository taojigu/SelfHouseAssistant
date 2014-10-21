//
//  LandObject.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LandObject : NSObject{
    
}

@property(nonatomic,assign)float selfHousePrice;
@property(nonatomic,assign)float commercialHousePrice;
@property(nonatomic,assign)float area;

-(void)saveUserDefaults;
-(void)synchronizeFromUserDefaults;

@end
