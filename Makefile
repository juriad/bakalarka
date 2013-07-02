all: prace.pdf

# Vyroba PDF primo z DVI by byla prijemnejsi, ale vetsina verzi dvipdfm nici obrazky
# prace.pdf: prace.dvi
#	dvipdfm -o $@ -p a4 -r 600 $<

VPATH = img

img/%.eps: %.dia
	dia -t eps -e $@ $< 

prace.pdf: prace.ps
	ps2pdf $< $@

prace.ps: prace.dvi
	dvips -o $@ -D600 -t a4 $<

# LaTeX je potreba spustit dvakrat, aby spravne spocital odkazy
prace.dvi: prace.tex $(wildcard *.tex) $(addsuffix .eps, $(basename $(wildcard img/*)))
	cslatex $<
	cslatex $<

show: prace.pdf
	zathura prace.pdf

clean:
	rm -f *.{log,dvi,aux,toc,lof,out} prace.ps prace.pdf
	rm -f `ls img/*.eps | grep -v 'logo.eps'`
