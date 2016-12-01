
#import <UIKit/UIKit.h>

@class Training;
@class AddTrainingViewController;

@protocol AddTrainingViewControllerDelegate
- (void)addTrainingViewControllerDidCancel:(AddTrainingViewController *)controller;
- (void)addTrainingViewController:(AddTrainingViewController *)controller
                   didAddTraining:(Training *)training;
- (void)addTrainingViewController:(AddTrainingViewController *)controller
                   didEditTraining:(Training *)training;

@end

@interface AddTrainingViewController : UITableViewController

@property (strong, nonatomic) id <AddTrainingViewControllerDelegate> delegate;
@property (strong, nonatomic) Training *training;

@end
