//
//  LYPopImagePickerAction.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2018-08-15.
//  COPYRIGHT © 2016-2019 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LYPopImagePickerAction : NSObject

/**
 instance getter

 @return instance of self
 */
+ (instancetype)action;

/**
 SHOW ACTIONSHEET TO PICK IMAGE

 @param basevc view controller to show
 @param edit allow editing
 @param titlePop pop actionsheet title
 @param titleCamera camera button title
 @param titleAlbum album button title
 @param titleCancel cancel button title
 @param action pick result action
 @param actionCancel cancel action
 */
- (void)showFromViewController:(UIViewController *)basevc
						  edit:(BOOL)edit
					  popTitle:(NSString *)titlePop
				   cameraTitle:(NSString *)titleCamera
					albumTitle:(NSString *)titleAlbum
				   cancelTitle:(NSString *)titleCancel
				   photoAction:(void (^)(UIImagePickerController *imp, NSDictionary *ret))action
				  cancelAction:(void (^)(void))actionCancel;

@end
