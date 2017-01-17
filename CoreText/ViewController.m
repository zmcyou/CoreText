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
    [self createTextView];

}

- (void)createTextView
{
    NSString *string = @"fefmoo;iefj,fjieopifjpaweifjpoiawjfpoiawjfpoiawepoijawepofjapoiejfpaoiwjfpoiwefpoiwjfipowpfiojaews;lkfjaskfjkals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoifefmoo;iefj,fjieopifjpaweifjpoiawjfpoiawjfpoiawepoijawepofjapoiejfpaoiwjfpoiwefpoiwjfipowpfiojaews;lkfjaskfjkals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoikals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoi我是一个";
    // 1. Create the text storage that backs the editor
    NSDictionary* attrs = @{NSFontAttributeName:
                                [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:attrs];
    _textStorage = [XMTextStorage new];
    [_textStorage appendAttributedString:attrString];
    
    CGRect newTextViewRect = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    
    // 2. Create the layout manager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    
    // 3. Create a text container
    CGSize containerSize = CGSizeMake(newTextViewRect.size.width, CGFLOAT_MAX);
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:containerSize];
    container.widthTracksTextView = YES;
    container.heightTracksTextView = YES;
    [layoutManager addTextContainer:container];
    [_textStorage addLayoutManager:layoutManager];
    
    // 4. Create a UITextView
    _textView = [[UITextView alloc] initWithFrame:newTextViewRect
                                    textContainer:container];
    _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_textView];
    
}


- (void)testExclusionPath
{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSString *string = @"fefmoo;iefj,fjieopifjpaweifjpoiawjfpoiawjfpoiawepoijawepofjapoiejfpaoiwjfpoiwefpoiwjfipowpfiojaews;lkfjaskfjkals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoifefmoo;iefj,fjieopifjpaweifjpoiawjfpoiawjfpoiawepoijawepofjapoiejfpaoiwjfpoiwefpoiwjfipowpfiojaews;lkfjaskfjkals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoikals;fadslkjsd;lfa;dlkj;lksjepofijwep9ofujioejfipoejfpoeijfpoiwejfpoiwejpofijwepoifjpwoijfpoiwejfpoiwejfiowejfoiwejfoi我是一个";
    
    _textStorage = [XMTextStorage new];
    [_textStorage appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attrs]];
    
    NSLayoutManager *manager = [[NSLayoutManager alloc] init];
    
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX)];
    container.heightTracksTextView = YES;
    container.widthTracksTextView = YES;
    [manager addTextContainer:container];
    [_textStorage addLayoutManager:manager];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200) textContainer:container];
//    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
//    _textView.text = string;
    _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [self.view addSubview:_textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
