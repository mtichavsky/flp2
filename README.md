# FLP: Hamiltonian cycle

Author: Milan Tichavský (xticha09)

## Design

The program picks the first point from the input file, which it uses as a starting point.
Then, it performs depth-first search with backtracking to find all possible Hamiltonian cycles.
All found cycles are at first sorted and compared with already found paths, so that no duplicate
cycle is added. If the given path wasn't found yet, this path is added to the dynamic predicate
`paths`.

## Usage

To build and run the program using input from `fully_3.in`, run

```sh
make build
./flp23-log < fully_3.in
```

To launch testing script, execute

```sh
make test # execution is pretty much instant
```

