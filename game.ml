open Graphics
open Geometry
open BoundingBox

module G = (val (init ()) : G)
  
type state = 
  { p : BoundingBox.Circle.t ;
    m : BoundingBox.Circle.t list
  }
  
let print_pressed_keys (l:Sdlkey.t list) =
  List.map (fun a -> Sdlkey.name a ) l
    
let cr_state x y r v  = 
  { p = Circle.create r v (Point.create x y) ;
    m = [] 
  }
    
(* Global variables *) 
let (mv_left:Vector.t) = Vector.create (-15.) 0.
let (mv_right:Vector.t) = Vector.create 15. 0. 
let (mv_down:Vector.t) = Vector.create 0. 15. 
let (mv_up:Vector.t) = Vector.create 0. (-15.)
let (initial_state:state) = cr_state 400. 550. 10. 10.
let (go_on: bool ref)  = ref true


(* Functions *)

(* Adds new shoot to the list, coords: actual coords of ship *)
let add_shoot (state:state) : state = 
  let (c:Circle.t)=Circle.create 5. 5. state.p.o in 
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
  let shots = state.m in 
  let rec loop acc l = 
    match l with 
    | [] -> acc
    | h::t ->  if c_outta_box h then 
	loop (h::acc) t
      else 
	loop acc t
  in 
  let a = { p=state.p ; m=loop [] shots } in
  a 
    
(* Moves all the shots within the drawbox *)
let move_shots (state:state) : state = 
  let newp = clean_shots_out state in
  let shots = List.map (fun a -> Circle.move mv_up a) newp.m in 
  let a = {p=state.p ; m=shots} in 
  a
    
(* val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
List.fold_left f a [b1; ...; bn] is f (... (f (f a b1) b2) ...) bn. 

let updates (st:state) : state = 
  let keys_p = Events.get_keys () in
  List.fold_left (fun acc k -> update k acc) st keys_p
*)

let draw_bullets (player:state) : unit = 
  List.iter G.bullet player.m

let move_player (key:Sdlkey.t) (state:state) : state = 
  if c_outta_box state.p then 
    state
  else 
    match key with
    | Sdlkey.KEY_UP -> let (a:state)={p=Circle.move mv_up state.p ; m=state.m} in a
    | Sdlkey.KEY_DOWN -> let (a:state)={p=Circle.move mv_down state.p ; m=state.m} in a 
    | Sdlkey.KEY_RIGHT -> let (a:state)={p=Circle.move mv_right state.p ; m=state.m} in a 
    | Sdlkey.KEY_LEFT -> let (a:state)={p=Circle.move mv_left state.p ; m=state.m} in a
    | _ -> state
      
      
(* if key pressed = move key then call move_player, 
   ignore rest, escape quits, space shoots *)
let update (key:Sdlkey.t) (state:state) : state =
  match key with 
  | Sdlkey.KEY_UP -> move_player key state
  | Sdlkey.KEY_DOWN -> move_player key state
  | Sdlkey.KEY_RIGHT -> move_player key state
  | Sdlkey.KEY_LEFT -> move_player key state
  | Sdlkey.KEY_ESCAPE -> go_on := false ; state
  | Sdlkey.KEY_SPACE -> add_shoot state 
  | _ -> state


(* gets all the pressed keys (Sdlevent.event list) , calls update on all the keys *)
let updates (st:state) : state = 
  let keys_p = Events.get_keys () in
  List.fold_left (fun acc k -> update k acc) st keys_p


let display (pl:state) =
  G.clean () ; 
  G.player pl.p ;
  G.delay 30 ;
  G.flip ()


let refresh (a: state ref ) = 
  let keys = Sdlevent.get 5 in 
  Events.updates keys ; 
  a := updates !a


let play () =
  let state = ref initial_state in
  while !go_on do
    refresh state ;
    move_shots !state ; 
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
