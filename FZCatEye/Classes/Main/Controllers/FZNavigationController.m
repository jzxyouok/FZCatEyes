//
//  FZNavigationController.m
//  FZCatEye
//
//  Created by 李忠 on 6/14/16.
//  Copyright © 2016 李忠. All rights reserved.
//

#import "FZNavigationController.h"

@interface FZNavigationController ()

@end

@implementation FZNavigationController

+ (void)initialize{
    
    UINavigationBar *nvbar = [UINavigationBar appearance];
    [nvbar setBarTintColor:[UIColor redColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
