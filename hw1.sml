fun is_older(dt1: int * int * int, dt2: int * int * int) =
    if #1 dt1 < #1 dt2 orelse 
        (#1 dt1 = #1 dt2 andalso #2 dt1 < #2 dt2) orelse
        (#1 dt1 = #1 dt2 andalso #2 dt1 = #2 dt2 andalso #3 dt1 < #3 dt2)
    then true
    else false

fun number_in_month(dts: (int * int * int) list, mo: int) =
    if null dts
    then 0
    else 
        if #2 (hd dts) = mo
        then 1 + number_in_month(tl dts, mo)
        else 0 + number_in_month(tl dts, mo)



fun number_in_months(dts: (int * int * int) list, mos: int list) =
    let 
        fun in_months(dt: (int * int * int), mos: int list) =
            if null mos
            then false
            else 
                if #2 dt = hd mos 
                then true
                else in_months(dt, tl mos)
    in
        if null dts
        then 0
        else
            if in_months(hd dts, mos)
            then 1 + number_in_months(tl dts, mos)
            else 0 + number_in_months(tl dts, mos)
    end

fun dates_in_month(dts: (int * int * int) list, mo: int) = 
    if null dts
    then []
    else 
        if #2 (hd dts) = mo 
        then (hd dts)::dates_in_month(tl dts, mo)
        else dates_in_month(tl dts, mo)

fun dates_in_months(dts: (int * int * int) list, mos: int list) = 
    let 
        fun in_months(dt: (int * int * int), mos: int list) =
            if null mos
            then false
            else 
                if #2 dt = hd mos 
                then true
                else in_months(dt, tl mos)
    in
        if null dts
        then []
        else 
            if in_months(hd dts, mos)
            then (hd dts)::dates_in_months(tl dts, mos)
            else dates_in_months(tl dts, mos)
    end

fun get_nth(strs: string list, n: int) =
    if n = 1
    then hd strs
    else get_nth(tl strs, n - 1)

fun date_to_string(dt: (int * int * int)) = 
    let
        val dates = ["January", "February", "March", "April",
            "May", "June", "July", "August",
            "September", "October", "November", "December"]
    in
        get_nth(dates, #2 dt) ^ " " ^ Int.toString(#3 dt) ^ ", " ^ Int.toString(#1 dt)
    end

fun number_before_reaching_sum(sum: int, ints: int list) =
    if sum < hd ints
    then 0
    else 1 + number_before_reaching_sum(sum - hd ints, tl ints)

fun what_month(day: int) = 
    let
        val days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        1 + number_before_reaching_sum(day - 1, days)
    end

fun month_range(day1, day2) = 
    let 
        val days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        fun num_range(num1, num2) = 
            if num1 = num2
            then num2::[]
            else num1::num_range(num1 + 1, num2)
    in
        num_range(what_month(day1), what_month(day2))
    end

fun oldest(dates: (int * int * int) list) = 
    if null dates
    then NONE
    else 
        let 
            fun oldest_date(dts: (int * int * int) list) = 
                if null (tl dts)
                then hd dts
                else 
                    let val oldest = oldest_date(tl dts)
                    in 
                        if is_older(hd dts, oldest)
                        then hd dts 
                        else oldest
                    end
        in
            SOME (oldest_date dates)
        end

val test1 = (2021, 1, 12)
val test2 = (2021, 1, 14)
val test3 = (2020, 1, 5)
val test4 = (2022, 2, 40)
val test5 = (2022, 1, 31)
val testList = ["test1", "test2", "test3", "test4", "test5"]
val testList = [test1, test2, test3, test4, test5]
val testList2 = [5, 2, 7, 19, 23, 1, 2, 3, 14]