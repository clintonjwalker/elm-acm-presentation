module Factorial exposing (factorial)


tailFact : Int -> Int -> Int
tailFact num product =
    if num < 2 then
        product

    else
        tailFact (num - 1) (product * num)


factorial : Int -> Int
factorial num =
    tailFact num 1
