release ?=

md_files = $(wildcard *.md)
html_files := $(md_files:.md=.html)

main: main.cr $(html_files) $(wildcard *.html)
	crystal build $(if $(release),--release )$<

render_md: render_md.cr
	crystal build $<

%.html: %.md render_md
	./render_md $< > $@

.PHONY: clean
clean:
	rm -f $(html_files) render_md main

.PHONY: run
run: main
	./creds.sh ./main
