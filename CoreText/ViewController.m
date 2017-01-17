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
    
    [self testExclusionPath];

}

- (void)testExclusionPath
{
    
    _exclusionView = [[XMExclusionView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 0, 60, 60)];
    _exclusionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_exclusionView];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSString *string = @"fefmoo;iefj,fjieopifjpaweifjpoiawjfpoiawjfpoiawepoijawepofjapoiejfpaoiwjfpoiwefpoiwjfipowpfiojaews;lkfjaskfjkals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoifefmoo;iefj,fjieopifjpaweifjpoiawjfpoiawjfpoiawepoijawepofjapoiejfpaoiwjfpoiwefpoiwjfipowpfiojaews;lkfjaskfjkals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoikals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoi我是一个";
    
    _textStorage = [XMTextStorage new];
    [_textStorage appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attrs]];
    
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
    
    _textView.scrollEnabled = NO;
    _textView.scrollEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
