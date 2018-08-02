//
//  QiButtonDetailViewController.m
//  QiButton
//
//  Created by wangyongwang on 2018/8/2.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiButtonDetailViewController.h"

#import "UIButton+touch.h"

#import "WWConfiguration.h"
#import "WWButton.h"
#import "WWTouchCancelView.h"

static NSInteger kContentModeIndex = 0;
static NSInteger kCount = 0;
static NSInteger kAnimateCurrent = 0;
static NSInteger kKeyAnimateCurrent = 0;
static CGFloat kNavStatusH = 0.0;
static NSInteger kButtonEventTouchOrder = 0;

@interface QiButtonDetailViewController ()
/** 按钮类型TableView */
@property (nonatomic,strong) UITableView *buttonTypeTableView;
/** ContentModeButton */
@property (nonatomic,strong) UIButton *contentModeButton;
/** 增大热区的按钮的显示计数的label */
@property (nonatomic,strong) UILabel *enlargeButtonClickAreaContainerLabel;

/**TableView数据数组*/
@property (nonatomic,copy) NSArray *titleArray;
/** 承载button的可变数组 */
@property (nonatomic,strong) NSMutableArray *buttonArrayM;
/** contentModeArray */
@property (nonatomic,copy) NSArray *contentModeArray;
/** 计数label */
@property (nonatomic,strong) UILabel *countLabel;

@end

@implementation QiButtonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self setupUI];
    
}
- (void)dealloc{
    WWLog();
}


- (void)prepareData{
    self.titleArray = @[@"UIButton基础使用",@"UIButton ContentMode",@"UIButton 多个状态点击",@"UIButton 动画",
                        @"UIButton 扩大点击区域",@"UIButton 图片文字排列",@"UIButton image缓存",@"UIButton 自己实现"];
    self.buttonArrayM = [NSMutableArray arrayWithCapacity:9];
    _contentModeArray =     @[@"UIViewContentModeScaleToFill",@"UIViewContentModeScaleAspectFit",@"UIViewContentModeScaleAspectFill",@"UIViewContentModeRedraw",
                              @"UIViewContentModeCenter",@"UIViewContentModeTop",@"UIViewContentModeBottom",@"UIViewContentModeLeft",
                              @"UIViewContentModeRight",@"UIViewContentModeTopLeft",@"UIViewContentModeTopRight",@"UIViewContentModeBottomLeft",
                              @"UIViewContentModeBottomRight"];
    kCount = 0;
    kAnimateCurrent = 0;
    kNavStatusH =  self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
}



- (void)setupUI{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.buttonType) {
        case WWButtonTypeNormal:
        {
            [self buttonBasicUse];
            break;
        }
        case WWButtonTypeContentMode:
        {
            [self buttonContentMode];
            break;
        }
        case WWButtonTypeClickState:
        {
            [self buttonClickState];
            break;
        }
        case WWButtonTypeAnimation:
        {
            [self buttonAnimate];
            break;
        }
        case WWButtonTypeEnlargeClickedArea:
        {
            [self buttonEnlargeClickArea];
            break;
        }
        case WWButtonTypeImageTextArrange:
        {
            [self buttonImageTextArrage];
            break;
        }
        case WWButtonTypeImageCache:
        {
            [self buttonImageCache];
            break;
        }
        case WWButtonTypeSelfRealize:
        {
            break;
        }
        default:
            break;
    }
}

#pragma mark - 九宫格样式的button排列
- (void)buttonNinePalaceMap{
    NSInteger value = 0;
    CGFloat btnWH = 120.f;
    for (NSInteger row = 0; row < 3; row ++) {
        for (NSInteger col = 0; col < 3; col ++) {
            value ++;
            UIButton *btn = [UIButton new];
            [self.view addSubview:btn];
            btn.frame = CGRectMake(col * btnWH, row * btnWH, btnWH, btnWH);
            [btn setTitle:[NSString stringWithFormat:@"%zd",value] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:48.f weight:UIFontWeightBold];
            btn.backgroundColor = [UIColor colorWithRed:((arc4random() % 256)/255.f) green:((arc4random() % 256)/255.f) blue:((arc4random() % 256)/255.f) alpha:1.f];
        }
    }
}

#pragma mark - UIButton 基础使用
- (void)buttonBasicUse{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *buttonTypeArr = @[@"UIButtonTypeCustom",
                               @"UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0)",
                               @"UIButtonTypeDetailDisclosure",
                               @"UIButtonTypeInfoLight",
                               @"UIButtonTypeInfoDark",
                               @"UIButtonTypeContactAdd",
                               @"UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos)",
                               @"UIButtonTypeRoundedRect = UIButtonTypeSystem"];
    NSInteger k = 0;
    CGFloat kButtonWidth = [UIScreen mainScreen].bounds.size.width / 3.f;
    CGFloat kButtonHeight = ([UIScreen mainScreen].bounds.size.height -self.navigationController.navigationBar.frame.size.height) / 3.f;
    
    for (NSInteger row = 0; row < 3; row ++) {
        for (NSInteger col = 0; col < 3; col ++) {
            if (k > 7) {
                k = 7;
            }
            UIButton *btn = [UIButton buttonWithType:k];
            [self.buttonArrayM addObject:btn];
            btn.tag = k;
            [self.view addSubview:btn];
            btn.frame = CGRectMake(kButtonWidth *col, kButtonHeight * row, kButtonWidth, kButtonHeight);
            [btn setTitle:buttonTypeArr[k] forState:UIControlStateNormal];
            if (row == 2 && col == 2) {
                btn.tag = 8;
                [btn setTitle:@"复位" forState:UIControlStateNormal];
            }
            btn.titleLabel.numberOfLines = 0;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            k++;
            if (k == 4 || k == 5) {
                //此处看起来的 Dark 和 Light确实是一个暗一个亮，不过并不像是简单的理解的一个亮一个暗
                [btn setBackgroundColor:[UIColor blueColor]];
            }else{
                [btn setBackgroundColor:[[UIColor redColor]colorWithAlphaComponent: 1.0/9.0 * k]];
            }
        }
    }
}

#pragma mark - buttonContentMode
- (void)buttonContentMode{
    
    NSInteger value = 0;
    CGFloat btnWH = 120.f;
    CGFloat margin = 8.f;
    for (NSInteger row = 0; row < 5; row ++) {
        for (NSInteger col = 0; col < 3; col ++) {
            UIButton *btn = [UIButton new];
            [self.view addSubview:btn];
            [btn setImage:[UIImage imageNamed:@"ninePalacePatch"] forState:UIControlStateNormal];
            btn.imageView.contentMode = value;
            btn.frame = CGRectMake(col * (btnWH + margin), row * (btnWH + margin), btnWH, btnWH);
            value ++;
            if (value >= 12) {
                value = 12;
            }
        }
    }
}

#pragma mark - button 点击状态
- (void)buttonClickState{
    //学习网址：https://www.jianshu.com/p/57b2c41448bf
    UIButton *stateBtn = [UIButton new];
    stateBtn.timeInterval = 2.f;
    [self.view addSubview:stateBtn];
    stateBtn.frame = CGRectMake(0.f, 0.f, 300.f, 300.f);
    stateBtn.backgroundColor = [UIColor lightGrayColor];
    [stateBtn setImage:
     [UIImage imageNamed:@"praise_normal"]
              forState:UIControlStateNormal];
    [stateBtn setImage:[UIImage imageNamed:@"praise_sel"]
              forState:UIControlStateSelected];
    //设置选中状态的高亮状态
    [stateBtn setImage:[UIImage imageNamed:@"praise_highlighted"]
              forState:UIControlStateSelected|UIControlStateHighlighted];
    [stateBtn setImage:[UIImage imageNamed:@"praise_highlighted"]
              forState:UIControlStateHighlighted];
    [stateBtn addTarget:self
                 action:@selector(stateButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    
    //这个按钮没有做处理 点击间隔时间的控制
    UIButton *stateBtn2 = [UIButton new];
    [self.view addSubview:stateBtn2];
    stateBtn2.frame = CGRectMake(0.f, 350.f, 300.f, 300.f);
    //    stateBtn2.center = self.view.center;
    stateBtn2.backgroundColor = [UIColor lightGrayColor];
    [stateBtn2 setImage:[UIImage imageNamed:@"praise_normal"] forState:UIControlStateNormal];
    [stateBtn2 setImage:[UIImage imageNamed:@"praise_sel"] forState:UIControlStateSelected];
    //UIControlStateSelected
    //设置选中状态的高亮状态
    [stateBtn2 setImage:[UIImage imageNamed:@"praise_highlighted"] forState:UIControlStateHighlighted];
    [stateBtn2 addTarget:self action:@selector(stateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _countLabel = [UILabel new];
    _countLabel.backgroundColor = [UIColor darkGrayColor];
    _countLabel.text = @"0";
    _countLabel.font = [UIFont systemFontOfSize:32.f];
    [self.view addSubview:_countLabel];
    _countLabel.frame = CGRectMake(0, 0, 300.f, 40.f);
    _countLabel.center = self.view.center;
    
}


#pragma mark - button 动画
- (void)buttonAnimate{
    CGFloat navStatusH =  self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    UIButton *animateBtn = [UIButton new];
    [animateBtn setTitle:@"scale move rotate" forState:UIControlStateNormal];
    [self.view addSubview:animateBtn];
    animateBtn.backgroundColor = [UIColor blueColor];
    animateBtn.frame = CGRectMake(0, 0, 150.f, 150.f);
    
    CGPoint animateBtnCenter = self.view.center;
    animateBtnCenter.y -= navStatusH/2.f;
    ////(总的高度 - 导航的高度)/2
    //    animateBtnCenter.y =((self.view.frame.size.height - navStatusH)/2.f);
    animateBtn.center = animateBtnCenter;
    [animateBtn addTarget:self
                   action:@selector(animateButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    UIButton *basicAnimateBtn = [UIButton new];
    [self.view addSubview:basicAnimateBtn];
    basicAnimateBtn.frame = CGRectMake(0.0, 0.0, 150.0, 150.0);
    basicAnimateBtn.backgroundColor = [UIColor purpleColor];
    [basicAnimateBtn setTitle:@"opacity position transform.scale.x" forState:UIControlStateNormal];
    basicAnimateBtn.titleLabel.numberOfLines = 0;
    [basicAnimateBtn addTarget:self action:@selector(basicAnimationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *keyAnimateBtn = [UIButton new];
    [keyAnimateBtn setTitle:@"KeyAnimate" forState:UIControlStateNormal];
    [keyAnimateBtn setImage:[UIImage imageNamed:@"QiShareLogo"] forState:UIControlStateNormal];
    [self.view addSubview:keyAnimateBtn];
    keyAnimateBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 300.0, CGRectGetMaxY(self.view.frame) - navStatusH - 150.0 - 34.0,300.0, 150.0);
    
    keyAnimateBtn.backgroundColor = [UIColor redColor];
    [keyAnimateBtn addTarget:self action:@selector(keyAnimateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - button扩大点击区域
- (void)buttonEnlargeClickArea{
    WWLog(@"");
    
    _enlargeButtonClickAreaContainerLabel = [UILabel new];
    _enlargeButtonClickAreaContainerLabel.backgroundColor = [UIColor grayColor];
    _enlargeButtonClickAreaContainerLabel.frame = CGRectMake(0, 0, 200.0, 200.0);
    [self.view addSubview:_enlargeButtonClickAreaContainerLabel];
    _enlargeButtonClickAreaContainerLabel.center = self.view.center;
    _enlargeButtonClickAreaContainerLabel.userInteractionEnabled = YES;
    
    WWButton *enlargeClickAreaBtn = [WWButton new];
    enlargeClickAreaBtn.backgroundColor = [UIColor redColor];
    [_enlargeButtonClickAreaContainerLabel addSubview:enlargeClickAreaBtn];
    enlargeClickAreaBtn.frame = CGRectMake(.0, .0, 6.0, 6.0);
    enlargeClickAreaBtn.center = CGPointMake(_enlargeButtonClickAreaContainerLabel.bounds.size.width / 2.0, _enlargeButtonClickAreaContainerLabel.bounds.size.height / 2.0);
    [enlargeClickAreaBtn addTarget:self action:@selector(enlargeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    WWButton *reduceClickAreaBtn = [WWButton new];
    reduceClickAreaBtn.ww_expandValue = 40.0;
    [self.view addSubview:reduceClickAreaBtn];
    
    reduceClickAreaBtn.frame = CGRectMake(0, 0, 100.0, 100.0);
    [reduceClickAreaBtn addTarget:self action:@selector(enlargeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    reduceClickAreaBtn.backgroundColor = [UIColor cyanColor];
    
    WWTouchCancelView *touchCancelV = [WWTouchCancelView new];
    [reduceClickAreaBtn addSubview:touchCancelV];
    touchCancelV.frame = CGRectMake(0, 0, 20.0, 20.0);
    [reduceClickAreaBtn addSubview:touchCancelV];
    touchCancelV.backgroundColor = [UIColor yellowColor];
    touchCancelV.center = reduceClickAreaBtn.center;
    
}

#pragma mark - 按钮图片文字排列
- (void)buttonImageTextArrage{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *titleImgVInsetBtn = [UIButton new];
    titleImgVInsetBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:titleImgVInsetBtn];
    [titleImgVInsetBtn setImage:[UIImage imageNamed:@"QiShareLogo"] forState:UIControlStateNormal];
    
    //如果是图片和文字的俯视图比较大的时候是可以
    titleImgVInsetBtn.frame = CGRectMake(0, 0, 300.f, 300.f);
    //    btn.frame = CGRectMake(0, 0, 200.f, 200.f);
    [titleImgVInsetBtn setTitle:@"QiShare" forState:UIControlStateNormal];
    titleImgVInsetBtn.titleLabel.backgroundColor = [UIColor redColor];
    //    btn.center = self.view.center;
    
    /**
     NSLog(@"%@",NSStringFromUIEdgeInsets(btn.imageEdgeInsets));
     NSLog(@"%@",NSStringFromUIEdgeInsets(btn.titleEdgeInsets));
     btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, )
     *  {0, 0, 0, 0}
     *  {0, 0, 0, 0}
     *
     */
    //需要先设置titleEdgeinsets 然后设置 imageEdgeinses 才行 因为知道这行代码 titleLabel的size才显示的是正常值 之前位置是有了但是size还是0
    //EdgeInsets的这种方式主要是靠的是 通过的测试得出来的结果
    titleImgVInsetBtn.titleEdgeInsets = UIEdgeInsetsMake(titleImgVInsetBtn.imageView.frame.size.height, -titleImgVInsetBtn.imageView.frame.size.width, 0, 0);
    titleImgVInsetBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, titleImgVInsetBtn.titleLabel.frame.size.height, -titleImgVInsetBtn.titleLabel.frame.size.width);
    
    UIButton *textImgVPositionBtn = [UIButton new];
    textImgVPositionBtn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textImgVPositionBtn];
    [textImgVPositionBtn setImage:[UIImage imageNamed:@"QiShareLogo"] forState:UIControlStateNormal];
    
    //如果是图片和文字的父视图比较大的时候是可以
    textImgVPositionBtn.frame = CGRectMake(50.0, 320.0, 300.0, 300.0);
    //    btn.frame = CGRectMake(0, 0, 200.f, 200.f);
    [textImgVPositionBtn setTitle:@"QiShare" forState:UIControlStateNormal];
    textImgVPositionBtn.titleLabel.backgroundColor = [UIColor cyanColor];
    //直接使用坐标系的方式 但是不能用这种方式因为一点击后马上恢复成了原来的样子 这种方式需要自己自定义继承自UIButton的类 然后在layoutSubViews中做调整
    //中心点平移多少和x平移多少都一样
    CGRect btnImgVRect = textImgVPositionBtn.imageView.frame;
    btnImgVRect.origin.y = 0;
    btnImgVRect.origin.x += (CGRectGetMidX(textImgVPositionBtn.bounds) - CGRectGetMidX(textImgVPositionBtn.imageView.frame));
    textImgVPositionBtn.imageView.frame = btnImgVRect;
    
    CGRect titleRect = textImgVPositionBtn.titleLabel.frame;
    titleRect.origin.x -= (CGRectGetMidX(textImgVPositionBtn.titleLabel.frame) - CGRectGetMidX(textImgVPositionBtn.bounds));
    titleRect.origin.y = CGRectGetMaxY(textImgVPositionBtn.imageView.frame);
    textImgVPositionBtn.titleLabel.frame = titleRect;
}

#pragma mark - button image 缓存
- (void)buttonImageCache{
    WWLog(@"");
}

- (void)btnClicked:(UIButton *)sender{
    if (sender.tag == 8) {
        [self.buttonArrayM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ((UIButton *)obj).enabled = YES;
        }];
        return;
    }
    sender.enabled = !sender.enabled;
}

- (void)handleButtonClicked{
    kCount ++;
    _countLabel.text = [NSString stringWithFormat:@"点击次数%zd",kCount];
}

- (void)stateButtonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    kCount ++;
    _countLabel.text = [NSString stringWithFormat:@"点击次数%zd",kCount];
}

#pragma mark - 按钮基础动画
- (void)basicAnimationButtonClicked:(UIButton *)sender{
    NSArray *propertyArr = @[@"opacity",@"position",@"transform.scale.x"];
    NSArray *valueArr = @[@(1.0),@(0.0),[NSValue valueWithCGPoint:CGPointMake(300.0,300.0)],[NSValue valueWithCGPoint:sender.center],@(1.0),@(0.0),[UIColor redColor],[UIColor yellowColor],@(M_PI_2 / 3.f),@(M_PI_2 / 2.f)];

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:propertyArr[(kCount % propertyArr.count)]];
    
    //    basicAnimation.removedOnCompletion = NO;
    basicAnimation.autoreverses = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    basicAnimation.duration = 1.0;
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        if(kCount >= propertyArr.count){
            kCount = 0;
        }
        basicAnimation.fromValue = valueArr[2 * (kCount)];
        basicAnimation.toValue = valueArr[2 * kCount + 1];
    }else{
        basicAnimation.fromValue = valueArr[2 * kCount + 1];
        basicAnimation.toValue = valueArr[2 * kCount];
        kCount ++;
        if(kCount >= propertyArr.count){
            kCount = 0;
        }
    }
    [sender.layer addAnimation:basicAnimation forKey:propertyArr[(kCount % propertyArr.count)]];
    basicAnimation.fillMode = kCAFillModeForwards;
    
}

#pragma mark - KeyAnimation
- (void)keyAnimateButtonClicked:(UIButton *)sender{
    if (kKeyAnimateCurrent ++ % 2) {
        // create a CGPath that implements two arcs (a bounce)
        CGMutablePathRef thePath = CGPathCreateMutable();
        CGPathMoveToPoint(thePath,NULL,74.0,74.0);
        CGPathAddCurveToPoint(thePath,NULL,74.0,500.0,
                              120.0,500.0,
                              170.0,74.0);
        CGPathAddCurveToPoint(thePath,NULL,120.0,500.0,
                              200.0,500.0,
                              340.0,74.0);
        
        CAKeyframeAnimation * theAnimation;
        
        // Create the animation object, specifying the position property as the key path.
        theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
        theAnimation.path=thePath;
        theAnimation.duration=5.0;
        
        // Add the animation to the layer.
        [sender.layer addAnimation:theAnimation forKey:@"position"];
        
        return;
    }
    
    
    // Animation 1
    CAKeyframeAnimation* widthAnim = [CAKeyframeAnimation animationWithKeyPath:@"borderWidth"];
    NSArray* widthValues = [NSArray arrayWithObjects:@1.0, @10.0, @5.0, @30.0, @0.5, @15.0, @2.0, @50.0, @0.0, nil];
    widthAnim.values = widthValues;
    widthAnim.calculationMode = kCAAnimationPaced;
    
    // Animation 2
    CAKeyframeAnimation* colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"borderColor"];
    NSArray* colorValues = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,
                            (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,  nil];
    colorAnim.values = colorValues;
    colorAnim.calculationMode = kCAAnimationPaced;
    
    // Animation group
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:colorAnim, widthAnim, nil];
    group.duration = 5.0;
    
    [sender.layer addAnimation:group forKey:@"BorderChanges"];
    
}

#pragma mark - animateButtonClicked
- (void)animateButtonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    NSInteger animateNum = kAnimateCurrent % 6;
    if (animateNum == 0 || animateNum == 1) {
        if (sender.selected) {
            [UIView animateWithDuration:1.f animations:^{
                sender.transform = CGAffineTransformScale(sender.transform, 2.f, 2.f);
            }];
        }else{
            [UIView animateWithDuration:1.f animations:^{
                sender.transform = CGAffineTransformIdentity;
            }];
        }
    }else if(animateNum == 2 || animateNum == 3){
        if (sender.selected) {
            sender.transform = CGAffineTransformMakeTranslation(100.f, 100.f);
        }else{
            sender.transform = CGAffineTransformIdentity;
        }
    }else{
        sender.transform = CGAffineTransformRotate(sender.transform, M_PI_2/3.f);
    }
    
    kAnimateCurrent ++;
}

#pragma mark - EnlargeButtonClicked
- (void)enlargeButtonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _enlargeButtonClickAreaContainerLabel.backgroundColor = [UIColor yellowColor];
        sender.backgroundColor = [UIColor blueColor];
    }else{
        _enlargeButtonClickAreaContainerLabel.backgroundColor = [UIColor grayColor];
        sender.backgroundColor = [UIColor redColor];
    }
    
}

@end
