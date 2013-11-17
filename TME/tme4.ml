type nat = 
  | Z
  | S of nat;;

let (t1:nat) = (S(S(S(S(S(S(S(S Z))))))));;


let rec nat_of_int (n:int) : nat =
  match n with
    | 0 -> Z
    | _ -> S (nat_of_int (n-1))
;;


let rec int_of_nat (n:nat) : int = 
  match n with
    | Z -> 0
    | S t -> 1 + int_of_nat t
;;

int_of_nat (S(S(S(S(S(S(S(S Z))))))));;
int_of_nat t1;;
nat_of_int 8 ;;


let rec nat_add (a:nat) (b:nat) : nat =
  match a with
    |Z -> b
    |S t -> S (nat_add t b)
;;

nat_add (S (S (S (S Z)))) (S (S (S (S (S Z)))));;


let rec nat_mult (a:nat) (b:nat) : nat = 
  match (a, b) with
    | _, Z
    | Z, _-> Z
    | (S Z), _ -> b
    | _, (S Z) -> a
    | (S t),_ -> nat_add b (nat_mult t b)
;;
      
[int_of_nat (nat_mult (S (S (S Z))) (S (S Z)));
int_of_nat (nat_mult (S (S (S Z))) (S Z));
int_of_nat (nat_mult (S (S (S Z)))  Z);
int_of_nat (nat_mult (S (S (S Z))) (S (S Z)))];;

(* Ex 4 *)

type arithexpr = 
  | Fois of arithexpr * arithexpr
  | Div of arithexpr * arithexpr
  | Plus of arithexpr * arithexpr
  | Moins of arithexpr * arithexpr
  | Inverse of arithexpr
  | Err of string
  | Var of string
  | Const of int
;;

let rec liste_vars (n:arithexpr) : (string list) =
  match n with 
    | Fois (a, b) | Div (a, b) | Plus (a, b) | Moins (a, b) -> (liste_vars a) @ (liste_vars b)
    | Var x -> [x]
    | Err x -> failwith x
    | Const a  -> []
    | Inverse a -> liste_vars a
;;
      
liste_vars (Fois (Plus (Var "x", Const 3), 
		  Moins (Var "y", Var "x")));;

let rec elim l = 
  match l with 
    | [] -> []
    | h::t -> h:: List.filter (fun x -> x<>h) (elim t);;


let plus_simpl (n:arithexpr) : (bool*arithexpr) = 
  match n with 
    | Plus (a, b) -> 
      begin
	match (a, b) with 
	  | Err x, _
	  | _, Err x -> (false, Err x)
	  | a, Const 0 
	  | Const 0, a -> (true, a)
	  | (Inverse a), b
	  | a, (Inverse b) -> if a=b then (true, Const 0) else (false, n)
	  | Moins(b, c), a 
	  | a, Moins(b, c) -> if a=c then (true, b) else (false, n)
	  | Const a, Const b -> (true, Const (a+b))
      end
;;


let moins_simpl (n:arithexpr) : (bool*arithexpr) = 
  match n with 
    | Moins(a, Err x)
    | Moins(Err x, a) -> (false, Err x)
    | Moins(Const 0, b)
    | Moins(b, Const 0) -> (true, b)
    | Moins(Const a, Const b) -> (true, Const (a-b)) 
;;
