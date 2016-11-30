
#import <UIKit/UIKit.h>

@class AddExerciseViewController;

@protocol AddExerciseViewControllerDelegate <NSObject>
- (void)addExerciseViewControllerDidCancel:(AddExerciseViewController *)controller;
- (void)addExerciseViewController:(AddExerciseViewController *)controller
                   didAddExercise:(NSArray *)exercises;
@end

@interface AddExerciseViewController : UITableViewController

@property (nonatomic, weak) id <AddExerciseViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *singleRepeat;
@property (strong, nonatomic) IBOutlet UITextField *singleRepeatCount;
@property (strong, nonatomic) IBOutlet UITextField *rangeRepeatFrom;
@property (strong, nonatomic) IBOutlet UITextField *rangeRepeatTo;
@property (strong, nonatomic) IBOutlet UIView *footer1;
@property (strong, nonatomic) IBOutlet UIView *footer2;

- (IBAction)addRepeat:(id)sender;
- (IBAction)addRange:(id)sender;

- (IBAction)cancel:(id)sender;

@end
