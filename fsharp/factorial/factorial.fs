namespace factorial

module mymodule =
  let rec factorial x = if x < 1 then 1 else x * factorial (x - 1)
  let x = factorial(4)
  printfn "x=%d" x
