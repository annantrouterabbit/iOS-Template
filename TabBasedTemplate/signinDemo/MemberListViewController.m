//
//  MemberListViewController.m
//  signinDemo
//
//  Created by Annant Gupta on 5/9/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "MemberListViewController.h"
#import <SWRevealViewController.h>

@interface MemberListViewController ()

@end

@implementation MemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LeftMenu"]style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    _dataArray = [[NSMutableArray alloc]initWithCapacity:3];
    [_dataArray insertObject:[NSMutableArray arrayWithObjects:@"Dhiren Patel", @"Bhaskar Rao" ,nil] atIndex:0];
    [_dataArray insertObject:[NSMutableArray arrayWithObjects:@"Ankit pundhir", @"Darshit Thesiya",nil] atIndex:1];
    [_dataArray insertObject:[NSMutableArray arrayWithObjects:@"Annant Gupta", @"Rahul Pawar",@"Shivam Agarwal",nil] atIndex:2];
    _memberType =[[NSArray alloc]initWithObjects:@"Manager",@"Senior Software Developer", @"Junior Software Developer" ,nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_memberType count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataArray objectAtIndex:section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:17];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)setupTable{
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.table.backgroundColor = [UIColor whiteColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_memberType objectAtIndex:section];
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
