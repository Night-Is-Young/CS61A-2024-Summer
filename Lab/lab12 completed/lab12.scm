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

(define (without-duplicates lst) (no-repeats lst))

(define (reverse lst)
  (if (null? lst)
    nil
    (append (reverse (cdr lst)) (list (car lst)))
  )
)