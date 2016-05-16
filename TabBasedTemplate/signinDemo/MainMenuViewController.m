//
//  MainMenuViewController.m
//  signinDemo
//
//  Created by Annant Gupta on 5/9/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "MainMenuViewController.h"
#import "LoginViewController.h"
#import "StripeCreateCardViewController.h"
#import "PayPalViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuItems = @[NSLocalizedString(@"Menu Item 1",@""),
                       NSLocalizedString(@"Menu Item 2",@""),
                       NSLocalizedString(@"Make Payment",@""),
                       NSLocalizedString(@"Logout",@"")];
    [self setupTable];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    SWRevealViewController *revealController = self.revealViewController;
//    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    [self refreshHeader];
    
}

-(void)refreshHeader{
    self.userAccountFullName.text = @"Annant Gupta";
    self.userAccountEmail.text = @"annant@gmail.com";
    NSString * profileImageUrl = @"defaultUser";
    if (![profileImageUrl isEqual:[NSNull null]])
        //     [_userAccountHeaderImage setImageWithURL:[NSURL URLWithString:ownedAccount.profileImageUrl]];
        _userAccountHeaderImage.image =[UIImage imageNamed:profileImageUrl];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.menuItems count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:17];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            
            NSLog(@"Menu Item 1 is selected");
            
            break;
        }
            
        case 1:
        {
            PayPalViewController *payPalViewController = [[PayPalViewController alloc] init];
            SWRevealViewController *revealViewController = (SWRevealViewController*)self.parentViewController;
            [((UINavigationController*)((UITabBarController*)revealViewController.frontViewController).selectedViewController) pushViewController:payPalViewController animated:NO];
            [revealViewController revealToggleAnimated:YES];

            break;
        }
        case 2:
        {
            StripeCreateCardViewController *stripePayment = [[StripeCreateCardViewController alloc]initWithNibName:@"StripeCreateCardViewController" bundle:nil
                                                         ];
            SWRevealViewController *revealViewController = (SWRevealViewController*)self.parentViewController;
            [((UINavigationController*)((UITabBarController*)revealViewController.frontViewController).selectedViewController) pushViewController:stripePayment animated:NO];
            [revealViewController revealToggleAnimated:YES];
            break;
        }
        case 3:
        {
            [[FBSDKLoginManager new]logOut];
            [[GIDSignIn sharedInstance] disconnect];
            NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
            [preferences removeObjectForKey:@"LoginToken"];
            NSLog(@"logintoken: %@", [preferences objectForKey:@"LoginToken"]);
            LoginViewController *lvc = [[LoginViewController alloc]initWithNibName:@"LoginView" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:lvc];
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            keyWindow.rootViewController = navigationController;
            break;
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_mainMenuHeader) {
        [[NSBundle mainBundle] loadNibNamed:@"MainMenuHeader" owner:self options:nil];
        _userAccountFullName.text = @"Annant Gupta";
        _userAccountEmail.text = @"annant@gmail.com";
        NSString * profileImageUrl = @"defaultUser";
        if (![profileImageUrl isEqual:[NSNull null]]){
            _userAccountHeaderImage.image =[UIImage imageNamed:profileImageUrl];
            
        }else{
            _userAccountHeaderImage.image = [UIImage imageNamed:@"defaultUser"];
        }
        _userAccountHeaderImage.layer.cornerRadius = _userAccountHeaderImage.bounds.size.width/2.0;
        // _userAccountHeaderImage.layer.borderColor = [[UIColor alloc]initWithRed:122.0/255.0 green:76.0/255.0 blue:117.0/255.0 alpha:1.0].CGColor;
        //_userAccountHeaderImage.layer.borderWidth = 2.0f;
        _userAccountHeaderImage.clipsToBounds = YES;
        //  _userAccountHeaderImage.backgroundColor = [UIColor whiteColor];
        
        /*
         UIView *separator = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
         separator.backgroundColor = [[UIColor alloc]initWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
         [self.userAccountHeader addSubview:separator];
         */
        self.mainMenuHeader.backgroundColor = [UIColor clearColor];
    }
    //self.userAccountHeader.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    //[self.userAccountHeader sizeToFit];
    
    return self.mainMenuHeader;
    
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
-(void)setupTable{
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.table.backgroundColor = [UIColor whiteColor];
}

@end
