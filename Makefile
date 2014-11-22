
build:
	docker build -t python-runtime:2.7 ./2.7
	docker build -t python-runtime:3.4 ./3.4

test: build
	tests/runtests tests/**/test.sh