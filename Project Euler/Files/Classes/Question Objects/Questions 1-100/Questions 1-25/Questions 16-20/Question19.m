//  Question19.m

#import "Question19.h"

@implementation Question19

// Enum for the days of the week.
typedef enum {
  Day_Monday,
  Day_Tuesday,
  Day_Wednesday,
  Day_Thursday,
  Day_Friday,
  Day_Saturday,
  Day_Sunday
}Day;

// Enum for the months of the year.
typedef enum {
  Month_January,
  Month_February,
  Month_March,
  Month_April,
  Month_May,
  Month_June,
  Month_July,
  Month_August,
  Month_September,
  Month_October,
  Month_November,
  Month_December
}Month;

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"14 June 2002";
  self.text = @"You are given the following information, but you may prefer to do some research for yourself.\n\n1 Jan 1900 was a Monday.\nThirty days has September,\nApril, June and November.\nAll the rest have thirty-one,\nSaving February alone,\nWhich has twenty-eight, rain or shine.\nAnd on leap years, twenty-nine.\nA leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.\n\nHow many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?";
  self.title = @"Counting Sundays";
  self.answer = @"171";
  self.number = @"Problem 19";
  self.estimatedComputationTime = @"1.86e-04";
  self.estimatedBruteForceComputationTime = @"1.86e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Variable to hold the current day number.
  uint currentDayNumber = 1;
  
  // Variable to hold the current day of the week (Note: January 1st, 1901 was
  // a Tuesday, so that is our default day).
  Day currentDayOfTheWeek = Day_Tuesday;
  
  // Variable to hold the current month.
  Month currentMonth = Month_January;
  
  // Variable to hold the number of Sundays on the first of the month.
  uint numberOfSundaysOnTheFirstOfTheMonth = 0;
  
  // Variable array to hold the number of days for each month.
  uint daysOfTheMonth[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  
  // For all the years from the beginning of 1901 to the end of 2000,
  for(int i = 1; i <= 100; i++){
    // If the year is a leap year,
    if((i % 4) == 0){
      // The number of days in February is 29.
      daysOfTheMonth[Month_February] = 29;
    }
    // If the year is NOT a leap year,
    else{
      // The number of days in February is 28.
      daysOfTheMonth[Month_February] = 28;
    }
    // Set the start month to January.
    currentMonth = Month_January;
    
    // Set the start day number to the first (i.e.: 1).
    currentDayNumber = 1;
    
    // The day of the week is carried over from the previous year, so no need to
    // set it here.
    
    // While the current month is one of the 12 months in the year,
    while(currentMonth <= Month_December){
      // Increment the current day by 1.
      currentDayNumber++;
      
      // If the current day number is equal to the end say of the month,
      if(daysOfTheMonth[currentMonth] == currentDayNumber){
        // Increment the current month by 1.
        currentMonth++;
        
        // Set the start day number to the first (i.e.: 1).
        currentDayNumber = 1;
        
        // If the current day of the week is a Sunday,
        if(currentDayOfTheWeek == Day_Sunday){
          // Incremembt the number of Sundays on the first of the month by 1.
          numberOfSundaysOnTheFirstOfTheMonth++;
        }
      }
      // If the current day of the week is a Sunday,
      if(currentDayOfTheWeek == Day_Sunday){
        // Set the current day of the week to Monday.
        currentDayOfTheWeek = Day_Monday;
      }
      // If the current day of the week is NOT a Sunday,
      else{
        // Increment the day of the week by 1 day.
        currentDayOfTheWeek++;
      }
    }
  }
  // Set the answer string to the number of Sundays on the first of the month.
  self.answer = [NSString stringWithFormat:@"%d", numberOfSundaysOnTheFirstOfTheMonth];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
}

- (void)computeAnswerByBruteForce; {
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Note: This is the same algorithm as the optimal one. I can't think of a more
  //       brute force way to do this!
  
  // Variable to hold the current day number.
  uint currentDayNumber = 1;
  
  // Variable to hold the current day of the week (Note: January 1st, 1901 was
  // a Tuesday, so that is our default day).
  Day currentDayOfTheWeek = Day_Tuesday;
  
  // Variable to hold the current month.
  Month currentMonth = Month_January;
  
  // Variable to hold the number of Sundays on the first of the month.
  uint numberOfSundaysOnTheFirstOfTheMonth = 0;
  
  // Variable array to hold the number of days for each month.
  uint daysOfTheMonth[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  
  // For all the years from the beginning of 1901 to the end of 2000,
  for(int i = 1; i <= 100; i++){
    // If the year is a leap year,
    if((i % 4) == 0){
      // The number of days in February is 29.
      daysOfTheMonth[Month_February] = 29;
    }
    // If the year is NOT a leap year,
    else{
      // The number of days in February is 28.
      daysOfTheMonth[Month_February] = 28;
    }
    // Set the start month to January.
    currentMonth = Month_January;
    
    // Set the start day number to the first (i.e.: 1).
    currentDayNumber = 1;
    
    // The day of the week is carried over from the previous year, so no need to
    // set it here.
    
    // While the current month is one of the 12 months in the year,
    while(currentMonth <= Month_December){
      // Increment the current day by 1.
      currentDayNumber++;
      
      // If the current day number is equal to the end say of the month,
      if(daysOfTheMonth[currentMonth] == currentDayNumber){
        // Increment the current month by 1.
        currentMonth++;
        
        // Set the start day number to the first (i.e.: 1).
        currentDayNumber = 1;
        
        // If the current day of the week is a Sunday,
        if(currentDayOfTheWeek == Day_Sunday){
          // Incremembt the number of Sundays on the first of the month by 1.
          numberOfSundaysOnTheFirstOfTheMonth++;
        }
      }
      // If the current day of the week is a Sunday,
      if(currentDayOfTheWeek == Day_Sunday){
        // Set the current day of the week to Monday.
        currentDayOfTheWeek = Day_Monday;
      }
      // If the current day of the week is NOT a Sunday,
      else{
        // Increment the day of the week by 1 day.
        currentDayOfTheWeek++;
      }
    }
  }
  // Set the answer string to the number of Sundays on the first of the month.
  self.answer = [NSString stringWithFormat:@"%d", numberOfSundaysOnTheFirstOfTheMonth];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
}

@end