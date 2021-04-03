all:  T2.log

	
#	Corre o ficheiro T2.m e analisa o log do ficheiro
T2.log: T2.m
	octave $< > $@


	
#	Higienização
clean:
	@rm -f octave-workspace *.log *.tex *.eps

.PHONY: clean
