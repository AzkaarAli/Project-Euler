//  Question24.m

#import "Question24.h"

@interface Question24 (Private)

- (BOOL)isNumberLexographic:(long long int)aNumber;

@end

@implementation Question24

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"16 August 2002";
  self.text = @"A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:\n\n012   021   102   120   201   210\n\nWhat is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?";
  self.title = @"Lexicographic permutations";
  self.answer = @"2783915460";
  self.number = @"Problem 24";
  self.estimatedComputationTime = @"4.6e-05";
  self.estimatedBruteForceComputationTime = @"978";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we use a bit of combinatorics to solve the question. Notice that the
  // total possible number of 9-lexographic numbers is:
  //
  // \prod_{i = 1} (i choose 1) = 10! > 1,000,000 > 9!.
  //
  // Therefore, if continually subtract off 9! from the number to find until it
  // is less than 9!, we will find the digit. As an example to finding the first
  // digit, we have:
  //
  // 2 * 9! = 725,760
  //
  // 1,000,000 - 725,760 = 274,240
  //
  // 6 * 8! = 241,920
  //
  // 274,240 - 241,920 = 32,320
  //
  // Therefore, the first digit is: 2.
  //
  // The second digit is the 6th digit starting from 0. Since 2 is gone now, the
  // second digit is 7.
  //
  // Therefore, we will have an array of digits that are still allowed to be used,
  // compute which digit is required from above, and add it to the constructed
  // number. Then we remove that digit from the remaining digits array and repeat.
  
  // Variable to hold the number to find.
  int numberToFind = 1000000;
  
  // Variable to hold the digit index for the factorials array to subtract from
  // the number to find.
  uint digitIndex = 9;
  
  // Variable to hold the current digit for the 9-lexographic number.
  uint currentDigit = 0;
  
  // Variable array to hold the factorial values of 0! to 9!.
  int factorialValues[10];
  
  // Variable array to hold the remaining digits that can be used when constructing
  // the 9-lexographic number.
  NSMutableArray * remainingDigitsArray = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
  
  // Variable to hold the constructed 
  NSString * required9LexographicNumber = @"";
  
  // First, we set up the factorials array.
  
  // Set the default factorial value of 0! = 1.
  factorialValues[0] = 1;
  
  // For all the numbers from 1 to 9,
  for(int number = 1; number < 10; number++){
    // Compute the factorial of the number.
    factorialValues[number] = factorialValues[(number - 1)] * number;
  }
  
  // Now, we compute the start index to look through for our factorial array.
  
  // While the number to find is less than the current factorial value (starting
  // from 9!, working down),
  while(numberToFind < factorialValues[digitIndex]){
    // Decrement the digit index by 1.
    digitIndex--;
  }
  // While the number to find is still 0.
  while(numberToFind > 0){
    // Subtract off the factorial value form the number to find.
    numberToFind -= factorialValues[digitIndex];
    
    // Increase the current digit by 1.
    currentDigit++;
    
    // If the number is less than the current factorial value,
    if(numberToFind < factorialValues[digitIndex]){
      // Add the current digit to the constructed 9-lexographic number.
      required9LexographicNumber = [NSString stringWithFormat:@"%@%@", required9LexographicNumber, [remainingDigitsArray objectAtIndex:currentDigit]];
      
      // Remove the current digit from the remaining digits.
      [remainingDigitsArray removeObjectAtIndex:currentDigit];
      
      // Decrement the digit index by 1.
      digitIndex--;
      
      // If there is only 2 remaining digits to add to the 9-lexographic number,
      if(digitIndex == 1){
        // While the remaining digits array still has elements,
        while([remainingDigitsArray count] > 0){
          // Add the first remaining digit to the constructed 9-lexographic number.
          required9LexographicNumber = [NSString stringWithFormat:@"%@%@", required9LexographicNumber, [remainingDigitsArray objectAtIndex:0]];
          
          // Remove the first digit from the remaining digits.
          [remainingDigitsArray removeObjectAtIndex:0];
        }
        // Break out of the loop.
        break;
      }
      // While the number to find is less than the current factorial value,
      while(numberToFind < factorialValues[digitIndex]){
        // Add the first remaining digit to the constructed 9-lexographic number.
        required9LexographicNumber = [NSString stringWithFormat:@"%@%@", required9LexographicNumber, [remainingDigitsArray objectAtIndex:0]];
        
        // Remove the first digit from the remaining digits.
        [remainingDigitsArray removeObjectAtIndex:0];
        
        // Decrement the digit index by 1.
        digitIndex--;
        
        // If we've added all the digits to the constructed 9-lexographic number,
        if(digitIndex == 0){
          // Break out of the loop.
          break;
        }
      }
      // If we've added all the digits to the constructed 9-lexographic number,
      if(digitIndex == 0){
        // Break out of the loop.
        break;
      }
      // Reset the current digit to 0.
      currentDigit = 0;
    }
    // If the number is equal to the current factorial value,
    else if(numberToFind == factorialValues[digitIndex]){
      // Add the current digit to the constructed 9-lexographic number.
      required9LexographicNumber = [NSString stringWithFormat:@"%@%@", required9LexographicNumber, [remainingDigitsArray objectAtIndex:currentDigit]];
      
      // Remove the current digit from the remaining digits.
      [remainingDigitsArray removeObjectAtIndex:currentDigit];
      
      // While the remaining digits array still has elements,
      while([remainingDigitsArray count] > 0){
        // Add the last remaining digit to the constructed 9-lexographic number.
        required9LexographicNumber = [NSString stringWithFormat:@"%@%@", required9LexographicNumber, [remainingDigitsArray lastObject]];
        
        // Remove the last digit from the remaining digits.
        [remainingDigitsArray removeLastObject];
      }
      // Break out of the loop.
      break;
    }
  }
  // Set the answer string to the required 9-lexographic number.
  self.answer = required9LexographicNumber;
  
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
  
  // Here, we simply look at every possible number from the first 9-lexographic
  // number to the last 9-lexographic number, and use a helper method to see if
  // the number is a 9-lexographic number or not. It is very slow!
  
  // Variable to hold the number of 9-lexographic numbers.
  uint numberOf9LexographicNumbers = 0;
  
  // Variable to hold the millionth 9-lexographic number.
  long long int millionth9LexographicNumber = 0;
  
  // For all the numbers from the first 9-lexographic number to the last
  // 9-lexographic number.
  for(long long int number = 123456789; number <= 9876543210; number++){
    // If the number is a 9-lexographic number,
    if([self isNumberLexographic:number]){
      // Increment the number of 9-lexographic numbers by 1.
      numberOf9LexographicNumbers++;
      
      // If the number of 9-lexographic numbers is 1,000,000,
      if(numberOf9LexographicNumbers == 1000000){
        // Set the millionth 9-lexographic number to the current number.
        millionth9LexographicNumber = number;
        
        // Break out of the loop.
        break;
      }
      // If we are no longer computing,
      if(!_isComputing){
        // Break out of the loop.
        break;
      }
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the millionth 9-lexographic number.
    self.answer = [NSString stringWithFormat:@"%llu", millionth9LexographicNumber];
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated brute force computation time to the calculated value. We
    // use scientific notation here, as the run time should be very short.
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  }
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question24 (Private)

- (BOOL)isNumberLexographic:(long long int)aNumber; {
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // If the number of digits is NOT 8 or 9,
  if((numberOfDigits > 9) || (numberOfDigits < 8)){
    // Return that the number is NOT 9-Lexographic.
    return NO;
  }
  // Variable to hold if the number is lexographic or not.
  BOOL numberIsLexographic = YES;
  
  // Variable to hold the digit we are looking at.
  uint digit = 0;
  
  // Variable to hold the power of 10 for the current digit.
  uint powerOf10 = 1;
  
  // Variable array to hold if the digit in the number has been used or not.
  BOOL isDigitUsed[10];
  
  // For all the digits from 0 to 9,
  for(int digit = 0; digit < 10; digit++){
    // Default that the digit has not been used or not.
    isDigitUsed[digit] = NO;
  }
  // If the number is in the 100 millions,
  if(numberOfDigits == 8){
    // Set that the 0 digit is already used (it's the left-most digit).
    isDigitUsed[0] = YES;
  }
  // While the number of digits is positive,
  while(numberOfDigits >= 0){
    // Grab the current digit from the input number.
    digit = (((long long int)(aNumber / powerOf10)) % 10);
    
    // If the digit has already been used,
    if(isDigitUsed[digit]){
      // Set that the number is NOT a 9-lexographic number.
      numberIsLexographic = NO;
      
      // Break out of the loop.
      break;
    }
    // If the digit has NOT already been used,
    else{
      // Set that the digit has been used.
      isDigitUsed[digit] = YES;
    }
    // Multiply the power of 10 by 10 for the next index.
    powerOf10 *= 10;
    
    // Decrease the number of digits by 1.
    numberOfDigits--;
  }
  // Return if the number is lexographic or not.
  return numberIsLexographic;
}

@end