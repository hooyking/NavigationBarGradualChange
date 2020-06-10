# NavigationBarGradualChange

视图滚动时导航栏颜色渐变

项目跑起来后点击下方 Debug View Hierarchy按钮可看到导航栏最上方是一个UIImageView，所以这儿关键是取到这个值

self.imageView = self.navigationController.navigationBar.subviews.firstObject;

如上就取到了这个值，将这个imageView用控制器持有起来，可以给控制器持有一个属性

@property (nonatomic, strong) UIImageView *imageView;

如我这儿滚动视图用的是UIScrollView（其他所有的滚动视图都适用），在scrollViewDelegate中如下写，就可使导航栏渐变

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat minAlphaOffset = - kNavConH;
    CGFloat maxAlphaOffset = 150;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    self.imageView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:alpha];
}
