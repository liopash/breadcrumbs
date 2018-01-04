fun map (f,xs) =
    case xs of
    [] => []
    | x::xs' => f x :: map(f, xs')

fun f y =
    let
      val x = y + 1
    in
      fn z => z + x + y
    end

val g = f 4

val y = 5 

val z = g 6

val prnt = fn x => print x

fun reduce (f, xs, acc) = 
     case xs of
     [] => acc
     | (x::xs) => reduce (f, xs, f (x,acc))

fun fold f acc xs =
     case xs of
     [] => acc
     | (x::xs') => fold f (f(acc,x)) xs'

val sum = fold (fn (x,y) => x + y) 0

fun reduce2 (f,xs,acc) =
     case xs of
     [] => acc
     | (x::xs) => reduce2 (f,xs,acc + f x)

fun add x = x + 1

fun tms x = x * 2

val g = add o tms

fun compose(k,l,z) = k (l z)

infix |> 

fun x |> f = f x 

fun sqrt i = i |> abs |> Real.fromInt |> Math.sqrt


fun sorted3_tpl (a,b,c) = c >= b andalso b >= a

val tpl1 = (1,2,3)

fun sort_nicer a b c = c >= b andalso b >= a

fun range a b = if a > b then [] else a :: range (a+1) b 

fun range2 (a,b) = if a > b then [] else a::range2(a+1,b)

fun pairing xs = List.map (fn x => (x,x)) xs

(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals xs = 
            let 
               val isUpper = fn x => (Char.isUpper (String.sub(x,0)))
            in 
               List.filter isUpper xs
            end

val only_capitals2 = fn xs => List.filter (fn x => Char.isUpper(String.sub(x,0))) xs

fun longest_string1 xs = 
            let 
                fun sizer (x, init) = if size x > size init then x else init
            in
                foldl sizer "" xs
            end

fun longest_string2 xs = 
            let 
                fun sizer (x, init) = if size x >= size init then x else init
            in
                foldl sizer "" xs
            end

fun longest_string_helper f = 
    foldl (fn (string, acc) => if f (size string, size acc) then string else acc) "" 

val longest_string3 = longest_string_helper (fn (x, y) => x > y)

val longest_string4 = longest_string_helper (fn (x, y) => x >= y)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = implode o rev o explode

(*------------

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
*)

fun first_answer f xs = 
    case xs of
        [] => raise NoAnswer
       | x::xs => case f x of
                  NONE => first_answer f xs 
                | SOME x => x

fun all_answers f xs =
    let 
       fun helper (xs,acc) = 
            case xs of
                [] => SOME acc
                | x::xs => case f x of
                          NONE => NONE 
                        | SOME x => helper (xs,acc@x)
    in 
      helper (xs,[])
    end
    

    (* val g = fn : (unit -> int) -> (string -> int) -> pattern -> int *)
    (* To help you think about the pattern matching problems, here are some patterns 
    in "normal SML speak" and their equivalents in the assignment's setting. (_, 5) is 
    like TupleP [Wildcard, ConstP 5], SOME (x, 3) is like 
    ConstructorP ("SOME", TupleP [Variable "x", ConstP 3]), 
    and (s, (t, _)) is like TupleP [Variable "s", TupleP [Variable "t", Wildcard]].*)
    
    val count_wildcards = 
          g (fn x => 1) (fn y => 0) 

    val count_wild_and_variable_lengths =
         g (fn x => 1) (fn y => size y)

    fun count_some_var (str,p) = 
         g (fn x => 0) (fn y => if y=str then 1 else 0) p
         