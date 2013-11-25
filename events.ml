

type key =
  | Up of Sdlkey.KEY_UP * bool
  | Down of Sdlkey.KEY_DOWN * bool
  | Right of Sdlkey.KEY_RIGHT * bool
  | Left  of Sdlkey.KEY_LEFT * bool
  | Escape of Sdlkey.KEY_ESCAPE * bool
;;

let keys = [ (Sdlkey.KEY_UP, false) ; 
	     (Sdlkey.KEY_DOWN, false) ;  
	     (Sdlkey.KEY_RIGHT, false) ; 
	     (Sdlkey.KEY_LEFT, false) ; 
	     (Sdlkey.KEY_ESCAPE, false) ] ;


let get_keys = 
  let rec loop acc = 
    match keys with 
      | [] -> acc
      | ((Sdlkey.KEY_DOWN, true) as h)::t
      | ((Sdlkey.KEY_RIGHT, true) as h)::t
      | ((Sdlkey.KEY_LEFT, true) as h)::t
      | ((Sdlkey.KEY_ESCAPE, true) as h) -> loop h::acc
      | _::t -> acc t in 
    keys []
;;

let update = 
  


val get_keys : unit -> Sdlkey.t list
val update : Sdlevent.event -> unit
val updates : Sdlevent.event list -> unit

   
(* http://ocamlsdl.sourceforge.net/doc/html/Sdlkey.html

variable globale dans events let keys = (liste de couples definie a la main (touche sdlkey, bool ref))
Deux evenments only - pressed and unpressed 

ocamlfind ocamlc -package sdl -c events.ml
ocamlfind compiler -package list_of_packages -c file_to_compile.ml

let onkeydown x =
match x.keysym with
Sdlkey.KEY_ESCAPE
| Sdlkey.KEY_q -> false
| _ -> true


*)
