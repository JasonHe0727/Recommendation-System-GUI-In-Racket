#lang racket
(require db)

(provide (all-defined-out))

(define (connect-db)
  (sqlite3-connect
    #:database "recommendations.db"))

(define (neighbours conn movie-id)
  (map
    (lambda (row) (cons (vector-ref row 0) (vector-ref row 1)))
    (query-rows 
      conn 
      "select movie2, distance from movies_similarities where movie1 = $1;" movie-id)))

(define (movie-name conn movie-id)
  (define row
    (car
      (query-rows
        conn
        "select * from movies_info where movieId = $1;" movie-id)))
  (string-join (row->list row) ", "))

(define (row->list row)
  (map
    (lambda (element)
      (cond
        [(number? element) (number->string element)]
        [(string? element) element]
        [else (error "not supported type")]))
    (vector->list row)))

; return (movieId . title . genres)
(define (query-movie conn keyword)
  (map
    vector->list 
    (query-rows
      conn
      (string-join 
        (list "select * from movies_info where title like '%" keyword "%';") ""))))

