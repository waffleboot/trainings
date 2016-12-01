
#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "AddExerciseViewController.h"

@interface ExerciseViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *value;
@property (strong, nonatomic) IBOutlet UILabel *pos;
@end

@interface ExerciseViewController : UITableViewController

@property (strong, nonatomic) Approach *approach;

@end
