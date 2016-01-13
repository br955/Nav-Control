//
//  EditCompany.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/13/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "EditCompany.h"

@interface EditCompany ()

@end

@implementation EditCompany

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _editText.text  = self.title;
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

- (void)dealloc {
    [_editText release];
    [super dealloc];
}
- (IBAction)finishEditing:(id)sender {
    [[DAO sharedManager]editCompany:_editText.text fromName:self.title];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
