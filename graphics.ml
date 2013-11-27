open Sdl
open Sdlevent
open Sdltimer
open Sdlvideo

open BoundingBox
open Geometry

let w = 800
let h = 600
  
module type G = sig
  val w : float
  val h : float
  val player : Circle.t -> unit
  val bullet : Circle.t -> unit
  val ennemy : Circle.t -> unit
  val star : Circle.t -> unit
  val score : int -> unit
  val flip : unit -> unit
  val clean : unit -> unit
    
  val ticks : unit -> int
  val delay : int -> unit
  val press_escape_to_continue : unit -> unit
    
  val win : unit -> unit
  val game_over : unit -> unit
end
  
let build () =
  let int = int_of_float in
  let window = set_video_mode w h [ `HWSURFACE; `DOUBLEBUF ] in
  let sprites = Sdlloader.load_image "sprites.png" in
  Sdlttf.init ();
  let font = Sdlttf.open_font "joystix.ttf" 18 in
  Sdlttf.set_font_style font [ Sdlttf.NORMAL ];
  let module G = struct
      
    let w = float w
    let h = float h
      
    let player { Circle.o = o; r = r } =
      let open Point in
      let selection = rect 134 28 80 90 in
      let projection = rect (int (o.x -. r)) (int (o.y -. r)) 80 96 in
      blit_surface ~dst:window ~dst_rect:projection
	~src:sprites ~src_rect:selection ()
	
    let bullet { Circle.o = o; r = r } =
      let open Point in
      let selection = rect 378 698 20 20 in
      let projection = rect (int (o.x -. r)) (int (o.y -. r)) 20 20 in
      blit_surface ~dst:window ~dst_rect:projection
	~src:sprites ~src_rect:selection ()
	
    let ennemy { Circle.o = o; r = r } =
      let open Point in
      let selection = rect 136 520 64 64 in
      let projection = rect (int (o.x -. r)) (int (o.y -. r)) 64 64 in
      blit_surface ~dst:window ~dst_rect:projection
	~src:sprites ~src_rect:selection ()
	
    let star { Circle.o = o; r = r } =
      let open Point in
      let selection = rect 465 697 15 15 in
      let projection = rect (int (o.x -. r)) (int (o.y -. r)) 15 15 in
      blit_surface ~dst:window ~dst_rect:projection
	~src:sprites ~src_rect:selection ()
	
    let flip () = flip window
      
    let clean () = fill_rect window 0l
      
    let ticks = get_ticks
      
    let delay = delay
      
    let score s =
      let open Sdlttf in
      let text = "Score : " ^ (string_of_int s) in
      let surface = render_text_solid font text ~fg:Sdlvideo.white in
      let projection = rect 25 25 25 25 in
      blit_surface ~dst:window ~dst_rect:projection ~src:surface ()
	
    let rec press_escape_to_continue () =
      let ev = Sdlevent.wait_event () in
      match ev with
      | KEYDOWN { keysym = sym } ->
	begin
	  match sym with
	  | Sdlkey.KEY_ESCAPE -> ()
	  | _ -> press_escape_to_continue ()
	end
      | _ -> press_escape_to_continue ()
	
    let win () =
      let open Sdlttf in
      let int = int_of_float in
      let text = "You win..." in
      let surface = render_text_solid font text ~fg:Sdlvideo.white in
      let projection = rect ((int w) / 2 - 50) ((int h) / 2) 100 50 in
      blit_surface ~dst:window ~dst_rect:projection ~src:surface ()
	
    let game_over () =
      let open Sdlttf in
      let int = int_of_float in
      let text = "Game over..." in
      let surface = render_text_solid font text ~fg:Sdlvideo.white in
      let projection = rect ((int w) / 2 - 100) ((int h) / 2) 100 50 in
      blit_surface ~dst:window ~dst_rect:projection ~src:surface ()
	
  end in
  (module G : G)
    
let init () =
  init [`VIDEO; `TIMER; `EVENTTHREAD];
  enable_events keyboard_event_mask;
  pump ();
  build ()
    
let quit () =
  quit ()
    
