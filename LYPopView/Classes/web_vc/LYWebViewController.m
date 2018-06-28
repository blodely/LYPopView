//
//  LYWebViewController.m
//  LYPopView
//
//  Created by Luo Yu on 2018/6/28.
//

#import "LYWebViewController.h"
#import "LYPopView.h"

@interface LYWebViewController () {
	
}

@end

@implementation LYWebViewController

// MARK: - ACTION

// MARK: - INIT

- (void)initial {
	
	self.hidesBottomBarWhenPushed = YES;
}

- (instancetype)init {
	if (self = [super initWithNibName:@"LYWebViewController" bundle:[NSBundle bundleWithIdentifier:LIB_POPVIEW_BUNDLE_ID]]) {
		[self initial];
	}
	return self;
}

- (instancetype)initWithTitle:(NSString *)titleName andURL:(NSString *)URLString {
	if (self = [super initWithNibName:@"LYWebViewController" bundle:[NSBundle bundleWithIdentifier:LIB_POPVIEW_BUNDLE_ID]]) {
		[self initial];
		
		self.title = titleName;
		self.URLString = URLString;
	}
	return self;
}

+ (UINavigationController *)navWebWithTitle:(NSString *)titleName andURL:(NSString *)URLString {
	
	LYWebViewController *webvc = [[LYWebViewController alloc] initWithTitle:titleName andURL:URLString];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webvc];
	return nav;
}

// MARK: - VIEW LIFE CYCLE

- (void)setupConstraints {
	
	NSLayoutConstraint *leftCons = [NSLayoutConstraint constraintWithItem:_web attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
	[self.view addConstraint:leftCons];
	
	NSLayoutConstraint *rightCons = [NSLayoutConstraint constraintWithItem:_web attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
	[self.view addConstraint:rightCons];
	
	NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:_web attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
	[self.view addConstraint:topCons];
	
	NSLayoutConstraint *bottomCons = [NSLayoutConstraint constraintWithItem:_web attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
	[self.view addConstraint:bottomCons];
	
	[self.view layoutSubviews];
}

- (void)loadView {
	[super loadView];
	
	[self.view layoutIfNeeded];
	
	{
		self.navigationItem.title = self.title;
	}
	
	{
		WKWebView *webview = [[WKWebView alloc] init];
		webview.frame = self.view.bounds;
		[self.view addSubview:webview];
		_web = webview;
	}
	
	[self setupConstraints];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW.
	
	[self.view layoutIfNeeded];
	
	{
		// LOAD URL
		if (_URLString != nil && [_URLString isEqualToString:@""] == NO) {
			[_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URLString]]];
		}
	}
	
	[self.view layoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.view layoutSubviews];
}

// MARK: MEMORY MANAGEMENT

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}

// MARK: - METHOD

// MARK: PRIVATE METHOD

// MARK: - DELEGATE

// MARK:

@end
