
fun same_string(s1 : string, s2 : string) =
  s1 = s2

(* problem 1.a) *)							  

fun all_except_option x =
  case x of
      (_,[]) => NONE
   |  (x,a::b) => let fun aux (x,[],c) = all_except_option(x,[])
			| aux (x,a::b,c) =
			  case x=a of
			      true => SOME (c@b)
			   |  false => aux(x,b,a::c)
		  in
		      aux(x,a::b,[])
		  end

(* problem 1.b) *)									 

fun get_substitutions1 ([],_) = []
  | get_substitutions1 (a::b,c) =
    case all_except_option(c,a) of
	NONE => get_substitutions1(b,c)
      | SOME x => x@get_substitutions1(b,c)
			      
(*problem 1.c) *)

fun get_substitutions2 ([],_) = []
  | get_substitutions2 (a::b,c) =
    let
        fun aux ([],_,d) = d
       	| aux (a::b,c,d) =
	  case all_except_option(c,a) of
              NONE => aux(b,c,d)
	    | SOME x => aux(b,c,d@x)
     in
        aux(a::b,c,[])
    end
			   
(* problem 1.d) *)

fun similar_names x =
  case x of
      ([],name) => [name]
    | (x::z,{first=a, middle=b, last=c}) =>
                  let val names = get_substitutions1(x::z,a)
		      fun replacer ([],name,que) = que
			| replacer (x'::z',{first=a, middle=b, last=c},que) = replacer(z',{first=a, middle=b, last=c},que@[{first=x', middle=b, last=c}]) 
		  in
		      replacer (names,{first=a, middle=b, last=c},[{first=a, middle=b, last=c}])
		  end
						

(* Problem 2 *)	

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color (a, _) =
  case a of
      Clubs => Black 
    | Spades => Black
    | _ => Red
       
fun card_value (_, Num x) = x
  | card_value (_, Ace) = 11
  | card_value _ = 10

fun remove_card (cs, c, e) =
  case (cs, c) of
      ([],_) => raise e
    | (a::b,c) => if a=c then b else a::remove_card(b,c,e)

fun all_same_color ([]) = true 
  | all_same_color (_::[]) = true  
  | all_same_color (a::b::c) = card_color(a)=card_color(b) andalso all_same_color (b::c)

fun sum_cards cards =
  let
      fun f (cards, acc) =
	case cards of
	    [] => acc
	  | a::cards => f(cards, card_value a+acc)
  in
      f(cards,0)
  end
      
fun score (cards, goal) =
    let
	val sum = sum_cards cards
	val color = all_same_color cards		    
    in
	case sum > goal of
	    true => if color then 3 * (sum - goal) div 2 else 3 * (sum - goal)
	  | false => if color then (goal - sum) div 2 else goal - sum
    end		  

fun officiate (cards : card list, moves: move list, goal: int) =
  let
      fun game x =
	case x of
	    ([],moves,goal,held) => score(held,goal)
	  | (_,[],goal,held) => score(held,goal)
	  | (c::cards',move::moves',goal,held)  => case sum_cards held > goal of
						       true => score(held,goal)
						    | false => case move of
								   Draw => game(cards',moves',goal,c::held)
								 | Discard x => game(c::cards',moves',goal,remove_card(held,x,IllegalMove))
  in
      game(cards,moves,goal,[])
  end
