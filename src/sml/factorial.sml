(* comment *)
fun factorial(n) = if n = 1 then 1 else n * factorial(n - 1);
fun rec_for_loop(x) = if x = 0 then print("") else (rec_for_loop(x - 1);print("factorial(" ^ Int.toString(x) ^ ")=<" ^ Int.toString(factorial(x)) ^ ">\n"));

fun main() =
  let
    val args = CommandLine.arguments()
    val argc = List.length(args)
    val prgmName = "factorial"
  in
    if argc <> 0 then
    (
      print("Usage: " ^ prgmName ^ "<noargs>\n");
      OS.Process.exit OS.Process.failure
    )
    else
    (
      rec_for_loop(12)
    )
  end;

val _ = main();
