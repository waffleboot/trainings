
#import <UIKit/UIKit.h>

@class Training;
@class AddTrainingViewController;

@protocol AddTrainingViewControllerDelegate <NSObject>
- (void)addTrainingViewControllerDidCancel:(AddTrainingViewController *)controller;
- (void)addTrainingViewController:(AddTrainingViewController *)controller
                   didAddTraining:(Training *)training;
@end

@interface AddTrainingViewController : UIViewController

@property (nonatomic, weak) id <AddTrainingViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
