
#import <UIKit/UIKit.h>

@class AddExerciseViewController;

@protocol AddExerciseViewControllerDelegate
- (void)addExerciseViewControllerDidCancel:(AddExerciseViewController *)controller;
- (void)addExerciseViewController:(AddExerciseViewController *)controller
                   didAddExercise:(NSArray<NSNumber*> *)exercises;
@end

@interface AddExerciseViewController : UITableViewController

@property (strong, nonatomic) id <AddExerciseViewControllerDelegate> delegate;

@end
