
#import "AddApproachViewController.h"
#import "DataModel.h"

@interface AddApproachViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

@implementation AddApproachViewController

- (void)viewDidLoad {
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
  tap.cancelsTouchesInView = NO;
  [self.view addGestureRecognizer:tap];
  if (self.approach) {
    self.name.text = self.approach.name;
    self.navigationItem.title = @"Подход";
    self.navigationItem.rightBarButtonItem.enabled = YES;
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [self.name becomeFirstResponder];
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [self.view endEditing:YES];
  [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
  self.navigationItem.rightBarButtonItem.enabled = NO;
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  if (textField == self.name) {
    NSString *text = [self.name.text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.navigationItem.rightBarButtonItem.enabled = text.length > 0;
  }
  return YES;
}

- (void)cancel:(id)sender {
  [self.delegate addApproachViewControllerDidCancel:self];
}

- (void)done:(id)sender {
  if (self.approach) {
    self.approach.name = self.name.text;
    [self.delegate addApproachViewController:self didEditApproach:self.approach];
  } else {
    Approach *approach = [[Approach alloc] init];
    approach.name = self.name.text;
    [self.delegate addApproachViewController:self didAddApproach:approach];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.name becomeFirstResponder];
}

@end
