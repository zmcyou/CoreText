//
//  XMExclusionView.m
//  CoreText
//
//  Created by Mi on 17/01/2017.
//  Copyright © 2017 zmcyou. All rights reserved.
//

#import "XMExclusionView.h"

@implementation XMExclusionView

- (UIBezierPath *)roundPathWithOrigin:(CGPoint)origin
{
    CGSize size = self.bounds.size;
    CGFloat radius = MAX(size.width, size.height) * 0.5 - 3;
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    return roundPath;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(currentContext, YES);
    [[UIColor blueColor] setFill];
    [[self roundPathWithOrigin:CGPointMake(rect.size.width / 2, rect.size.height / 2)] fill];
}

@end
