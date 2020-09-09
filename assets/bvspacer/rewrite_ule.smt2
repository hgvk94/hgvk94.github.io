(declare-const x (_ BitVec 128))
(declare-const y (_ BitVec 128))
(declare-const z (_ BitVec 128))
;all rules for rewriting x + y <= z

;soundness proofs
;antecedents ==> consequent

(push)
;rule 1: x >= -y /\ x <= z - y ==> x + y <= z
(assert (and (bvuge x (bvneg y)) (bvule x (bvadd z (bvneg y))) (not (bvule (bvadd x y) z))))
(check-sat)
(pop)

(push)
;rule 2: z >= y /\ x <= z - y ==> x + y <= z
(assert (and (bvuge z y) (bvule x (bvadd z (bvneg y))) (not (bvule (bvadd x y) z))))
(check-sat)
(pop)

(push)
;rule 3: z >= y /\ x >= -y /\ y != 0 ==> x + y <= z
(assert (and (bvuge z y) (bvuge x (bvneg y)) (not (= y #x00000000000000000000000000000000)) (not (bvule (bvadd x y) z))))
(check-sat)
(pop)

;completeness proof
; (\/ antecedents) <==> consequent

(push)
;left to right direction
(assert (or (and (bvule x (bvadd z (bvneg y))) (bvuge x (bvneg y)))
            (and (bvule x (bvadd z (bvneg y))) (bvuge z y))
            (and (bvuge x (bvneg y)) (bvuge z y) (not (= y #x00000000000000000000000000000000)))))
(assert (not (bvule (bvadd x y) z)))
(check-sat)
(pop)

(push)
;the other direction
(assert (or (not (bvuge x (bvneg y))) (not (bvule x (bvadd z (bvneg y))))))
(assert (or (not (bvuge z y)) (not (bvule x (bvadd z (bvneg y))))))
(assert (or (not (bvuge x (bvneg y))) (not (bvuge z y)) (= y #x00000000000000000000000000000000)))
(assert (bvule (bvadd x y) z))
(check-sat)
(pop)

;proof that only one rule is applicable
(push)
;when rule 3 is applicable, neither of the other 2 are applicable
;z >= y /\ x >= -y /\ y != 0 ==> !(x <= z - y)
(assert (bvuge z y))
(assert (bvuge x (bvneg y)))
(assert (not (= y #x00000000000000000000000000000000)))
(assert (bvule x (bvadd z (bvneg y))))
(check-sat)
(pop)


;all rules for rewriting z <= x + y

;soundness proofs
;antecedents ==> consequent

(push)
;rule 1: x < -y /\ z - y <= x ==> z <= x + y
(assert (and (bvult x (bvneg y)) (bvule (bvadd z (bvneg y)) x) (not (bvule z (bvadd x y)))))
(check-sat)
(pop)

(push)
;rule 2: z < y /\ z - y <= x ==> z <= x + y
(assert (and (bvult z y) (bvule (bvadd z (bvneg y)) x) (not (bvule z (bvadd x y)))))
(check-sat)
(pop)

(push)
;rule 3: z <= x /\ y = 0 ==> z <= x + y
(assert (and (bvule z x) (= y #x00000000000000000000000000000000) (not (bvule z (bvadd x y)))))
(check-sat)
(pop)

(push)
;rule 4: x < -y /\ z < y /\ !(y = 0) ==> z <= x + y
(assert (and (bvult z y) (bvult x (bvneg y)) (not (= y #x00000000000000000000000000000000)) (not (bvule z (bvadd x y)))))
(check-sat)
(pop)
;completeness proof
; (\/ antecedents) <==> consequent

(push)
;left to right direction
(assert (or (and (bvule (bvadd z (bvneg y)) x) (bvult x (bvneg y)))
            (and (bvule (bvadd z (bvneg y)) x) (bvult z y))
            (and (bvule z x) (= y #x00000000000000000000000000000000))
            (and (bvult z y) (bvult x (bvneg y)) (not (= y #x00000000000000000000000000000000)))))
(assert (not (bvule z (bvadd x y))))
(check-sat)
(pop)

(push)
;the other direction
(assert (or (not (bvult x (bvneg y))) (not (bvule (bvadd z (bvneg y)) x))))
(assert (or (not (bvult z y)) (not (bvule (bvadd z (bvneg y)) x))))
(assert (or (not (bvule z x)) (not (= y #x00000000000000000000000000000000))))
(assert (or (not (bvult z y)) (not (bvult x (bvneg y))) (= y #x00000000000000000000000000000000)))
(assert (bvule z (bvadd x y)))
(check-sat)
(pop)

;proof that only one rule is applicable
(push)
;the antecedents of rules 1 and 2 contradict each other
;z < y /\ x < -y ==> !(z - y <= x)
(assert (bvult z y))
(assert (bvult x (bvneg y)))
(assert (bvule (bvadd z (bvneg y)) x))
(check-sat)
(pop)
