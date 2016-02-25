#import <UIKit/UIKit.h>
CGFloat const TagsViewHeight = 35.f;
CGFloat const TagsViewY = 64;

/// 精华 Cell 的间距
CGFloat const TopicCellMargin = 10;
CGFloat const TopicCellTextContentMinY = 66;
CGFloat const TopicCellBottomBarHeight = 35;
/// 图片帖子中图片内容的最大高度
CGFloat const TopicCellPictureMaxHeight = 1024;
/// 图片帖子中图片内容当超过最大高度时, 默认使用的图片的高度
CGFloat const TopicCellPictureDefaultHeight = 250;

NSString * const UserSexMale = @"m";
NSString * const UserSexFemale = @"f";

// tabBar 被点击的控制的索引
NSString * const TabBarSelectedViewControllerAtIndex = @"TabBarSelectedViewControllerAtIndex";
// tabBar 被点击的控制器
NSString * const TabBarSelectedViewController = @"TabBarSelectedViewController";
// tabBar 被点击的控制的通知
NSString * const TabBarDidSelectedNotification = @"TabBarDidSelectedNotification";