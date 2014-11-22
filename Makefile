
build:
	cd 2.7 && docker build -t python-runtime:2.7 .
	cd 3.4 && docker build -t python-runtime:3.4 .

test: build
	tests/runtests tests/**/test.sh