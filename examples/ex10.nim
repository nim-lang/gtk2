import
  glib2, gdk2, gtk2, cairo, strutils, math

var 
  gcount : int = 0
  gpos=[0,0]

proc expose_proc(widget: PWidget, event: PEventExpose, cv: PDrawable): gboolean {.cdecl.} =
    let cairo : PContext = widget.window.cairo_create();
    ### a text    
    cairo.move_to(20, 110)
    cairo.select_font_face("Arial",  FONT_SLANT_ITALIC, FONT_WEIGHT_BOLD)
    cairo.set_font_size(14.0)
    cairo.show_text("Hello, cairo")

    cairo.select_font_face("Arial",  FONT_SLANT_NORMAL, FONT_WEIGHT_BOLD)    
    cairo.set_font_size(10.0)
    cairo.move_to(4, 200-4);
    cairo.show_text("Press mouse button, and move it...")
    
    cairo.move_to(20, 130);
    cairo.set_font_size(24.0)
    cairo.show_text("Nim!")
    # a polyline
    cairo.move_to(0,0)
    cairo.line_to(100,100)
    cairo.line_to(100,0)
    cairo.line_to(0,100)
    cairo.line_to(100,100)
    cairo.stroke
    # a rectangle
    cairo.rectangle(110, 10, 30,30)
    cairo.stroke  
    cairo.rectangle(110, 50, 30,30)
    cairo.fill
    # polygone
    # a polyline
    cairo.translate(10,20)
    cairo.move_to(100,100)
    cairo.line_to(150,110)
    cairo.line_to(200,100)
    cairo.line_to(155,130)
    cairo.line_to(100,100)
    cairo.close_path
    cairo.fill
    cairo.translate(-10,-20)
    # arc 
    cairo.move_to(50,160)
    cairo.arc(50,160,20,0.0, -3.1415/3.0)
    cairo.close_path
    cairo.stroke
    cairo.arc(10,160,10,0.0, -3.1415/3.0)
    cairo.close_path
    cairo.fill
    # color/opacity fg/bg
    cairo.set_source_rgba(1.0, 0.1, 0.1 , 1.0)  
    cairo.rectangle(110, 90, 30,30)
    cairo.fill
    cairo.set_source_rgba(0.0, 0.3, 0.8 , 0.5)  
    cairo.rectangle(120, 20, 40,30)
    cairo.fill
    # animation :)
    gcount=(gcount+1) %% 360
    cairo.set_source_rgba(0.3, float(1+gcount)/360.0, 0.3 , 1.0)  
    cairo.move_to(90,51)
    cairo.arc(90,51,8,0.0, (2*3.1415/360.0)*(float(gcount)))
    cairo.close_path
    cairo.stroke
    # mouse position
    
    cairo.set_source_rgba(1.0, 0.0, 0.1 , 1.0)  
    cairo.rectangle(float(gpos[0]-5), float(gpos[1]-5), 10.0,10.0)
    cairo.fill
    
    # end expose event
    cairo.destroy()
    result=false

############################# Handler n drawing area

var gmousePressed: bool
proc click_proc(widget: PWidget, event: TEventButton): gboolean {.cdecl.} =
  echo("mouse-button press x=" & $event.x & 
    " y=" & $event.y & " button=" & $event.button & 
    " state=" &  $event.state)
  gpos=[int(event.x),int(event.y)]
  gmousePressed=true
proc motion_proc(widget: PWidget, event: TEventButton): gboolean {.cdecl.} =  
  if gmousePressed:
    echo("mouse-button motion x=" & $event.x & 
      " y=" & $event.y & " button=" & $event.button & 
      " state=" & $event.state)
    gpos=[int(event.x),int(event.y)]
    widget.queue_draw_area(0,0,200,200)
    
proc release_proc(widget: PWidget, event: TEventButton): gboolean {.cdecl.} =
  echo("mouse-button-release")
  gmousePressed=false
  

proc mainnQuit(widget: PWidget, data: Pgpointer) {.cdecl.} =
  echo("quit")
  main_quit()

################################ Main

nim_init()
let win = window_new(gtk2.WINDOW_TOPLEVEL)
let content = vbox_new(true,10)
win.set_title("Gtk: " & " essai")
win.set_default_size(200,200)

#------------- Drawing

let cv=  drawing_area_new()
add_events(PWIDGET(cv),gint(
  EXPOSURE_MASK + BUTTON_PRESS_MASK + POINTER_MOTION_MASK + 
  BUTTON_RELEASE_MASK + KEY_PRESS_MASK))

discard signal_connect(cv, "expose-event",        SIGNAL_FUNC(exposeProc)  , cv.window)
discard signal_connect(cv, "button-press-event",  SIGNAL_FUNC(click_proc)  , cv)
discard signal_connect(cv, "motion-notify-event", SIGNAL_FUNC(motion_proc) , cv)
discard signal_connect(cv, "button-release-event",SIGNAL_FUNC(release_proc), cv)

cv.set_size_request(200, 200)
content.add( cv )

#periodic cb for animation
proc timer_proc() =
  cv.queue_draw_area(0,0,200,200) #  generate a expose-event, which call expose_proc() via gtk, each 50 ms

discard g_timeout_add(50, timer_proc, nil)

win.add(content)
cv.show()
win.show_all()
discard signal_connect(win, "destroy", SIGNAL_FUNC(mainnQuit), win)
main()

 
  
