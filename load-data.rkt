#lang racket

(define (read-lines file-name)
  (define file (open-input-file file-name))
  (define (read-lines-iter file result)
    (define line (read-line file))
    (if (eof-object? line)
      result
      (read-lines-iter file (cons line result))))
  (define result (reverse (read-lines-iter file '())))
  (close-input-port file)
  result)

(define (load-id-dict file-name)
  (make-hash (map
               (lambda (line) (map string->number (string-split line ",")))
               (read-lines file-name))))

(define (load-index-dict file-name)
  (make-hash (map
               (lambda (line) (map string->number (string-split line ",")))
               (read-lines file-name))))

(define (load-data file-name)
  (map 
    (lambda (line) (map string->number (string-split line " ")))
    (read-lines file-name)))

(define (index->user-id index)
  (car (hash-ref index-user-id-dict index)))

(define (index->movie-id index)
  (car (hash-ref index-movie-id-dict index)))

(define (user-id->index user-id)
  (car (hash-ref user-id-dict user-id)))

(define (movie-id->index movie-id)
  (car (hash-ref movie-id-dict movie-id)))

(define (first-user tuple) (car tuple))
(define (second-user tuple) (cadr tuple))
(define (first-movie tuple) (car tuple))
(define (second-movie tuple) (cadr tuple))
(define (distance tuple) (caddr tuple))

(define (recommend-user user-id)
  (define index (user-id->index user-id))
  (map 
    (lambda (tuple) (string-join 
                      (list (number->string (index->user-id (second-user tuple)))
                            (number->string (distance tuple))) ", "))
    (filter
      (lambda (tuple) (= (first-user tuple) index))
      user-similarities)))

(define (recommend-movie movie-id)
  (define index (movie-id->index movie-id))
  (map 
    (lambda (tuple) 
      (define movie-id (list-ref movie-sorted-list (second-movie tuple)))
      (define movie-name (hash-ref movie-id-name movie-id))
      (string-join 
        (list (number->string movie-id)
              movie-name
              (number->string (distance tuple))) ", "))
    (filter
      (lambda (tuple) (= (first-movie tuple) index))
      movie-similarities)))

(define user-id-dict (load-id-dict "record/userId_dictionary.txt"))
(define movie-id-dict (load-id-dict "record/movieId_dictionary.txt"))

(define index-user-id-dict (load-index-dict "record/userId_dictionary.txt"))
(define index-movie-id-dict (load-index-dict "record/movieId_dictionary.txt"))

; user_x user_y distance
(define user-similarities (load-data "record/user_similarities.txt"))
; movie_x movie_y distance
(define movie-similarities (load-data "record/movie_similarities.txt"))

(define user-sorted-list (sort (hash-keys user-id-dict) <))
(define movie-sorted-list (sort (hash-keys movie-id-dict) <))

(define movie-id-name
  (make-hash
    (map (lambda (tuple) (cons (string->number (car tuple)) (cadr tuple)))
         (cdr
           (map 
             (lambda (line) (string-split line ","))
             (read-lines "record/movies.csv"))))))

(provide (all-defined-out))
