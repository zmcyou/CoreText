//
//  XMExclusionView.m
//  CoreText
//
//  Created by Mi on 17/01/2017.
//  Copyright © 2017 zmcyou. All rights reserved.
//

#import "XMExclusionView.h"

@implementation XMExclusionView

- (UIBezierPath *)roundPath
{
    if (_roundPath == nil)
    {
        CGSize size = self.bounds.size;
        CGFloat radius = MAX(size.width, size.height) * 0.5 - 3;
        _roundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width / 2, size.height / 2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }
    
    return _roundPath;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(currentContext, YES);
    [[UIColor blueColor] setFill];
    [self.roundPath fill];
}

@end
