
import 
  glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  main_quit()

# This function is used to close the window when clicking on the "Click me" button.
proc widgetDestroy(w: PWidget) {.cdecl.} = 
  destroy(w)

nimrod_init()
var window = window_new(WINDOW_TOPLEVEL)
var button = button_new("Click me")
set_border_width(window, 5)
add(window, button)
discard signal_connect(window, "destroy", 
                       SIGNAL_FUNC(ex5.destroy), nil)
discard signal_connect_object(button, "clicked", 
                              SIGNAL_FUNC(widgetDestroy), 
                              window)
show(button)
show(window)
main()

