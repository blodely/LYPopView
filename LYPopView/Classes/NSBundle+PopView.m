//
//  NSBundle+PopView.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "NSBundle+PopView.h"
#import "LYPopView.h"

@implementation NSBundle (PopView)

+ (NSBundle *)popResourceBundle {
	return [NSBundle bundleWithURL:[[NSBundle bundleForClass:[LYPopView class]] URLForResource:@"LYPopView" withExtension:@"bundle"]];
}

@end
