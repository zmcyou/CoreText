//
//  XMTextStorage.m
//  CoreText
//
//  Created by Mi on 17/01/2017.
//  Copyright © 2017 zmcyou. All rights reserved.
//

#import "XMTextStorage.h"

@implementation XMTextStorage
{
    NSMutableAttributedString *_backingStore;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _backingStore = [NSMutableAttributedString new];
    }
    return self;
}

#pragma subclass 必须要实现的方法
- (NSString *)string
{
    return [_backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range
{
    return [_backingStore attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    //开始编辑
    [self beginEditing];
    
     //编辑
    [_backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes  range:range changeInLength:str.length - range.length];
    
    //结束编辑
    [self endEditing];
}

- (void)setAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range
{
    [self beginEditing];
    
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    
    [self endEditing];
}

#pragma dynamic formatting
//当text发生变化时，通知layoutmanager
- (void)processEditing
{
    [self performReplacementsForRange:self.editedRange];
    [super processEditing];
}

//当编辑textview时，changedRange一般就是一个字符
- (void)performReplacementsForRange:(NSRange)changedRange
{
    NSRange lineRange1 = [[_backingStore string] lineRangeForRange:NSMakeRange(changedRange.location, 0)];
    NSRange extendedRange = NSUnionRange(lineRange1, changedRange);
    
    NSRange lineRange2 = [[_backingStore string] lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)];
    
    [self applyStylesToRange:NSUnionRange(extendedRange, lineRange2)];
}

- (void)applyStylesToRange:(NSRange)searchRange
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    UIFontDescriptor *boldFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    
    UIFont *normalFont = [UIFont fontWithDescriptor:fontDescriptor size:0];
    UIFont *boldFont = [UIFont fontWithDescriptor:boldFontDescriptor size:0];
    
    NSDictionary *normalAttributes = @{NSFontAttributeName:normalFont};
    NSDictionary *boldAttributes = @{NSFontAttributeName:boldFont};
    
    NSString *regexStr = @"\\*\\w+(\\s\\w+)*\\*";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:0 error:nil];
    [regex enumerateMatchesInString:[_backingStore string] options:0 range:searchRange usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        
        NSRange matchRange = match.range;
        [self addAttributes:boldAttributes range:matchRange];
        
        //剩下的恢复原来的属性
        if (NSMaxRange(matchRange) + 1 < self.length)
        {
            [self addAttributes:normalAttributes range:NSMakeRange(NSMaxRange(matchRange) + 1, 1)];
        }
    }];
}

@end
