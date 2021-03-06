
import 
  glib2, gtk2

proc newbutton(ALabel: cstring): PWidget = 
  result = button_new(ALabel)
  show(result)

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  main_quit()

nim_init()
### This is where the settings are happening for the boxes within the window ###

var window = window_new(WINDOW_TOPLEVEL) # Box to divide window in 2 halves:
var totalbox = vbox_new(true, 10)
show(totalbox)   # A box for each half of the screen:
var hbox = hbox_new(false, 5)
show(hbox)
var vbox = vbox_new(true, 5)
show(vbox)       # Put boxes in their halves
pack_start(totalbox, hbox, true, true, 0)
pack_start(totalbox, vbox, true, true, 0) # Now fill boxes with buttons.

### This is where the settings part ends ###

pack_start(hbox, newbutton("Button 1"), false, false, 0)
pack_start(hbox, newbutton("Button 2"), false, false, 0)
pack_start(hbox, newbutton("Button 3"), false, false, 0) # Vertical box
pack_start(vbox, newbutton("Button A"), true, true, 0)
pack_start(vbox, newbutton("Button B"), true, true, 0)
pack_start(vbox, newbutton("Button C"), true, true, 0) # Put totalbox in window
set_border_width(PCONTAINER(window), 5)
add(PContainer(window), totalbox)
discard signal_connect(window, "destroy", SIGNAL_FUNC(ex3.destroy), nil)
show(window)
main()

