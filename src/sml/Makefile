all:
	@git ls-files | ctags --links=no --languages=c,javascript,java,python,sml -L- 
	@mlton factorial.sml
	@mlton fibonacci.sml
