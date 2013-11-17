(*Feuille d'exercies 3
  Jonathan SID-OTMANE 2900600
  Julien Henon 2800871
*)
(*Exercice III: Carre Magique *)

let carre :int array array = [| [| 2; 7; 6|] ; [|9; 5; 1;|] ; [|4; 3; 8|] |] ;;
let carre2 :int array array = [| [|1; 2; 3|] ; [|4; 5; 6|]; [|7; 8; 9|] |];; 

let rec  carre_magique (n:int) : int =
  let t = Array.make n (Array.make n 0) in
    if i=1 then
     t.(i) <- (Array.make m 0)
    done;
    t
;;
(*
let array_somme (tab :int array) =
  let somme = ref 0 in
    for i=0 to (Array.lenght tab) - 1 do
      somme = !somme + tab.(i)
    done ;
    !somme
;;
*)

let  somme_tab (t:int array) :int =
  let rec loop  (i:int) (acc:int) :int=
    match i with
      |0 -> acc + t.(0)
      |_ -> (loop (i - 1) (acc + t.(i)))
  in
    loop ( (Array.length t) -1 ) 0
;;

let somme_array tab = 
  Array.fold_left (+) 0 tab 
;;

let diagonale (t :int array array) : int array =
  let n = Array.length t in
  let res = Array.make n 0 in
    for i=0 to  (n - 1) do
      res.(i) <- t.(i).(i)
    done;
    res
;;



let diagonaleInverse (t :int array array) : int array =
  let n = Array.length t in
  let res = Array.make n 0 in
    for i=0 to  (n - 1) do
      res.(i) <- t.(i).(n-1-i)
    done;
    res
;;
(*
let diagonale1 (tab : int array array) : int array =
  if Array.length tab = 0 then
    [||]
  else
    let tab2 = Array.create(Array.lenght tab) 0 in
      for i = 0 to Array.lenght tab -1 do
	tab2.(i) <- tab.(i).(i)
      done ;
      tab2
;; *)

(*
let diagonal1 (tab : int array array ) : int array =
  let t = Array.create (Array.length tab) 0 in
  let rec aux ind =
    t.ind <- tab.(ind).(ind) ;
    if not(Array.length tab = ind) then
      aux (ind +1)
  in 
aux tab 0 ;
    t ;; *)

let colonne (i:int)  (tab : int array array) : int array =
  let t :int array =  Array.create 3 0 in
  let i :int =  i - 1 in
    for j = 0 to 2 do
      t.(j) <- carre.(j).(i)
    done ;
t ;;

 let ligne (i:int) (tab :int array array) :int array =
   Array.copy tab.(i-1)
 ;;

 let est_present (x:int) (tab :int array array) :bool =
   let n = (Array.length tab) - 1 in
   let a = ref false in
     for i = 0 to n do
       for j = 0 to n do
	 (* a := (tab.(i).(j) = x) || !a *)
	 if tab.(i).(j) = x then
	   a:=true
	     
       done;
     done;
     !a
 ;;

 let marque (k:int) (tab:int array) (m:int array array) :bool =
   match (est_present k m), tab.(k) with
     |true,0 -> tab.(k) <- k; true
     |_ -> false
 ;;

 let tous_les_entiers (m:int array array) :bool =
   let x = Array.length m.(0) in
   let cond = ref true in
     for i = 1 to (x*x) do
       cond := (est_present i m) && !cond
     done;
     !cond
 ;;

 let est_magique (m:int array array) :bool=
   let x = Array.length m.(0) in
   let diag = somme_tab (diagonale m) in
   let cond = ref true in
     for i = 1 to x do
       cond :=( somme_tab (ligne i m) ==  diag) && !cond ;
       cond :=( somme_tab (colonne i m) ==  diag) && !cond

     done;
       (somme_tab (diagonaleInverse m)  == diag) && !cond
 ;;

(*Exercice VI: tri rapide *)

 let liste = [12; 1; 9; 6; 5; 3; 10; 2] ;;

(*
 let separation (x:int) (tab: int list) : (int list * int list) =
   let a = ref [] in
   let b = ref [] in
   let tab = ref tab in
     for i = 0 to ( List.length !tab) - 1 do
       if (List.hd !tab) < x then
	 a := (List.hd !tab)::!a
       else
	 b := (List.hd !tab)::!b;
       tab := List.tl !tab
     done;
      !a,!b
;; *)


 let separation (x:int) (tab: int list) : (int list * int list) =
   let a = ref [] in
   let b = ref [] in
   let tab = ref tab in
     for i = 0 to ( List.length !tab) - 1 do
       let head = (List.hd !tab) in
       if head < x then
	 a := head::!a
       else if head > x then
	 b := head::!b;
       tab := List.tl !tab
     done;
      !a,!b
;;

 let rec quicksort (l:int list) : (l:int list)
     match l with
       | [] -> []
       | a::[] -> [a]
       | a::b -> match separation a b with
	   | c,d -> c@b
 ;;
