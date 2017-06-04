//
//  UIColor+LYPopViewHex.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

@interface UIColor (LYPopViewHex)

/**
 hex color convertor

 @param hexstring hex color string
 @return color object
 */
+ (UIColor *)pv_hex:(NSString *)hexstring;

@end
