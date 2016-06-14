//
//  FZTaBarController.m
//  FZCatEye
//
//  Created by 李忠 on 6/14/16.
//  Copyright © 2016 李忠. All rights reserved.
//

#import "FZTaBarController.h"
#import "FZNavigationController.h"
#import "FZFZMoiveController.h"
#import "FZCinemaController.h"
#import "FZDiscoveryController.h"
#import "FZMineController.h"

@implementation FZTaBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI{
    FZNavigationController *movieNv = [self getNavWithVc:[[FZFZMoiveController alloc] init] withImageName:@"icon_route_car_normal" withTitle:@"电影"];
    
    FZNavigationController *cinemaNv = [self getNavWithVc:[[FZCinemaController alloc] init] withImageName:@"icon_route_car_normal" withTitle:@"影院"];
    
    
    FZNavigationController *discoveryNv = [self getNavWithVc:[[FZDiscoveryController alloc] init] withImageName:@"icon_route_car_normal" withTitle:@"发现"];
    
    FZNavigationController *mineNv = [self getNavWithVc:[[FZMineController alloc] init] withImageName:@"icon_route_car_normal" withTitle:@"我"];
    
    self.viewControllers = @[movieNv, cinemaNv, discoveryNv, mineNv];
    
    [self.tabBar setTintColor:[UIColor redColor]];
    
}

- (FZNavigationController *)getNavWithVc:(UIViewController *)vc withImageName:(NSString *)nameStr withTitle:(NSString *)title{
    
    vc.view.backgroundColor = [UIColor grayColor];
    
    FZNavigationController *nv = [[FZNavigationController alloc] initWithRootViewController:vc];
    
    nv.tabBarItem.title = title;
    nv.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_route_car_highlighted"];
    
    
    nv.tabBarItem.image = [UIImage imageNamed:nameStr];
    
    return nv;
}
@end
