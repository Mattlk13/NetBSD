(define social-ime-on-key '("<Control>\\" generic-on-key))
(define social-ime-on-key? (make-key-predicate '("<Control>\\" generic-on-key?)))
(define social-ime-off-key '("<Control>\\" generic-off-key))
(define social-ime-off-key? (make-key-predicate '("<Control>\\" generic-off-key?)))
(define social-ime-begin-conv-key '(generic-begin-conv-key))
(define social-ime-begin-conv-key? (make-key-predicate '(generic-begin-conv-key?)))
(define social-ime-commit-key '(generic-commit-key))
(define social-ime-commit-key? (make-key-predicate '(generic-commit-key?)))
(define social-ime-cancel-key '(generic-cancel-key))
(define social-ime-cancel-key? (make-key-predicate '(generic-cancel-key?)))
(define social-ime-next-candidate-key '(generic-next-candidate-key))
(define social-ime-next-candidate-key? (make-key-predicate '(generic-next-candidate-key?)))
(define social-ime-prev-candidate-key '(generic-prev-candidate-key))
(define social-ime-prev-candidate-key? (make-key-predicate '(generic-prev-candidate-key?)))
(define social-ime-next-page-key '(generic-next-page-key))
(define social-ime-next-page-key? (make-key-predicate '(generic-next-page-key?)))
(define social-ime-prev-page-key '(generic-prev-page-key))
(define social-ime-prev-page-key? (make-key-predicate '(generic-prev-page-key?)))
