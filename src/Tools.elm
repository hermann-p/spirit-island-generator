module Tools exposing (..)


splitList : Int -> List a -> List (List a)
splitList n xs =
    case List.take n xs of
        [] ->
            []

        head ->
            head :: splitList n (List.drop n xs)


splitListFull : Int -> a -> List a -> List (List a)
splitListFull n filler xs =
    xs
        |> splitList n
        |> List.map (padWith n filler)


unnest1 : List (List a) -> List a
unnest1 list =
    case list of
        x :: xs ->
            x ++ unnest1 xs

        _ ->
            []


padWith : Int -> a -> List a -> List a
padWith n el xs =
    let
        padding =
            List.repeat (n - List.length xs) el
    in
    xs ++ padding
