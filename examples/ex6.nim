
import 
  glib2, gtk2

type 
  TButtonSignalState = object 
    obj: gtk2.Pobject
    signalID: int32
    disable: bool

  PButtonSignalState = ptr TButtonSignalState

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  main_quit()

# This function is used to close the window when clicking on the "Click me" button.
proc widgetDestroy(w: PWidget) {.cdecl.} = destroy(w)

proc disablesignal(widget: PWidget, data: Pgpointer){.cdecl.} = 
  var s = cast[PButtonSignalState](data)
  if s.disable: 
    signal_handler_block(s.obj, s.signalID.culong)
  else: 
    signal_handler_unblock(s.obj, s.signalID.gulong)
  s.disable = not s.disable

var 
  quitState: TButtonSignalState

nim_init()
var window = window_new(WINDOW_TOPLEVEL)
var quitbutton = button_new("Quit program")
var disablebutton = button_new("Disable button")
var windowbox = vbox_new(true, 10)
pack_start(windowbox, disablebutton, true, false, 0)
pack_start(windowbox, quitbutton, true, false, 0)
set_border_width(window, 10)
add(window, windowbox)
discard signal_connect(window, "destroy", SIGNAL_FUNC(ex6.destroy), nil)
quitState.obj = quitbutton
quitState.signalID = signal_connect_object(quitState.obj, "clicked", 
                       SIGNAL_FUNC(widgetDestroy), window).int32
quitState.disable = true
discard signal_connect(disablebutton, "clicked", 
                   SIGNAL_FUNC(disablesignal), addr(quitState))
show(quitbutton)
show(disablebutton)
show(windowbox)
show(window)
main()

