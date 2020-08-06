#|  |#

;; Exercício 1
(define x 3)
(define y 4)
(define (distancia x y)
  (sqrt (+ (sqr x) (sqr y))))
#| 
> (distancia x y)
5
> (distancia 12 5)
13 |#


;; Exercício 2
(define prefix "hello")
(define suffix "world")
(define (concatenar prefix suffix)
  (string-append prefix "_" suffix))
#|
> (concatenar prefix suffix)
"hello_world"
> (concatenar "oi" "mundo")
"oi_mundo" |#


;; Exercício 3
(define str "helloworld")
(define ind "0123456789")
(define i 5)
(require racket/string)
(define (adicionar str i)
  (string-append (substring str 0 i) "_" (substring str i)))
#|
> (adicionar str i)
"hello_world"
> (adicionar "oimundo" 2)
"oi_mundo" |#


;; Exercício 4
(define str2 "helloworld")
(define ind2 "0123456789")
(define j 5)
(require racket/string)
(define (deletar str i)
  (string-append (substring str 0 (- i 1)) (substring str i)))
#|
> (deletar str2 j)
"hellworld"
> (deletar "oimundo" 2)
"omundo" |#


;;Exercício 5
(require 2htdp/image)
(define arvore
  (above (star-polygon 10 20 3 "solid" "green")
         (rectangle 10 40 "solid" "brown")))
#|
> (place-image arvore
             50 70
             (empty-scene 100 100))
. |#


;; Exercício 6
(define cat "../T2/cat.png")
(define (conta-pixels img)
  (* (image-height cat) (image-width cat)))
#|
> (conta-pixels cat)
8775 |#


;; Exercício 7
(require racket/bool)
(define sunny #true)
(define friday #false)
(define (shopping sunny friday)
  (or (eq? sunny #false) (eq? friday #true)))
#|
> (shopping sunny friday)
#false |#


;; Exercício 8
#|(define cat "../T2/cat.png")
deixei como comentário pois "cat" já foi definida no exercício 6. |#
(define (tall-wide img)
  (if (> (image-height img) (image-width img))
      "tall"
      "wide"))
#|
> (tall-wide cat)
"tall" |#

(define (tall-wide-square img)
  (if (> (image-height img) (image-width img))
      "tall"
      (if (= (image-height img) (image-width img)) "square" "wide")))
#|
> (tall-wide-square cat)
"tall" |#


;; Exercício 9
(define in "oi")
(define (converter in)
  (if (string? in)
      (string-length in)
      (if (image? in)
          (* (image-height in) (image-width in))
          (if (number? in)
              (if (> in 0)
                  (- in 1)
                  "o número não é maior que 0")
              (if (false? in)
                  20
                  10)))))
#|
> (converter in)
2

> (converter "../T2/cat.png")
8775
> (converter 17)
16
> (converter 0)
"o número não é maior que 0"
> (converter -5)
"o número não é maior que 0"
> (converter #false)
20
> (converter #true)
10 |#


;; Exercício 11
(define (d x y)
  (sqrt (+ (sqr x) (sqr y))))
#|
> (d 3 4)
5
> (d 6 8)
10 |#


;; Exercício 12
(define (cvolume a)
  (* a a a))
(define (csurface a)
  (sqr a))
#|
> (cvolume 1)
1
> (cvolume 2)
8
> (cvolume 3)
27
> (csurface 1)
1
> (csurface 2)
4
> (csurface 3)
9 |#


;; Exercício 13
(define (string-first str)
  (substring str 0 1))
#|
> (string-first "teste")
"t"
> (string-first "/teste")
"/" |#


;; Exercício 14
(define (string-last str)
  (substring str (- (string-length str) 1)))
#|
> (string-last "teste")
"e"
> (string-last "teste/")
"/" |#


;; Exercício 15
(require racket/bool)
(define (sf sunny friday)
  (or (eq? sunny #false) (eq? friday #true)))
#|
> (sf #false #true)
#true
> (sf #false #false)
#true
> (sf #true #true)
#true
> (sf #true #false)
#false |#


;; Exercício 16
(define (count-pixels img)
  (* (image-height img) (image-width img)))
#|
> (count-pixels "../T2/cat.png")
8775
> (count-pixels "../T2/rocket.png")
1176 |#


;; Exercício 17
(define (tallwidesquare img)
  (if (> (image-height img) (image-width img))
      "tall"
      (if (= (image-height img) (image-width img)) "square" "wide")))
#|
> (tallwidesquare "../T2/cat.png")
"tall"
> (tallwidesquare "../T2/rocket.png")
"tall" |#


;; Exercício 18
(define (stringjoin str str2)
  (string-append str "_" str2))
#|
> (stringjoin "um" "teste")
"um_teste" |#


;; Exercício 19
(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))
#|
> (string-insert "umteste" 2)
"um_teste"
> (string-insert "outroteste" 5)
"outro_teste" |#


;; Exercício 20
(define (string-delete str i)
  (string-append (substring str 0 (- i 1)) (substring str i)))
#|
> (string-delete "teeste" 2)
"teste"
> (string-delete "testte" 4)
"teste" |#


;; Exercício 21
(define (ff x)
  (* 10 x))

(ff (ff 1))
#|
(ff (ff 1))
(ff (* 10 1))
(ff 10)
(* 10 10)
100 |#

(+ (ff 1) (ff 1))
#|
(+ (ff 1) (ff 1))
(+ (* 10 1) (ff 1))
(+ 10 (ff 1))
(+ 10 (* 10 1))
(+ 10 10)
20 |#


;; Exercício 22
(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))

(distance-to-origin 3 4)
#|
(distance-to-origin 3 4)
(sqrt
(+ (sqr 3) (sqr 4)))
(sqrt (+ 9 (sqr 4)))
(sqrt (+ 9 16))
(sqrt 25)
5 |#


;; Exercício 23
(define (string-first2 s)
  (substring s 0 1))

(string-first2 "Teste")
#| ele cria uma nova string (do índice 0 ao 1) a partir da string dada.
(string-first2 "Teste")
(substring "Teste" 0 1)
"T" |#


;; Exercício 24
(define (==> x y)
  (or (not x) y))

(==> #true #false)
#|
(==> #true #false)
(or (not #true) #false)
(or #false #false)
#false
|#


;; Exercício 25
(define (image-classify img)
  (cond
    [(>= (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(<= (image-height img) (image-width img)) "wide"]))

(image-classify "../T2/cat.png")
#|
(image-classify "../T2/cat.png")
(cond
  ((>= (image-height "../T2/cat.png") (image-width "../T2/cat.png")) "tall")
  ((= (image-height "../T2/cat.png") (image-width "../T2/cat.png")) "square")
  ((<= (image-height "../T2/cat.png") (image-width "../T2/cat.png")) "wide"))
(cond
  ((>= 117 75) "tall")
  ((= (image-height "../T2/cat.png") (image-width "../T2/cat.png")) "square")
  ((<= (image-height "../T2/cat.png") (image-width "../T2/cat.png")) "wide"))
(cond
  (#true "tall")
  ((= (image-height "../T2/cat.png") (image-width "../T2/cat.png")) "square")
  ((<= (image-height "../T2/cat.png") (image-width "../T2/cat.png")) "wide"))
"tall" |#


;; Exercício 26
(define (stringinsert s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))
 
(stringinsert "helloworld" 6)
#| 
(string-insert "helloworld" 6)
(string-append (substring "helloworld" 0 6)"_" (substring "helloworld" 6))
(string-append "hellow" "_" (substring "helloworld" 6))
(string-append "hellow" "_" "orld")
"hellow_orld"
os índices de uma string começam pelo 0 e não pelo 1, então, o programa deveria trabalhar com i-1 ao invés de i. |#


;; Exercício 27
(define avg-attendance 120)
(define fixed-cost 180)
(define cost-per-attendee 0.04)
(define avg-price 5.0)
(define attendance-change 15)
(define cent-change 0.1)

(define (attendees ticket-price)
  (- avg-attendance (* (- ticket-price avg-price) (/ attendance-change cent-change))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ fixed-cost (* cost-per-attendee (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))


;; Exercício 28
#|
> (profit 1)
511.2
> (profit 2)
937.2
> (profit 3)
1063.2
> (profit 4)
889.2
> (profit 5)
415.2
O preço de ingresso que mais da lucro ao cinema é $3.

> (profit 3.20)
1052.4
> (profit 3.10)
1059.3
> (profit 2.90)
1064.1
> (profit 2.80)
1062
O melhor preço de ingresso é $2.90. |#

(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))
#|
> (profit2 1)
511.2
> (profit2 2)
937.2
> (profit2 3)
1063.2
> (profit2 4)
889.2
> (profit2 5)
415.2 |#


;; Exercício 29
(define cost-per-attendee2 1.50)

(define (attendees2 ticket-price)
  (- avg-attendance (* (- ticket-price avg-price) (/ attendance-change cent-change))))

(define (revenue2 ticket-price)
  (* ticket-price (attendees2 ticket-price)))

(define (cost2 ticket-price)
  (* cost-per-attendee2 (attendees2 ticket-price)))

(define (profit3 ticket-price)
  (- (revenue2 ticket-price)
     (cost2 ticket-price)))
#|
> (profit3 3)
630
> (profit3 4)
675
> (profit3 5)
420 |#

(define (profit4 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (* 1.50
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price))))))
#|
> (profit4 3)
630
> (profit4 4)
675
> (profit4 5)
420 |#


;; Exercício 30
(define price-sensitivity (/ 15 0.1))
(define (profit5 price)
  (- (* (+ 120
           (* price-sensitivity
              (- 5.0 price)))
        price)
     (* 1.50
           (+ 120
              (* price-sensitivity
                 (- 5.0 price))))))
