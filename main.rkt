#lang racket 
(require "gui.rkt")
(require "query-database.rkt")

(define conn (connect-db))

(project-init
  #:query-button-callback
  (lambda (button control-event) (query-action))
  #:query-result-list-box-callback
  (lambda (button control-event) (query-neighbours)))

(define (query-action)
  (define query-result
    (query-movie conn (get-keyword)))
  (fill-list-box 
    query-result-list-box
    (map movie-info->string query-result)))

(define (get-keyword)
  (send movie-name-text-field get-value))

(define (get-selection)
  (send query-result-list-box get-string-selection))

(define (query-neighbours)
  (define selection (get-selection))
  (when (not (eq? selection #f))
    (define movie-id (movie-info-string->movie-id selection))
    (define query-result (neighbours conn movie-id))
    (define neighbours-list
      (map
        (lambda (movie-info)
          (movie-name conn (car movie-info))) query-result))
    (fill-list-box movie-recommendation-list-box neighbours-list)))

(define (fill-list-box list-box string-list)
  (send list-box clear)
  (for ([item string-list])
    (send list-box append item)))

(define (movie-info->string movie-info)
  (string-join
    (map
      (lambda (item) 
        (if (number? item) (number->string item) item)) 
      movie-info) ", "))

(define (movie-info-string->movie-id movie-info-string)
  (string->number
    (car
      (string-split movie-info-string ","))))

(fill-list-box query-result-list-box '())
(fill-list-box movie-recommendation-list-box '())
(send main-frame show #t)
