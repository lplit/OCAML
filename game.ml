open Graphics

module G = (val (init ()) : G)

type state = { p : BoundingBox.Circle.t }
    
let update x = x;;

let display =
    G.flip;
;;

let play =
  while true do 
    begin 
      update ;
      display ;
      G.flip;
    end 
  done
;;


		     
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
