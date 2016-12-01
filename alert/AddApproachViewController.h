
#import <UIKit/UIKit.h>

@class Approach;
@class AddApproachViewController;

@protocol AddApproachViewControllerDelegate <NSObject>
- (void)addApproachViewControllerDidCancel:(AddApproachViewController *)controller;
- (void)addApproachViewController:(AddApproachViewController *)controller
                   didAddApproach:(Approach *)approach;
- (void)addApproachViewController:(AddApproachViewController *)controller
                   didEditApproach:(Approach *)approach;
@end

@interface AddApproachViewController : UITableViewController

@property (strong, nonatomic) id <AddApproachViewControllerDelegate> delegate;
@property (strong, nonatomic) Approach *approach;

@end
