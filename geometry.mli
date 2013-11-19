module Vector :
  sig type t = { x : float; y : float; } val create : float -> float -> t end
module Point :
  sig
    type t = { x : float; y : float; }
    val create : float -> float -> t
    val move : Vector.t -> t -> t
  end
