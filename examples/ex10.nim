import
  gtk2, gdk2, cairo, glib2


var
  gcount: int = 0
  gpos=[0,0]
  buttonPressed: bool

proc expose_proc(widget: PWidget, event: PEventExpose): gboolean {.cdecl.} =
  let cr : PContext = widget.window.cairo_create()
  
  ### some texts
  cr.move_to(20, 110)
  cr.select_font_face("Arial",FONT_SLANT_NORMAL,FONT_WEIGHT_BOLD)
  cr.set_font_size(14.0)
  cr.show_text("Hello, cairo")
  cr.move_to(20, 130)
  cr.set_font_size(24.0)
  cr.show_text("Nim!")
  
  # a polyline
  cr.move_to(0,0)
  cr.line_to(100,100)
  cr.line_to(100,0)
  cr.line_to(0,100)
  cr.line_to(100,100)
  cr.stroke
  
  # some rectangles
  cr.rectangle(110, 10, 30,30)
  cr.stroke
  cr.rectangle(110, 50, 30,30)
  cr.fill
  
  # a polygone
  cr.translate(10,20)
  cr.move_to(100,100)
  cr.line_to(150,110)
  cr.line_to(200,100)
  cr.line_to(155,130)
  cr.line_to(100,100)
  cr.close_path
  cr.fill
  cr.translate(-10,-20)
  
  # arc
  cr.move_to(50,160)
  cr.arc(50,160,20,0.0, -3.1415/3.0)
  cr.close_path
  cr.stroke
  cr.arc(10,160,10,0.0, -3.1415/3.0)
  cr.close_path
  cr.fill
  
  # color/opacity fg/bg
  cr.set_source_rgba(1.0, 0.1, 0.1 , 1.0)
  cr.rectangle(110, 90, 30,30)
  cr.fill
  cr.set_source_rgba(0.0, 0.3, 0.8 , 0.5)
  cr.rectangle(120, 20, 40,30)
  cr.fill
  
  # animation : timer generate
  gcount=(gcount+1) %% 360
  cr.set_source_rgba(0.3, float(1+gcount)/360.0, 0.3 , 1.0)
  cr.move_to(90,51)
  cr.arc(90,51,8,0.0, (2*3.1415/360.0)*(float(gcount)))
  cr.close_path
  cr.stroke
  
  # show mouse position

  cr.set_source_rgba(1.0, 0.0, 0.1 , 1.0)
  cr.rectangle(float(gpos[0]-5), float(gpos[1]-5), 10.0,10.0)
  cr.fill

  # end expose event
  cr.destroy()
  result=false

########################### Callbacks

proc click_proc(w: PWidget, ev: TEventButton): gboolean {.cdecl.} =
  echo("mouse-button press x=" & $ev.x &
    " y=" & $ev.y & " button=" & $ev.button &
    " state=" &  $ev.state)
  gpos=[int(ev.x),int(ev.y)]
  buttonPressed=true

proc motion_proc(widget: PWidget, ev: TEventButton): gboolean {.cdecl.} =
  if buttonPressed:
    echo("mouse-button motion x=" & $ev.x &
      " y=" & $ev.y & " button=" & $ev.button &
      " state=" & $ev.state)
    gpos=[int(ev.x),int(ev.y)]
    widget.queue_draw_area(0,0,200,200)

proc release_proc(widget: PWidget, ev: TEventButton): gboolean {.cdecl.} =
  echo("mouse-button-release")
  buttonPressed=false


proc mainnQuit(widget: PWidget, data: Pgpointer) {.cdecl.} =
  echo("quit")
  main_quit()

####################################################
##                 M a i n
####################################################

nim_init()
let win = window_new(gtk2.WINDOW_TOPLEVEL)
let content = vbox_new(true,10)
win.set_title("Gtk: " & " essai")
win.set_default_size(200,200)

########### DrawingArea

let cv=  drawing_area_new()
add_events(PWIDGET(cv),gint(EXPOSURE_MASK + BUTTON_PRESS_MASK + 
          POINTER_MOTION_MASK + BUTTON_RELEASE_MASK + KEY_PRESS_MASK))

discard signal_connect(cv,"expose-event"        ,SIGNAL_FUNC(exposeProc), nil)
discard signal_connect(cv,"button-press-event"  ,SIGNAL_FUNC(click_proc), nil)
discard signal_connect(cv,"motion-notify-event" ,SIGNAL_FUNC(motion_proc),nil)
discard signal_connect(cv,"button-release-event",SIGNAL_FUNC(release_proc),nil)

cv.set_size_request(200, 200)
content.add( cv )

proc timer_proc() = cv.queue_draw_area(0,0,200,200)

discard g_timeout_add(50, timer_proc, nil)

win.add(content)
win.show_all()
discard signal_connect(win, "destroy", SIGNAL_FUNC(mainnQuit), win)
main()



