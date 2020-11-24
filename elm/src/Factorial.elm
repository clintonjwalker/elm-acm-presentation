module Factorial exposing (badFactorial, factorial)

-- factorial is the only exposed method.
-- this is the functional equivalent of "private methods"


badFactorial : Int -> Int
badFactorial num =
    if num == 1 then
        1
    else
        num * badFactorial (num - 1)


tailFact : Int -> Int -> Int
tailFact num product =
    if num < 2 then
        product

    else
        tailFact (num - 1) (product * num)


factorial : Int -> Int
factorial num =
    tailFact num 1



-- Remember: Tail-Recursion, TCO
