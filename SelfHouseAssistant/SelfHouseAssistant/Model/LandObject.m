//
//  LandObject.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14-10-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "LandObject.h"

#define LandObjectSelfHousePriceKey @"LandObjectSelfHousePriceKey"
#define LandObjectCommercialHousePriceKey @"LandObjectCommercialHousePriceKey"
#define LandObjectAreaKey @"LandObjectAreaKey"



@implementation LandObject

@synthesize selfHousePrice;
@synthesize commercialHousePrice;
@synthesize area;

-(void)saveUserDefaults{
    NSUserDefaults*userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setFloat:self.selfHousePrice forKey:LandObjectSelfHousePriceKey];
    [userDefault setFloat:self.commercialHousePrice forKey:LandObjectCommercialHousePriceKey];
    [userDefault setFloat:self.area forKey:LandObjectAreaKey];
}
-(void)synchronizeFromUserDefaults{
    NSUserDefaults*userDefault=[NSUserDefaults standardUserDefaults];
    self.selfHousePrice=[userDefault floatForKey:LandObjectSelfHousePriceKey];
    self.commercialHousePrice=[userDefault floatForKey:LandObjectCommercialHousePriceKey];
    self.area=[userDefault floatForKey:LandObjectAreaKey];
}
@end
