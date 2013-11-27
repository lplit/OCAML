open Sdlevent;;

type key = (Sdlkey.t * bool ref) list;;

(* True = key pressed, false otherwise *)
let keys = [ (Sdlkey.KEY_UP, ref false) ; 
	     (Sdlkey.KEY_DOWN, ref false) ;  
	     (Sdlkey.KEY_RIGHT, ref false) ; 
	     (Sdlkey.KEY_LEFT, ref false) ; 
	     (Sdlkey.KEY_SPACE, ref false) ; 
	     (Sdlkey.KEY_ESCAPE, ref false) ] ;;


(* List of keys pressed *)
let get_keys = 
  List.map fst (List.filter (fun (a,b) -> !b=true) keys)
;;


(* Updates keypress *)
let update e =
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

      
let updates (evlist:Sdlevent.event list) = 
  List.iter update evlist
;;
