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

@end
