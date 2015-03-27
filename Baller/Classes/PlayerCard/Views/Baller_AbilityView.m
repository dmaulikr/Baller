//
//  Baller_AbilityView.m
//  Baller
//
//  Created by malong on 15/1/28.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#import "Baller_AbilityView.h"

@implementation Baller_AbilityView

- (void)awakeFromNib{
    self.topView.hidden = YES;
    self.leftBottomView.hidden = YES;
    self.leftTopView.hidden = YES;
    self.rightBottomView.hidden = YES;
    self.rightTopView.hidden = YES;
    self.bottomView.hidden = YES;
    self.doneButton.hidden = YES;
    self.cancel.hidden = YES;
    _showEvaluateViews = NO;
}

- (void)setShowEvaluateViews:(BOOL)showEvaluateViews{
    if (_showEvaluateViews == showEvaluateViews) {
        return;
    }
    if (self.chosedAttributes.allKeys.count) {
        [self.chosedAttributes removeAllObjects];
    }
    _showEvaluateViews = showEvaluateViews;
    self.topView.hidden = !showEvaluateViews;
    self.leftBottomView.hidden = !showEvaluateViews;
    self.leftTopView.hidden = !showEvaluateViews;
    self.rightBottomView.hidden = !showEvaluateViews;
    self.rightTopView.hidden = !showEvaluateViews;
    self.bottomView.hidden = !showEvaluateViews;
    self.doneButton.hidden = !showEvaluateViews;
    self.cancel.hidden = !showEvaluateViews;
    
}

- (NSMutableDictionary *)chosedAttributes
{
    if (!_chosedAttributes) {
        _chosedAttributes = [NSMutableDictionary new];
    }
    return _chosedAttributes;
}

- (IBAction)doneButtonAction:(id)sender {
    if (0 == self.chosedAttributes.allValues.count) {
        [Baller_HUDView bhud_showWithTitle:@"尚未选择要评价的能力"];
        return;
    }
    
    if (!_evaluatedPersonUid || !_evaluateType) {
        return;
    }


    NSMutableDictionary * parameters = self.chosedAttributes.mutableCopy;
    
    if ([_evaluateType isEqualToString:@"activity"]) {
        if (_activity_id) {
            [parameters setValue:_activity_id forKey:@"activity_id"];
        }else{
            return;
        }
        [parameters setValue:_evaluateType forKey:@"type"];
        
    }else if ([_evaluateType isEqualToString:@"friend"]){
        [parameters setValue:_evaluateType forKey:@"type"];

    }else{
        return;
    }
    [parameters setValue:_evaluatedPersonUid forKey:@"uid"];
    [parameters setValue:[USER_DEFAULT valueForKey:Baller_UserInfo_Authcode] forKey:@"authcode"];
    [AFNHttpRequestOPManager postWithSubUrl:Baller_evaluate_activity parameters:parameters responseBlock:^(id result, NSError *error) {

        if (error) {
            [Baller_HUDView bhud_showWithTitle:error.domain];
            return ;
        }
        
        if ([result intForKey:@"errorcode"] == 0) {
            self.showEvaluateViews = NO;
            [Baller_HUDView bhud_showWithTitle:@"评价成功！"];
            if (_evaluateButton)[_evaluateButton removeFromSuperview];
            
        }else{
            [Baller_HUDView bhud_showWithTitle:[result valueForKey:@"msg"]];
        }
        
    }];
    
}

- (IBAction)cancelButtonAction:(id)sender {
    self.showEvaluateViews = NO;
}


- (IBAction)shootButtonAction:(id)sender {
    
    if (![self isHaveChosedThreeAttributes]) {
        self.topView.hidden = YES;
        [self.chosedAttributes setValue:@"1" forKey:@"shoot"];
    }
}

- (IBAction)assistButtonAction:(id)sender {

    if (![self isHaveChosedThreeAttributes]) {
        self.rightTopView.hidden = YES;
        [self.chosedAttributes setValue:@"1" forKey:@"assists"];
    }
}


- (IBAction)boardButtonAction:(id)sender {
    
    if (![self isHaveChosedThreeAttributes]) {
        self.rightBottomView.hidden = YES;
        [self.chosedAttributes setValue:@"1" forKey:@"backboard"];
    }
}
- (IBAction)stealButtonAction:(id)sender {
    
    if (![self isHaveChosedThreeAttributes]) {
        self.bottomView.hidden = YES;
        [self.chosedAttributes setValue:@"1" forKey:@"steal"];
    }
}

- (IBAction)coverButtonAction:(id)sender {

    if (![self isHaveChosedThreeAttributes]) {
        self.leftBottomView.hidden = YES;
        [self.chosedAttributes setValue:@"1" forKey:@"over"];

    }
}


- (IBAction)crossButtonAction:(id)sender {

    if (![self isHaveChosedThreeAttributes]) {
        self.leftTopView.hidden = YES;
        [self.chosedAttributes setValue:@"1" forKey:@"breakthrough"];

    }
}

- (BOOL)isHaveChosedThreeAttributes
{
    BOOL isHaveThree = self.chosedAttributes.allKeys.count==3;
    if (isHaveThree) {
        [Baller_HUDView bhud_showWithTitle:@"最多只可评价三项！"];
    }
    return isHaveThree;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
