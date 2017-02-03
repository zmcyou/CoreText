//
//  ViewController.m
//  CoreText
//
//  Created by Bill on 1/15/17.
//  Copyright © 2017 zmcyou. All rights reserved.
//

#import "ViewController.h"
#import "XMExclusionView.h"
#import "XMTextStorage.h"

@interface ViewController ()

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) XMExclusionView *exclusionView;
@property (strong, nonatomic) XMTextStorage *textStorage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testExclusionPath];

}

- (void)testExclusionPath
{
    
    _exclusionView = [[XMExclusionView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 0, 80, 80)];
    _exclusionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_exclusionView];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    
    //文字
    NSString *string = @"Notes on iOS7\nThis is a big change in the UI design, it's going to take a *lot* of getting used to!";
    
    //图片
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"textkit"];
    NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    _textStorage = [XMTextStorage new];
    [_textStorage appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attrs]];
    [_textStorage appendAttributedString:imageString];
    
    NSLayoutManager *manager = [[NSLayoutManager alloc] init];
    
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX)];
    container.heightTracksTextView = YES;
    container.widthTracksTextView = YES;
    container.exclusionPaths = @[[_exclusionView roundPathWithOrigin:_exclusionView.center]];
    [manager addTextContainer:container];
    [_textStorage addLayoutManager:manager];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200) textContainer:container];
    _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _textView.backgroundColor = [UIColor grayColor];
   
    [self.view insertSubview:_textView atIndex:0];
    
    //需要加上这两行代码，在文字高度大于textView高度的时候，才能显示完全（不明所以）
    _textView.scrollEnabled = NO;
    _textView.scrollEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
