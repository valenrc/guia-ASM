SHELL := /bin/bash
all:
	mkdir TP1-b
	python src/deleter.py src TP1-b
	cd src/Resuelto/validate_key/ && $(MAKE)
	cp src/Resuelto/validate_key/validate_key TP1-b/src/
	rm -rf TP1-b/src/Resuelto
	cp .gitignore TP1-b
	cp README.md TP1-b
	vimdiff <(cd .; find . | sort) <(cd TP1-b; find . | sort)

clean:
	rm -rf TP1-b
