-- Elm can infer types as follows:


module TeachingBasics exposing (..)


impliedVariableType =
    29



-- Though, it is normally always better to define
-- your types as follows:


typeInferencePlease : Int
typeInferencePlease =
    30



-- This actually allows Elm to produce better error messages.
-- Elm has all of the basic data types (Int, String, Float, Bool, Char, List, Dict, etc.)
-- But it also has Tuples:


twoVariables : ( Int, String )
twoVariables =
    ( 8, "This is a Tuple" )



-- And Records:


user :
    { id : Int
    , userName : String
    , password : String

    -- ...
    }
user =
    { id = 1
    , userName = "presentationUser"
    , password = "..."

    -- ...
    }



-- Declaring record types can be tedious.
-- We can `alias` these record types as follows:


type alias User =
    { id : Int
    , userName : String
    , password : String

    -- ...
    }



-- Notice that the alias is Capitalized -- Elm is sensitive to capitalization
-- All types are Capital, and data/functions are lowercase
--
-- But, what then, is a `Type`?
-- These are what you may call "Enumerables", or "Union Types", or "Algebraic Data Types"
-- For instance, consider the definition of a Bool:


type CustomBool
    = True
    | False



-- This is read as "CustomBool is either True or False"
-- That's not very helpful though... We can do better...
-- Let's make a "null" data type:


type NullableString
    = HasString String
    | NoData



-- Woah, what's that `HasString String`?


myStringWithAValue : NullableString
myStringWithAValue =
    HasString "Data coming from API"


myNullString : NullableString
myNullString =
    NoData



-- Okay, but how do you use a NullableString
-- Like this:


iCouldBeNull : NullableString
iCouldBeNull =
    HasString "Something here"


getTheValueOrSetToEmpty : String
getTheValueOrSetToEmpty =
    case iCouldBeNull of
        HasString theDataContainedWithinValue ->
            theDataContainedWithinValue

        NoData ->
            ""



-- Don't worry, you don't need to write Nullabe<type> for everything.
-- Elm has "generic" data types (not really, we will cover this in a minute though)


type NullableTypes whateverType
    = Value whateverType
    | Null



-- Yay! Now we can use this instead of our NullableString!


myNullableInt : NullableTypes Int
myNullableInt =
    Value 8



-- Don't worry, we're just reinventing the wheel here. Elm already has this defined in the standard library.
-- In elm, we use `Maybe` to determine a value


maybeString : Maybe String
maybeString =
    Just "A string is contained here"


maybeInt : Maybe Int
maybeInt =
    Nothing



-- So, that actually introduces something quite interesting:
-- ELM HAS NO NULL VALUES. There is never "Missing data". You will always know if
-- you have a string, int, or any other value.
--
-- I can't add 2 `Maybe Int`'s together. Maybe has no definition of +. If I want
-- to add them together, I need to make sure I'm actually **dealing** with Int
-- values. This is the power of Elm's type system.
--
-- It also extends into Elm's Error types: Result
-- Here's an example Result type:


tryParseInt : Result String Int
tryParseInt =
    case String.toInt "a" of
        Just val ->
            Ok val

        -- val is an Int
        Nothing ->
            Err "Failed to parse int"



-- This is a String
-- Woah, what' that? Those are two different types!
-- We can do some pretty complicated things with this:


type UnknownDataType
    = GotInt Int
    | GotChar Char
    | GotString (Maybe String)
    | ParsedInt (Result Int String)



-- That's a lot of types!
--
-- So now let's talk about "generics" it turns out, this whole example has been a lie.
-- Elm doesn't really have "types". Nor generics. Nor aliases.
-- Elm is a Functional Programming Language. Elm has Functions
--
-- Let's look at the following type definition:


type alias DateTime =
    { year : Int
    , month : Int
    , day : Int
    , hour : Int
    , minute : Int

    -- ...
    }



-- I just said Elm doesn't have types, so what the heck is `DateTime` then?
-- DateTime is a function, which takes 4 Ints and returns a record.
-- We should be able to call functions, right? We can:


todaysDate : DateTime
todaysDate =
    DateTime 2020 11 23 17 30



-- What about generics!?!? Well, since all an alias is is a Function,


type OneOf varA varB
    = Left varA
    | Right varB


left : OneOf String Int
left =
    Left "Took the left variant"


right : OneOf String Int
right =
    Right 5



-- This is simply ***CALLING*** the type function that returns the value.
-- BOTH VARIANTS ARE THE SAME TYPE: FUNCTION
--
-- Up until this point, we've only been dealing with Data. Let's take a moment
-- to start USING these functions


isEven : Int -> Bool
isEven num =
    remainderBy 2 num == 0



-- The `->` is how we define a return type.
-- Let's do a more complex example:


add : ( Int, Int ) -> Int
add ( a, b ) =
    a + b



-- Okay, that's fine. But it's actually not as FUNCTIONAL as we want it to be.
-- Let's see how we can make it better


functionalAdd : Int -> (Int -> Int)
functionalAdd a b =
    a + b



-- Hold up, how do I read this?!
-- functionalAdd is a function... That returns... a function... that returns an Int
--
-- In fact, we don't need the parenthesis:


functionalMultiply : Int -> Int -> Int
functionalMultiply a b =
    a * b



-- But why? This doesn't look useful.
-- Let's make another function `divisibleBy`. This function is going to tell us
-- if two one number is divisble by another


divisibleBy : Int -> Int -> Bool
divisibleBy divBy num =
    remainderBy divBy num == 0



-- Cool, now we have a function that takes 2 parameters.
-- Let's make another function OFF of this function


divisibleByFive : Int -> Bool
divisibleByFive =
    divisibleBy 5



-- This is a technique called `currying`. We've taken a function, and made a function OUT OF it.
-- Elm makes no distinction between functions and data, so we can treat data as functions:


listOfDivisions : List (Int -> Bool)
listOfDivisions =
    [ divisibleBy 3, divisibleBy 5 ]



-- There's only one other thing we are going to cover before moving on to the FizzBuzz and Factorial examples:


numbersDivisibleByNineSquared : List Int
numbersDivisibleByNineSquared =
    List.range 1 100
        -- Take a list of 100 numbers
        |> List.filter (\num -> divisibleBy 9 num)
        -- Filter values not divisible by 9
        -- And square the result
        |> List.map (\num -> num * num)
