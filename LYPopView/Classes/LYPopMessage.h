//
//  LYPopMessage.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <LYPopView/LYPopView.h>

@interface LYPopMessage : LYPopView

/**
 message
 */
@property (nonatomic, strong) NSString *message;

/**
 instance creator

 @param aTitle pop view title
 @param aMessage message in pop view
 */
+ (void)showPopWithTitle:(NSString *)aTitle andMessage:(NSString *)aMessage;

@end
