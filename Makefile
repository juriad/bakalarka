all: prace.pdf

# Vyroba PDF primo z DVI by byla prijemnejsi, ale vetsina verzi dvipdfm nici obrazky
# prace.pdf: prace.dvi
#	dvipdfm -o $@ -p a4 -r 600 $<

VPATH = img:work

img/%.eps: %.dia
	dia -t eps -e $@ $< 

work/prace.pdf: prace.ps
	ps2pdf $< $@

work/prace.ps: prace.dvi
	cd work; \
		dvips -o prace.ps -D600 -t a4 prace.dvi

work: $(wildcard *.tex) $(addsuffix .eps, $(basename $(wildcard img/*))) $(wildcard *.bib)
	mkdir -p work
	cp $^ work/
	cp czechiso.bst work/
	cd work; \
		vlna -l *.tex; \
	    vlna -l -v ai *.tex

work/prace.dvi: work
	cd work; \
		cslatex prace.tex; \
		makeindex prace.nlo -s nomencl.ist -o prace.nls; \
		cslatex prace.tex; \
		bibtex prace.aux; \
		cslatex prace.tex; \
		cslatex prace.tex 

show: prace.pdf
	zathura $<

clean:
	rm -rf work
	rm -f `ls img/*.eps | grep -v 'logo.eps'`
	rm -f *~ img/*~
