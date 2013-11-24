type key = 
| Up of Sdlkey.t * bool
| Down of Sdlkey.t * bool
| Right of Sdlkey.t * bool
| Left  of Sdlkey.t * bool
| Escape of Sdlkey.t * bool
;

let update = 
match Sdlkey.t with
| KEY_UP ->
| KEY_DOWN ->
| KEY_RIGHT ->
| KEY_LEFT ->
| KEY_ESCAPE ->


Sdlkey.t



type key
val get_keys : unit -> Sdlkey.t list
val update : Sdlevent.event -> unit
val updates : Sdlevent.event list -> unit

   
(* http://ocamlsdl.sourceforge.net/doc/html/Sdlkey.html

variable globale dans events let keys = (liste de couples definie a la main (touche sdlkey, bool ref))
Deux evenments only - pressed and unpressed 

ocamlfind ocamlc -package sdl -c events.ml
ocamlfind compiler -package list_of_packages -c file_to_compile.ml


*)
