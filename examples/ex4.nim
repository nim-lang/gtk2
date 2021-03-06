
import 
  glib2, gtk2

proc newbutton(ALabel: cstring): PWidget = 
  result = button_new(ALabel)
  show(result)

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  main_quit()

nim_init()
var window = window_new(WINDOW_TOPLEVEL)
var maintable = table_new(6, 6, true)

proc AddToTable(Widget: PWidget, Left, Right, Top, Bottom: guint) = 
  attach_defaults(mainTable, Widget, Left, Right, Top, Bottom)

show(mainTable)
AddToTable(newbutton("1,1 At 1,1"), 1, 2, 1, 2)
AddToTable(newbutton("2,2 At 3,1"), 3, 5, 1, 3)
AddToTable(newbutton("4,1 At 4,1"), 1, 5, 4, 5) # Put all in window
set_border_width(window, 5)
add(window, maintable)
discard signal_connect(window, "destroy", 
                       SignalFunc(ex4.destroy), nil)
show(window)
main()

