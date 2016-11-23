
#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface TrainingViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@interface TrainingViewController : UIViewController
@property Training *training;
@end

