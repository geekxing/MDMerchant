//
//  MDTitleView.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDTitleView.h"

#pragma mark - MDTitleViewConfiguration

// changeable
#define MDDefaultMargin                     4.f
#define MDDefaultMenuTextMargin             2.f
#define MDDefaultMenuIconMargin             2.f
#define MDDefaultMenuCornerRadius           5.f
#define MDDefaultAnimationDuration          0.2
#define MDDefaultBackgroundColor            [UIColor clearColor]
#define MDDefaultTextColor                  [UIColor blackColor]
#define MDDefaultSelectedTextColor          [UIColor blackColor]
#define MDDefaultMenuFont                   UIFontMake(12)
#define MDDefaultMenuWidth                  120.f
#define MDDefaultMenuRowHeight              40.f
#define MDDefaultMenuIconSize               12.f

@interface MDTitleViewConfiguration ()

@end

@implementation MDTitleViewConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuRowHeight = MDDefaultMenuRowHeight;
        self.menuWidth = MDDefaultMenuWidth;
        self.underLineWidth = MDDefaultMenuWidth;
        self.textColor = MDDefaultTextColor;
        self.selectedTextColor = MDDefaultSelectedTextColor;
        self.textFont = MDDefaultMenuFont;
        self.menuTextMargin = MDDefaultMenuTextMargin;
        self.menuIconMargin = MDDefaultMenuIconMargin;
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

@end


#pragma mark - MDTitleCollectionCell

@interface MDTitleCollectionCell ()

@property (nonatomic, weak) MDTitleViewConfiguration *config;
@property (nonatomic, strong) UIButton *iconTitleBtn;

@end

@implementation MDTitleCollectionCell

-(UIButton *)iconTitleBtn
{
    if (!_iconTitleBtn) {
        _iconTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconTitleBtn.userInteractionEnabled  =NO;
    }
    return _iconTitleBtn;
}

-(void)setupWithMenuName:(NSString *)menuName menuImage:(UIImage *)menuImage
{
    
    if (!menuImage) {
    }else{
        [self.iconTitleBtn setImage:menuImage forState:UIControlStateNormal];
    }
    self.iconTitleBtn.titleLabel.font = _config.textFont;
    self.iconTitleBtn.titleLabel.textAlignment = _config.textAlignment;
    [self.iconTitleBtn setTitleColor:_config.textColor forState:UIControlStateNormal];
    [self.iconTitleBtn setTitleColor:_config.selectedTextColor forState:UIControlStateSelected];
    [self.iconTitleBtn setTitle:menuName forState:UIControlStateNormal];
    [self.iconTitleBtn sizeToFit];
    self.iconTitleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -MDDefaultMenuIconMargin, 0, 0);
    self.iconTitleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -MDDefaultMenuTextMargin);
    self.iconTitleBtn.center = self.contentView.center;
    [self.contentView addSubview:self.iconTitleBtn];
}

@end


@interface MDTitleView ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView  *titleCollection;
@property (nonatomic, strong) NSMutableArray<NSString*> *titleArray;
@property (nonatomic, strong) NSMutableArray<UIImage*> *titleImageArray;
@property (nonatomic, strong) MDTitleViewDoneBlock doneBlock;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, assign) NSInteger lastSelectIdx;
@property (nonatomic, strong) NSMutableArray *selectArr;
@end

static NSString *reuseId = @"cell";

@implementation MDTitleView

+ (instancetype)showWithConfig:(MDTitleViewConfiguration *)config
                     menuArray:(NSArray<NSString*> *)menuArray
                    imageArray:(NSArray *)imageArray
                     doneBlock:(MDTitleViewDoneBlock)doneBlock
{
    MDTitleView *title = [[self alloc] init];
    [title showForConfig:config
                    menu:menuArray
          imageNameArray:imageArray
               doneBlock:doneBlock];
    return title;
}

- (void)refreshWithMenuArray:(NSArray<NSString *> *)menuArray
                  imageArray:(NSArray *)imageArray {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titleArray = [menuArray mutableCopy];
        self.titleImageArray = [imageArray mutableCopy];
        [self.titleCollection reloadData];
    });
}

- (void)refreshWithTitle:(NSString *)title image:(UIImage *)image atIndex:(NSInteger)index {
    self.titleArray[index] = title;
    if (image) {
        self.titleImageArray[index] = image;
    }
    [self.titleCollection reloadData];
}

- (void)showForConfig:(MDTitleViewConfiguration *)config
                 menu:(NSArray<NSString*> *)titleArray
       imageNameArray:(NSArray<UIImage*> *)imageNameArray
            doneBlock:(MDTitleViewDoneBlock)doneBlock
{
    _config = config;
    self.titleArray = [titleArray mutableCopy];
    self.titleImageArray = [imageNameArray mutableCopy];
    self.selectArr = [NSMutableArray array];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        [self.selectArr addObject:@0];
    }
    if (self.selectArr.count) {
        self.selectArr[0] = @1;
    }
    self.lastSelectIdx = 0;
    self.doneBlock = doneBlock;
    [self setup];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _titleCollection.size = frame.size;
}

- (void)setup {
    
    [self md_addSubviews:@[self.titleCollection, self.indicatorView]];
    //默认在评论页
    _indicatorView.width = _config.underLineWidth;
    _indicatorView.centerX = _config.menuWidth / 2;
    _indicatorView.bottom = _titleCollection.bottom;
    
    [_titleCollection reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _indicatorView.bottom = _titleCollection.bottom;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *menuImage;
    if (_titleArray.count - 1 >= indexPath.row) {
        menuImage = _titleImageArray[indexPath.row];
    }
    MDTitleCollectionCell *menuCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    menuCell.config = _config;
    menuCell.iconTitleBtn.enabled = self.isBtnEnaled;
    menuCell.iconTitleBtn.selected = [self.selectArr[indexPath.row] boolValue];
    
    [menuCell setupWithMenuName:_titleArray[indexPath.row] menuImage:menuImage];
    return menuCell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectItemAtIndex:indexPath.row];
}

#pragma mark - Action
- (void)selectItemAtIndex:(NSInteger)idx {
    [UIView animateWithDuration:.25 animations:^{
        CGFloat lineWidth = _config.underLineWidth;
        CGFloat menuWidth = _config.menuWidth;
        _indicatorView.width = lineWidth;
        _indicatorView.centerX = (idx + 0.5) * menuWidth;
    }];
    self.selectArr[_lastSelectIdx] = [NSNumber numberWithBool:NO];
    self.selectArr[idx] = [NSNumber numberWithBool:YES];
    _lastSelectIdx = idx;
    [self.titleCollection reloadData];
    if (self.doneBlock) {
        self.doneBlock(idx);
    }
}

#pragma mark - setter & getter

- (void)setCurIndex:(NSInteger)curIndex {
    _previousIndex = _curIndex;
    _curIndex = curIndex;
    [self selectItemAtIndex:curIndex];
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        //绿色的指示线
        UIView *indicatorView = [UIView new];
        indicatorView.backgroundColor = [UIColor whiteColor];
        indicatorView.height = 2;
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

-(UICollectionView *)titleCollection
{
    if (!_titleCollection) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(_config.menuWidth, _config.menuRowHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _titleCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_titleCollection registerClass:[MDTitleCollectionCell class] forCellWithReuseIdentifier:reuseId];
        _titleCollection.backgroundColor = [UIColor clearColor];
        _titleCollection.scrollEnabled = NO;
        _titleCollection.clipsToBounds = YES;
        _titleCollection.delegate = self;
        _titleCollection.dataSource = self;
    }
    return _titleCollection;
}


@end
