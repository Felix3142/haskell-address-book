module File
    ( readContacts
    , writeContacts
    ) where

import Control.Monad ((>=>))
import Control.Monad.IO.Class (liftIO)
import qualified Data.ByteString.Char8 as C8
import qualified Data.Yaml as Yaml

import Contacts (Contacts)

readContacts :: String -> IO (Either Yaml.ParseException Contacts)
readContacts =
    readFile >=> return . decodeContacts

writeContacts :: String -> Contacts -> IO ()
writeContacts path =
    liftIO . writeFile path . encodeContacts

decodeContacts :: String -> Either Yaml.ParseException Contacts
decodeContacts = Yaml.decodeEither' . C8.pack

encodeContacts :: Contacts -> String
encodeContacts = C8.unpack . Yaml.encode