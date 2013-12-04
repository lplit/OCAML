open Graphics
open Geometry
open BoundingBox

module G = (val (init ()) : G)
  
type state = { 
  p : BoundingBox.Circle.t ;
}
  
let cr_state x y r v  = 
  { p = Circle.create r v (Point.create x y) }
    
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
  match key with 
  | Sdlkey.KEY_UP
  | Sdlkey.KEY_DOWN
  | Sdlkey.KEY_RIGHT
  | Sdlkey.KEY_LEFT -> Printf.printf "Moving\n" ; move_player key state
  | Sdlkey.KEY_ESCAPE -> Graphics.quit () ; state
  | Sdlkey.KEY_SPACE -> state
  | _ -> state


(* gets all the pressed keys (Sdlevent.event list) , calls update on all the keys *)
let updates (st:state) : state = 
  let keys_p = Events.get_keys () in
  List.fold_left (fun acc k -> update k acc) st keys_p


let display () =
  let p1 = cr_state 20. 20. 10. 10. in 
  let player = ref p1 in 
  G.flip () ;
  G.player player.p;
  player = updates p1

(* Tu crées un nouvel état avec { p = ton nouveau player } et ta boucle while peut
utiliser une ref vers un état que tu mets à jour au fur et à mesure.

Ou alors tu fais une fonction récursive avec un accumulateur pour l'état. *)
let play () =
  while true do
    display () 
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
