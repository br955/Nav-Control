//
//  AddCompany.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/12/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "AddCompany.h"

@interface AddCompany ()

@end

@implementation AddCompany

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)finishNamingCompany:(id)sender {
    [[DAO sharedManager]addCompany:_companyName.text stockSymbol: _stockSymbol.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_companyName release];
    [_stockSymbol release];
    [super dealloc];
}
@end
