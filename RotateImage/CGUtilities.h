//  Created by 李新星 on 15/11/27.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


// main screen's scale
#ifndef kScreenScale
#define kScreenScale CScreenScale()
#endif

// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize CScreenSize()
#endif

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth CScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight CScreenSize().height
#endif


/// Get main screen's scale.
CGFloat CScreenScale();

/// Get main screen's size. Height is always larger than width.
CGSize CScreenSize();


/// Convert degrees to radians.
static inline CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

/// Convert radians to degrees.
static inline CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}

/// Returns the center for the rectangle.
static inline CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

/// Returns the area of the rectangle.
static inline CGFloat CGRectGetArea(CGRect rect) {
    if (CGRectIsNull(rect)) return 0;
    rect = CGRectStandardize(rect);
    return rect.size.width * rect.size.height;
}

