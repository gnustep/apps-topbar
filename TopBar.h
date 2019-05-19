#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>

#define RIGHTPADDING 10

@interface MyDelegate : NSObject
{
  NSWindow *topBar;
  NSRect screenFrame;
  NSSize screenSize;
}

- (NSColor *) backgroundColor;
- (NSColor *) transparentColor;
- (NSInteger) menuBarHeight;
- (void) createTopBar;
- (void) applicationWillFinishLaunching: (NSNotification *)not;
- (void) applicationDidFinishLaunching: (NSNotification*)not;



@end
