
all: t4.log impout.log	

t4pre.log: ../sim/t4.net
	ngspice -b $< -o $@ 
	
t4.log: t4pre.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $iT4.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	
	


preimpout.log: ../sim/impout.net
	ngspice -b $< -o $@
	
impout.log: preimpout.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $iimp.tex;)

clean:
	@rm -f *.log *.tex *.pdf *.ps *.txt *~

.PHONY: clean
