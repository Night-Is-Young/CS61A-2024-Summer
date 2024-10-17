(define (square n) (* n n))

(define (pow base exp)
  (if (= exp 1)
    base
    (if (even? exp)
      (square (pow base (quotient exp 2)))
      (* (square (pow base (quotient exp 2))) base)
    )
  )
)

(define (repeatedly-cube n x)
  (if (zero? n)
      x
      (let ((y (repeatedly-cube (- n 1) x)))
        (* y y y)
      )
  )
)

(define (cddr s) (cdr (cdr s)))

(define (cadr s) (car (cdr s)))

(define (caddr s) (car (cddr s)))

(define (ascending? s)
  (if (or (null? s) (null? (cdr s)))
    #t
    (and
      (not (> (car s) (cadr s)))
      (ascending? (cdr s))
    )
  )
)

(define (my-filter pred s)
  (if (null? s)
    s
    (if (pred (car s))
      (cons
        (car s)
        (my-filter pred (cdr s))
      )
      (my-filter pred (cdr s))
    )  
  )
)

(define (no-repeats s) 
  (if (null? s)
    s
    (cons
      (car s)
      (no-repeats 
        (my-filter 
          (lambda (t) (not (= t (car s))))
          (cdr s)
        )
      )
    )
  )
)

; helper function
; returns the values of lst that are bigger than x
; e.g., (larger-values 3 '(1 2 3 4 5 1 2 3 4 5)) --> (4 5 4 5)
(define (larger-values x lst)
  (filter
    (lambda (t) (> t x))
    lst  
  )  
)

(define (longest-increasing-subsequence lst)
  (if (null? lst)
      nil
      (begin (define first (car lst))
             (define rest (cdr lst))
             (define large-values-rest
                     (larger-values first rest))
             (define with-first
                     (cons first (longest-increasing-subsequence large-values-rest)))
             (define without-first
                     (longest-increasing-subsequence rest))
             (if (> (length with-first) (length without-first))
                 with-first
                 without-first)
      )
  )
)
