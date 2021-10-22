# TopBar

I've wrote this little tool because, even if gnustep can display a global menubar like Macosx,
all non gnustep apps are not able to do so. Each time a gnustep app loses the focus, the globalmenubar disappears if for instance a gtk app gets the focus. 
Then enter TopBar, a persistant bar at the top the screen that lays down under gnustep global menubar.
This is just a little hack, but it's the best I could do by myself. 

You should use a compositor like compton with it , if you want TopBar too be fully visible by transparancy under gnustep's globalmenubars.

There are limitations too : if TopBar is covered by a gnustep's menubar (but visible with compton), it's widget won't be clickable. I did'nt find a solution to this issus for now.

Bertrand Dekoninck
