open Graphics
open Geometry
module G = (val (init ()) : G) 

type state = { 
  p : BoundingBox.Circle.t } 

(* Global variables *) 
let mv_left:Vector.t = Vector.create -5 0 ;
let mv_right = Vector.create 5 0 ;
let mv_down = Vector.create 0 5 ;
let mv_up = Vector.create 0 -5 ;

(* Functions *)

(* gere les if key pressed = move key then call move_player, 
   ignore rest, escape quits, space shoots, s shows score *)
let update (key:Sdlkey.t) (state:state) : state =
  match key with 
  | Sdlkey.KEY_UP
  | Sdlkey.KEY_DOWN
  | Sdlkey.KEY_RIGHT
  | Sdlkey.KEY_LEFT -> move_player key state
  | Sdlkey.KEY_ESCAPE -> G.quit() 
  | Sdlkey.KEY_SPACE -> state 


let display () =
    G.flip()


let play () =
  while true do 
    updates()
    display()
  done


(* Key + state(player) -> player with modfied position *)
let move_player (key:Sdlkey.t) (state:state) : state = 
  match key with 
  (* Move v:vector c:circle *)
  | Sdlkey.KEY_UP -> Circle.move mv_up state.p
  | Sdlkey.KEY_DOWN -> Circle.move mv_down state.p
  | Sdlkey.KEY_RIGHT -> Circle.move mv_right state.p
  | Sdlkey.KEY_LEFT -> Circle.move mv_left state.p
  | _ -> state



(* gets all the pressed keys (events) , calls update on all the keys *)
let updates (state:state) : state = 
  List.iter update Events.get_keys () 



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

