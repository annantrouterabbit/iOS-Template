//
//  WalkthroughContainer.m
//  walkthrough
//
//  Created by Ankit Pundhir on 11/05/16.
//  Copyright © 2016 Ankit Pundhir. All rights reserved.
//

#import "WalkthroughContainer.h"
#import "WalkthroughScreen.h"
#import "WalkthroughScreenDTO.h"
#import "WalkthroughIndicators.h"

@interface WalkthroughContainer ()<UIPageViewControllerDataSource>
@end

@implementation WalkthroughContainer

-(instancetype)init{
    NSLog(@"Use initInsideController");
    return nil;
}

-(instancetype)initWithPlistName:(NSString*)plistName withAnimationDuration:(NSUInteger)duration{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    self = [super initWithNibName:@"WalkthroughContainer" bundle:frameworkBundle];
    if(self){
        self.animationDuration = duration;
        self.screensDictionary = plistName;
        self.view.backgroundColor = [UIColor clearColor];
        return self;
    }
    
    return nil;
}

-(instancetype)initInsideController:(UIViewController*)controller withPlistName:(NSString*)plistName withAnimationDuration:(NSUInteger)duration{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    self = [super initWithNibName:@"WalkthroughContainer" bundle:frameworkBundle];
    if(self){
        self.animationDuration = duration;
        self.screensDictionary = plistName;
        self.view.backgroundColor = [UIColor blackColor];
        [self.view setFrame:[controller.view bounds]];
        [controller addChildViewController:self];
        [controller.view addSubview:self.view];
        [self didMoveToParentViewController:controller];
        return self;
    }
    
    return nil;
}

-(void)animateScreenWithIndex:(NSUInteger)index{
    WalkthroughScreen *initialViewController = [self viewControllerAtIndex:index];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(void)animateScreens{
    self.screenIndex++;
    if (self.screenIndex == self.screens.count) {
        self.screenIndex = 0;
    }
    [self animateScreenWithIndex:self.screenIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *walkthroughScreens = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.screensDictionary ofType:@"plist"]];
    
    
    if(walkthroughScreens){
        NSMutableArray *screens = [[NSMutableArray alloc] initWithArray:@[]];
        
        for (NSDictionary *walkthroughScreen in walkthroughScreens) {
            WalkthroughScreenDTO *screen = [[WalkthroughScreenDTO alloc] init];
            screen.title = [walkthroughScreen valueForKey:@"title"];
            screen.caption = [walkthroughScreen valueForKey:@"caption"];
            screen.image = [walkthroughScreen valueForKey:@"image"];
            [screens addObject:screen];
        }
        
        NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
        self.screenNibName = @"WalkthroughScreen";
        self.screenNibBundle = frameworkBundle;
        self.screens = screens;
        
        [self setButtonTextColor:nil];
        
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        self.pageViewController.dataSource = self;
        self.pageViewController.view.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 45);
        
        [self animateScreenWithIndex:0];
        [self addChildViewController:self.pageViewController];
        [[self view] addSubview:[self.pageViewController view]];
        [self.pageViewController didMoveToParentViewController:self];
        
        if (self.animationDuration > 0) {
            [NSTimer scheduledTimerWithTimeInterval:self.animationDuration target:self selector:@selector(animateScreens) userInfo:nil repeats:YES];
        }
    }else{
        NSLog(@"Invalid plist file.");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(WalkthroughScreen *)viewControllerAtIndex:(NSUInteger)index{
    WalkthroughScreenDTO *screenDTO = [self.screens objectAtIndex:index];
    WalkthroughScreen *screen = [[WalkthroughScreen alloc] initWithNibName:self.screenNibName bundle:self.screenNibBundle withIndex:index withTitle:screenDTO.title withCaption:screenDTO.caption withImage:screenDTO.image];
    self.screenIndex = index;
    return screen;
}


#pragma mark - UIPageViewControllerHelper

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = [(WalkthroughScreen *)viewController index];
    if(index == 0){
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(WalkthroughScreen *)viewController index];
    
    
    index++;
    
    if (index == self.screens.count) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return self.screens.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return self.screenIndex;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setButtonTextColor:(UIColor*)textColor{
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    if(!textColor){
        textColor = pageControl.currentPageIndicatorTintColor;
    }
    
    [self.login setTitleColor:textColor forState:UIControlStateNormal];
    [self.signup setTitleColor:textColor forState:UIControlStateNormal];
}


+(void)setDefaultIndicators{
    WalkthroughIndicators *indicators = [[WalkthroughIndicators alloc] init];
    [self setIndicators:indicators];
}

- (IBAction)registerAccount:(id)sender {
    if([self.delegate conformsToProtocol:@protocol(WalkthroughAuthenticationDelegate)]){
        [self.delegate didAuthenticateRegister];
    }
}

- (IBAction)loginAccount:(id)sender {
    if([self.delegate conformsToProtocol:@protocol(WalkthroughAuthenticationDelegate)]){
        [self.delegate didAuthenticateLogin];
    }
}

+(void)setIndicators:(WalkthroughIndicators*)indicators{
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    pageControl.pageIndicatorTintColor = indicators.inactiveColor;
    pageControl.currentPageIndicatorTintColor = indicators.activeColor;
    pageControl.backgroundColor = indicators.backgroundColor;
}

@end
