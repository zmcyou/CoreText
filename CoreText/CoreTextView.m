//
//  CoreTextView.m
//  CoreText
//
//  Created by Mi on 03/02/2017.
//  Copyright © 2017 zmcyou. All rights reserved.
//

#import "CoreTextView.h"

@implementation CoreTextView


//layout a paragraph
//- (void)drawRect:(CGRect)rect {
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //Flip the context coordinates in iOS
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    
//    //create the path where you will draw the text
//    CGMutablePathRef path = CGPathCreateMutable();//need release
//    
//    //initialize a rectangular path
//    CGRect bounds = CGRectMake(0.0, 90.0, 200.0, 200.0);
//    CGPathAddRect(path, NULL, bounds);
//    
//    //initilize a string
//    CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
//    
//    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);//need release
//    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString);
//    
//    //color
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();//need release
//    CGFloat components[] = {1.0, 0.0, 0.0, 0.8};
//    CGColorRef red = CGColorCreate(rgbColorSpace, components);//need release
//    
//    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red);
//    
//    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(attrString);//need release
//    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);//need release
//    CTFrameDraw(frame, context);
//    
//    CFRelease(path);
//    CFRelease(attrString);
//    CFRelease(rgbColorSpace);
//    CFRelease(red);
//    CFRelease(frameSetter);
//    CFRelease(frame);
//}

//simple text label
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0f, -1.0f);
//    
//    CFStringRef string = CFSTR("春江潮水连海平，海上明月共潮生。床前明月光");
//    
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();//need release
//    CGFloat componets[] = {0.0f, 0.0f , 1.0f, 1.0f};
//    CGColorRef blue = CGColorCreate(rgbColorSpace, componets);//need release
//    
//    CFStringRef keys[] = {kCTForegroundColorAttributeName};
//    CFTypeRef values[] = {blue};
//    
//    CFDictionaryRef attributes = CFDictionaryCreate(kCFAllocatorDefault, (const void **)&keys, (const void **)values, 1, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);//need release
//    
//    CFAttributedStringRef attrString = CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);//need release
//    
//    CTLineRef line = CTLineCreateWithAttributedString(attrString);//need release
//    CGContextSetTextPosition(context, 10.0, 10.0);
//    CTLineDraw(line, context);
//    
//    CFRelease(rgbColorSpace);
//    CFRelease(blue);
//    CFRelease(attrString);
//    CFRelease(attributes);
//    CFRelease(line);
//}

//图文混排
void RunDelegateDeallocCallBack(void *refCon)
{
    
}

CGFloat RunDelegateGetAscentCallBack(void *refCon)
{
    NSString *imageName = (__bridge NSString *)refCon;
    return [[UIImage imageNamed:imageName] size].height;
}

CGFloat RunDelegateGetDecentCallBack(void *refCon)
{
    return 0;
}

CGFloat RunDelegateGetWidthCallBack(void *refCon)
{
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.width;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"2017撸起袖子加油干"];
    
    UIFont *font = [UIFont systemFontOfSize:24];
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);//need release
    
    [attString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, attString.length)];
    
    [attString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[UIColor redColor].CGColor range:NSMakeRange(0, 4)];
    
    [attString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[UIColor blueColor].CGColor range:NSMakeRange(attString.length - 3, 3)];
    
    //给图片设置CTRunDelegate, delegate 决定留给图片的空间大小
    NSString *imageName = @"milogo";
    CTRunDelegateCallbacks imageCallBacks;
    imageCallBacks.version = kCTRunDelegateVersion1;
    imageCallBacks.dealloc = RunDelegateDeallocCallBack;
    imageCallBacks.getAscent = RunDelegateGetAscentCallBack;
    imageCallBacks.getDescent = RunDelegateGetDecentCallBack;
    imageCallBacks.getWidth = RunDelegateGetWidthCallBack;
    
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallBacks, (__bridge void *)imageName);//need release
    NSMutableAttributedString *imageAttrString = [[NSMutableAttributedString alloc] initWithString:@" "];
    [imageAttrString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    [imageAttrString addAttribute:@"imageName" value:imageName range:NSMakeRange(0, 1)];
    
    [attString insertAttributedString:imageAttrString atIndex:4];
    

    CGMutablePathRef path = CGPathCreateMutable();//need release
    CGRect bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attString);//need release
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);//need release
    CTFrameDraw(frame, context);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    
    for (int i = 0; i < CFArrayGetCount(lines); i++)
    {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        
        for (int j = 0; j < CFArrayGetCount(runs); j++)
        {
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary *attributes = (NSDictionary *)CTRunGetAttributes(run);
            
            CGFloat runX = lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            
            NSString *imageName = attributes[@"imageName"];
            if (imageName)
            {
                UIImage *image = [UIImage imageNamed:imageName];
                CGRect imageDrawRect;
                imageDrawRect.size = image.size;
                imageDrawRect.origin.x = runX;
                imageDrawRect.origin.y = lineOrigin.y;
                CGContextDrawImage(context, imageDrawRect, image.CGImage);
            }
        }
    }
    
    CFRelease(fontRef);
    CFRelease(path);
    CFRelease(frameSetter);
    CFRelease(frame);
    CFRelease(runDelegate);
}


@end
