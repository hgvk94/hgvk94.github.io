---
layout: page
pin: true
title:  GSpacerBV
date:   2020-05-14 00:17:06 -0400
permalink: /gspacerbv/
visible: 1
---
We wanted to make Spacer more efficient for reasoning about Software programs (with fixed-precision numbers) and complicated hardware designs. Such problems are conveniently expressed in the first order theory of Fixed-Size Bit-Vectors (BV).
To instantiate Spacer for any theory, you would need three ingredients: a good SMT solver, an interpolation algorithm (for generalizing lemmas), and a Model Based Projection (MBP) algorithm (for computing predecessors to Bad states). 
For example, for the theory of Linear Integer Arithmetic, Spacer uses a simplex based SMT solver inside Z3, the Farkas interpolation algorithm, and a Fourier-Motzkin based MBP. In BV, Spacer has a choice of SMT solvers inside Z3 ([and Nikolaj is working on a new one!!](https://github.com/Z3Prover/z3/pull/4674)) but very limited support for interpolation and MBP. In our most recent work, we develop a new MBP algorithm for BV and extend global guidance techniques to BV. [Here is the full paper](/assets/bvspacer/paper.pdf).

The proof of correctness for our rewrite rules can be found [here](/assets/bvspacer/rewrite_ule.smt2).
