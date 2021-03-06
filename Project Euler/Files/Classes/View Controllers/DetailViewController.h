//  DetailViewController.h

#import <UIKit/UIKit.h>
#import "QuestionAndAnswer.h"

@class ViewController;

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, QuestionAndAnswerDelegate> {
  BOOL                               _isComputing;
  uint                               _questionNumber;
  NSOperationQueue                 * _operationQueue;
  UIPopoverController              * _uiPopoverController;
  ViewController                   * __weak _viewController;
  QuestionAndAnswer                * _questionAndAnswer;
  IBOutlet UILabel                 * _questionDateLabel;
  IBOutlet UILabel                 * _questionTitleLabel;
  IBOutlet UILabel                 * _questionAnswerLabel;
  IBOutlet UILabel                 * _questionNumberLabel;
  IBOutlet UILabel                 * _computationTimeLabel;
  IBOutlet UILabel                 * _bruteForceComputationTimeLabel;
  IBOutlet UIButton                * _backButton;
  IBOutlet UIButton                * _cancelButton;
  IBOutlet UIButton                * _computeButton;
  IBOutlet UIButton                * _computeByBruteForceButton;
  IBOutlet UIButton                * _showQuestionsTableViewButton;
  IBOutlet UITextView              * _questionTextView;
  IBOutlet UIActivityIndicatorView * _activityIndicatorView;
}

@property (nonatomic, assign) uint             questionNumber;
@property (nonatomic, weak)   ViewController * viewController;

- (IBAction)backButtonPressed:(UIButton *)aButton;
- (IBAction)cancelButtonPressed:(UIButton *)aButton;
- (IBAction)computeButtonPressed:(UIButton *)aButton;
- (IBAction)computeBruteForceButtonPressed:(UIButton *)aButton;
- (IBAction)showQuestionsTableViewButtonPressed:(UIButton *)aButton;

@end