type key = (Sdlkey.t, bool ref) list;;

let keys = [ (Sdlkey.KEY_UP, false) ; 
	     (Sdlkey.KEY_DOWN, false) ;  
	     (Sdlkey.KEY_RIGHT, false) ; 
	     (Sdlkey.KEY_LEFT, false) ; 
	     (Sdlkey.KEY_ESCAPE, false) ] ;;

let get_keys = 
  let rec loop acc = 
    match keys with 
    | [] -> acc
    | ((Sdlkey.KEY_DOWN, true) as h)::t
    | ((Sdlkey.KEY_RIGHT, true) as h)::t
    | ((Sdlkey.KEY_LEFT, true) as h)::t
    | ((Sdlkey.KEY_ESCAPE, true) as h) -> loop h::acc
    | _::t -> acc t ;
  in 
  loop []
;;

(*
let update = 
  (* treat two events and ignore rest *)
;;

let updates = 
  
;;

*)
(*
val get_keys : unit -> Sdlkey.t list
val update : Sdlevent.event -> unit
val updates : Sdlevent.event list -> unit
*)
   

(* http://ocamlsdl.sourceforge.net/doc/html/Sdlkey.html

variable globale dans events let keys = (liste de couples definie a la main (touche sdlkey, bool ref))
Deux evenments only - pressed and unpressed 

ocamlfind ocamlc -package sdl -c events.ml
ocamlfind compiler -package list_of_packages -c file_to_compile.ml


type keyboard_event = {
  ke_which : int;(*The keyboard device index*)
  ke_state : switch_state;(*PRESSED or RELEASED*)
  keysym : Sdlkey.t;(*SDL virtual keysym*)
  keymod : Sdlkey.mod_state;(*current key modifiers*)
  keycode : char;(*translated character*)
  unicode : int;
}

let onkeydown x =
match x.keysym with
Sdlkey.KEY_ESCAPE
| Sdlkey.KEY_q -> false
| _ -> true


*)
