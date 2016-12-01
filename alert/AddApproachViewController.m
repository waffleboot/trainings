
#import "AddApproachViewController.h"
#import "DataModel.h"

@interface AddApproachViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

@implementation AddApproachViewController

- (void)viewDidLoad {
  if (self.approach) {
    self.name.text = self.approach.name;
    self.navigationItem.title = @"Подход";
  }
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

@end
