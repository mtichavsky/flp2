# FLP: Hamiltonian cycle
# Author: Milan Tichavský <xticha09>

TESTS_DIR=test-cases

.PHONY: build clean

build:
	swipl -q -g main -o flp23-log -c flp23-log.pl

run: build
	./flp23-log < $(TESTS_DIR)/fully_3.in

test: build
	./flp23-log < $(TESTS_DIR)/fully_3.in | sort > $(TESTS_DIR)/fully_3.res
	diff $(TESTS_DIR)/fully_3.res $(TESTS_DIR)/fully_3.out
	./flp23-log < $(TESTS_DIR)/graph6a.in | sort > $(TESTS_DIR)/graph6a.res
	diff $(TESTS_DIR)/graph6a.res $(TESTS_DIR)/graph6a.out
	./flp23-log < $(TESTS_DIR)/graph6b.in | sort > $(TESTS_DIR)/graph6b.res
	diff $(TESTS_DIR)/graph6b.res $(TESTS_DIR)/graph6b.out

clean:
	rm flp23-log
