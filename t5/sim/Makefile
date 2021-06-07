
all: t5.log is.log	

t5pre.log: ../sim/t5.net
	ngspice -b $< -o $@ 
	
t5.log: t5pre.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $iT5.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	
	


preis.log: ../sim/is.net
	ngspice -b $< -o $@
	
is.log: preis.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $is.tex;)

clean:
	@rm -f *.log *.tex *.pdf *.ps *.txt *~

.PHONY: clean
