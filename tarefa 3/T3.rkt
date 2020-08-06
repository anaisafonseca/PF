(require 2htdp/image)
(require 2htdp/universe)

;; Exercício 33
#| Problema do ano 2000 foi um problema que aconteceu devido ao jeito que
programas de computadores mais antigos foram feitos. Eles foram projetados
para lidar com anos contendo apenas 2 dígitos (por exemplo '99 ao invés de
1999), e as pessoas começaram a se preocupar de que processos por data dariam
problema na passagem do ano de 1999 para 2000. |#


;; Exercício 34
; String -> String
; Consome uma string e retorna seu primeiro caractere.
(define (string-first str)
  (string-ith str 0))
#|
> (string-first "oi")
"o"
> (string-first "Thaíssa")
"T" |#


;; Exercício 35
; String -> String
; Consome uma string e retorna seu último caractere.
(define (string-last str)
  (string-ith str (- (string-length str) 1)))
#|
> (string-last "oi")
"i"
> (string-last "Thaíssa")
"a" |#


;; Exercício 36
; Image -> Number
; Consome uma imagem e conta o número de pixels dessa imagem.
(define (image-area img)
  (* (image-height img) (image-width img)))
#|
> (image-area "../tarefa 3/lion.png")
5328 |#


;; Exercício 37
; String -> String
; Consumir uma string e remover seu primeiro caractere.
(define (string-rest str)
  (substring str 1))
#|
> (string-rest "oi")
"i"
> (string-rest "Thaíssa")
"haíssa" |#


;; Exercício 38
; String -> String
; Consome uma string e remove seu último caractere.
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))
#|
> (string-remove-last "oie")
"oi"
> (string-remove-last "Thaíssa")
"Thaíss" |#




;; Exercícios 39 a 44
(require 2htdp/image)
(require 2htdp/universe)

; define as dimensões do "mundo"
(define WIDTH-OF-WORLD 400)
(define HEIGHT-OF-WORLD 40)

; informações das rodas dos carros
(define WHEEL-RADIUS 5) 
(define WHEEL-DISTANCE 5)


(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define BODY-LENGTH 30)
(define BODY-HEIGHT 10)

(define BODY
  (above (rectangle 15 5 "solid" "red")
         (rectangle 30 10 "solid" "red")))

(define CAR (overlay/align/offset "middle" "bottom"
                                  BOTH-WHEELS 0 -5 BODY))

(define Y-CAR 30)
(define CAR-CENTER (/ (image-width CAR) 2))

; define o BACKGROUND (mundo com arvore)
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
(define BACKGROUND (place-image
                    TREE
                    350 25
                    (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

; WorldState -> Image
; posiciona a imagem do carro ws pixels da margem esquerda do BACKGROUND
(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND))

; WorldState -> WorldState
; move o carro em 3 pixels para cada tick do relógio.
; given 20, expect 23
; given 78, expect 81
(define (tock ws)
  (+ ws 3))

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

; WorldState String -> WorldState
; para cada tecla apertada, reinicia o mundo.
(define (stroke ws ke) 0)

; WorldState -> WorldState
; inicializa o programa no estado inicial.
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [on-mouse hyper]
            [to-draw render]
            [on-key stroke]
            [stop-when end?]))


(check-expect (render  50) (place-image CAR  50 Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR 200 Y-CAR BACKGROUND))

;; WorldState -> Boolean
;; end car simulation when car reaches end of world
(check-expect (end? 0) #false)
(check-expect (end? 100) #false)
(check-expect (end? (+ WIDTH-OF-WORLD (/ (image-width CAR) 2))) #true)

(define (end? ws)
  (>= ws 415))

; AnimationState é um Número
; interpreta o número de ticks do relógio desde o começo da animação
(define AS1  0)

; AnimationState -> AnimationState
; soma 1 ao AnimationState a cada tick do relógio
(define (tock2 as) (add1 as))

(check-expect (tock2 0) 1)
(check-expect (tock2 100) 101)

;(define (render as) BACKGROUND) ;stub
(define (render2 as)
  (place-image CAR (* as 3) Y-CAR BACKGROUND))

; AnimationState -> Boolean
; termina a animação quando o carro chega no fim do mundo 
(check-expect (end?2 0) #false)
(check-expect (end?2 WIDTH-OF-WORLD) #true)
(define (end?2 as)
  (>= (* as 3) (+ WIDTH-OF-WORLD (/ (image-width CAR) 2))))

; AnimationState -> AnimationState
(define (main2 as)
  (big-bang as
            [on-tick   tock2]
            [on-mouse hyper]
            [to-draw   render2]
            [on-key stroke]
            [stop-when end?2]
            ))

#| All 11 tests passed!
> (main 0)
417
> (main2 0)
139 |#

; WorldState Number Number String -> WorldState
; coloca o carro na posição x-mouse
; if the given me is "button-down" 
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))
; ("on-mouse" adicionada no big-bang da função main e main2)




;; Exercício 45
(define cat1 "../tarefa 3/cat.png")
(define WORLD-WIDTH 400)
(define WORLD-HEIGHT 150)
(define catpos (/ WORLD-HEIGHT 2))
(define back (empty-scene WORLD-WIDTH WORLD-HEIGHT))

(define (main3 ws)
  (big-bang ws
            (on-tick tock3)
            (to-draw render3)
            ))

(check-expect (tock3 10) 13)
(check-expect (tock3 WORLD-WIDTH) 0)

(define (tock3 ws)
  (if (< ws WORLD-WIDTH)
      (+ ws 3)
      0))

(check-expect (render3 0) (place-image cat1  0 catpos back))
(check-expect (render3 4) (place-image cat1  4 catpos back))

(define (render3 ws)
  (place-image cat1 ws catpos back))
#| All 4 tests passed!
> (main3 0) |#



;; Exercício 46
(define cat2 "../tarefa 3/cat.png")

#|  definições iguais as do exercício 45:
(define WORLD-WIDTH 400)
(define WORLD-HEIGHT 150)
(define catpos (/ WORLD-HEIGHT 2))
(define back (empty-scene WORLD-WIDTH WORLD-HEIGHT)) |#

(define (render4 ws)
  (cond
    [(= (modulo ws 2) 0) (place-image cat1 ws catpos back)]
    [else (place-image cat2 ws catpos back)]))

(define (main4 ws)
  (big-bang ws
            (on-tick tock3)
            (to-draw render4)
            ))



;; Exercício 47
(define moldura
  (rectangle 12 102 "solid" "black"))
(define barra
  (rectangle 10 100 "solid" "red"))
(define barra2
  (overlay barra moldura))
(define moldura2
  (rectangle 14 104 "outline" "black"))

(define (render5 hp)
  (place-image barra2
               7
               (- 152 hp)
               moldura2))

(define (tock5 hp)
  (if (< hp 0.1)
      0
      (- hp 0.1)))

(define (main5 hp)
  (big-bang hp                         
            (on-tick tock5)           
            (to-draw render5)         
            (on-key setas)
            ))

(define (cima hp) (+ hp (/ 1 3)))
(define (baixo hp) (+ hp 0.2))

(define (setas hp ke)
  (cond [(key=? ke "up") (cima hp)]
        [(key=? ke "down") (baixo hp)]
        [else hp]))
#|> (main5 100) |#



;; Exercício 48 e 49
; observação de funções no stepper



;; Exercício 50
; TrafficLight -> TrafficLight
(check-expect (traffic-light-next "red") "green")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))




;; Exercício 51
; utiliza a função "traffic-light-next" do exercício anterior

(define (render6 s)
  (circle 10 "solid" s))

(define (traffic-light s)
  (big-bang s
            [to-draw render6]
            [on-tick traffic-light-next 1]))
; deve ser chamada com "yellow" para que comece com a cor vermelha
#| > (traffic-light "yellow") |#




;; Exercício 52
; [3,5] => 3,4,5
; (3,5] => 4,5
; [3,5) => 3,4
; (3,5) => 4




;; Exercício 53
(define HEIGHT 300)
(define WIDTH  100)
(define YDELTA 3)

(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define CENTER (- HEIGHT (/ (image-height ROCKET) 2)))


; A LR (short for: launching rocket) is one of:
; – "resting"
; – nonnegative number
; interpretation a grounded rocket, in count-down mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)
(define LR1 "resting")
(define LR2 0)   
(define LR3 (/ HEIGHT 2))   
(define LR4 (- HEIGHT   
               (image-height ROCKET)))
(define LR5 HEIGHT) 

(define (trans n)  (- CENTER n))

;(place-image ROCKET 50 (trans LR2) BACKG)  ; landed
;(place-image ROCKET 50 (trans 75) BACKG)   ; 75 units high
;(place-image ROCKET 50 (trans LR3) BACKG)  ; almost half way
;(place-image ROCKET 50 (trans LR4) BACKG)  ; almost all the way
;(place-image ROCKET 50 (trans LR5) BACKG)  ; all the way up


; A LRCD (for launching rocket count down) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber
; interpretation a grounded rocket, in count-down mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)
(define LRCD0 "resting")
(define LRCD1 -2)  ; counting down
(define LRCD2  0)  ; launch!!!
(define LRCD3 100) ; 100 pixels high



(define (show x)
  (cond
    [(string? x)
     (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 (- HEIGHT CENTER)
                               BACKG))]
    [(>= x 0)
     (place-image ROCKET 10 (- x CENTER) BACKG)]))

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; LRCD -> LRCD
(define (main6 s)
  (big-bang s
    [to-draw show]
    [on-key launch]
    [on-tick fly .3]))
