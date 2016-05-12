//
//  WalkthroughScreen.m
//  walkthrough
//
//  Created by Ankit Pundhir on 11/05/16.
//  Copyright © 2016 Ankit Pundhir. All rights reserved.
//

#import "WalkthroughScreen.h"

@interface WalkthroughScreen ()
{
    NSUInteger indexNumber;
    NSString *titleText;
    NSString *captionText;
    NSString *imageName;
}
@end

@implementation WalkthroughScreen

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withIndex:(NSUInteger)index withTitle:(NSString *)title withCaption:(NSString *)caption withImage:(NSString*)image{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if(!self){
            return nil;
        }
    
        indexNumber = index;
        titleText = title;
        captionText = caption;
        imageName = image;
        return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.index = indexNumber;
    self.screenTitle.text = titleText;
    self.screenCaption.text = captionText;
    self.screenImage.image = [UIImage imageNamed:imageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
