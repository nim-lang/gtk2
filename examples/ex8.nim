
import 
  glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  main_quit()

nim_init()
var window = window_new(WINDOW_TOPLEVEL)
var stackbox = vbox_new(true, 10)
var label1 = label_new("Red label text")
var labelstyle = copy(get_style(label1))
labelStyle.fg[STATE_NORMAL].pixel = 0
labelStyle.fg[STATE_NORMAL].red = uint16.high
labelStyle.fg[STATE_NORMAL].blue = 0
labelStyle.fg[STATE_NORMAL].green = 0
set_style(label1, labelstyle) 
# Uncomment this to see the effect of setting the default style.
# set_default_style(labelstyle) # xxx would give CT error
var label2 = label_new("Black label text")
pack_start(stackbox, label1, true, true, 0)
pack_start(stackbox, label2, true, true, 0)
set_border_width(window, 5)
add(window, stackbox)
discard signal_connect(window, "destroy", 
                   SIGNAL_FUNC(ex8.destroy), nil)
show_all(window)
main()

