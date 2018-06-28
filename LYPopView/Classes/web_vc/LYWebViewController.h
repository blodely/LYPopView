//
//  LYWebViewController.h
//  LYPopView
//
//  Created by Luo Yu on 2018/6/28.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface LYWebViewController : UIViewController

@property (weak, nonatomic) WKWebView *web;

@property (strong, nonatomic) NSString *URLString;

- (instancetype)initWithTitle:(NSString *)titleName andURL:(NSString *)URLString;

+ (UINavigationController *)navWebWithTitle:(NSString *)titleName andURL:(NSString *)URLString;

@end
