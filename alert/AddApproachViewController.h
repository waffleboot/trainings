
#import <UIKit/UIKit.h>

@class Approach;
@class AddApproachViewController;

@protocol AddApproachViewControllerDelegate <NSObject>
- (void)addApproachViewControllerDidCancel:(AddApproachViewController *)controller;
- (void)addApproachViewController:(AddApproachViewController *)controller
                   didAddApproach:(Approach *)approach;
@end

@interface AddApproachViewController : UITableViewController

@property (nonatomic, weak) id <AddApproachViewControllerDelegate> delegate;

@end
