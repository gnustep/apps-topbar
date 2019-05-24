#import "UserView.h"
#import "TopBar.h"


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

@implementation UserView : NSObject

-(NSButton *) userButton
{
  return userButton;
}

-(CGFloat) width
{
  NSRect frame = [[self userButton] frame];
  CGFloat width = NSWidth(frame);
  return width;
}

-(id) initWithOrigin:(CGFloat)xOrigin
               height:(CGFloat)h
{
   if ((self = [super init]) != nil)
    {
      NSFont *menuFont=[NSFont menuBarFontOfSize:0];
      NSMutableDictionary *attributes ;
      attributes = [NSMutableDictionary new];
      [attributes setObject:menuFont
		     forKey:NSFontAttributeName];
      userName = [NSUserName() capitalizedString];
      NSMutableAttributedString *userString = [[NSMutableAttributedString alloc] initWithString:userName
										     attributes:attributes];
      NSSize stringSize=[userString size];
      xOrigin = xOrigin - stringSize.width - 5;
      h = h/2 - stringSize.height/2;
      userButton = [[NSButton alloc] initWithFrame:
					 NSMakeRect (xOrigin,h ,stringSize.width, stringSize.height)];
      [userButton setFont: menuFont];
      [userButton setAlignment: NSRightTextAlignment];
      [userButton setBordered: NO];
      [userButton setTitle: userName];
      [userString release];
    }
   return self;
}

-(void) dealloc
{

  [userButton release];
  [super dealloc];
}

@end
