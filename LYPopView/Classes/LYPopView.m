//
//  LYPopView.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 19/12/2016.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYPopView.h"
#import "FCFileManager.h"

NSString *const LIB_POPVIEW_BUNDLE_ID = @"org.cocoapods.LYPopView";
NSString *const NAME_CONF_POPVIEW = @"conf-pop-view-style";

@interface LYPopView () {
	
	__weak UIControl *cBg;
	
	__weak UIView *vCont;
	
	__weak UIView *vTitle;
}

@end

@implementation LYPopView

// MARK: - INIT

- (instancetype)initWithFrame:(CGRect)frame {
	frame.origin = CGPointZero;
	frame.size = [UIScreen mainScreen].bounds.size;
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	self.backgroundColor = [UIColor clearColor];
	self.clipsToBounds = YES;
	
	NSDictionary *conf = [self configurations];
	
	CGSize screen = [UIScreen mainScreen].bounds.size;
	CGFloat padding = [conf[@"popview-padding"][@"conf-value"] integerValue];
	CGFloat cornerRadius = [conf[@"popview-corner-radius"][@"conf-value"] integerValue];
	
	{
		UIControl *ctrlBg = [[UIControl alloc] init];
		ctrlBg.frame = (CGRect){0, 0, screen.width, screen.height};
		ctrlBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
		[ctrlBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:ctrlBg];
		cBg = ctrlBg;
	}
	
	{
		UIView *viewCont = [[UIView alloc] init];
		viewCont.backgroundColor = [UIColor whiteColor];
		viewCont.clipsToBounds = YES;
		CGFloat width = screen.width - padding * 2;
		CGFloat height = width / 0.7;
		viewCont.frame = (CGRect){padding, (screen.height - height) / 2, width, height};
		viewCont.layer.masksToBounds = YES;
		viewCont.layer.cornerRadius = cornerRadius;
		[self addSubview:viewCont];
		vCont = viewCont;
	}
	
	{
		UIView *viewTitle = [[UIView alloc] init];
		viewTitle.frame = (CGRect){0, 0, vCont.bounds.size.width, 44};
		[vCont addSubview:viewTitle];
		vTitle = viewTitle;
	}
}

// MARK: - METHOD

- (void)show {
	
	self.hidden = NO;
	cBg.alpha = 0;
	
	if ([self superview] == nil) {
		// SUPER VIEW = WINDOW
		[[UIApplication sharedApplication].keyWindow addSubview:self];
	}
	
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		cBg.alpha = 1;
	} completion:^(BOOL finished) {
		
	}];
}

// MARK: | PRIVATE METHOD

- (void)dismiss {
	
	// ANIMATE OUT
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		
		cBg.alpha = 0;
		
	} completion:^(BOOL finished) {
		
		// REMOVE SELF
		[self removeFromSuperview];
	}];
}

- (NSDictionary *)configurations {
	
	NSString *confpath;
	
	confpath = [[NSBundle mainBundle] pathForResource:NAME_CONF_POPVIEW ofType:@"plist"];
	
	if (confpath == nil || [confpath isEqualToString:@""] == YES || [FCFileManager isFileItemAtPath:confpath] == NO) {
		NSLog(@"LYPopView WARNING\n\tAPP CONFIGURATION FILE WAS NOT FOUND.\n\t%@", confpath);
		
		// FALLBACK TO LIB DEFAULT
		confpath = [[NSBundle bundleWithIdentifier:LIB_POPVIEW_BUNDLE_ID] pathForResource:NAME_CONF_POPVIEW ofType:@"plist"];
	}
	
	NSDictionary *conf = [FCFileManager readFileAtPathAsDictionary:confpath];
	
	if (conf == nil) {
		NSLog(@"LYPopView ERROR\n\tCONFIGURATION FILE WAS NEVER FOUND.");
	}
	
	return conf;
}
	
// MARK: - OVERRIDE

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/

- (void)setFrame:(CGRect)frame {
	frame = [UIScreen mainScreen].bounds;
	[super setFrame:frame];
}

// MARK: - DELEGATE

@end
