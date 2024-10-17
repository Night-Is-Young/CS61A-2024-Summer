(define (cadr lst) (car (cdr lst)))

(define (make-kwlist1 keys values)
  (cons keys (cons values nil)))

(define (get-keys-kwlist1 kwlist) (car kwlist))

(define (get-values-kwlist1 kwlist)
  (cadr kwlist))

(define (make-kwlist2 keys values)
  (if (null? keys)
    nil
    (cons (cons (car keys) (cons (car values) nil)) (make-kwlist2 (cdr keys) (cdr values)))
  )
)

(define (get-keys-kwlist2 kwlist)
  (if (null? kwlist)
    nil
    (cons (car (car kwlist)) (get-keys-kwlist2 (cdr kwlist)))
  )
)

(define (get-values-kwlist2 kwlist)
  (if (null? kwlist)
    nil
    (cons (cadr (car kwlist)) (get-values-kwlist2 (cdr kwlist)))
  )
)

(define (add-to-kwlist kwlist key value)
  (make-kwlist (append (get-keys-kwlist kwlist) (cons key nil)) (append (get-values-kwlist kwlist) (cons value nil)))
)

(define (get-first-from-kwlist kwlist key)
  (let ((keys (get-keys-kwlist kwlist))
      (values (get-values-kwlist kwlist)))
    (cond 
      ((null? keys) nil)
      ((not (eq? (car keys) key)) (get-first-from-kwlist (make-kwlist (cdr keys) (cdr values)) key))
      (#t (car values))
    )
  )
)
