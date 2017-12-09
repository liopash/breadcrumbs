fun is_older ( date1 : int * int * int, date2 : int * int * int ) =
  #1 date1 <= #1 date2 andalso #2 date1 <= #2 date2 andalso #3 date1 < #3 date2
									  
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
    val months = ["January","February","March","April","May","June","July","September","October","November","December"]
  in
    get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end

fun number_before_reaching_sum ( sum : int, xs : int list ) =
  if  hd xs < sum  
  then 1 + number_before_reaching_sum (sum ,hd xs + hd(tl xs) :: tl(tl xs) )
  else 0   
	   
fun what_month ( days : int ) = 
  number_before_reaching_sum(days, [31,28,31,30,31,30,31,31,30,31,30,31]) + 1

