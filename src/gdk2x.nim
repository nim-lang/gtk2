{.deadCodeElim: on.}
import gdk2, glib2, gdk2pixbuf, pango, cairo
import x, xlib , xutil

when defined(win32):
  const
    lib = "libgdk-win32-2.0-0.dll"
elif declared(gtk_quartz):
  const
    lib = "libgdk-quartz-2.0.dylib"
elif defined(macosx):
  const
    lib = "libgdk-x11-2.0.dylib"
else:
  const
    lib = "libgdk-x11-2.0.so(|.0)"

proc x11_drawable_get_xdisplay*(drawable: gdk2.PDrawable): xlib.PDisplay  {.cdecl,
 dynlib: lib, importc: "gdk_x11_drawable_get_xdisplay".}
proc x11_drawable_get_xid*(drawable: gdk2.PDrawable): TXID  {.cdecl,
 dynlib: lib, importc: "gdk_x11_drawable_get_xid".}
proc x11_window_get_drawable_impl*(window: gdk2.PWindow): gdk2.PDrawable {.cdecl,
 dynlib: lib, importc: "gdk_x11_window_get_drawable_impl".}
proc x11_pixmap_get_drawable_impl*(pixmap: gdk2.PPixmap): gdk2.PDrawable {.cdecl,
 dynlib: lib, importc: "gdk_x11_pixmap_get_drawable_impl".}
proc x11_image_get_xdisplay*(image: PImage): xlib.PDisplay {.cdecl,
 dynlib: lib, importc: "gdk_x11_image_get_xdisplay".}
proc x11_image_get_ximage*(image: PImage): PXImage {.cdecl,
 dynlib: lib, importc: "gdk_x11_image_get_ximage".}
proc x11_colormap_get_xdisplay*(colormap: gdk2.PColormap): xlib.PDisplay {.cdecl,
 dynlib: lib, importc: "gdk_x11_colormap_get_xdisplay".}
proc x11_colormap_get_xcolormap*(colormap: gdk2.PColormap): x.PColormap {.cdecl,
 dynlib: lib, importc: "gdk_x11_colormap_get_xcolormap".}
proc x11_cursor_get_xdisplay*(cursor: gdk2.PCursor): xlib.PDisplay {.cdecl,
 dynlib: lib, importc: "gdk_x11_cursor_get_xdisplay".}
proc x11_cursor_get_xcursor*(cursor: gdk2.PCursor): x.PCursor {.cdecl,
 dynlib: lib, importc: "gdk_x11_cursor_get_xcursor".}
proc x11_display_get_xdisplay*(display: gdk2.PDisplay): xlib.PDisplay {.cdecl,
 dynlib: lib, importc: "gdk_x11_display_get_xdisplay".}
proc x11_visual_get_xvisual*(visual: gdk2.PVisual): xlib.PVisual {.cdecl,
 dynlib: lib, importc: "gdk_x11_visual_get_xvisual".}
proc x11_screen_get_xscreen*(screen: gdk2.PScreen): xlib.PScreen {.cdecl,
    dynlib: lib, importc: "gdk_x11_screen_get_xscreen".}
proc x11_screen_get_screen_number*(screen: gdk2.PScreen): cint {.cdecl,
    dynlib: lib, importc: "gdk_x11_screen_get_screen_number".}
proc x11_window_set_user_time*(window: gdk2.PWindow, timestamp: guint32) {.cdecl,
    dynlib: lib, importc: "gdk_x11_window_set_user_time".}
proc x11_window_move_to_current_desktop*(window: gdk2.PWindow) {.cdecl,
    dynlib: lib, importc: "gdk_x11_window_move_to_current_desktop".}
proc x11_screen_get_window_manager_name*(screen: gdk2.PScreen): cstring {.cdecl,
    dynlib: lib, importc: "gdk_x11_screen_get_window_manager_name".}

# NOT Multihead safe
proc x11_get_default_root_xwindow*(): x.PWindow {.cdecl,
    dynlib: lib, importc: "gdk_x11_get_default_root_xwindow".}
proc x11_get_default_xdisplay*(): xlib.PDisplay {.cdecl,
  dynlib: lib, importc: "gdk_x11_get_default_xdisplay".}
proc x11_get_default_screen*(): gint {.cdecl,
  dynlib: lib, importc: "gdk_x11_get_default_screen".}
# -- not multihead safe
proc COLORMAP_XDISPLAY*(cmap: gdk2.PColormap): xlib.PDisplay =
  result = x11_colormap_get_xdisplay(cmap)
proc COLORMAP_XCOLORMAP*(cmap: gdk2.PColormap): x.PColormap =
  result = x11_colormap_get_xcolormap(cmap)
proc CURSOR_XDISPLAY*(cursor: gdk2.PCursor): xlib.PDisplay =
  result = x11_cursor_get_xdisplay(cursor)
proc CURSOR_XCURSOR*(cursor: gdk2.PCursor): x.PCursor =
  result = x11_cursor_get_xcursor(cursor)
proc IMAGE_XDISPLAY*(image: PImage): xlib.PDisplay =
  result = x11_image_get_xdisplay(image)
proc IMAGE_XIMAGE*(image: PImage): PXImage =
  result = x11_image_get_ximage(image)

# NOT Multihead safe
proc ROOT_WINDOW*(): x.PWindow =
  result = x11_get_default_root_xwindow()
# -- not multihead safe
proc DISPLAY_XDISPLAY*(display: gdk2.PDisplay): xlib.PDisplay =
  result = x11_display_get_xdisplay(display)
proc WINDOW_XDISPLAY*(win: gdk2.PWindow): xlib.PDisplay  =
  result = x11_drawable_get_xdisplay(x11_window_get_drawable_impl(win))
proc WINDOW_XID*(win: gdk2.PWindow): TXID =
  result = x11_drawable_get_xid(win)
proc WINDOW_XWINDOW*(win: gdk2.PWindow): TXID =
  result = x11_drawable_get_xid(win)
proc PIXMAP_XDISPLAY*(win: gdk2.PPixmap): xlib.PDisplay =
  result = x11_drawable_get_xdisplay(x11_pixmap_get_drawable_impl(win))
proc PIXMAP_XID*(win: gdk2.PDrawable): TXID =
  result = x11_drawable_get_xid(win)
proc DRAWABLE_XDISPLAY*(win: gdk2.PDrawable): xlib.PDisplay =
  result = x11_drawable_get_xdisplay(win)
proc DRAWABLE_XID*(win: gdk2.PDrawable): TXID =
  result = x11_drawable_get_xid(win)
proc SCREEN_XDISPLAY*(screen: gdk2.PScreen): xlib.PDisplay =
  result = x11_display_get_xdisplay(gdk2.get_display(screen))
proc SCREEN_XSCREEN*(screen: gdk2.PScreen): xlib.PScreen =
  result = x11_screen_get_xscreen(screen)
proc SCREEN_XNUMBER*(screen: gdk2.PScreen): cint =
  result = x11_screen_get_screen_number(screen)
proc VISUAL_XVISUAL*(visual: gdk2.PVisual): xlib.PVisual =
  result = x11_visual_get_xvisual(visual)

proc x11_screen_lookup_visual*(screen: gdk2.PScreen,
   xvisualid: x.PVisualID): gdk2.PVisual {.cdecl,
    dynlib: lib, importc: "gdk_x11_screen_lookup_visual".}
proc x11_colormap_foreign_new*(visual: gdk2.PVisual,
 xcolormap: x.PColormap): gdk2.PColormap {.cdecl,
    dynlib: lib, importc: "gdk_x11_colormap_foreign_new".}
proc x11_get_server_time*(window: gdk2.PWindow): guint32 {.cdecl,
    dynlib: lib, importc: "gdk_x11_get_server_time".}
proc x11_display_get_user_time*(display: gdk2.PDisplay): guint32 {.cdecl,
    dynlib: lib, importc: "gdk_x11_display_get_user_time".}
proc x11_display_get_startup_notification_id*(display: gdk2.PDisplay): PPgchar {.cdecl,
    dynlib: lib, importc: "gdk_x11_display_get_startup_notification_id".}
proc x11_display_set_cursor_theme*(display: gdk2.PDisplay, theme: PPgchar, size: gint) {.cdecl,
    dynlib: lib, importc: "gdk_x11_display_set_cursor_theme".}
proc x11_display_broadcast_startup_message*(display: gdk2.PDisplay,
    message_type: cstring) {.cdecl, varargs,
    dynlib: lib, importc: "gdk_x11_display_broadcast_startup_message".}
proc x11_screen_supports_net_wm_hint*(screen: gdk2.PScreen, property: gdk2.PAtom): gboolean {.cdecl,
    dynlib: lib, importc: "gdk_x11_screen_supports_net_wm_hint".}
proc x11_screen_get_monitor_output*(screen: gdk2.PScreen; monitor_num: gint): PXID {.cdecl,
    dynlib: lib, importc: "gdk_x11_screen_get_monitor_output".}

# NOT Multihead safe
proc x11_grab_server*() {.cdecl,
  dynlib: lib, importc: "gdk_x11_grab_server".}
proc x11_ungrab_server*() {.cdecl,
  dynlib: lib, importc: "gdk_x11_ungrab_server".}
# -- not multihead safe
proc x11_lookup_xdisplay*(xdisplay: xlib.PDisplay): gdk2.PDisplay {.cdecl,
    dynlib: lib, importc: "gdk_x11_lookup_xdisplay".}
proc x11_atom_to_xatom_for_display*(display: gdk2.PDisplay,
    atom: gdk2.PAtom): x.PAtom {.cdecl,
      dynlib: lib, importc: "gdk_x11_atom_to_xatom_for_display".}
proc x11_xatom_to_atom_for_display*(display: gdk2.PDisplay,
    xatom: x.PAtom): gdk2.PAtom {.cdecl,
      dynlib: lib, importc: "gdk_x11_xatom_to_atom_for_display".}
proc x11_get_xatom_by_name_for_display*(display: gdk2.PDisplay,
    atom_name: PPgchar): x.PAtom {.cdecl,
      dynlib: lib, importc: "gdk_x11_get_xatom_by_name_for_display".}
proc x11_get_xatom_name_for_display*(display: gdk2.PDisplay,
    xatom: x.PAtom): PPgchar {.cdecl,
      dynlib: lib, importc: "gdk_x11_get_xatom_name_for_display".}

proc x11_atom_to_xatom*(atom: gdk2.PAtom): x.PAtom {.cdecl,
  dynlib: lib, importc: "gdk_x11_atom_to_xatom".}
proc x11_xatom_to_atom*(xatom: x.PAtom): gdk2.PAtom {.cdecl,
  dynlib: lib, importc: "gdk_x11_xatom_to_atom".}
proc x11_get_xatom_by_name*(atom_name: PPgchar): x.PAtom {.cdecl,
  dynlib: lib, importc: "gdk_x11_get_xatom_by_name".}
proc x11_get_xatom_name*(xatom: x.PAtom): PPgchar {.cdecl,
  dynlib: lib, importc: "gdk_x11_get_xatom_name".}
proc x11_display_grab*(display: gdk2.PDisplay) {.cdecl,
    dynlib: lib, importc: "gdk_x11_display_grab".}
proc x11_display_ungrab*(display: gdk2.PDisplay) {.cdecl,
    dynlib: lib, importc: "gdk_x11_display_ungrab".}
proc x11_register_standard_event_type*(display: gdk2.PDisplay,
    event_base: gint, n_events: gint) {.cdecl,
      dynlib: lib, importc: "gdk_x11_register_standard_event_type".}
proc x11_set_sm_client_id*(sm_client_id: glib2.PPgchar) {.cdecl,
    dynlib: lib, importc: "gdk_x11_set_sm_client_id".}
proc x11_window_foreign_new_for_display*(display: gdk2.PDisplay,
    window: x.PWindow): gdk2.PWindow {.cdecl,
      dynlib: lib, importc: "gdk_x11_window_foreign_new_for_display".}
proc x11_window_lookup_for_display*(display: gdk2.PDisplay,
    window: x.PWindow): gdk2.PWindow {.cdecl,
      dynlib: lib, importc: "gdk_x11_window_lookup_for_display".}
proc x11_display_text_property_to_text_list*(display: gdk2.PDisplay,
    encoding: gdk2.PAtom, format: gint, text: PPguchar, length: gint,
    list: PPPgchar): gint {.cdecl,
      dynlib: lib, importc: "gdk_x11_display_text_property_to_text_list".}
proc x11_free_text_list*(list: PPgchar) {.cdecl,
    dynlib: lib, importc: "gdk_x11_free_text_list".}
proc x11_display_string_to_compound_text*(display: gdk2.PDisplay,
    str: PPgchar, encoding: gdk2.PAtom, format: gint,
    ctext: PPPgchar, length: gint): gint {.cdecl,
    dynlib: lib, importc: "gdk_x11_display_string_to_compound_text".}
proc x11_display_utf8_to_compound_text*(display: gdk2.PDisplay,
    str: PPgchar, encoding: gdk2.PAtom, format: gint,
    ctext: PPPgchar, length: gint): gboolean {.cdecl,
    dynlib: lib, importc: "gdk_x11_display_utf8_to_compound_text".}
proc x11_free_compound_text*(ctext: PPguchar) {.cdecl,
    dynlib: lib, importc: "gdk_x11_free_compound_text".}
