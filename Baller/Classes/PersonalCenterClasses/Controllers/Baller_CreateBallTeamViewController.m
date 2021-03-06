//
//  Baller_CreateBallTeamViewController.m
//  Baller
//
//  Created by malong on 15/1/31.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#import "Baller_CreateBallTeamViewController.h"

@interface Baller_CreateBallTeamViewController ()

@end

@implementation Baller_CreateBallTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建球队";
    
    self.createTeamCardView = [[Baller_CardView alloc]initWithFrame:CGRectMake(TABLE_SPACE_INSET, TABLE_SPACE_INSET, ScreenWidth-2*TABLE_SPACE_INSET, self.view.frame.size.height-2*TABLE_SPACE_INSET) playerCardType:kBallerCardType_CreateBasketBallTeam];
    
    if ([USER_DEFAULT valueForKey:Baller_UserInfo_HeadImageData]) {
        UIImage * headImage = [UIImage imageWithData:[USER_DEFAULT valueForKey:Baller_UserInfo_HeadImageData]];
        
        [self showBlurBackImageViewWithImage:headImage];
        [[self.createTeamCardView headImageButton]setImage:headImage forState:UIControlStateNormal];
        
    }else{
        [[self.createTeamCardView headImageButton] setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[USER_DEFAULT valueForKey:Baller_UserInfo_HeadImage]] placeholderImage:[UIImage imageNamed:@"ballPark_default"]];
        
    }
    __WEAKOBJ(weakSelf, self);
    self.createTeamCardView.bottomButtonClickedBlock = ^(BallerCardType cardType){
        [weakSelf createBallerTeam];
    };
    
    [self.view addSubview:self.createTeamCardView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 创建球场
/*!
 *  @brief  创建球场
 */
- (void)createBallerTeam{
    
    NSString * teamName = self.createTeamCardView.createTeamView.teamNameTextfield.text;
    if (![LTools isValidateName:teamName]) {
        [Baller_HUDView bhud_showWithTitle:@"请输入合适的球队名"];
        return;
    }
    
    if (!self.createTeamCardView.createTeamView.teamLogoData) {
        [Baller_HUDView bhud_showWithTitle:@"请设置球队logo"];
        return;
    }
    
    
    [AFNHttpRequestOPManager postImageWithSubUrl:Baller_team_create parameters:@{@"authcode":[USER_DEFAULT valueForKey:Baller_UserInfo_Authcode],@"team_name":teamName,@"court_id":@"4"} fileName:@"logo" fileData:self.createTeamCardView.createTeamView.teamLogoData fileType:nil responseBlock:^(id result, NSError *error)
    {
        if (error) return ;
        if ([[result valueForKey:@"errorcode"] integerValue] == 0) {
            self.basketBallTeamCreatedBlock(result);
        }
    }];
    
}

@end
