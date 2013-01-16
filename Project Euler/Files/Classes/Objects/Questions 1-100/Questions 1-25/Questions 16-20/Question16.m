//  Question16.m

#import "Question16.h"
#import "BigInt.h"

@interface Question16 (Private)

- (uint)digitSumOfNumber:(NSString *)aNumber;

@end

@implementation Question16

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"03 May 2002";
  self.text = @"2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.\n\nWhat is the sum of the digits of the number 2^1000?";
  self.title = @"Power digit sum";
  self.answer = @"1366";
  self.number = @"Problem 16";
  self.estimatedComputationTime = @"3.05e-03";
  self.estimatedBruteForceComputationTime = @"3.05e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we just use a BigInt data model to handle the multiplication. Then we
  // return the result as a string, and use a helper method to add up the digits.
  
  // Variable to hold the value we will continually multiply with. We start at
  // 1024 = 2^10 to reduce the number of multiplications.
  BigInt * baseNumber = [BigInt createFromInt:1024];
  
  // Variable to hold the result number of the multiplication. Start at the
  // default value of 1.
  BigInt * resultNumber = [BigInt createFromInt:1];
  
  // Temporary variable to hold the result of the multiplication.
  BigInt * temporaryNumber = nil;
  
  // Since we want to compute 2^1000, we simply multiply 2^10 100 times as:
  //
  // (2^10)^100 = 2^1000
  
  // While looping 100 time,
  for(int i = 0; i < 100; i++){
    // Store the multiplication of the base number 2^10 and the result number in
    // a temporary variable.
    temporaryNumber = [baseNumber multiply:resultNumber];
    
    // Set the result number to be the result of the above multiplication.
    resultNumber = temporaryNumber;
  }
  // Set the answer string to the sum of the digits.
  self.answer = [NSString stringWithFormat:@"%d", [self digitSumOfNumber:[resultNumber toStringWithRadix:10]]];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

- (void)computeAnswerByBruteForce; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we just use a BigInt data model to handle the multiplication. Then we
  // return the result as a string, and use a helper method to add up the digits.
  
  // Variable to hold the value we will continually multiply with. We start at
  // 1024 = 2^10 to reduce the number of multiplications.
  BigInt * baseNumber = [BigInt createFromInt:1024];
  
  // Variable to hold the result number of the multiplication. Start at the
  // default value of 1.
  BigInt * resultNumber = [BigInt createFromInt:1];
  
  // Temporary variable to hold the result of the multiplication.
  BigInt * temporaryNumber = nil;
  
  // Since we want to compute 2^1000, we simply multiply 2^10 100 times as:
  //
  // (2^10)^100 = 2^1000
  
  // While looping 100 time,
  for(int i = 0; i < 100; i++){
    // Store the multiplication of the base number 2^10 and the result number in
    // a temporary variable.
    temporaryNumber = [baseNumber multiply:resultNumber];
    
    // Set the result number to be the result of the above computation.
    resultNumber = temporaryNumber;
  }
  // Set the answer string to the sum of the digits.
  self.answer = [NSString stringWithFormat:@"%d", [self digitSumOfNumber:[resultNumber toStringWithRadix:10]]];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question16 (Private)

- (uint)digitSumOfNumber:(NSString *)aNumber; {
  // Variable to hold the current digit.
  uint currentDigit = 0;
  
  // Variable to hold the current index of the string.
  int currentIndex = [aNumber length];
  
  // Variable to hold the digit sum.
  uint digitSum = 0;
  
  // Variable to hold the index and length of the current "digit".
  NSRange subStringRange = NSMakeRange(0, 0);
  
  // While the current index is greater than or equal to the midPoint,
  while(currentIndex > 0){
    // Decrease the currentIndex by 1, which is equivalent to looking at the
    // next digit to the right.
    currentIndex--;
    
    // Compute the range of the next "digit".
    subStringRange = NSMakeRange(currentIndex, 1);
    
    // Compute the current digit given the by current index.
    currentDigit = [[aNumber substringWithRange:subStringRange] intValue];
    
    // Increase the digit sum by the value of the digit.
    digitSum += currentDigit;
  }
  // Return the digit sum.
  return digitSum;
}

@end