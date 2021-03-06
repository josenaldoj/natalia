module Main (main) where

-- natalia's modules
import Blocks.Blocks
import Lexical.Lexemes
import Lexical.Tokens
import Memory.Memory
import Statements.Statements
import TypeValue.TypeValue

-- Haskell's modules
import Control.Monad.IO.Class
import System.Environment
import System.IO.Unsafe
import Text.Parsec

-- the entire program
program :: ParsecT [Token] [MemoryCell] IO ()
program = do
            retPredefinedBlocks <- predefinedBlocks (ConsNatInt 0)
            retMainBlock <- mainBlock
            eof
            return ()

-- invocação do parser para o símbolo de partida 

parser :: [Token] -> IO (Either ParseError ())
parser tokens = runParserT program [] "Error message" tokens

main :: IO ()
main = do
    args <- getArgs

    if length args == 0 then
        putStrLn "You must pass a natalia program as an argument!"
    else
        case unsafePerformIO (parser (getTokens (head args))) of
                { Left err -> print err; 
                    Right ans -> return ()
                }




