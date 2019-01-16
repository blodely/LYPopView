//
//	LYPrivacyPop.m
//	LYPOPVIEW
//
//	CREATED BY LUO YU ON 2019-01-16.
//	COPYRIGHT © 2016-2019 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
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

#import "LYPrivacyPop.h"
#import <LYPopView/LYPopView.h>
#import <WebKit/WebKit.h>
#import <LYCategory/LYCategory.h>
#import <Masonry/Masonry.h>


NSString *const LYPrivacyPolicyAgreed = @"space.luoyu.popview.privacy.policy.agreed";

@interface LYPrivacyPop () <WKNavigationDelegate, WKUIDelegate> {
	__weak UIView *vIndicator;
	__weak WKWebView *web;
	__weak UIButton *btnConfirm;
}
@end

@implementation LYPrivacyPop

// MARK: - ACTION

- (void)confirmButtonPressed:(id)sender {
	[self dismiss];
}

// MARK: - INIT

- (void)initial {
	maxHeight = WIDTH * 1.2;
	[super initial];
	
	CGFloat pd = 18;
	
	{
		[vCont roundedCornerRadius:pd];
		vCont.backgroundColor = [UIColor whiteColor];
		[vCont mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self).offset(floorf(WIDTH * 0.1));
			make.right.equalTo(self).offset(-floorf(WIDTH * 0.1));
			make.height.mas_equalTo(self->maxHeight);
			make.centerY.equalTo(self);
		}];
		
		[cBg removeTarget:self action:@selector(dismiss) forControlEvents:UIControlEventAllEvents];
	}
	
	{
		// MARK: TITLE
		UILabel *label = [[UILabel alloc] init];
		label.textColor = [UIColor darkTextColor];
		label.numberOfLines = 0;
		label.font = [UIFont boldSystemFontOfSize:17];
		[vCont addSubview:label];
		_lblTitle = label;
		
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.left.equalTo(self->vCont).offset(pd + 2);
			make.right.equalTo(self->vCont).offset(-pd);
		}];
		
		UIView *line = [[UIView alloc] init];
		line.userInteractionEnabled = NO;
		line.clipsToBounds = YES;
		line.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[vCont addSubview:line];
		[line mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(label.mas_bottom).offset(pd);
			make.left.right.equalTo(self->vCont);
			make.height.mas_equalTo(1 / SCALE);
//			make.leading.equalTo(label.mas_leading);
//			make.width.mas_equalTo(40);
//			make.height.mas_equalTo(2);
		}];
	}
	
	{
		// loading view
		UIView *view = [[UIView alloc] init];
		[vCont addSubview:view];
		vIndicator = view;
		
		UILabel *label = [[UILabel alloc] init];
		label.font = [UIFont systemFontOfSize:15];
		label.textAlignment = NSTextAlignmentCenter;
		label.textColor = [UIColor grayColor];
		label.text = NSLocalizedString(@"Loading", nil);
		[view addSubview:label];
		
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[view addSubview:indicator];
		[indicator startAnimating];
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.center.equalTo(self->vCont);
			make.left.right.equalTo(self->vCont);
		}];
		
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(view);
			make.left.right.equalTo(view);
		}];
		
		[indicator mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(label.mas_bottom).offset(6);
			make.centerX.equalTo(view);
			make.bottom.equalTo(view);
		}];
	}
	
	{
		// INJECT JS TO FORBID CALLOUT AND SELECTION
		NSMutableString *js = [[NSMutableString alloc] initWithCapacity:1];
		[js appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
		[js appendString:@"document.documentElement.style.webkitUserSelect='none';"];
		[js appendString:@"document.getElementsByTagName('h1')[0].style.fontSize='1.2em';"];
		WKUserScript *script = [[WKUserScript alloc] initWithSource:js
													  injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
												   forMainFrameOnly:YES];
		
		WKPreferences *pref = [[WKPreferences alloc] init];
		pref.javaScriptEnabled = YES;
		pref.javaScriptCanOpenWindowsAutomatically = NO;
		
		WKWebViewConfiguration *webconf = [[WKWebViewConfiguration alloc] init];
		webconf.allowsInlineMediaPlayback = NO;
		if (@available(iOS 9.0, *)) {
			webconf.allowsAirPlayForMediaPlayback = NO;
		}
		[webconf.userContentController addUserScript:script];
		
		// CREATE WEB VIEW
		WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webconf];
		[vCont addSubview:webview];
		web = webview;
		web.navigationDelegate = self;
		web.UIDelegate = self;
		web.hidden = YES;
		[webview mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self->_lblTitle.mas_bottom).offset(pd * 2 + 2);
			make.left.right.equalTo(self->vCont);
		}];
	}
	
	{
		// MARK: BUTTON CONFIRM
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		button.titleLabel.font = [UIFont systemFontOfSize:18];
		[button setContentEdgeInsets:UIEdgeInsetsMake(0, pd, 0, pd)];
		[button setTitle:NSLocalizedString(@"Agree", nil) forState:UIControlStateNormal];
		[vCont addSubview:button];
		btnConfirm = button;
		
		[btnConfirm addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		
		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.bottom.equalTo(self->vCont);
			make.height.mas_equalTo(44);
		}];
	}
}

// MARK: - METHOD

+ (BOOL)userAgreedPrivacyPolicy {
	return [[NSUserDefaults standardUserDefaults] boolForKey:LYPrivacyPolicyAgreed];
}

- (void)loadContent {
	[web loadRequest:[NSURLRequest requestWithFormat:@"%@", _URLString]];
}

// MARK: OVERWRITE

- (void)show {
	[self loadContent];
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:LYPrivacyPolicyAgreed] == NO) {
		self.hidden = NO;
		cBg.alpha = vCont.alpha = 1;
		vCont.center = (CGPoint){WIDTH * 0.5, HEIGHT * 0.5};
		if ([self superview] == nil) {
			// SUPER VIEW = WINDOW
			[[UIApplication sharedApplication].keyWindow addSubview:self];
		}
		[[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
		
		[web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
		
		/*
		__weak LYPrivacyPop *weakSelf = self;
		nmgr = [AFNetworkReachabilityManager managerForDomain:domain];
		[nmgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
			switch (status) {
				case AFNetworkReachabilityStatusUnknown: {
				} break;
				case AFNetworkReachabilityStatusNotReachable: {
				} break;
				case AFNetworkReachabilityStatusReachableViaWiFi:
				case AFNetworkReachabilityStatusReachableViaWWAN: {
					NSLog(@"reachable");
					[weakSelf loadContent];
				} break;
				default: {
				} break;
			}
		}];
		[nmgr startMonitoring];
		*/
		
	} else {
		// PASS
	}
}

- (void)dismiss {
	
	// ANIMATE OUT
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self->cBg.alpha = 0;
		self->vCont.alpha = 0;
	} completion:^(BOOL finished) {
		// REMOVE SELF
		[self->web removeObserver:self forKeyPath:@"estimatedProgress"];
		[self removeFromSuperview];
	}];
	
	/*
	[nmgr stopMonitoring];
	nmgr = nil;
	*/
	
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:LYPrivacyPolicyAgreed];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

// MARK: PRIVATE METHOD

// MARK: - DELEGATE

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
	
	if ([keyPath isEqualToString:@"estimatedProgress"] && object == web) {
		if (web.estimatedProgress >= 1.0f) {
			// DELAY ONE SECOND TO DISMISS PROGRESS BAR
			web.hidden = NO;
			vIndicator.hidden = YES;
		}
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

// MARK: WKNavigationDelegate

// MARK: WKUIDelegate

@end
