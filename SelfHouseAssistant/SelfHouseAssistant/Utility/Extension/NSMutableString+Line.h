//
//  NSMutableString+Line.h
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14/10/31.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString(Line)

-(void)appendStringLine:(NSString*)string;
-(void)appendLine;
-(void)appendLine:(NSInteger)lineNumber;
@end
