module Circle = struct 
    
  type t = {
    r:float ; 
    v:float ;
    cen:Point.t }

  let create r v cen = {
    r=r;
    v=v;
    cen=cen }

  let move v circle = {
    cen = Point.move v cen ; 
    r = circle.r ; 
    v = circle.v }

  let collide cira cirb = 
    let rs = cira.r +. cirb.r in 
    let p1 = cira.Point.cen in 
    let p2 = cirb.Point.cen in 
    
    if rs >= Point.distance p1 p2 then 
      true 
    else 
      false
  ;;
  
  let collide_with_any_of p plist =
    (* apply collide to any two elements of the list, fold left? *)
    (* check the list module for an iterator *)
    
end

(* 
==========================================================================

What's the difference between {} in functions and just defining it usually
{} = constructors?
How to open/reference a module?

*)
