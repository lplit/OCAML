open Sdlevent;;

type key = (Sdlkey.t * bool ref) list;;

(* True = key pressed, false otherwise *)
let keys = [ (Sdlkey.KEY_UP, ref false) ; 
	     (Sdlkey.KEY_DOWN, ref false) ;  
	     (Sdlkey.KEY_RIGHT, ref false) ; 
	     (Sdlkey.KEY_LEFT, ref false) ; 
	     (Sdlkey.KEY_SPACE, ref false) ; 
	     (Sdlkey.KEY_ESCAPE, ref false) ] ;;

(* Updates 1 keypress *)
let update (e:Sdlevent.event) =
  try
    match e with
    | KEYDOWN { keysym = sym } ->
      (List.assoc sym keys) := true
    | KEYUP { keysym = sym } ->
      (List.assoc sym keys) := false 
    | _ ->
      ()
  with Not_found ->
    ()
;;

(* Updates all the keys' pressed state *)
let updates (evlist:Sdlevent.event list) = 
  List.iter update evlist
;;

(* List of keys pressed *)
let get_keys () : (Sdlkey.t list) =
  List.map fst (List.filter (fun (a,b) -> !b=true) keys)
  ;;

