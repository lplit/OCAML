open Graphics
open Geometry
open BoundingBox

module G = (val (init ()) : G)
  
type state = 
  { p : BoundingBox.Circle.t ;
    m : BoundingBox.Circle.t list
  }
  
let cr_state x y r v  = 
  { p = Circle.create r v (Point.create x y) ;
    m = [] 
  }
    
(* Global variables *)
let (click:float) = 15.
let (mv_left:Vector.t) = Vector.create (-.click) 0.
let (mv_right:Vector.t) = Vector.create click 0. 
let (mv_down:Vector.t) = Vector.create 0. click 
let (mv_up:Vector.t) = Vector.create 0. (-.click)
let (initial_state:state) = cr_state 400. 500. 10. 5.
let (go_on: bool ref)  = ref true


(* Functions *)

(* Adds new shoot to the list, coords: actual coords of ship *)
let add_shot (state:state) : state = 
  let (c:Circle.t)=Circle.create 2. 1. state.p.o in 
  match state.m with 
  | [] -> let a = {p=state.p ; m=[c] } in a
  | _ -> 
    let ls = c::state.m in
    let a = {p=state.p ; m = List.rev ls } in 
    a 

(* Checks if c is outside of the drawing zone *)
let c_outta_box (c:Circle.t) : bool = 
  c.o.Point.x > 800. || c.o.x < 0. || c.o.y > 600. || c.o.y < 0.

(* Removes shots from oustide the drawbox *)
let clean_shots_out (state:state) : state =
  let rec loop acc l = 
    match l with 
    | [] -> acc
    | h::t ->  if c_outta_box h (* || Circle.collide_with_any_of h state.en *) then 
	loop acc t
      else 
	loop (h::acc) t
  in
  let new_shots = loop [] state.m in 
  let a = { p=state.p ; m=new_shots } in
  a

(* Moves all the shots within the drawbox *)
let move_shots (state:state) : state =
  let newp = clean_shots_out state in
  let shots = List.map (fun a -> Circle.move mv_up a) newp.m in
  let a = {p=state.p ; m=shots} in
  a

(* Shows all the missiles on the screen *) 
let draw_bullets (player:state) : unit = 
  List.iter G.bullet player.m

let move_player (key:Sdlkey.t) (state:state) : state = 
  let cen = state.p.o in
  if cen.x >= (780. -. click) then 
    let (a:state)={p=Circle.move mv_left state.p ; m=state.m} in a
  else if cen.x <= click then
    let (a:state)={p=Circle.move mv_right state.p ; m=state.m} in a 
  else if cen.y >= (530. -. click) then 
    let (a:state)={p=Circle.move mv_up state.p ; m=state.m} in a
  else if cen.y <= click then
    let (a:state)={p=Circle.move mv_down state.p ; m=state.m} in a 
  else 
    match key with
    | Sdlkey.KEY_UP -> let (a:state)={p=Circle.move mv_up state.p ; m=state.m} in a
    | Sdlkey.KEY_DOWN -> let (a:state)={p=Circle.move mv_down state.p ; m=state.m} in a 
    | Sdlkey.KEY_RIGHT -> let (a:state)={p=Circle.move mv_right state.p ; m=state.m} in a 
    | Sdlkey.KEY_LEFT -> let (a:state)={p=Circle.move mv_left state.p ; m=state.m} in a
    | _ -> state
      
      
(* Manages keypresses *)
let update (key:Sdlkey.t) (state:state) : state =
  match key with
  | Sdlkey.KEY_UP -> move_player key state
  | Sdlkey.KEY_DOWN -> move_player key state
  | Sdlkey.KEY_RIGHT -> move_player key state
  | Sdlkey.KEY_LEFT -> move_player key state
  | Sdlkey.KEY_ESCAPE -> go_on := false ; state
  | Sdlkey.KEY_SPACE -> add_shot state 
  | _ -> state


(* Executes keyboard input *)
let updates (st:state) : state = 
  let keys_p = Events.get_keys () in
  List.fold_left (fun acc k -> update k acc) st keys_p


let display (pl:state) =
  G.clean () ; 
  draw_bullets pl ;
  G.player pl.p ;
  G.delay 30 ;
  G.flip ()

let refresh (a: state ref ) = 
  let keys = Sdlevent.get 5 in 
  Events.updates keys ; 
  a := updates !a ;
  a := move_shots !a

let play () =
  let state = ref initial_state in
  while !go_on do
    refresh state ;
    display !state
  done ;
  Graphics.quit ()
    
let _ = play () 



(*
module type G =
  sig
    val w : float
    val h : float
    val player : BoundingBox.Circle.t -> unit
    val bullet : BoundingBox.Circle.t -> unit
    val ennemy : BoundingBox.Circle.t -> unit
    val star : BoundingBox.Circle.t -> unit
    val score : int -> unit
    val flip : unit -> unit
    val clean : unit -> unit
    val ticks : unit -> int
    val delay : int -> unit
    val press_escape_to_continue : unit -> unit
    val win : unit -> unit
    val game_over : unit -> unit
  end
val init : unit -> (module G)
val quit : unit -> unit
*)
