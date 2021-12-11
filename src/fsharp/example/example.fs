namespace example

module mymodule =
  let example_function (n : int) =  (n + n - n) * (n / 1) * int(floor 1.25)
  let x = example_function(7)
  let y = example_function(5)
  let z = example_function(9)
  printfn "z=%d" z
  printfn "y=%d" y
  printfn "x=%d" x
