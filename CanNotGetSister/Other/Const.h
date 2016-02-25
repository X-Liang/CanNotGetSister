#import <UIKit/UIKit.h>
/// 帖子类型
typedef NS_ENUM(NSUInteger, TopicType) {
    TopicTypeAll = 1,
    TopicTypePicture = 10,
    TopicTypeWorld = 29,
    TopicTypeVoice = 31,
    TopicTypeVideo = 41,
};

UIKIT_EXTERN CGFloat const TagsViewHeight;
UIKIT_EXTERN CGFloat const TagsViewY;

UIKIT_EXTERN CGFloat const TopicCellMargin;
UIKIT_EXTERN CGFloat const TopicCellTextContentMinY;
UIKIT_EXTERN CGFloat const TopicCellBottomBarHeight;
UIKIT_EXTERN CGFloat const TopicCellPictureMaxHeight;
UIKIT_EXTERN CGFloat const TopicCellPictureDefaultHeight;

/// User 模型中的性别属性值
UIKIT_EXTERN NSString * const UserSexMale;
UIKIT_EXTERN NSString * const UserSexFemale;

// tabBar 被点击的控制的索引
UIKIT_EXTERN NSString * const TabBarSelectedViewControllerAtIndex;
// tabBar 被点击的控制器
UIKIT_EXTERN NSString * const TabBarSelectedViewController;
// tabBar 被点击的控制的通知
UIKIT_EXTERN NSString * const TabBarDidSelectedNotification;