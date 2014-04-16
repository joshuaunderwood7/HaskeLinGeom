module GrammarOfReducedSearches where

import qualified Data.Vector as V

frst (x,_,_) = x
scnd (_,x,_) = x
thrd (_,_,x) = x

vectorSize = 256

init_i       = 0
init_END     = 0
init_CHILD   = V.fromList $ take vectorSize $ repeat 0
init_SIBLING = V.fromList $ take vectorSize $ repeat 0
init_PARENT  = V.fromList $ take vectorSize $ repeat 0

data GrammarState = GrammarState {
            i :: Int,
            end :: Int,
            child :: V.Vector Int,
            sibling :: V.Vector Int,
            parent :: V.Vector Int
            } deriving(Show)

init_GrammarState = GrammarState init_i init_END init_CHILD init_SIBLING init_PARENT

q0 _ _ = "there was an error"

q1 theWorld inputString = if _q1 then do 
    --S(i) -> A(i)
    let theNewString = inputString

    --formulas for G s
    let theNewWorld = theWorld

    q2 theNewWorld theNewString
    else do
    q0 GrammarState inputString
    where _q1 = True

q2 theWorld inputString = if _q2_gs then do 
    --A(i) –> A(End)_pi_(End)A(i)
    let theNewString = inputString

    {--
        Parent(End) := i 
            If Child(i) /= 0
            then
                Sibling(Child(i)):=End
            else
                Sibling(i):= 0
        Endif
        Child(i):=End
        End:=End+1
        formulas for G s 
    --}
    let theNewWorld = theWorld

    q2 theNewWorld theNewString
    else do
    q3 GrammarState inputString
    where _q2_gs = True

q3 theWorld inputString = if _q3 then do 
    --A(i) –> e
    let theNewString = inputString

    -- formulas for G s 
    let theNewWorld = theWorld

    theNewString
    else do
    q0 GrammarState inputString
    where _q3 = True

main = do
    putStrLn "bye"
    print init_GrammarState
