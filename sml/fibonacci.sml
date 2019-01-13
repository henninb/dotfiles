(* comment *)

fun fibonacci(x) = if x = 0 then 0 else if x = 1 then 1 else fibonacci(x - 2) + fibonacci(x - 1);
fun rec_for_loop(x) = if x = 0 then print("") else (rec_for_loop(x - 1);print("fibonacci(" ^ Int.toString(x) ^ ")=<" ^ Int.toString(fibonacci(x)) ^ ">\n"));

fun main() =
  let
    val args = CommandLine.arguments()
    val argc = List.length(args)
    val prgmName = "fibonacci"
  in
    if argc <> 0 then
    (
      print("Usage: " ^ prgmName ^ " <noargs>\n");
      OS.Process.exit OS.Process.failure
    )
    else
    (
      rec_for_loop(40)
    )
  end;

val _ = main();

