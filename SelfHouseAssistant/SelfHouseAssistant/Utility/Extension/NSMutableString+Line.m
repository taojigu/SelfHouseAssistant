//
//  NSMutableString+Line.m
//  SelfHouseAssistant
//
//  Created by VooleDev6 on 14/10/31.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "NSMutableString+Line.h"

@implementation NSMutableString(Line)

-(void)appendStringLine:(NSString*)string{

    NSAssert(nil!=string, @"nil string could not be append to line");
    [self appendString:string];
    [self appendLine];
    return;
}
-(void)appendLine{
    [self appendString:@"\r\n"];
}

-(void)appendLine:(NSInteger)lineNumber{
    NSAssert(lineNumber>=0, @"number of line should not be less than 0");
    for (NSInteger lineIndex=0; lineIndex<lineNumber; lineNumber++) {
        [self appendLine];
    }
}

@end
