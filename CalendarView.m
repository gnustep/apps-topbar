#import "CalendarView.h"
#import "GNUstepGUI/GSTheme.h"

@implementation CalendarView

#define isLeapYear(year) (((year % 4) == 0 && ((year % 100) != 0)) || (year % 400) == 0)

static short numberOfDaysInMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

+ (NSSize) size
{
  return NSMakeSize(240, 270);
}

- (NSCalendarDate *) date
{
  return date;
}

- (void) setDate: (NSCalendarDate *) newDate
{
   int i, currentDay, currentMonth, currentYear;
   int daysInMonth, startDayOfWeek, day;
   NSCalendarDate *firstDayOfMonth;
   NSButtonCell *tempCell;

   ASSIGN(date, newDate);

   [yearLabel setStringValue: [date descriptionWithCalendarFormat: @"%Y"]];

   currentMonth = [date monthOfYear];
   
   [monthMatrix selectCellWithTag: currentMonth-1];

   currentYear = [date yearOfCommonEra];
   firstDayOfMonth = [NSCalendarDate dateWithYear: currentYear
                                            month: currentMonth
                                              day: 1
                                             hour: 0
                                           minute: 0
                                           second: 0
                                         timeZone: [NSTimeZone localTimeZone]];

   daysInMonth = numberOfDaysInMonth[currentMonth - 1];

   if ((currentMonth == 2) && (isLeapYear(currentYear)))
      daysInMonth++;

   startDayOfWeek = [firstDayOfMonth dayOfWeek];

   day = 1;

   for (i = 0; i < 42; i++)
   {
      tempCell = [dayMatrix cellWithTag: i];
      if (i < startDayOfWeek || i >= (daysInMonth + startDayOfWeek))
      {
         [tempCell setEnabled: NO];
         [tempCell setTitle: @""];
      }
      else
      {
         [tempCell setEnabled: YES];
         [tempCell setTitle: [NSString stringWithFormat: @"%d", day++]];
      }
   }

   currentDay = [date dayOfMonth];
   [dayMatrix selectCellWithTag: startDayOfWeek + currentDay - 1];
}

- (id) initWithFrame: (NSRect) rect
{
   int i, j, count=0;
   NSImage *rightArrow, *leftArrow;
   NSButtonCell *monthCell, *dayCell, *tempCell;
   NSArray *weekArray;

   [super initWithFrame: rect];

   calendarBox = [[NSBox alloc] initWithFrame: NSMakeRect(0, 0, 240, 220)];
   [calendarBox setBorderType: NSNoBorder];
   [calendarBox setTitlePosition: NSAtTop];
   [calendarBox setTitle: _(@"Calendar")];

   yearLabel = [[NSTextField alloc] initWithFrame: NSMakeRect(85, 170, 60, 20)];
   [yearLabel setStringValue: @"This Year"];
   [yearLabel setBezeled: NO];
   [yearLabel setBackgroundColor: [[GSTheme theme] menuItemBackgroundColor]];
   [yearLabel setEditable: NO];
   [yearLabel setSelectable: NO];
   [yearLabel setAlignment: NSCenterTextAlignment];

   leftArrow = [NSImage imageNamed: @"common_ArrowLeft.tiff"];
   rightArrow = [NSImage imageNamed: @"common_ArrowRight.tiff"];

   lastYearButton = [[NSButton alloc] initWithFrame: NSMakeRect(10, 170, 22, 22)];
   [lastYearButton setImage: leftArrow];
   [lastYearButton setImagePosition: NSImageOnly];
   [lastYearButton setBordered: NO];

   nextYearButton = [[NSButton alloc] initWithFrame: NSMakeRect(198, 170, 22, 22)];
   [nextYearButton setImage: rightArrow];
   [nextYearButton setImagePosition: NSImageOnly];
   [nextYearButton setBordered: NO];

   [lastYearButton setTarget: self];
   [lastYearButton setAction: @selector(updateDate:)];

   [nextYearButton setTarget: self];
   [nextYearButton setAction: @selector(updateDate:)];

   [calendarBox addSubview: yearLabel];
   [calendarBox addSubview: lastYearButton];
   [calendarBox addSubview: nextYearButton];
   RELEASE(yearLabel);
   RELEASE(lastYearButton);
   RELEASE(nextYearButton);

   monthArray = [[NSArray alloc] initWithObjects: 
				   _(@"Jan"), _(@"Feb"), _(@"Mar"),_(@"Apr"), _(@"May"), _(@"Jun"), 
				 _(@"Jul"), _(@"Aug"), _(@"Sep"), _(@"Oct"), _(@"Nov"), _(@"Dec"), nil];

   monthCell = [[NSButtonCell alloc] initTextCell: @""];
   [monthCell setBordered: NO];
   [monthCell setShowsStateBy: NSOnOffButton];
   [monthCell setAlignment: NSCenterTextAlignment];

   monthMatrix = [[NSMatrix alloc] initWithFrame: NSMakeRect(10, 130, 220, 40)
                                            mode: NSRadioModeMatrix
                                       prototype: monthCell
                                    numberOfRows: 2
                                 numberOfColumns: 6];

   for (i = 0; i < 2; i++)
      for (j = 0; j < 6; j++)
      {
         tempCell = [monthMatrix cellAtRow: i column: j];
         [tempCell setTag: count];
         [tempCell setTitle: [monthArray objectAtIndex: count]];
         count++;
      }
   RELEASE(monthCell);

   weekArray = [NSArray arrayWithObjects: _(@"Sun"), _(@"Mon"), _(@"Tue"), _(@"Wed"),
			_(@"Thr"), _(@"Fri"), _(@"Sat"), nil];

   dayCell = [[NSButtonCell alloc] initTextCell: @""];
   [dayCell setBordered: NO];
   [dayCell setShowsStateBy: NSOnOffButton];
   [dayCell setAlignment: NSCenterTextAlignment];

   dayMatrix = [[NSMatrix alloc] initWithFrame: NSMakeRect(10, 10, 210, 110)
                                          mode: NSRadioModeMatrix
                                     prototype: dayCell
                                  numberOfRows: 7
                               numberOfColumns: 7];

   for (j = 0; j < 7; j++)
   {
      tempCell = [dayMatrix cellAtRow: 0 column: j];
      [tempCell setTitle: [weekArray objectAtIndex: j]];
      [tempCell setAlignment: NSCenterTextAlignment];
      [tempCell setEnabled: NO];
   }

   RELEASE(dayCell);

   count = 0;

   for (i = 1; i < 7; i++)
      for (j = 0; j < 7; j++)
         {
           [[dayMatrix cellAtRow: i column: j] setTag: count++];
         }

   [monthMatrix setTarget: self];
   [monthMatrix setAction: @selector(updateDate:)];

   [dayMatrix setTarget: self];
   [dayMatrix setAction: @selector(updateDate:)];

   [calendarBox addSubview: monthMatrix];
   [calendarBox addSubview: dayMatrix];
   RELEASE(monthMatrix);
   RELEASE(dayMatrix);

   [self addSubview: calendarBox];
   RELEASE(calendarBox);

   return self;
}

- (void) updateDate: (id) sender
{
    int i=0, j=0, k=0;
  NSCalendarDate *newDate;
  
  if (sender == lastYearButton)
    {
      i = -1;
    }
  else if (sender == nextYearButton)
    {
      i = 1;
    }
  else if (sender == monthMatrix)
    {
      j = [[[sender selectedCells] lastObject] tag] + 1 - [date monthOfYear];
      NSLog(@"Mois : %i",j);
    }
  else if (sender == dayMatrix)
    {
      k = [[[[sender selectedCells] lastObject] stringValue] intValue] - [date dayOfMonth];
      /* NSLog(@" Day : %i", [date dayOfMonth]);
      NSLog(@"intValue : %i", [[[sender selectedCells] lastObject] intValue]);
      NSLog(@"Jour : %i", k);*/ //FIXME : wrong intValue
    }
  
  newDate = [date addYear: i
		    month: j
		      day: k
		     hour: 0
		   minute: 0
		   second: 0];
  [self setDate: newDate];
}

- (void) dealloc
{
  DESTROY(date);
  DESTROY(monthArray);
  [super dealloc];
}

@end
