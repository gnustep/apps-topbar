#include "TopBar.h"

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool;

  pool = [NSAutoreleasePool new];
  [NSApplication sharedApplication];
  [NSApp setDelegate: [MyDelegate new]];

  [pool drain];
  return NSApplicationMain (argc, argv);
}
