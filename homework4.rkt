
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; problem 1

(define (sequence x y z)
  (if (> x y)
      null
      (cons x (sequence (+ x z) y z))))

;; problem 2

(define (string-append-map xs sfx)
  (map (lambda (x) (string-append x sfx)) xs))

;; problem 3

(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs)  (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

;; problem 4

(define (stream-for-n-steps s n)
  (letrec ([f (lambda (s n)
        (let ([pr (s)])        
          (if (= n 0)
              null
        (cons (car pr) (f (cdr pr) (- n 1))))))])
    (f s n)))

;; problem 5

(define funny-number-stream
  (letrec ([fn (lambda (x)
                 (if (= (modulo x 5) 0)
                    (cons  (- x) (lambda () (fn (+ x 1))))
                    (cons x (lambda () (fn (+ x 1))))))])
    (lambda () (fn 1))))

;; problem 6

(define dan-then-dog
  (letrec ([fn (lambda (x)
                 (if (equal? x "dan.jpg")
                     (cons x (lambda () (fn "dog.jpg")))
                     (cons x (lambda () (fn "dan.jpg")))))])
    (lambda () (fn "dan.jpg"))))