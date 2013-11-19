module Circle : sig
  type t

  val create : Geometry.Point.t -> float -> float -> t
  val move : Geometry.Vector.t -> t -> t
  val collide : t -> t -> bool
  val collide_with_any_of : t -> t list -> bool
end

