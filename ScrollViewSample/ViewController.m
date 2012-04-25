//
//  ViewController.m
//  ScrollViewSample
//
//  Created by 真有 津坂 on 12/04/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//1.StoryboardにscrollViewを設置して結びつける
//2.scrollViewの上にUIパーツを設置して結びつける
//3..mに以下の「追加」と書かれている部分を書き込む

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myscrollView;
@synthesize myField;
@synthesize myLabel;
@synthesize myLabel2;
@synthesize myField2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        //追加、scrollViewのサイズを設定
    self.myscrollView.contentSize = CGSizeMake(320, 460);
    
    //以下追加、キーボードが表示されたらスクロール/消えたら元に戻るときにはNotificationを使う
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    keyboardShown = NO;
}

//以下追加、UIKeyboardDidShowNotificationが送信されたときに実行される
- (void)keyboardShow:(NSNotification *)notificatioin {
    
    if (keyboardShown) {
        return;
    }
    
    NSDictionary *info = [notificatioin userInfo];
    
    //キーボードのサイズを取得
    NSValue *keyboardValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keySize = [keyboardValue CGRectValue].size;
    
    offset = myscrollView.contentOffset;
    
    //scrollViewのサイズを変更
    CGRect scrollViewFrame = myscrollView.frame;
    scrollViewFrame.size.height -= keySize.height;
    myscrollView.frame = scrollViewFrame;
    
    //スクロールする
    CGRect textFieldRect = myField.frame;
    textFieldRect.origin.y += 10;
    [myscrollView scrollRectToVisible:textFieldRect animated:YES];
    
    keyboardShown = YES;
}

//以下追加、UIKeyboardDidHideNotificationが送信されたときに実行される
- (void)keyboardHide:(NSNotification *)notificatioin {
    if (!keyboardShown) {
        return;
    }    
    
    //scrollViewをもとに戻す
    myscrollView.frame = CGRectMake(0, 0, 320, 460);
    myscrollView.contentOffset = offset;
    keyboardShown = NO;
    
}



- (void)viewDidUnload
{
    [self setMyscrollView:nil];
    [self setMyField:nil];
    [self setMyLabel:nil];
    [self setMyLabel2:nil];
    [self setMyField2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)keyHide:(id)sender {
    myLabel.text = myField.text;
 
}

- (IBAction)keyHide2:(id)sender {
    myLabel2.text = myField2.text;
   
}
@end
