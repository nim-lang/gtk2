{.deadCodeElim: on.}
{.push gcsafe.}
import
  glib2, gdk2, gdk2pixbuf, gtk2

const
  lib = "(libgtkmacintegration.2.dylib|libgtkmacintegration-gtk2.2.dylib)"

type
  POSXApplication* = ptr TOSXApplication
  TOSXApplication* = object of TGObject
    private_data*: gpointer

  POSXApplicationClass* = ptr TOSXApplicationClass
  TOSXApplicationClass* = object of TGObjectClass

  TOSXApplicationAttentionType* = enum
    CRITICAL_REQUEST = 0, INFO_REQUEST = 10

proc get_type*(): GType{.cdecl, dynlib: lib,
    importc: "gtkosx_application_get_type".}

proc get*(): POSXApplication{.cdecl, dynlib: lib,
    importc: "gtkosx_application_get".}

proc ready*(application: POSXApplication){.cdecl, dynlib: lib,
    importc: "gtkosx_application_ready".}

proc set_use_quartz_accelerators*(application: POSXApplication,
                                 value: gboolean){.cdecl, dynlib: lib,
    importc: "gtkosx_set_use_quartz_accelerators".}

proc use_quartz_accelerators*(application: POSXApplication): gboolean {.cdecl,
    dynlib: lib, importc: "gtkosx_application_use_quartz_accelerators".}

proc set_menu_bar*(application: POSXApplication, menu_shell: PMenuShell){.cdecl,
    dynlib: lib, importc: "gtkosx_application_set_menu_bar".}

proc sync_menubar*(application: POSXApplication){.cdecl, dynlib: lib,
    importc: "gtkosx_application_sync_menubar".}

proc insert_app_menu_item*(application: POSXApplication, menu_item: PWidget,
                           index: gint){.cdecl, dynlib: lib,
     importc: "gtkosx_application_insert_app_menu_item".}

proc set_window_menu*(application: POSXApplication, menu_item: PMenuItem){.cdecl,
    dynlib: lib, importc: "gtkosx_application_set_window_menu".}

proc set_help_menu*(application: POSXApplication, menu_item: PMenuItem){.cdecl,
    dynlib: lib, importc: "gtkosx_application_set_help_menu".}

proc set_dock_menu*(application: POSXApplication, menu_shell: PMenuShell){.cdecl,
    dynlib: lib, importc: "gtkosx_application_set_dock_menu".}

proc set_dock_icon_pixbuf*(application: POSXApplication, pixbuf: PPixbuf){.cdecl,
    dynlib: lib, importc: "gtkosx_application_set_dock_icon_pixbuf".}

proc set_dock_icon_resource*(application: POSXApplication,
                            name, resoucer_type, subdir : cstring){.cdecl, dynlib: lib,
     importc: "gtkosx_application_set_dock_item_resource".}

proc attention_request*(application: POSXApplication,
                        kind: TOSXApplicationAttentionType): gint {.cdecl,
    dynlib: lib, importc: "gtkosx_application_attention_request".}

proc cancel_attention_request*(application: POSXApplication, id: gint){.cdecl,
    dynlib: lib, importc: "gtkosx_application_cancel_attention_request".}

proc get_bundle_path*(): cstring{.cdecl, dynlib: lib,
    importc: "gtkosx_application_get_bundle_path".}

proc get_resource_path*(): cstring{.cdecl, dynlib: lib,
    importc: "gtkosx_application_get_resource_path(".}

proc get_executable_path*(): cstring{.cdecl, dynlib: lib,
    importc: "gtkosx_application_get_executable_path".}

proc get_bundle_id*(): cstring{.cdecl, dynlib: lib,
    importc: "gtkosx_application_get_bundle_id".}

proc get_bundle_info*(key : cstring): cstring{.cdecl, dynlib: lib,
    importc: "gtkosx_application_get_bundle_info".}
{.pop.}
