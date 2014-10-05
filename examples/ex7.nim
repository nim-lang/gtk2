
import 
  gdk2, glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  main_quit()

const 
  inside: cstring = "Mouse is over label"
  outside: cstring = "Mouse is not over label"

var 
  overLabel: bool

nimrod_init()
var window = window_new(gtk2.WINDOW_TOPLEVEL)
var stackbox = vbox_new(true, 10)
var box1 = event_box_new()
var label1 = label_new("Move mouse over label")
add(box1, label1)
var box2 = event_box_new()
var label2 = label_new(outside)
add(box2, label2)
pack_start(stackbox, box1, true, true, 0)
pack_start(stackbox, box2, true, true, 0)
set_border_width(window, 5)
add(window, stackbox)
discard signal_connect(window, "destroy", 
                   SIGNAL_FUNC(ex7.destroy), nil)
overlabel = false


proc changeLabel(P: PWidget, event: gdk2.PEventCrossing, 
                data: var bool){.cdecl.} = 
  if not data: set_text(label1, inside)
  else: set_text(label2, outside)
  data = not data


discard signal_connect(box1, "enter_notify_event", 
                   SIGNAL_FUNC(changeLabel), addr(overlabel))
discard signal_connect(box1, "leave_notify_event", 
                   SIGNAL_FUNC(changeLabel), addr(overlabel))
show_all(window)
main()

