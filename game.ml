open Graphics
open Geometry
open BoundingBox

module G = (val (init ()) : G)
  
type state = { 
  p : BoundingBox.Circle.t ;
}
let print_pressed_keys (l:Sdlkey.t list) =
  List.map (fun a -> Sdlkey.name a ) l
  
let cr_state x y r v  = 
  { p = Circle.create r v (Point.create x y) }
    
(* Global variables *) 
let (mv_left:Vector.t) = Vector.create (-15.) 0.
let (mv_right:Vector.t) = Vector.create 15. 0. 
let (mv_down:Vector.t) = Vector.create 0. 15. 
let (mv_up:Vector.t) = Vector.create 0. (-15.)
let (initial_state:state) = cr_state 400. 550. 10. 10.

(* Functions *)

(* Key + state(player) -> player with modfied position *)
let move_player (key:Sdlkey.t) (state:state) : state = 
  match key with
  | Sdlkey.KEY_UP ->
    let (a:state)={p=Circle.move mv_up state.p} in Printf.printf "Up\n" ;  a
  | Sdlkey.KEY_DOWN -> 
    let a={p=Circle.move mv_down state.p} in Printf.printf "Down\n" ; a 
  | Sdlkey.KEY_RIGHT -> 
    let a={p=Circle.move mv_right state.p} in Printf.printf "Right\n" ; a 
  | Sdlkey.KEY_LEFT -> 
    let a={p=Circle.move mv_left state.p} in Printf.printf "Left\n" ; a
  | _ -> state
      
(* if key pressed = move key then call move_player, 
   ignore rest, escape quits, space shoots *)
let update (key:Sdlkey.t) (state:state) : state =
(*  Printf.printf "Update called\n" ; *)
  match key with 
  | Sdlkey.KEY_UP -> Printf.printf "Going up\n" ; move_player key state
  | Sdlkey.KEY_DOWN -> Printf.printf "Going down\n" ; move_player key state
  | Sdlkey.KEY_RIGHT -> Printf.printf "Going right\n" ; move_player key state
  | Sdlkey.KEY_LEFT -> Printf.printf "Going left\n" ; move_player key state
  | Sdlkey.KEY_ESCAPE -> Graphics.quit () ; state
  | Sdlkey.KEY_SPACE -> state
  | _ -> state


(* gets all the pressed keys (Sdlevent.event list) , calls update on all the keys *)
let updates (st:state) : state = 
(*  Printf.printf "Updates called\n" ; *)
  let keys_p = Events.get_keys () in
  List.fold_left (fun acc k -> update k acc) st keys_p


let display (pl:state) =
  G.flip () ;
  G.player pl.p


let play () =
  let state = ref initial_state in
  while true do
    print_pressed_keys (Events.get_keys ()) ;
    state := updates !state;
    display !state
  done

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
