//
//  NavigationBar.m
//  signinDemo
//
//  Created by Annant Gupta on 5/6/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "NavigationBar.h"
#import <objc/runtime.h>

@implementation NavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(void)navigationBarWithLeftMenu:(UINavigationItem *)navigationItem centerView:(UIView *)centerView menuView:(UIView *)menuView{
    UIBarButtonItem *leftMenuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LeftMenu"] landscapeImagePhone:[UIImage imageNamed:@"LeftMenu"]  style:UIBarButtonItemStylePlain target:self action:@selector(toggleMenu:)];
    [navigationItem setLeftBarButtonItem:leftMenuButton];
    [menuView setFrame:CGRectMake(-(centerView.frame.size.width-30.0f), centerView.frame.origin.y, centerView.frame.size.width-30.0f, centerView.frame.size.height)];
    [menuView needsUpdateConstraints];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreenleft:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [menuView addGestureRecognizer:swipeGesture];
    [centerView addSubview:menuView];
    objc_setAssociatedObject(leftMenuButton, "MenuView", menuView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(leftMenuButton, "centerView", centerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(swipeGesture, "centerView", centerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(leftMenuButton, "MenuHidden",  @1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
                                       
}
- (void)swipedScreenleft:(UISwipeGestureRecognizer*) swipeGesture {
//    m_pViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UIView *centerView = objc_getAssociatedObject(swipeGesture, "centerView");
    CATransition *transition = [CATransition animation];
    transition.duration = 0.75;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [centerView.layer addAnimation:transition forKey:nil];
//    [centerView addSubview:PadViewController.view];
}

+(void)toggleMenu: (id)sender{
    UIBarButtonItem *leftMenuButton  = (UIBarButtonItem *)sender;
    NSLog(@"Yeah!its working");
    NSNumber *menuHidden = objc_getAssociatedObject(leftMenuButton, "MenuHidden");
    UIView *centerView = objc_getAssociatedObject(leftMenuButton, "centerView");
//    UIView *menuView =objc_getAssociatedObject(leftMenuButton, "MenuView");
//        NSLog(@"%@", menuHidden);
        if([menuHidden isEqual: @0]){
            NSLog(@"if%@", menuHidden);
            menuHidden = @1;
            
            [UIView beginAnimations:@"animationOff" context:NULL];
            [UIView setAnimationDuration:0.5f];
//            [menuView setFrame:CGRectMake(-(centerView.frame.size.width-30.0f), centerView.frame.origin.y, menuView.frame.size.width, menuView.frame.size.height)];
//            [UIView commitAnimations];
            [centerView setFrame:CGRectMake(0, 0, centerView.frame.size.width, centerView.frame.size.height)];
            [UIView commitAnimations];

    
        } else{
            NSLog(@"else%@", menuHidden);
            menuHidden = @0;
            [UIView beginAnimations:@"animationOff" context:NULL];
            [UIView setAnimationDuration:0.5f];
//            [menuView setFrame:CGRectMake(0, 0, menuView.frame.size.width, menuView.frame.size.height)];
//            [UIView commitAnimations];
            [centerView setFrame:CGRectMake((centerView.frame.size.width-30.0f), centerView.frame.origin.y, centerView.frame.size.width, centerView.frame.size.height)];
          
            
            

        }
        objc_setAssociatedObject(leftMenuButton, "MenuHidden", menuHidden, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        NSLog(@"%@", menuHidden);
    
}
@end
