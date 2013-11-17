let foo (n : int) :bool =
  n > 0 ;;


let list_exist (f: 'a -> bool) (liste : 'a list) :bool =
 (* let liste :bool list = List.map foo liste in *)
    List.fold_left || false (List.map foo liste )
;;

list_exist foo [1; -1];;
