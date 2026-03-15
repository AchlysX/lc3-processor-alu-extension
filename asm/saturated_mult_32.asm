        .ORIG x3000       ; Début de la routine saturated_mult_32

; Entrées :
; - R1 : Partie basse du premier opérande
; - R2 : Partie haute du premier opérande
; - R3 : Partie basse du second opérande
; - R4 : Partie haute du second opérande
; Sortie :
; - R5 : Partie basse du résultat
; - R6 : Partie haute du résultat

saturated_mult_32
        ; Initialiser les résultats
        AND R5, R5, #0      ; R5 = 0 (partie basse du résultat)
        AND R6, R6, #0      ; R6 = 0 (partie haute du résultat)

        ; Calcul des produits partiels
        ; R1 * R3 (Low * Low)
        ADD R7, R1, #0      ; Charger R1
        ADD R0, R3, #0      ; Charger R3
        JSR saturated_mult_16 ; Appeler le multiplicateur 16 bits
        ADD R5, R0, #0      ; R5 = R0 (partie basse)

        ; R1 * R4 (Low * High)
        ADD R7, R1, #0      ; Charger R1
        ADD R0, R4, #0      ; Charger R4
        JSR saturated_mult_16 ; Appeler le multiplicateur 16 bits
        ADD R6, R0, #0      ; Ajouter à la partie haute

        ; R2 * R3 (High * Low)
        ADD R7, R2, #0      ; Charger R2
        ADD R0, R3, #0      ; Charger R3
        JSR saturated_mult_16 ; Appeler le multiplicateur 16 bits
        ADD R6, R6, R0      ; Ajouter à la partie haute

        ; R2 * R4 (High * High)
        ADD R7, R2, #0      ; Charger R2
        ADD R0, R4, #0      ; Charger R4
        JSR saturated_mult_16 ; Appeler le multiplicateur 16 bits
        BRp SATURATE        ; Si débordement, saturer le résultat

        ; Combiner les résultats (pas de débordement)
        RET

SATURATE
        ; Saturer le résultat à 0xFFFFFFFF
        ADD R5, R5, #-1     ; R5 = 0xFFFF
        ADD R6, R6, #-1     ; R6 = 0xFFFF
        RET

        .END                ; Fin de la routine
