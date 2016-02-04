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