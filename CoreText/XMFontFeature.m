//
//  XMFontFeature.m
//  CoreText
//
//  Created by Mi on 17/01/2017.
//  Copyright © 2017 zmcyou. All rights reserved.
//

#import "XMFontFeature.h"

@implementation XMFontFeature

+ (UIFont *)numberFont
{
    NSArray *timeFeatureSettings = @[
                                     @{
                                         UIFontFeatureTypeIdentifierKey: @(kNumberSpacingType),
                                         UIFontFeatureSelectorIdentifierKey: @(kProportionalNumbersSelector)
                                         },
                                     @{
                                         UIFontFeatureTypeIdentifierKey: @(kCharacterAlternativesType),
                                         UIFontFeatureSelectorIdentifierKey: @(2)
                                         }];
    
    UIFont *originalFont = [UIFont fontWithName: @"HelveticaNeue-Medium" size: 12.0];
    UIFontDescriptor *originalDescriptor = [originalFont fontDescriptor];
    UIFontDescriptor *timeDescriptor = [originalDescriptor
                                        fontDescriptorByAddingAttributes: @{
                                                                            UIFontDescriptorFeatureSettingsAttribute: timeFeatureSettings }];
    UIFont *timeFont = [UIFont fontWithDescriptor: timeDescriptor size: 12.0];
    
    return timeFont;
}

//创建formmater开销比较大，所以重复利用
+ (NSString *)numberFormattedString:(NSString *)string
{
    static NSNumberFormatter *_numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    });
   
    return [_numberFormatter stringFromNumber:@(string.floatValue)];
}

- (void)checkFontFeature
{
    UIFont *font = [UIFont fontWithName: @"HelveticaNeue-Medium" size: 12.0];
    CFArrayRef fontFeatures = CTFontCopyFeatures((__bridge CTFontRef) font);
    NSLog(@"properties = %@", fontFeatures);
}

@end
