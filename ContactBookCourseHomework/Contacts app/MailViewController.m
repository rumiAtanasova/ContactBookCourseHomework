

#import "MailViewController.h"
#import "SecondViewController.h"
#import "ContactsBook.h"
#import "Contact.h"


@interface MailViewController () 
@property (weak, nonatomic) IBOutlet UITextField *receiverTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextLField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSString* cellText;
@end

@implementation MailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (IBAction)sendEmail:(id)sender {
    NSArray* toRecipients = [NSArray arrayWithObject:self.receiverTextLabel.text];
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:toRecipients];
    [controller setSubject:self.subjectTextLField.text];
    [controller setMessageBody:self.textView.text isHTML:NO];
    if (controller)
        [self presentViewController:controller animated:YES completion:nil];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.receiverTextLabel.text = [[self.receiverTextLabel.text stringByAppendingString:self.cellText] stringByAppendingString:@" "];
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SecondViewController* svc = (SecondViewController*)self.navigationController.viewControllers[0];
    return [svc.currentContact emailsCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondViewController* svc = (SecondViewController*)self.navigationController.viewControllers[0];
    static NSString* identifier = @"emailCel";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [svc.currentContact giveEmailForRow:indexPath.row];
    self.cellText = cell.textLabel.text;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
