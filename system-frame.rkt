#lang racket/gui
(require racket/gui/base)
(require "load-data.rkt")

(define frame 
  (new frame% 
       [label "推荐系统演示"]
       [width 800]
       [height 600]
       [min-width 800]
       [min-height 600]
       [stretchable-width #f]
       [stretchable-height #f]))

(define main-panel 
  (new vertical-panel%
       [parent frame]
       [alignment '(left top)]))

(define buttons-panel 
  (new horizontal-panel% 
       [parent main-panel]
       [alignment '(left top)]
       [spacing 5]))

(define list-boxes-panel 
  (new horizontal-panel%
       [parent main-panel]
       [alignment '(left top)]))

(define mode-choice 
  (new choice%
       [parent buttons-panel]
       [label "选择推荐模式"]
       [choices (list "推荐相似用户" "推荐相似电影")]))

(define (switch-user-mode)
  (send choices-list-box set-label "选择用户")
  (send recommendations-list-box set-label "推荐用户")
  (fill-list-box choices-list-box 
                 (map
                   (lambda (id) (number->string id))
                   user-sorted-list)))

(define (switch-movie-mode)
  (send choices-list-box set-label "选择电影")
  (send recommendations-list-box set-label "推荐电影")
  (fill-list-box choices-list-box 
                 (map
                   (lambda (id) 
                     (string-join 
                       (list 
                         (number->string id)
                         (hash-ref movie-id-name id)) ", ")) movie-sorted-list)))

(define switch-button 
  (new button%
       [parent buttons-panel]
       [label "切换"]
       [callback (lambda (button event)
                   (define text (send mode-choice get-string-selection))
                   (cond
                     [(string=? text "推荐相似用户") (switch-user-mode)]
                     [(string=? text "推荐相似电影") (switch-movie-mode)]))]))

(define (recommend-user-action button event)
  (define choice (send choices-list-box get-selections))
  (when (not (null? choice))
    (begin 
      (define index (car choice))
      (fill-list-box
        recommendations-list-box
        (recommend-user (list-ref user-sorted-list index))))))

(define (recommend-movie-action button event)
  (define choice (send choices-list-box get-selections))
  (when (not (null? choice))
    (begin 
      (define index (car choice))
      (fill-list-box 
        recommendations-list-box 
        (recommend-movie (list-ref movie-sorted-list index))))))

(define recommend-button 
  (new button%
       [parent buttons-panel]
       [label "推荐"]
       [callback 
         (lambda (button event)
           (define text (send mode-choice get-string-selection))
           (cond
             [(string=? text "推荐相似用户")
              (recommend-user-action button event)]
             [(string=? text "推荐相似电影")
              (recommend-movie-action button event)]))]))

(define (fill-list-box list-box string-list)
  (send list-box clear)
  (for ([item string-list])
    (send list-box append item)))

(define choices-list-box 
  (new list-box%
       [parent list-boxes-panel]
       [label "选择用户"]
       [min-height 500]
       [choices (map 
                  (lambda (id) (number->string id))
                  user-sorted-list)]))

(define recommendations-list-box 
  (new list-box%
       [parent list-boxes-panel]
       [label "推荐用户"]
       [choices '()]
       [min-height 500]))


(provide (all-defined-out))

(send frame show #t)
