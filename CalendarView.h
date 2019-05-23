#import <AppKit/AppKit.h>

@interface CalendarView : NSView
{
  NSBox *calendarBox;
  NSTextField *yearLabel;
  NSButton *lastYearButton, *nextYearButton;
  NSMatrix *monthMatrix, *dayMatrix;
  NSCalendarDate *date;
  NSArray *monthArray;
}

+ (NSSize) size;
- (NSCalendarDate *) date;
- (void) setDate: (NSCalendarDate *)date;

/* Used by interface */
- (void) updateDate: (id) sender;

@end



