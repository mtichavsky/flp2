
.PHONY: build clean

build:
	swipl -q -g main -o flp23-log -c flp23-log.pl

run: build
	./flp23-log < fully_3.in

test: build
	./flp23-log < fully_3.in > out.txt
	diff out.txt fully_3.out

clean:
	rm flp23-log
