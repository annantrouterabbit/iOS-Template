//
//  MemberListViewController.h
//  signinDemo
//
//  Created by Annant Gupta on 5/9/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property NSMutableArray *dataArray;
@property NSArray *memberType;
@end
