SlideViewControllerDemo
=======================

######正如下图中所见,Demo整合了Nav,Tab,ViewPager,SideView,以及TapGesture等常用容器,并且每种容器都进行了必要的封装以便于使用,当然,每一个容器都可以再次的自定义
<img src="https://github.com/DahanHu/SlideViewControllerDemo/blob/master/SlideViewControllerDemo/slide.gif" alt="SlideViewController" title="SlideViewController" width="320" height="568" /><br/>

How to use
==========

######上面说过,本Demo只是多个容器(已经在下面给出了链接)整合出来的界面,并没有对所有的容器进行再封装,所以没有实例化方法,以下是整合过程:
####1. [DHSlideMenuController](https://github.com/DahanHu/DHSlideMenuController)作为整个App的根视图ViewController<br/>
  
    DHSlideMenuController *rootVC = [DHSlideMenuController sharedInstance];
    rootVC.mainViewController = mainViewController;
    rootVC.leftViewController = leftViewController;
    rootVC.rightViewController = rightViewController;
    
####2. [DHTabBarMenuViewPager](https://github.com/DahanHu/DHTabBarMenuViewPager)作为DHSlideMenuController的mainViewController,至于leftViewController和rightViewController应该至少有一个,否则就没有意义了,对吧
  
    DHTabBarViewController *mainViewController = [[DHTabBarViewController alloc]
    initWithChildViewControllers:YourViewControllersArray 
    tabTitles:YourTitleArray tabImages:YourImagesArray 
    selectedImages:YourSelectedImagesArray 
    backgroundImage:TabBarBackgroundImageName 
    selectionIndicatorImage:SelectedTabBackgroundImageName];
    
####3. [DHMenuViewPager](https://github.com/DahanHu/DHMenuViewPager)就是ViewPager容器,我们需要把他作为DHTabBarMenuViewPager的viewControllers添加到DHMenuViewPager中去

    DHMenuPagerViewController *pagerView = [[DHMenuPagerViewController alloc]
    initWithViewControllers:YourViewControllersArray
    titles:TitleViewTitles menuBackgroundColor:YouColoredIt titleColor:YouColoredIt;

####4. 但是我们的例子是有NavigationBar的,所以就索性把DHMenuViewPager给Embed In NavigationController中去,这里我用一个继承自UINavigationController类的[NavParentController](./SlideViewControllerDemo/NavParentController.m)类来为Nav作通用配置
    
    UINavigationController [[NavTwoController alloc] initWithRootViewController:pagerView];
    
Tips
======
请留意[AppDelegate.m](./SlideViewControllerDemo/AppDelegate.m)文件,并且注意每一个容器使用的层次关系,Tab中的每一个ContentViewController都需要继承自NavParentController

Thanks
======

本Demo属于入门级,如果你有更好的实现方式,不妨fork一下,在代码中体现出来,或是我的思路和方式不可取,欢迎指正,我表示由衷的感谢!
