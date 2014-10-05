# This example shows how to use the GTK-Quartz Mac integration.
# Only compiles on OSX, obviously. Use -d:gtk_quartz when compiling.

import
  glib2, gtk2, gtkmacintegration, os

proc destroy(widget: PWidget, data: Pgpointer) {.cdecl.} =
  main_quit()

var
  application: POSXApplication
  window: PWidget
nimrod_init()

# OSX application initialization
application = POSXApplication(g_object_new(get_type(), nil))
var menubar = menu_bar_new()
var filemenu = menu_new()
var about = menu_item_new("About")
var separator = separator_menu_item_new()
var prefs = menu_item_new("Preferences")
var file = menu_item_new("File")
var filenew = menu_item_new("New")
file.set_submenu(filemenu)
filemenu.append(filenew)
menubar.append(file)
application.set_menu_bar(menubar)
menubar.show_all()
application.insert_app_menu_item(about, 0)
application.insert_app_menu_item(separator, 1)
application.insert_app_menu_item(prefs, 2)
ready(application)

# Window initialization
proc do_info_attention_request() {.cdecl.} =
  os.sleep(1000)
  discard application.attention_request(INFO_REQUEST)

proc do_critical_attention_request() {.cdecl.} =
  os.sleep(1000)
  discard application.attention_request(CRITICAL_REQUEST)

var button_attention_info = button_new("Info")
var button_attention_critical = button_new("Critical")
var hbox = hbox_new(true, 10)
hbox.pack_start(button_attention_info, false, false, 10)
hbox.pack_end(button_attention_critical, false, false, 10)
var vbox = vbox_new(true, 10)
var label = label_new("""
    Attention requests only work if the application doesn't
    have focus. To test them, click a button and change the focus elsewhere within
    one second.""")
vbox.pack_start(label, false, false, 5)
vbox.pack_end(hbox, false, false, 10)
window = window_new(WINDOW_TOPLEVEL)
PContainer(window).add(vbox)
discard signal_connect_object(button_attention_info, "clicked", 
                              SIGNAL_FUNC(gtk_quartz_ex1.do_info_attention_request), 
                              window)
discard signal_connect_object(button_attention_critical, "clicked", 
                              SIGNAL_FUNC(gtk_quartz_ex1.do_critical_attention_request), 
                              window)
discard signal_connect(window, "destroy",
                       SIGNAL_FUNC(gtk_quartz_ex1.destroy), nil)
window.show_all()
main()
