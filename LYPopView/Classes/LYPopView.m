//
//  LYPopView.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 19/12/2016.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYPopView.h"
#import "PopView.h"
#import <LYPopView/NSBundle+PopView.h>
#import "FCFileManager.h"

NSString *const LIB_POPVIEW_BUNDLE_ID = @"org.cocoapods.LYPopView";
NSString *const NAME_CONF_POPVIEW = @"conf-pop-view-style";

NSString *const confValue = @"conf-value";

@interface LYPopView () {
	
	__weak UIControl *cBg;
	
	__weak UIView *vCont;
	
	__weak UIView *vTitle;
}

@end

@interface UIColor (Hex)
+ (UIColor *)pv_hex:(NSString *)hexstring;
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
	CGFloat padding = [conf[@"popview-padding"][confValue] integerValue];
	CGFloat cornerRadius = [conf[@"popview-corner-radius"][confValue] integerValue];
	
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
		viewCont.backgroundColor = [UIColor pv_hex:conf[@"popview-window-bg-color"][confValue]];
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
		CGFloat width = vCont.bounds.size.width;
		
		UIView *viewTitle = [[UIView alloc] init];
		viewTitle.frame = (CGRect){0, 0, width, 44};
		viewTitle.backgroundColor = [UIColor pv_hex:conf[@"popview-theme-color"][confValue]];
		[vCont addSubview:viewTitle];
		vTitle = viewTitle;
		
		UILabel *labelTitle = [[UILabel alloc] init];
		labelTitle.frame = (CGRect){10, 0, width - 20, 44};
		labelTitle.textColor = [UIColor pv_hex:conf[@"popview-title-color"][confValue]];
		labelTitle.textAlignment = NSTextAlignmentCenter;
		labelTitle.font = [UIFont systemFontOfSize:16];
		[viewTitle addSubview:labelTitle];
		_lblTitle = labelTitle;
		
		UIButton *buttonClose = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonClose.frame = (CGRect){width - 44, 0, 44, 44};
		[buttonClose setBackgroundImage:[[UIImage imageNamed:@"cross-48-gs" inBundle:[NSBundle popResourceBundle] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
		[buttonClose setTintColor:[UIColor pv_hex:conf[@"popview-title-color"][confValue]]];
		[buttonClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
		[viewTitle addSubview:buttonClose];
	}
}

// MARK: - METHOD

- (void)show {
	
	self.hidden = NO;
	cBg.alpha = 0;
	CGPoint center = vCont.center;
	center.y = vCont.bounds.size.height / 2 + [UIScreen mainScreen].bounds.size.height;
	vCont.center = center;
	
	if ([self superview] == nil) {
		// SUPER VIEW = WINDOW
		[[UIApplication sharedApplication].keyWindow addSubview:self];
	}
	
	center.y = self.bounds.size.height / 2;
	
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		cBg.alpha = 1;
		vCont.center = center;
	} completion:^(BOOL finished) {
		
	}];
}

// MARK: | PRIVATE METHOD

- (void)dismiss {
	
	CGPoint center = vCont.center;
	center.y = - vCont.bounds.size.height / 2;
	
	// ANIMATE OUT
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		
		cBg.alpha = 0;
		vCont.center = center;
		
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

// MARK: - COLOR

@implementation UIColor (Hex)
+ (UIColor *)pv_hex:(NSString *)hexstring {
	// WE FOUND AN EMPTY STRING, WE ARE RETURNING NOTHING
	if (hexstring.length == 0) {
		return nil;
	}
	
	// CHECK FOR HASH AND ADD THE MISSING HASH
	if('#' != [hexstring characterAtIndex:0]) {
		hexstring = [NSString stringWithFormat:@"#%@", hexstring];
	}
	
	// RETURNING NO OBJECT ON WRONG ALPHA VALUES
	NSArray *validHexStringLengths = @[@7,];
	NSNumber *hexStringLengthNumber = [NSNumber numberWithUnsignedInteger:hexstring.length];
	if ([validHexStringLengths indexOfObject:hexStringLengthNumber] == NSNotFound) {
		return nil;
	}
	
	unsigned value = 0;
	NSScanner *hexValueScanner = nil;
	
	NSString *redHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(1, 2)]];
	hexValueScanner = [NSScanner scannerWithString:redHex];
	[hexValueScanner scanHexInt:&value];
	unsigned redInt = value;
	hexValueScanner = nil;
	
	NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(3, 2)]];
	hexValueScanner = [NSScanner scannerWithString:greenHex];
	[hexValueScanner scanHexInt:&value];
	unsigned greenInt = value;
	hexValueScanner = nil;
	
	NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(5, 2)]];
	hexValueScanner = [NSScanner scannerWithString:blueHex];
	[hexValueScanner scanHexInt:&value];
	unsigned blueInt = value;
	hexValueScanner = nil;
	
	return [UIColor colorWithRed:redInt/255.0f green:greenInt/255.0f blue:blueInt/255.0f alpha:1.0f];
}
@end
