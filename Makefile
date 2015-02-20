Src=active-v11
Bib=$(shell ls *.bib *.bst)

all : dirs tex bib  tex tex done



commit:; - git status; git commit -a; git push origin master
typo:  ; - git status; git commit -am "typo"; git push origin master
update:; - git pull origin master
status:; - git status
gitting:
	git config --global credential.helper cache
	git config credential.helper 'cache --timeout=3600'

one : dirs tex done 

view :
	evince $(HOME)/tmp/$(Src).pdf &

timm :
	cp $(HOME)/tmp/$(Src).pdf $(HOME)/public_html/tmp

done : embedfonts
	@printf "\n\n\n==============================================\n"
	@printf       "see output in $(HOME)/tmp/$(Src).pdf\n"
	@printf       "==============================================\n\n\n"
	@printf "\n\nWarnings (may be none):\n\n"
	grep arning $(HOME)/tmp/${Src}.log

dirs : 
	- [ ! -d $(HOME)/tmp ] && mkdir $(HOME)/tmp

tex :
	- pdflatex -output-directory=$(HOME)/tmp $(Src)

embedfonts:
	@ gs -q -dNOPAUSE -dBATCH -dPDFSETTINGS=/prepress -sDEVICE=pdfwrite \
          -sOutputFile=$(HOME)/tmp/$(Src)-embedded.pdf $(HOME)/tmp/$(Src).pdf
	@ mv              $(HOME)/tmp/$(Src)-embedded.pdf $(HOME)/tmp/$(Src).pdf

bib : 
	- cp $(Bib) $(HOME)/tmp; cd $(HOME)/tmp; bibtex $(Src)

