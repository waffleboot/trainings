
#import "AddTrainingViewController.h"
#import "DataModel.h"

@interface AddTrainingViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *largePeriod;
@property (strong, nonatomic) IBOutlet UITextField *smallPeriod;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

@implementation AddTrainingViewController

- (void)viewDidLoad {
  if (self.training) {
    self.name.text = self.training.name;
    self.smallPeriod.text = [NSString stringWithFormat:@"%lu", self.training.smallPeriod];
    self.largePeriod.text = [NSString stringWithFormat:@"%lu", self.training.largePeriod];
    self.navigationItem.title = @"Тренировка";
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void)cancel:(id)sender {
  [self.view.window endEditing:YES];
  [self.delegate addTrainingViewControllerDidCancel:self];
}

- (void)done:(id)sender {
  [self.view.window endEditing:YES];
  if (self.training) {
    self.training.name = self.name.text;
    self.training.smallPeriod = [self.smallPeriod.text integerValue];
    self.training.largePeriod = [self.largePeriod.text integerValue];
    [self.delegate addTrainingViewController:self didEditTraining:self.training];
  } else {
    Training *training = [[Training alloc] init];
    training.name = self.name.text;
    training.smallPeriod = [self.smallPeriod.text integerValue];
    training.largePeriod = [self.largePeriod.text integerValue];
    [self.delegate addTrainingViewController:self didAddTraining:training];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    [self.name becomeFirstResponder];
  } else if (indexPath.row == 0) {
    [self.largePeriod becomeFirstResponder];
  } else {
    [self.smallPeriod becomeFirstResponder];
  }
}

@end
