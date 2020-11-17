module FizzBuzz exposing (buzzing)


type alias Rule =
    ( Int -> Bool, String )


multipleOf : Int -> Int -> Bool
multipleOf a b =
    remainderBy a b == 0


isInTheFifties : Int -> Bool
isInTheFifties num =
    num >= 50 && num <= 59


rules : List Rule
rules =
    [ ( multipleOf 3, "Fizz" ), ( multipleOf 5, "Buzz" ), ( isInTheFifties, "Baz" ) ]



-- multipleOf: Int -> Int -> Bool
-- (multipleOf 3): Int -> Bool


matchNumberToRules : Int -> List Rule
matchNumberToRules num =
    rules
        |> List.filter (\( cond, _ ) -> cond num)


printNumber : Int -> String
printNumber num =
    let
        ruleMatches =
            matchNumberToRules num
                |> List.map (\( _, text ) -> text)
                |> String.join ""
    in
    if String.isEmpty ruleMatches then
        String.fromInt num

    else
        ruleMatches


buzzing : List String
buzzing =
    List.range 1 100
        |> List.map printNumber
