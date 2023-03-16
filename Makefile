# Some simple testing tasks (sorry, UNIX only).

FLAGS=
FILES := aioodbc tests examples setup.py


checkrst:
	python setup.py check --restructuredtext

lint: checkrst
	flake8 aioodbc tests examples setup.py

test: flake
	py.test -s $(FLAGS) ./tests/

vtest:
	py.test -s -v $(FLAGS) ./tests/

cov cover coverage: flake
	py.test -s -v  --cov-report term --cov-report html --cov aioodbc ./tests
	@echo "open file://`pwd`/htmlcov/index.html"
clean:
	rm -rf `find . -name __pycache__`
	rm -f `find . -type f -name '*.py[co]' `
	rm -f `find . -type f -name '*~' `
	rm -f `find . -type f -name '.*~' `
	rm -f `find . -type f -name '@*' `
	rm -f `find . -type f -name '#*#' `
	rm -f `find . -type f -name '*.orig' `
	rm -f `find . -type f -name '*.rej' `
	rm -f .coverage
	rm -rf coverage
	rm -rf build
	rm -rf htmlcov
	rm -rf dist

doc:
	make -C docs html
	@echo "open file://`pwd`/docs/_build/html/index.html"

black:
	black -l 79 $(FILES)

fmt:
	isort ${FILES}
	black -l 79 ${FILES}

checkfmt:
	isort --check-only --diff $(FILES)
	black -l 79 --check $(FILES)

.PHONY: all flake test vtest cov clean doc
