
#import "AddTrainingViewController.h"
#import "DataModel.h"

@interface AddTrainingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *largePeriod;
@property (weak, nonatomic) IBOutlet UITextField *smallPeriod;
@end

@implementation AddTrainingViewController

- (void)cancel:(id)sender {
  [self.delegate addTrainingViewControllerDidCancel:self];
}

- (void)done:(id)sender {
  Training *training = [[Training alloc] init];
  training.name = self.name.text;
  training.smallPeriod = [self.smallPeriod.text integerValue];
  training.largePeriod = [self.largePeriod.text integerValue];
  [self.delegate addTrainingViewController:self didAddTraining:training];
}

@end
