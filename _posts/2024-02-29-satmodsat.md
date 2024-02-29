---
layout: page
pin: true
title:  Speculative SAT modulo SAT
date:   2024-02-29 00:17:06 -0400
permalink: /specsms/
visible: 1
---
We are working on a long term project of rewriting Spacer to have the theory of EUF at its core. The architecture is going to be similiar to an SMT solver: one core model checker for EUF at the centre and theory solvers for MBP, interpolants, inductive generalization, and global guidance used on demand. Our work on lightweight quantifier elimination using e-graphs([link] (https://link.springer.com/chapter/10.1007/978-3-031-37703-7_4)) is a step in this direction.

Another important direction is to come up with a model checking algorithm for EUF. Two critical components for the task are computing predecessors and generalizing lemmas. While we can use [covers](https://link.springer.com/chapter/10.1007/978-3-540-78739-6_16) for computing predecessor, we have to assume that we won't be able to do it precisely when combined with theories. Therefore, the model checker will have to work with abstract predecessors. 

In our latest [work](https://arxiv.org/abs/2306.17765), we investigate an approach to combine (boolean) IC3 with abstract predecessors. Well, we are not quite there yet. In modular model checking algorithms like IC3, decisions are made by one SAT solver at a time. The SAT solver produces a *complete* assignment for its module and propagates the assignment  (a predecessor) to the next solver. We can think of an abstract predecessor as a *partial* assignment to the module. We develop an approach for modular SAT solving when one of the SAT solvers make a partial assignment and then switches over control to the next SAT solver. We develop a clausal proof format for modular solvers and give an algorithm for genrating interpolants from such proofs.

We [implement](https://github.com/hgvk94/z3/tree/tacas24submission) this feature using SAT solver extensions in Z3.

