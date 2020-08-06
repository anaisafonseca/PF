#lang racket

(define (substituira n x list)
  (if (null? list)
      '()
      (if (list? (car list))
          (cons (substituira n x (car list))
                (substituira n x (cdr list)))
          (if (equal? n (car list))
              (cons x (substituira n x (cdr list)))
              (cons (car list) (substituira n x (cdr list)))
          ))))
