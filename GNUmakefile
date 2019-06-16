ifeq ($(GNUSTEP_MAKEFILES),)
 GNUSTEP_MAKEFILES := $(shell gnustep-config --variable=GNUSTEP_MAKEFILES 2>/dev/null)
endif
ifeq (*(GNUSTEP_MAKEFILES),)
 (error  You need to set GNUSTEP_MAKEFILES before compiling!)
endif

GNUSTEP_INSTALLATION_DOMAIN = SYSTEM

include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME= TopBar
TopBar_APPLICATION_ICON = Resources/Separator.tiff

#
# Resource files
#
TopBar_RESOURCE_FILES = \
Resources/Separator.tiff\
Resources/Logo.tiff\
Resources/English.lproj \
Resources/French.lproj

GSPanel_LANGUAGES = \
Resources/English \
Resources/French


#
# The Objective-C source file
#

TopBar_OBJC_FILES =\
		TopBar.m\
		ClockView.m\
		CalendarView.m\
		UserView.m\
		main.m\


include $(GNUSTEP_MAKEFILES)/application.make

