let keys = [ (Sdlkey.KEY_UP, false) ; 
	     (Sdlkey.KEY_DOWN, false) ;  
	     (Sdlkey.KEY_RIGHT, false) ; 
	     (Sdlkey.KEY_LEFT, false) ; 
	     (Sdlkey.KEY_ESCAPE, false) ] ;

type key =
  | Up of Sdlkey.t * bool
  | Down of Sdlkey.t * bool
  | Right of Sdlkey.t * bool
  | Left  of Sdlkey.t * bool
  | Escape of Sdlkey.t * bool
;;

let get_keys = 
  let rec loop acc = 
    match keys with 
      | [] -> acc::[]
      | _, true -> 
;;	
	
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
