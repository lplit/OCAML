(*Exercise 2*)

let rec u (n:int)=
if (n=0) then
  42
else 
  3*(u(n-1))+4
;;

u 5;;

(* Q2 *)

let u2 (n:int) : int  = 
  let rec aux (n:int) (acc:int):int =
    if (n=0) then
      acc 
    else aux (n-1) (3*acc+4)
  in
    if n<0 then 
      raise (Invalid_argument "u2")
    else
      aux n 42;;

u2 5;

(* Q4 *)

let rec iter (n:int) (f:int->int) (a:int):int=
  if n=0 then
    a
  else
    iter (n-1) f a;;


(* Q5 *)

let iter2 (n:int) (f:int->int) (a:int):int =
  let rec aux (n:int) (acc:int) : int =
    if n=0 then
      acc
    else 
      aux (n-1) (f acc)
  in
    aux n a
;;

let add2 n = n + 2 ;;

iter2 2 add2 0 ;;

add2 ;;

(* Q7 *)

iter 5 (fun x->3*x+4) 42;;
iter 10 (fun x->3*x+4) 42;;
iter 15 (fun x->3*x+4) 42;;

(* Q8 *)

let rec sum_u (n:int) : int =
  if n=0 then
    0
  else
    n + (sum_u (n-1))
;;

(* Q9 *)

let sum_u2 (n:int) : int = 
  let rec aux (n:int) (acc:int) : int = 
    if n=0 then
      acc
    else 
      aux (n-1) (acc+n)
  in
    aux n 0
;;

sum_u 10;;
sum_u2 10;;

(* Q10 *)

let sum_u3 (n:int) : int = 
  (* @nb_iter controle nb iterations
     @cpt valeurs successives des termes de la suite, a partir de 42 decrementation
     @acc valeurs successives de la some.
  *)
  let rec aux (nb_iter:int) (cpt:int) (acc:int) =
    if nb_iter<0 then 
      acc
    else 
      aux (nb_iter-1) nb_iter (acc+cpt)
  in
    aux n 0 0
;;

sum_u3 10;;

(* Q11 *)

let sum_u4 (n:int) : int = 
  let acc=ref 0 in
    for i=0 to n do
      acc.contents <- acc.contents + i
    done;
    !acc
;;

sum_u4 10;;

(* Q12 *)


let est_u (k:int) : bool =
  let i=(k-4) in
    if k<42 then 
      false
    else if k=42 then 
      true 
    else if i mod 3 =0  then 
      est_u (i/3)
    else
      false
;;

est_u 130;;


(* EX 4 *)


(* Q1 *)

let sum_u5 (n:int) : int = 
  if n<0 then
    raise (Invalid_argument "n<0")
  else
    (n*(n+1))/2
;;

sum_u5 (-5);;  
sum_u5 5;;
sum_u5 10;;


(* Q2 *)

let triangulaire (n:int) : bool =
  if n<0 then
    false
  else 
    let rec loop (k:int) : bool = 
      let tmp= (k * (k+1)) / 2 in
	Printf.printf "%d\n" tmp;
	if tmp > n then 
	  false 
	else if tmp<n then 
	  loop (k+1)
	else
	  true
    in
      loop 1
;;

triangulaire 6 ;;
triangulaire 55;;


(* Q3 *)

let triangulaire_ter (n:int) : bool =
  if n<0 then
    false
  else
    let rec loop (k:int) (acc:int) : bool =
(*      let tmp= (k * (k+1)) / 2 in 
      Printf.printf "%d\n" tmp; *)
	if acc > n then
	  false
	else if acc<n then
	  loop (k+1) (acc+k)
	else
	  true
    in
      loop 0 0 
;;

triangulaire_ter 6;;
triangulaire_ter 55;;


(* Q4 *)

let triangulaire_iter (n:int) : bool = 
  if n<0 then
    false
  else
    let rec loop (k:int) (acc:int) : bool =
      if acc > n then
	false
      else if acc<n then
	loop (k+1) (acc+k)
      else
	true
    in
      loop 0 0 
;;

let sum_u4 (n:int) : int = 
  let acc=ref 0 in
    for i=0 to n do
      acc.contents <- acc.contents + i
    done;
    !acc
;;
