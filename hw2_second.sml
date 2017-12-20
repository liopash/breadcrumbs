
fun same_string(s1 : string, s2 : string) =
  s1 = s2

fun is_in_list (_,[]) = false
  | is_in_list (c,a::b) = if same_string(c,a) then true else is_in_list(c,b) 

fun all_except_string (_,[]) = []
  | all_except_string (c,a::b) = if same_string(c,a)
                                 then all_except_string(c,b)
			         else a::all_except_string(c,b)
(* problem 1.a) *)							  
fun all_except_option x =
  case x of
      (_,[]) => NONE
   |   (z,a::b) => if (a::b) = (all_except_string x) then NONE else SOME (all_except_string x)

(* problem 1.b) *)									 
fun get_substitutions1 ([],_) = []
  | get_substitutions1 (a::b,c) = if is_in_list(c,a) then all_except_string(c,a) @ get_substitutions1(b,c) else get_substitutions1(b,c) 				   
(* problem 1.d) 						       
val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	          {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]  *)



(* you may assume that Num is always used with values 2, 3, ..., 10    though it will not really come up *)

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color (a, _) =
  if a = Clubs orelse a = Spades
  then Black
  else Red
       
fun card_value (_, Num x) = x
  | card_value (_, Ace) = 11
  | card_value _ = 10

		       (* a function remove_card, which takes a list of cards cs, a card c, and an exception e *)		       
fun remove_card (cs, c, e) =
  case (cs, c) of
      ([],_) => raise e
    | (a::b,c) => if a=c then b else a::remove_card(b,c,e)

fun all_same_color ([]) = true 
  | all_same_color (_::[]) = true  
  | all_same_color (a::b::c) = card_color(a)=card_color(b) andalso all_same_color (b::c)

fun sum_cards2 ([]) = 0 
  | sum_cards2 (a::b) = card_value a + sum_cards2 b

fun sum_cards cards =
  let
      fun f (cards, acc) =
	case cards of
	    [] => acc
	  | a::cards => f(cards, card_value a+acc)
  in
      f(cards,0)
  end
		      
fun score ([], goal) = goal 
  | score (cards, goal) = goal - sum_cards
			  
	
										 
		       
		   
			       
