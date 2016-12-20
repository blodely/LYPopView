//
//  LYPopMessage.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <LYPopView/LYPopView.h>

@interface LYPopMessage : LYPopView

@property (nonatomic, strong) NSString *message;

+ (void)showPopWithTitle:(NSString *)aTitle andMessage:(NSString *)aMessage;

@end
