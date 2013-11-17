type nat =
        | Z
        | S of nat;;

let rec eq = function
        | Z , Z -> true
        | S n, Z 
        | Z, S  n -> false
        | S n1, S n2 -> eq (n1,n2)
;;

let int_of_nat n =
  let rec loop n acc =
    match n with
      | Z -> acc
      | S n -> loop n (acc+1)
  in
loop n 0;;

let nat_of_int n=
  let rec loop n acc =
    match n with
      | 0 -> acc
      | n -> loop (n-1) (S acc)
  in
loop n Z;;

let nat_add n m  =
  let rec loop n m acc =
    match n,m with
      | Z,Z -> acc
      | Z, S n -> loop Z n (acc + 1)
      | S n, Z -> loop n Z (acc + 1)
      | S n, S m -> loop n m (acc + 2)
  in
loop n m 0;;

let nat_mult n m =
  let rec loop n m acc = 
    match n,m with
      | Z,Z -> acc
      | Z, S n -> loop n m acc
      | S n, Z -> loop n m acc
      | S n, S m -> loop n m acc
  in
loop n m 0;;
