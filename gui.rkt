#lang racket/base

;;==========================================================================
;;===                Code generated with MrEd Designer 3.16              ===
;;===              https://github.com/Metaxal/MrEd-Designer              ===
;;==========================================================================

;;; Call (project-init) with optional arguments to this module

(require
 racket/gui/base
 racket/class
 racket/list
 )

(provide (all-defined-out))

(define (label-bitmap-proc l)
  (let ((label (first l)) (image? (second l)) (file (third l)))
    (or (and image?
             (or (and file
                      (let ((bmp (make-object bitmap% file 'unknown/mask)))
                        (and (send bmp ok?) bmp)))
                 "<Bad Image>"))
        label)))

(define (list->font l)
  (with-handlers
   ((exn:fail?
     (λ (e)
       (send/apply
        the-font-list
        find-or-create-font
        (cons (first l) (rest (rest l)))))))
   (send/apply the-font-list find-or-create-font l)))

(define project #f)
(define main-frame #f)
(define vertical-panel-2494 #f)
(define horizontal-panel-2646 #f)
(define movie-name-text-field #f)
(define query-button #f)
(define query-result-list-box #f)
(define movie-recommendation-list-box #f)
(define (project-init
         #:main-frame-label
         (main-frame-label "电影推荐系统")
         #:main-frame-width
         (main-frame-width 800)
         #:main-frame-height
         (main-frame-height 600)
         #:main-frame-min-width
         (main-frame-min-width 800)
         #:main-frame-min-height
         (main-frame-min-height 600)
         #:vertical-panel-2494-alignment
         (vertical-panel-2494-alignment (list 'center 'top))
         #:horizontal-panel-2646-alignment
         (horizontal-panel-2646-alignment (list 'left 'top))
         #:movie-name-text-field-callback
         (movie-name-text-field-callback
          (lambda (text-field control-event) (void)))
         #:movie-name-text-field-font
         (movie-name-text-field-font
          (list->font
           (list 15 "DejaVu Serif" 'default 'normal 'normal #f 'default #f)))
         #:movie-name-text-field-horiz-margin
         (movie-name-text-field-horiz-margin 20)
         #:movie-name-text-field-min-width
         (movie-name-text-field-min-width 600)
         #:movie-name-text-field-min-height
         (movie-name-text-field-min-height 30)
         #:query-button-label
         (query-button-label (label-bitmap-proc (list "查询" #f #f)))
         #:query-button-callback
         (query-button-callback (lambda (button control-event) (void)))
         #:query-button-font
         (query-button-font
          (list->font
           (list 14 "DejaVu Serif" 'default 'normal 'normal #f 'default #f)))
         #:query-button-min-width
         (query-button-min-width 150)
         #:query-button-min-height
         (query-button-min-height 30)
         #:query-result-list-box-callback
         (query-result-list-box-callback
          (lambda (list-box control-event) (void)))
         #:query-result-list-box-style
         (query-result-list-box-style
          ((λ (l) (list* (first l) (second l) (third l)))
           (list 'single 'vertical-label '())))
         #:query-result-list-box-font
         (query-result-list-box-font
          (list->font
           (list 14 "DejaVu Serif" 'default 'normal 'normal #f 'default #f)))
         #:query-result-list-box-min-width
         (query-result-list-box-min-width 800)
         #:query-result-list-box-min-height
         (query-result-list-box-min-height 192)
         #:movie-recommendation-list-box-callback
         (movie-recommendation-list-box-callback
          (lambda (list-box control-event) (void)))
         #:movie-recommendation-list-box-style
         (movie-recommendation-list-box-style
          ((λ (l) (list* (first l) (second l) (third l)))
           (list 'single 'vertical-label '())))
         #:movie-recommendation-list-box-font
         (movie-recommendation-list-box-font
          (list->font
           (list 14 "DejaVu Serif" 'default 'normal 'normal #f 'default #f)))
         #:movie-recommendation-list-box-min-width
         (movie-recommendation-list-box-min-width 800)
         #:movie-recommendation-list-box-min-height
         (movie-recommendation-list-box-min-height 578))
  (set! main-frame
    (new
     frame%
     (parent project)
     (label main-frame-label)
     (width main-frame-width)
     (height main-frame-height)
     (x #f)
     (y #f)
     (style '())
     (enabled #t)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'top))
     (min-width main-frame-min-width)
     (min-height main-frame-min-height)
     (stretchable-width #f)
     (stretchable-height #f)))
  (set! vertical-panel-2494
    (new
     vertical-panel%
     (parent main-frame)
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment vertical-panel-2494-alignment)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! horizontal-panel-2646
    (new
     horizontal-panel%
     (parent vertical-panel-2494)
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment horizontal-panel-2646-alignment)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! movie-name-text-field
    (new
     text-field%
     (parent horizontal-panel-2646)
     (label "电影名称")
     (callback movie-name-text-field-callback)
     (init-value "")
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '())))
     (font movie-name-text-field-font)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin movie-name-text-field-horiz-margin)
     (min-width movie-name-text-field-min-width)
     (min-height movie-name-text-field-min-height)
     (stretchable-width #f)
     (stretchable-height #f)))
  (set! query-button
    (new
     button%
     (parent horizontal-panel-2646)
     (label query-button-label)
     (callback query-button-callback)
     (style '())
     (font query-button-font)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width query-button-min-width)
     (min-height query-button-min-height)
     (stretchable-width #t)
     (stretchable-height #f)))
  (set! query-result-list-box
    (new
     list-box%
     (parent vertical-panel-2494)
     (label "查询结果")
     (choices (list "First" "Second"))
     (callback query-result-list-box-callback)
     (style query-result-list-box-style)
     (font query-result-list-box-font)
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width query-result-list-box-min-width)
     (min-height query-result-list-box-min-height)
     (stretchable-width #f)
     (stretchable-height #f)))
  (set! movie-recommendation-list-box
    (new
     list-box%
     (parent vertical-panel-2494)
     (label "电影推荐")
     (choices (list "First" "Second"))
     (callback movie-recommendation-list-box-callback)
     (style movie-recommendation-list-box-style)
     (font movie-recommendation-list-box-font)
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width movie-recommendation-list-box-min-width)
     (min-height movie-recommendation-list-box-min-height)
     (stretchable-width #f)
     (stretchable-height #t))))

(module+ main (project-init))
