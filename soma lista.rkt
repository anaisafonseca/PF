#lang racket

(define (soma a x)
  (if (empty? x)
      a
      (soma (+ a (car x)) (cdr x))))

(soma 0 (list 0 2 4 6 8 10))
