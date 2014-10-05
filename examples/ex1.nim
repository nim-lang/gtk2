import 
  glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer) {.cdecl.} =
  main_quit()

var
  window: PWidget
nimrod_init()
window = window_new(WINDOW_TOPLEVEL)
discard signal_connect(window, "destroy",
                       SIGNAL_FUNC(ex1.destroy), nil)
show(window)
main()
