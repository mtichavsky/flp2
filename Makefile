# FLP: Hamiltonian cycle
# Author: Milan Tichavský <xticha09>

.PHONY: build clean

build:
	swipl -q -g main -o flp23-log -c flp23-log.pl

run: build
	./flp23-log < fully_3.in

test: build
	./flp23-log < fully_3.in | sort > fully_3.res
	diff fully_3.res fully_3.out
	./flp23-log < graph6a.in | sort > graph6a.res
	diff graph6a.res graph6a.out
	./flp23-log < graph6b.in | sort > graph6b.res
	diff graph6b.res graph6b.out

clean:
	rm flp23-log
