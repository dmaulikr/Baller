//
//  Baller_BallFriendsTableViewCell.m
//  Baller
//
//  Created by malong on 15/1/31.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#import "Baller_BallFriendsTableViewCell.h"

@implementation Baller_BallFriendsTableViewCell

- (void)awakeFromNib {
    
    self.imageView.layer.cornerRadius = 4.0;
    self.imageView.layer.borderWidth = 0.5;
    self.imageView.image = [UIImage imageNamed:@"ballPark_default"];
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.borderColor = BALLER_CORLOR_b2b2b2.CGColor;
    self.textLabel.backgroundColor = CLEARCOLOR;
    self.textLabel.font = SYSTEM_FONT_S(13.0);
    self.textLabel.text = @"Brad Pitt";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        
    }else{
        
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15.0+NUMBER(18.0, 18.0, 18.0, 18.0), 9.5, 41, 41);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+25.0, 23.5, 120, 13.0);

}

- (CircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[CircleView alloc]initWithFrame:CGRectMake(NUMBER(15.0, 13.0, 10.0, 10.0), 22, 16.0, 16.0)];
        [self.contentView addSubview:_circleView];

    }
    return _circleView;
}

- (void)setChosing:(BOOL)chosing{
    _chosing = chosing;
    [self circleView].grayLayer.hidden = !chosing;
}


@end


@implementation CircleView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.width/2.0;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColorFromRGB(0x9f9f9f).CGColor;
        
        self.grayLayer = [CALayer layer];
        _grayLayer.frame = CGRectMake(frame.size.width/4.0, frame.size.height/4.0, frame.size.width/2.0,frame.size.height/2.0);
        _grayLayer.cornerRadius = frame.size.width/4.0;
        _grayLayer.backgroundColor = UIColorFromRGB(0x535353).CGColor;
        _grayLayer.hidden = YES;
        [self.layer addSublayer:_grayLayer];
    }
    return self;
}

@end
