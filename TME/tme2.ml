(** 
    Author: Michal Rudek
    Etu: 2900375
    LI220 OCAML
    UPMC Paris 6 - 2013/2014
*)


(* ----------Utilities---------- *)
let plist (list:int list) = List.iter (fun a -> (Printf.printf "%d " a)) list; Printf.printf "\n";;
let parr (arr:int array) = Array.iter (fun a -> (Printf.printf "%d " a)) arr; Printf.printf "\n";;
let pmat (arr:int array array) =
  for i=0 to Array.length arr-1 do 
    for j=0 to Array.length arr-1 do
      Printf.printf "%d " arr.(i).(j)
    done; 
    Printf.printf "\n";
  done; 
;;

let rec appartient x l = if l = [] then false else (List.hd l = x) || (appartient x (List.tl l));;
let iarr (n:int) : float array =
  let arr=Array.make n 0.0 in
  let tmp=ref 0.0 in
    for i=0 to n-1 do
      arr.(i) <- tmp.contents;
      tmp.contents <- tmp.contents +. 0.1
    done;
    arr;;


(* ----------Variables--------- *)

let l = 12 :: 99 :: 37 :: 138 :: [];;
let l2= 1 :: 2 :: 3 :: 4 :: [];;
let l3=[];;

let a1 = alloarray 10;;
let a2 = alloarray 15;;
let a3 = alloarray 20;;
let a4 = Array.init 10 (fun i -> i);;

let mar1 = Array.create 10 0;;

let f1 = 1.0 :: 1.5 :: 2.0 :: [];;
let f2 = iarr 10;;
let f3 = iarr 20;;

let carre = [| [|2; 7; 6|];
	       [|9; 5; 1|];
	       [|4; 3; 8|] |] ;;

let carre2 = [| [|0; 1; 2|];
		[|3; 4; 5|];
		[|6; 7; 8|] |] ;;

let carre3 = [| [|2; 7; 6|];
		[|9; 5; 1|];
		[|4; 3; 8|] |] ;;


(* ----------Q 1.1---------- *)

let maximum liste =       
  let rec maximum_rec liste a = 
    match liste with
      |  [] -> a
      | tete :: queue -> maximum_rec queue (max a tete) in
    maximum_rec liste (List.hd liste);;

maximum l;;


(* ----------Q 1.2---------- *)

let max_list (l:int list) : int =
  if l=[] then
    raise (Invalid_argument "Empty list")
  else 
    List.fold_left (max) (List.hd l) l;;

max_list l;;
max_list l2;;
max_list l3;;


(* ----------Q 1.3---------- *)

let max_array (l:int array) = 
  if (Array.length l) = 0 then
    raise (Invalid_argument "Empty array")
  else
    for i=1 to (Array.length l)-1 do
      if (l.(i) >= l.(0)) then 
	l.(0) <- l.(i)
      done;
  l.(0)
;;

max_array a1;;
max_array a2;;
max_array a3;;

let alloarray (n:int) = 
  let a1 = Array.create n 0 in
    for i=0 to (Array.length a1 - 1) do
      a1.(i) <- i
    done;
a1;;


(* ----------Q 1.4---------- *)

let max_array2 (l:int array) : int =
  if Array.length l=0 then
    raise (Invalid_argument "Empty list")
  else 
    Array.fold_left (max) l.(0) l;;

max_array2 a1;;
max_array2 a2;;
max_array2 a3;;


(* ----------Ex 2---------- *)


(* ----------Q 2.1---------- *)

let moyenne_list (list:float list) : float =
  let rec aux (l:float list) (acc:float) : float =
    if (l = []) then
      acc
    else 
      aux (List.tl l) (acc+.(List.hd l)) in
  (aux list 0.0)/.(float_of_int (List.length list))
;;

moyenne_list f1;;


(* ----------Q 2.2---------- *)

let moyenne_arr2 (arr:float array) : float =
  let temp=ref 0.0 in
    for i=0 to (Array.length arr-1) do
      Printf.printf "Arr[%d] = %2f\n" i arr.(i);
      temp.contents <- temp.contents +. arr.(i)
    done;
    !temp /. (float_of_int (Array.length arr))
;;

moyenne_arr2 f2;;



(* ----------Exercice III---------- *)
(* ----------Carre Magique--------- *)

let somme_array_imp (arr:int array) : int =
  if Array.length arr = 0 then 
    0
  else
    let temp=ref 0 in
      for i=0 to Array.length arr-1 do
	temp := !temp + arr.(i)
      done;
    temp.contents
;;

let somme_array_rec (arr:int array) : int =
  let rec aux (i:int) (acc:int) = 
    if i< (Array.length arr) then 
      aux (i+1) (acc+arr.(i))
    else 
      acc
	in
    aux 0 0
;;

let somme_array_fold (arr:int array) : int =
  if Array.length arr = 0 then 
    0
  else 
    Array.fold_left (fun x y -> x + y) 0 arr
;;


somme_array_imp a4;;
somme_array_rec a4;;
somme_array_fold a4;;


(* ----------Q3.2---------- *)

let diagonale (mat:int array array) : int array =
  let dia = Array.length mat in
  let arr = Array.create dia 0 in 
  let i=ref 0 in 
    for n=0 to dia-1 do
      arr.(n) <- mat.(!i).(!i);
      i := !i + 1;
    done;
    arr
;;


let diagonale2 (mat:int array array) : int array =
  let dia = Array.length mat in
  let arr = Array.create dia 0 in 
  let i=ref 0 in 
    for n=dia-1 downto 0 do
      Printf.printf "i: %d n: %d mat[i][n-i]: [%d][%d]:%d\n" !i n !i (n) mat.(!i).(n);
      arr.(!i) <- mat.(!i).(n);
      i := !i + 1;
    done;
    arr
;;

diagonale2 carre;;
diagonale carre;;

(*
let diagonale2 (mat:int array array) : int array =
  let len = Array.length mat in
  let arr = Array.create len 0 in 

  let rec aux (i:int) : int array=
    if i>0 && i<len then
      arr.(i) <- mat.(i).(i);
    aux (i-1);
 else
   acc 
 in
  aux len mat
;;
*)


(* ----------Q3.3----------*)

let colonne (n:int) (arr:int array array) : int array =
  let ret = Array.create (Array.length arr) 0 in 
    for i=0 to Array.length arr-1 do 
      ret.(i) <- arr.(n).(i)
    done;
    ret
;;

let ligne (n:int) (arr:int array array) : int array =
  let ret = Array.create (Array.length arr) 0 in 
    for i=0 to Array.length arr-1 do 
      ret.(i) <- arr.(i).(n)
    done;
    ret
;;

ligne 1 carre;;
colonne 1 carre;;


(* ----------Q3.4----------*)

let est_present (n:int) (arr:int array array) : bool =
  let len = Array.length arr-1 in
  let ans = ref false in 
    for i=0 to len do
      for j=0 to len do 
	if (arr.(i).(j)=n) then 
	  ans := true
      done;
    done;
    !ans;;

est_present 5 carre;;
est_present 11 carre;;


(* ----------Q3.5----------*)

let marque (k:int) (tab:int array) (m:int array array) : bool =
  let ans = ref false in
    if (est_present k m) && (tab.(k) = 0) then
      begin
      tab.(k) <- k ;
      ans := true
      end ;
    !ans;;


marque 15 mar1 carre;;
marque 1 mar1 carre;;
marque 5 mar1 carre;;


let tous_les_entiers (arr:int array array) : bool = 
  let (ans:bool ref) = ref true in 
  let (len:int) = (Array.length arr)*(Array.length arr) in
  let (temp:int array) = Array.create len 0 in
    for i=0 to len-1 do 
      if (marque i temp arr = false) then 
	ans := false
    done;
    parr temp;
    pmat arr;
    !ans;;

tous_les_entiers carre2;;
tous_les_entiers carre3;;

(* ----------Q3.6----------*)


(* ----------Fonctions auxiliaires----------*)
let get_col (arr:int array array) (nb:int) : (int array) = 
  let ans = Array.make (Array.length arr) 0 in
    for i=0 to Array.length arr-1 do 
      ans.(i) <- arr.(i).(nb)
    done;
    ans;;

let sum_1d (arr:int array) : int = 
  let s = ref 0 in 
    Array.iter (fun x-> s := !s + x) arr; 
    !s;;

let sum_arr (arr:int array array) : bool = 
  let len = Array.length arr-1 in
  let ans = ref true in
let sum1 = sum_1d arr.(0) in
    for i=1 to len do
      let line = sum_1d arr.(i) in 
      let column = sum_1d(get_col arr i) in 
	Printf.printf "Len: %d | ans: %b | sum1: %d | Line: %d | Column: %d\n" (len+1) !ans sum1 line column;
	if (sum1 != line || sum1 != column) then
	  ans := false;
    done; 
    !ans;;

sum_arr carre;;
sum_arr carre2;;
sum_arr carre3;;

(* ----------Main function----------*)
let est_magique (arr:int array array) : bool = 
  let ans= ref false in 
    if ((tous_les_entiers arr=true) && (sum_arr arr=true)) then
      ans := true;
    !ans;;

est_magique carre;;
est_magique carre2;;
est_magique carre3;;


(* ----------Exercice IV----------*)
(* ----------TRI  FUSION----------*)

let l4 = 0 :: 2 :: 4 :: 8 :: [] ;;
let l5 = 1 :: 3 :: 5 :: 7 :: [] ;;


(* ----------4.1----------*)

let rec merge_i (l1:'a list)  (l2:'a list) : ('a list) =
  match (l1,l2) with
      [],_ -> l2
    | _,[] -> l1
    | h1::t1, h2::t2 ->
	if h1 < h2 then 
	  h1::(merge_i t1 l2) 
	else 
	  h2::(merge_i l1 t2)
;;

merge_i l2 l3;;
merge_i l4 l5;;
merge_i [] [1;2;];;
merge_i [3;4;] [1;2;];;
merge_i [5;6][];;


(* ----------4.3----------*)

let rec merge (acc:'a list) (l1:'a list)  (l2:'a list) : ('a list) =
  match (l1, l2) with 
      [],_ -> l2
    | _,[] -> l1
    | h1::t1, h2::t2 ->
	if h1 < h2 then 
	  h1::(merge acc t1 l2) 
	else 
	  h2::(merge acc l1 t2)
;;

merge [] l2 l3;;
merge [] l4 l5;;
merge [] [] [1;2;];;
merge [] [3;4;] [1;2;];;
merge [] [5;6][];;
	    

(* ----------4.3----------*)

let iter_merge (arr:'a list list) : ('a list) =
  let rec aux (acc:'a list) (li:'a list list) =
    match li with
      | [] -> raise (Invalid_argument "Empty list")
      | h::s::t ->(merge_i h s)@aux acc t
      | h::[] -> merge_i acc h
  in 
    match arr with 
	[] -> []
      | h::t -> aux [] arr;;

let l6 = [[0;2;4];[1;3];[6;8];[5;7;9];[10;11]];;

iter_merge l6;;


(* ----------4.4----------*)

let split (l:'a list) : ('a list list) =
  let res = [] in
    if l=[] then 
      []
    else 
      List.map (fun a -> a::res) l;;

split [1;2;3;];;
split l6;;


(* ----------4.5----------*)

let rec merge_sort (l:'a list) : ('a list) = 
  match l with 
    | [] -> []
    | a::[] -> [a]
    | a::s as list -> 
	
;;

merge_sort l6;;
