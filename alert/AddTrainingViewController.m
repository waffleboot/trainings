
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
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
  tap.cancelsTouchesInView = NO;
  [self.view addGestureRecognizer:tap];
  if (self.training) {
    self.name.text = self.training.name;
    self.smallPeriod.text = [NSString stringWithFormat:@"%lu", self.training.smallPeriod];
    self.largePeriod.text = [NSString stringWithFormat:@"%lu", self.training.largePeriod];
    self.navigationItem.title = @"Тренировка";
    self.navigationItem.rightBarButtonItem.enabled = YES;
  }
}

- (void)viewWillAppear:(BOOL)animated {
  if (!self.training) {
    [self.name becomeFirstResponder];
  }
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [self.view endEditing:YES];
  [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
  self.navigationItem.rightBarButtonItem.enabled = NO;
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
  text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSString *name = self.name.text;
  NSString *largePeriod = self.largePeriod.text;
  NSString *smallPeriod = self.smallPeriod.text;
  if (self.name == textField) {
    name = text;
  } else if (self.largePeriod == textField) {
    largePeriod = text;
  } else {
    smallPeriod = text;
  }
  self.navigationItem.rightBarButtonItem.enabled = name.length > 0 && smallPeriod.length > 0 && largePeriod.length > 0;
  return YES;
}

- (void)cancel:(id)sender {
  [self.delegate addTrainingViewControllerDidCancel:self];
}

- (void)done:(id)sender {
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
