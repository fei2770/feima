//
//  FMEmployeeTableViewCell.m
//  feima
//
//  Created by fei on 2020/8/6.
//  Copyright © 2020 hegui. All rights reserved.
//

#import "FMEmployeeTableViewCell.h"
#import <YBPopupMenu/YBPopupMenu.h>

@interface FMEmployeeTableViewCell ()<YBPopupMenuDelegate>{
    NSArray *titles;
}

@property (nonatomic,strong) UIImageView *myImgView;
@property (nonatomic,strong) UILabel     *nameLabel;
@property (nonatomic,strong) UILabel     *typeLabel;
@property (nonatomic,strong) UIButton    *moreBtn;
@property (nonatomic, strong) YBPopupMenu *popupMenu;

@property (nonatomic,strong) FMEmployeeModel *model;

@end

@implementation FMEmployeeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark YBPopupMenuDelegate
#pragma mark 选择
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    MyLog(@"点击了 %ld 选项",index);
    [_popupMenu dismiss];
    if (self.moreBlock) {
        self.moreBlock(self.model, index);
    }
}

#pragma mark -- Event response
#pragma mark 更多
- (void)moreAction:(UIButton *)sender {
   _popupMenu = [YBPopupMenu showRelyOnView:sender titles:titles icons:nil menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = NO;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.offset = 10;
        popupMenu.type = YBPopupMenuTypeDefault;
        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }];
}

#pragma mark 填充数据
- (void)fillContentWithData:(FMEmployeeModel *)model status:(NSInteger)status{
    self.model = model;
    titles = @[@"轨迹路径",@"基本信息",@"转移客户",status == 1 ? @"禁用" : @"启用"];
    [self.myImgView sd_setImageWithURL:[NSURL URLWithString:self.model.logo] placeholderImage:[UIImage ctPlaceholderImage]];
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = [self.model.postName substringToIndex:1];
}

#pragma mark -- Private methods
- (void)setupUI {
    [self.contentView addSubview:self.myImgView];
    [self.myImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(54, 54));
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.myImgView.mas_right).offset(12);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(22);
        make.width.mas_greaterThanOrEqualTo(20);
    }];
    
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.moreBtn.mas_left).offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

#pragma mark 头像
-(UIImageView *)myImgView{
    if (!_myImgView) {
        _myImgView = [[UIImageView alloc] init];
        _myImgView.layer.cornerRadius = 27;
        _myImgView.layer.masksToBounds = YES;
    }
    return _myImgView;
}

#pragma mark 用户名
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont mediumFontWithSize:14];
        _nameLabel.textColor = [UIColor textBlackColor];
    }
    return _nameLabel;
}

#pragma mark 职务
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont regularFontWithSize:12];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.backgroundColor = [UIColor systemColor];
        _typeLabel.layer.cornerRadius = 15;
        _typeLabel.clipsToBounds = YES;
    }
    return _typeLabel;
}

#pragma mark 更多
- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:ImageNamed(@"more") forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
