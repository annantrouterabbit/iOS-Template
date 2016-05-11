//
//  MainMenuViewController.h
//  signinDemo
//
//  Created by Annant Gupta on 5/9/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>

@interface MainMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property NSArray *menuItems;
@property (strong, nonatomic) IBOutlet UIView *mainMenuHeader;
@property (weak, nonatomic) IBOutlet UIImageView *userAccountHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *userAccountFullName;
@property (weak, nonatomic) IBOutlet UILabel *userAccountEmail;


@end
