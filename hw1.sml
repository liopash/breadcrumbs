fun is_older ( date1 : int * int * int, date2 : int * int * int ) =
  ( #1 date1 < #1 date2 ) orelse
  ( #1 date1 = #1 date2 andalso #2 date1 < #2 date2 ) orelse
  ( #1 date1 = #1 date1 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2 )
    									  
fun number_in_month ( dates : ( int * int * int ) list, month : int ) =
  if null dates
  then 0
  else if #2 (hd dates) = month
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)
			
fun number_in_months ( dates : ( int * int * int ) list, months : int list ) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)

							    
fun dates_in_month ( dates : ( int * int * int ) list, month : int ) =
  if null dates
  then []
  else if #2 (hd dates) = month
    then [hd dates] @  dates_in_month( tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months ( dates : ( int * int * int ) list, months : int list ) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)
							 							    
fun get_nth ( nths : string list, n : int ) =
  if n = 1
  then hd nths
  else get_nth(tl nths, n - 1)
	      
fun date_to_string ( date : int * int * int ) =
  let   
    val months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
  in
    get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end

fun number_before_reaching_sum ( sum : int, xs : int list ) =
  if  hd xs < sum  
  then 1 + number_before_reaching_sum (sum ,hd xs + hd(tl xs) :: tl(tl xs) )
  else 0   
	   
fun what_month ( days : int ) = 
  number_before_reaching_sum(days, [31,28,31,30,31,30,31,31,30,31,30,31]) + 1

fun month_range ( day1 : int, day2 : int ) =
  if day1 > day2
  then []
  else if day1 = day2
       then [what_month day2]
       else what_month day1 :: month_range(day1 + 1, day2)

fun oldest ( dates : ( int * int * int ) list ) =
    if null dates
    then NONE
    else
	let val tl_ans = oldest(tl dates)
	in
	    if isSome tl_ans
               andalso is_older(hd (tl dates), hd dates)
	    then tl_ans
            else SOME (hd dates)
        end 

	
val test1 = is_older ((1,2,3),(2,3,4)) = true

val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1

val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3

val test9 = what_month 70 = 3

val test10 = month_range (31, 34) = [1,2,2,2]

val test11 = is_older((1,2,3),(2,3,4)) = true
val test12 = is_older((2012, 2, 28), (2012, 3, 29)) = true
val test13 = is_older((2012, 2, 28), (2012, 2, 29)) = true
val test14 = is_older((2012, 2, 28), (2012, 2, 28)) = false
val test15 = is_older((2013, 3, 29), (2012, 2, 28)) = false
val test16 = is_older((2013, 3, 29), (2013, 2, 28)) = false
val test17 = is_older((2013, 3, 29), (2013, 3, 28)) = false
val test18 = is_older((2012, 2, 28), (2011, 8, 29)) = false

val test21 = number_in_month([(2012, 2, 28), (2013, 12, 1)], 2) = 1
val test22 = number_in_month([(2012, 2, 28), (2013, 2, 1)],  2) = 2
val test23 = number_in_month([(2012, 3, 28), (2013, 4, 1)],  2) = 0

val test31 = number_in_months([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,3,4]    ) = 3
val test32 = number_in_months([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [12,13,14] ) = 1
val test33 = number_in_months([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [112,13,14]) = 0
val test34 = number_in_months([(2012,2,28), (2013,12,1), (2011,2,31), (2011,2,28)], [2]        ) = 3
val test35 = number_in_months([(2012,2,28), (2013,12,1), (2011,2,31), (2011,2,28)], [8]        ) = 0
val test36 = number_in_months([(2012,2,28), (2013,12,1), (2011,2,31), (2011,2,28)], []         ) = 0

val test41 = dates_in_month([(2012,2,28), (2013,12,1)], 2) = [(2012,2,28)]
val test42 = dates_in_month([(2012,2,28), (2013,2,11)], 2) = [(2012,2,28), (2013,2,11)]
val test43 = dates_in_month([(2012,2,28), (2013,12,1)], 3) = []
val test44 = dates_in_month([(2012,2,28), (2013,12,1), (2010,2,18)], 2) = [(2012,2,28), (2010,2,18)]
val test45 = dates_in_month([], 2) = []

val test51 = dates_in_months([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,3,4]) = [(2012,2,28), (2011,3,31), (2011,4,28)]
val test52 = dates_in_months([(2012,1,11), (2012,1,12), (2012,1,14)], [1,2]) = [(2012,1,11), (2012,1,12), (2012,1,14)]
val test53 = dates_in_months([(2012,1,11), (2012,1,12), (2012,2,14)], [3,4]) = []
val test54 = dates_in_months([(2012,1,11), (2012,1,12), (2012,2,14)], []) = []
val test55 = dates_in_months([], [1, 2]) = []
val test56 = dates_in_months([], []) = []

val test61 = get_nth(["hi", "there", "how", "are", "you"], 2) = "there"
val test62 = get_nth(["hi", "there", "how", "are", "you"], 1) = "hi"
val test63 = get_nth(["hi", "there", "how", "are", "you"], 5) = "you"

val test71 = date_to_string((2013, 6, 1)) = "June 1, 2013"
val test72 = date_to_string((2013, 12, 1)) = "December 1, 2013"
val test73 = date_to_string((2013, 1, 1)) = "January 1, 2013"

val test81 = number_before_reaching_sum(10, [1,2,3,4,5]) = 3
val test82 = number_before_reaching_sum(10, [1,2,3,3,5]) = 4
val test83 = number_before_reaching_sum(10, [2,2,3,4,5]) = 3
val test84 = number_before_reaching_sum(10, [10,2,3,4,5]) = 0
val test85 = number_before_reaching_sum(10, [2,2,2,2,2,2]) = 4
val test86 = number_before_reaching_sum(5, [6, 6]) = 0
val test87 = number_before_reaching_sum(6, [6, 6]) = 0
val test88 = number_before_reaching_sum(7, [6, 6]) = 1

val test91 = what_month(70) = 3
val test92 = what_month(30) = 1
val test93 = what_month(1) = 1
val test94 = what_month(32) = 2
val test95 = what_month(365) = 12
val test96 = what_month(364) = 12

val test110 = month_range(31, 34) = [1,2,2,2]
val test111 = month_range(10, 11) = [1,1]
val test112 = month_range(10, 15) = [1,1,1,1,1,1]
val test113 = month_range(364, 365) = [12,12]
val test114 = month_range(28, 32) = [1,1,1,1,2]
val test115 = month_range(100, 99) = []

val test211 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test212 = oldest([(2012,2,28),(2011,3,31),(2011,12,28)]) = SOME (2011,3,31)
val test213 = oldest([(2012,2,28)]) = SOME (2012,2,28)
					   val test214 = oldest([]) = NONE
