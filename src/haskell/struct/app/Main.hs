module Main where

import Data.List

data Transaction = Transaction Integer String Integer String String Integer String String Double Int
   deriving Show
-- data Transaction = Transaction String String
--  deriving Show
--newtype Transaction = String String deriving Show

transaction :: Transaction
-- transaction = Transaction "1001" "guid"
transaction = Transaction 1 "guid" 1 "credit" "chase_brian" 1 "aliexpress.com" "none" 12.51 1
main = print "hello world"


-- import Data.Dates
-- import Data.BigDecimal
-- , _transactionId: Long = 0L
-- , _guid: String = "",
-- , _accountId: Long = 0
-- , _accountType: AccountType = AccountType.Credit,
-- , _accountNameOwner: String = ""
-- , _transactionDate: Date = Date(0),
-- , _description: String = ""
-- , _category: String = "",
-- , _amount: BigDecimal = BigDecimal(0.00)
-- , _cleared: Int = 0,
-- , _reoccurring: Boolean = false
-- , _notes: String = "",
-- , _dateUpdated: Timestamp = Timestamp(0),
-- , _dateAdded: Timestamp = Timestamp(0),
-- , _sha256: String = ""
