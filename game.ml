open Graphics
open Geometry
open BoundingBox

module G = (val (init ()) : G)

type state = { 
  p : BoundingBox.Circle.t ;
}

(* Global variables *) 
let (mv_left:Vector.t) = Vector.create (-5.) 0.
let (mv_right:Vector.t) = Vector.create 5. 0. 
let (mv_down:Vector.t) = Vector.create 0. 5. 
let (mv_up:Vector.t) = Vector.create 0. (-5.)
		      
(* Functions *)

(* Key + state(player) -> player with modfied position *)
let move_player (key:Sdlkey.t) (state:state) : state = 
  match key with
  | Sdlkey.KEY_UP ->
    let (a:state)={p=Circle.move mv_up state.p} in a
  | Sdlkey.KEY_DOWN -> 
    let a={p=Circle.move mv_down state.p} in a 
  | Sdlkey.KEY_RIGHT -> 
    let a={p=Circle.move mv_right state.p} in a 
  | Sdlkey.KEY_LEFT -> 
    let a={p=Circle.move mv_left state.p} in a
  | _ -> state
      
(* if key pressed = move key then call move_player, 
   ignore rest, escape quits, space shoots *)
let update (key:Sdlkey.t) (state:state) : state =
  match key with 
  | Sdlkey.KEY_UP
  | Sdlkey.KEY_DOWN
  | Sdlkey.KEY_RIGHT
  | Sdlkey.KEY_LEFT -> move_player key state
  | Sdlkey.KEY_ESCAPE -> state
  | Sdlkey.KEY_SPACE -> state
  | _ -> state


let pt1= Point.create 1. 1. 
let cir1 = Circle.create 10. 10. pt1 
let player= {p=cir1}

let display () =
  G.flip () 


(* gets all the pressed keys (Sdlevent.event list) , calls update on all the keys *)
let updates (st:state) : state = 
  let keys_p = Events.get_keys () in
  List.fold_left (fun acc k -> update k acc) st keys_p


let play () =
  while true do 
    G.score 50 ; 
  done


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
