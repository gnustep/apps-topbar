/*
    Borrowed from Saso Kiserkov code in EtoileMenuServer.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/
#import "TopBar.h"
#import "ClockView.h"

#import <AppKit/NSButton.h>
#import <AppKit/NSFont.h>
#import <AppKit/NSWindow.h>

#import <Foundation/NSTimer.h>
#import <Foundation/NSInvocation.h>
#import <Foundation/NSCalendarDate.h>
#import <Foundation/NSString.h>
#import <Foundation/NSBundle.h>
#import <Foundation/NSUserDefaults.h>
#import "GNUstepGUI/GSTheme.h"

static inline NSString *
ShortNameOfDay(int day)
{
  return [[[NSUserDefaults standardUserDefaults]
    objectForKey: NSShortWeekDayNameArray]
    objectAtIndex: day];
}

static inline NSString *
AMPMStringForHour(int hour)
{
  NSArray * AMPMArray = [[NSUserDefaults standardUserDefaults]
    objectForKey: NSAMPMDesignation];

  if (hour < 12)
    {
      return [AMPMArray objectAtIndex: 0];
    }
  else
    {
      return [AMPMArray objectAtIndex: 1];
    }
}
 
@implementation ClockView : NSObject


- (void) dealloc
{
  [timer invalidate];
  TEST_RELEASE(clockButton);


  [super dealloc];
}

- (id) initWithOrigin:(CGFloat)xOrigin
		     :(CGFloat)yOrigin
{
  if ((self = [super init]) != nil)
    {
      NSInvocation * inv;
      NSFont *menuFont=[NSFont menuBarFontOfSize:0];
      NSMutableDictionary *attributes ;
      attributes = [NSMutableDictionary new];
      [attributes setObject:menuFont
		     forKey:NSFontAttributeName];
      NSMutableAttributedString *clockString = [[NSMutableAttributedString alloc] initWithString: @"Mon XX : XX PM" ];
      [clockString setAttributes:attributes range:NSMakeRange(0,[clockString length])]; 
      NSSize stringSize=[clockString size];
      xOrigin = xOrigin - stringSize.width - 5;
      yOrigin -= stringSize.height/2;
      clockButton = [[NSButton alloc] initWithFrame:
					 NSMakeRect (xOrigin, yOrigin, stringSize.width,stringSize.height)];
      [clockButton setFont: menuFont];
      [clockButton setBordered: NO];
      inv = [NSInvocation invocationWithMethodSignature: [self
        methodSignatureForSelector: @selector(updateClock)]];
      [inv setTarget: self];
      [inv setSelector: @selector(updateClock)];
      [inv retainArguments];
      timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                           invocation: inv
                                              repeats: YES];
      [self updateClock];
    }

  return self;
}

- (void) updateClock
{
  NSCalendarDate * date;
  int newHour, newMinute, newDay;

  date = [NSCalendarDate calendarDate];

  // only redraw every minute
  newHour = [date hourOfDay];
  newMinute = [date minuteOfHour];
  newDay = [date dayOfWeek];
  if (hour != newHour || minute != newMinute || day != newDay)
    {
      BOOL useAmPmTime = [[NSUserDefaults standardUserDefaults]
        boolForKey: @"UseAMPMTimeIndication"];

      hour = newHour;
      minute = newMinute;
      day = newDay;

      if (useAmPmTime)
        {
          int h = hour;

          if (h == 0)
            {
              h = 12;
            }
          else if (h > 12)
            {
              h -= 12;
            }

          [clockButton setTitle: [NSString stringWithFormat:
		                _(@"%@ %d: %02d %@"), ShortNameOfDay(day), h, minute,
					   AMPMStringForHour(hour)]];
        }
      else
        {
          [clockButton setTitle: [NSString stringWithFormat: _(@"%@ %d: %02d"),
					   ShortNameOfDay(day), hour, minute]];
	}
    }
}

- (NSView *) clockButton
{
  return (NSView *)clockButton;
}

@end
