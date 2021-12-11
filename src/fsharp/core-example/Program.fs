open System

type Transaction =
    { guid: string
      description: string;
      category: string;
      accountType: string;
      accountNameOwner: string;
      notes: string;
      transactionState: string;
      accountId: int;
      transactionId: int;
      reoccurring: bool;
      amount: float;
    }

let transaction = { guid = "abc"; description = "desc"; category = "cat"; accountType = "credit"; accountNameOwner = "test_brian"; notes = "note"; transactionState = ""; accountId = 1; transactionId = 1; reoccurring = false; amount = 0.0 }

[<EntryPoint>]
let main argv =
    printfn "Hello World"
    0
