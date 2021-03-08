
import 
  gdk2, glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  main_quit()

const 
  inside: cstring = "Mouse is over label"
  outside: cstring = "Mouse is not over label"

var 
  overButton: bool

nim_init()
var window = window_new(gtk2.WINDOW_TOPLEVEL)
var stackbox = vbox_new(true, 10)
var button1 = button_new("Move mouse over button")
var buttonStyle = copy(get_style(button1))
buttonStyle.bg[STATE_PRELIGHT].pixel = 0
buttonStyle.bg[STATE_PRELIGHT].red = uint16.high
buttonStyle.bg[STATE_PRELIGHT].blue = 0
buttonStyle.bg[STATE_PRELIGHT].green = 0
set_style(button1, buttonstyle) # TODO: BUG doesn't work
var button2 = button_new()
var aLabel = label_new(outside)


proc changeLabel(P: PWidget, event: gdk2.PEventCrossing, 
                 data: var bool){.cdecl.} = 
  if not data: set_text(aLabel, inside)
  else: set_text(aLabel, outside)
  data = not data


add(button2, aLabel)
pack_start(stackbox, button1, true, true, 0)
pack_start(stackbox, button2, true, true, 0)
set_border_width(window, 5)
add(window, stackbox)
discard signal_connect(window, "destroy", 
                   SIGNAL_FUNC(ex9.destroy), nil)
overButton = false
discard signal_connect(button1, "enter_notify_event", 
                   SIGNAL_FUNC(changeLabel), addr(overButton))
discard signal_connect(button1, "leave_notify_event", 
                   SIGNAL_FUNC(changeLabel), addr(overButton))
show_all(window)
main()
