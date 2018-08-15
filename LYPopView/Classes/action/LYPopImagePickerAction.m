//
//  LYPopImagePickerAction.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2018-08-15.
//  COPYRIGHT © 2016-2018 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
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

#import "LYPopImagePickerAction.h"
#import <BlocksKit/BlocksKit+UIKit.h>


@implementation LYPopImagePickerAction

+ (void)showFrownViewController:(UIViewController *)basevc edit:(BOOL)edit popTitle:(NSString *)titlePop cameraTitle:(NSString *)titleCamera albumTitle:(NSString *)titleAlbum cancelTitle:(NSString *)titleCancel cameraAction:(void (^)(UIImagePickerController *, NSDictionary *))actionCamera albumAction:(void (^)(UIImagePickerController *, NSDictionary *))actionAlbum cancelAction:(void (^)(void))actionCancel {
	
	UIAlertController *sheet = [UIAlertController alertControllerWithTitle:titlePop message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
	
	// ADD ALBUM BUTTON
	[sheet addAction:[UIAlertAction actionWithTitle:titleAlbum style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		UIImagePickerController *imp = [[UIImagePickerController alloc] init];
		imp.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		imp.allowsEditing = edit;
		[imp setBk_didCancelBlock:^(UIImagePickerController *impc) {
			[impc dismissViewControllerAnimated:YES completion:^{}];
		}];
		[imp setBk_didFinishPickingMediaBlock:^(UIImagePickerController *impc, NSDictionary *data) {
			actionAlbum(impc, data);
			[impc dismissViewControllerAnimated:YES completion:^{}];
		}];
		[basevc presentViewController:imp animated:YES completion:^{}];
	}]];
	
	// ADD CAMERA BUTTON
	[sheet addAction:[UIAlertAction actionWithTitle:titleCamera style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		UIImagePickerController *imp = [[UIImagePickerController alloc] init];
		imp.sourceType = UIImagePickerControllerSourceTypeCamera;
		imp.allowsEditing = edit;
		[imp setBk_didCancelBlock:^(UIImagePickerController *impc) {
			[impc dismissViewControllerAnimated:YES completion:^{}];
		}];
		[imp setBk_didFinishPickingMediaBlock:^(UIImagePickerController *impc, NSDictionary *data) {
			actionCamera(impc, data);
			[impc dismissViewControllerAnimated:YES completion:^{}];
		}];
		[basevc presentViewController:imp animated:YES completion:^{}];
		
	}]];
	
	// ADD CANCEL BUTTON
	[sheet addAction:[UIAlertAction actionWithTitle:titleCancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		actionCancel();
	}]];
	
	// SHOW ACTION_SHEET
	[basevc presentViewController:sheet animated:YES completion:^{}];
	
}

+ (void)showFrownViewController:(UIViewController *)basevc popTitle:(NSString *)titlePop cameraTitle:(NSString *)titleCamera albumTitle:(NSString *)titleAlbum cancelTitle:(NSString *)titleCancel cameraAction:(void (^)(UIImagePickerController *, NSDictionary *))actionCamera albumAction:(void (^)(UIImagePickerController *, NSDictionary *))actionAlbum cancelAction:(void (^)(void))actionCancel {
	
	[self showFrownViewController:basevc edit:YES popTitle:titlePop cameraTitle:titleCamera albumTitle:titleAlbum cancelTitle:titleCancel cameraAction:actionCamera albumAction:actionAlbum cancelAction:actionCancel];
}

@end
