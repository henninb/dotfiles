namespace factorial

module mymodule =
  let rec factorial x = if x < 1 then 1 else x * factorial (x - 1)
  printfn "factorial(6)=%d" (factorial(6))
  printfn "factorial(5)=%d" (factorial(5))
  printfn "factorial(4)=%d" (factorial(4))
