
#import "EditDoneNavigationItem.h"

@implementation EditDoneNavigationItem

static NSInteger kTag = 1;

- (void)awakeFromNib {
  [super awakeFromNib];
  NSMutableArray *buttons = [self.rightBarButtonItems mutableCopy];
  UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
  editBarButtonItem.tag = kTag;
  [buttons insertObject:editBarButtonItem atIndex:0];
  self.rightBarButtonItems = buttons;
}

- (void)replaceWith:(UIBarButtonItem *)item {
  NSInteger idx = [self.rightBarButtonItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    UIBarButtonItem *item = obj;
    if (item.tag == kTag) {
      *stop = YES;
      return YES;
    }
    return NO;
  }];
  if (idx != NSNotFound) {
    NSMutableArray *buttons = [self.rightBarButtonItems mutableCopy]; item.tag = kTag;
    [buttons replaceObjectAtIndex:idx withObject:item];
    self.rightBarButtonItems = buttons;
  }
}

- (void)edit {
  UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self action:@selector(done)];
  [self replaceWith:doneBarButtonItem];
  [self.tableView setEditing:YES animated:NO];
}

- (void)done {
  UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                     target:self action:@selector(edit)];
  [self replaceWith:editBarButtonItem];
  [self.tableView setEditing:NO animated:NO];
  
}

@end
