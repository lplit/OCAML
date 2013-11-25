type key = (Sdlkey.t, bool ref) list;;

let keys = [ (Sdlkey.KEY_UP, false) ; 
	     (Sdlkey.KEY_DOWN, false) ;  
	     (Sdlkey.KEY_RIGHT, false) ; 
	     (Sdlkey.KEY_LEFT, false) ; 
	     (Sdlkey.KEY_SPACE, false) ; 
	     (Sdlkey.KEY_ESCAPE, false) ] ;;

let get_keys = 
  filter -> map
;;

let update (event:Sdlevent.event) =
  match event.ke_state with
  | PRESSED ->
  | RELEASED ->
;;
  
let updates (evlist:Sdlevent.event list) = 
  List.iter update evlist
;;

(*
http://ocamlsdl.sourceforge.net/doc/html/Sdlkey.html

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
