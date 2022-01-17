[![new](https://github.com/yegor256/fibonacci/actions/workflows/make.yml/badge.svg)](https://github.com/yegor256/fibonacci/actions/workflows/make.yml)

Here we compare [Fibonacci](https://en.wikipedia.org/wiki/Fibonacci_number) 
algorithm implemented in C++, Rust, Lisp, and some other programing languages
in different programming styles, like object-oriented, procedural, functional, etc.
We are trying to understand which style compiles to shorter binary code and 
works faster. If you can imagine some other way how this algorithm
could be implemented in C++ or other languages, 
don't hesitate to submit a pull request.

To build it just run:

```bash
$ make
```

The result will be in `summary.txt` file.

To analyze the quality of the code in this repo and make sure
there are no hidden defects, run all static analyzers and style checkers:

```bash
$ make sa
```

You need to have [Clang](https://clang.llvm.org),
[Make](https://www.gnu.org/software/make/),
[Rust](https://www.rust-lang.org/tools/install),
[Common Lisp](https://lisp-lang.org/learn/getting-started/),
[Clang-Tidy](https://clang.llvm.org/extra/clang-tidy/),
[Clang-Format](https://clang.llvm.org/docs/ClangFormat.html),
[cppcheck](https://github.com/danmar/cppcheck),
and [cpplint](https://github.com/cpplint/cpplint) installed.
