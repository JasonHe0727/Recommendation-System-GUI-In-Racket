#lang racket

(define (read-lines file)
  (define (read-lines-iter file result)
    (define line (read-line file))
    (if (eof-object? line)
      result
      (read-lines-iter file (cons line result))))
  (read-lines-iter file '()))

(define (load-id-dict file-name)
  (define file (open-input-file file-name))

  (define id-dictionary 
    (make-hash (map
                 (lambda (line) (map string->number (string-split line ",")))
                 (read-lines file))))

  (close-input-port file)
  id-dictionary)

(define (load-index-dict file-name)
  (define file (open-input-file file-name))

  (define index-dictionary 
    (make-hash (map
                 (lambda (line) (reverse (map string->number (string-split line ","))))
                 (read-lines file))))

  (close-input-port file)
  index-dictionary)

(define (load-data file-name)
  (define file (open-input-file file-name))
  (define data (reverse (map 
                          (lambda (line) (map string->number (string-split line " ")))
                          (read-lines file))))
  (close-input-port file)
  data)

(define user-id-dict (load-id-dict "record/userId_dictionary.txt"))
(define movie-id-dict (load-id-dict "record/movieId_dictionary.txt"))

(define index-user-id-dict (load-index-dict "record/userId_dictionary.txt"))
(define index-movie-id-dict (load-index-dict "record/movieId_dictionary.txt"))

(define user-similarities (load-data "record/user_similarities.txt"))
(define movie-similarities (load-data "record/movie_similarities.txt"))

(define user-sorted-list (sort (hash-keys user-id-dict) <))
(define movie-sorted-list (sort (hash-keys movie-id-dict) <))

(define (index->user-id index)
  (car (hash-ref index-user-id-dict index)))

(define (index->movie-id index)
  (car (hash-ref index-movie-id-dict index)))

(define (user-id->index user-id)
  (car (hash-ref user-id-dict user-id)))

(define (movie-id->index movie-id)
  (car (hash-ref movie-id-dict movie-id)))

(define (recommend-user user-id)
  (define index (user-id->index user-id))
  (map 
    (lambda (tuple) (string-join 
                      (list (number->string (index->user-id (cadr tuple)))
                            (number->string (caddr tuple))) ", "))
    (filter
      (lambda (tuple) (= (car tuple) index))
      user-similarities)))

(define (recommend-movie movie-id)
  (define index (movie-id->index movie-id))
  (map 
    (lambda (tuple) (string-join 
                      (list (number->string (index->movie-id (cadr tuple)))
                            (number->string (caddr tuple))) ", "))
    (filter
      (lambda (tuple) (= (car tuple) index))
      movie-similarities)))

(provide (all-defined-out))
