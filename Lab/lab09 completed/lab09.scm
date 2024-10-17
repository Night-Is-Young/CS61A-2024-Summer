(define (over-or-under num1 num2)
  ;(cond 
  ;  ((> num1 num2) 1)
  ;  ((< num1 num2) -1)
  ;  (#t 0)
  ;  )
  (if (> num1 num2) 1 (if (< num1 num2) -1 0))
)

(define (make-adder num)
  (lambda (inc) (+ num inc))
)

(define (composed f g)
  (lambda (x) (f (g x)))
)

(define (repeat f n)
  (if (= n 1)
    f
    (composed f (repeat f (- n 1)))
  )
)

(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (> a b)
      b
      a))

(define (gcd a b)
  (define min_num (min a b))
  (define max_num (max a b))
  (define modulo_num (modulo max_num min_num))
  (if (= modulo_num 0)
    min_num
    (gcd min_num modulo_num)  
  )
)

(define (duplicate lst)
  (if (null? lst)
    lst
    (cons
      (car lst)
      (cons
        (car lst)
        (duplicate (cdr lst))  
      )
    )
  )
)

(expect (duplicate '(1 2 3)) (1 1 2 2 3 3))

(expect (duplicate '(1 1)) (1 1 1 1))

(define (deep-map fn s)
  (if (null? s)
    s
    (if (list? s)
      (cons
        (deep-map fn (car s))
        (deep-map fn (cdr s))
      )
      (fn s)
    )
  )
)