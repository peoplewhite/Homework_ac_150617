//
//  FirstViewController.m
//  Homework_ac_150617
//
//  Created by Po-Hao Cheng on 2015/6/18.
//  Copyright (c) 2015年 phc. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    strUsername = @"sean";
    strPassword = @"111";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnStart {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"My Title"
                                                                   message:@"Hello, world"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    
    
  
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"username";
        [textField addTarget:self action:@selector(saveUsername:) forControlEvents:UIControlEventEditingChanged];
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"password";
        [textField addTarget:self action:@selector(savePassword:) forControlEvents:UIControlEventEditingChanged];
        textField.secureTextEntry = YES;
    }];
    
    
    UIAlertAction *login = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
       //在這裏下帳密判斷式
        if ([typedUsername isEqualToString:strUsername] && [typedPassword isEqualToString:strPassword]) {
            [self performSegueWithIdentifier:@"change2Album" sender:self];
        }
        else if ([typedUsername isEqualToString:strUsername] && ![typedPassword isEqualToString:strPassword]) {
           //密碼錯誤
            UIAlertController *passwordError = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                   message:@"密碼錯誤\n請重新登入"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:passwordError animated:YES completion:nil];
           
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [passwordError dismissViewControllerAnimated:YES completion:nil];
                
            }];
            [passwordError addAction:ok];
            
            
        }
        else {
            UIAlertController *passwordError = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                   message:@"查無此帳號\n請重新登入"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:passwordError animated:YES completion:nil];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [passwordError dismissViewControllerAnimated:YES completion:nil];
                
            }];
            [passwordError addAction:ok];
        }
        
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
        
    
    [alert addAction:login];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
   
}



- (void)saveUsername:(UITextField *)username {
    typedUsername = username.text;
}
- (void)savePassword:(UITextField *)password {
    typedPassword = password.text;
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
