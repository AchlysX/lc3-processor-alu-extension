        .ORIG x3000       ; Début de la routine hamming_weight

; Entrées :
; - R1 : Registre dont on veut calculer le poids de Hamming
; Sortie :
; - R0 : Poids de Hamming (nombre de bits à 1 dans R1)

hamming_weight
        AND R0, R0, #0    ; Initialiser R0 à 0 (compteur de bits à 1)

LOOP    AND R2, R1, #1    ; Isoler le bit de poids faible de R1
        ADD R0, R0, R2    ; Ajouter ce bit à R0 s’il est à 1
        ADD R1, R1, #-1   ; Décaler R1 à droite (division entière par 2)
        BRp LOOP          ; Reboucler tant que R1 > 0

DONE    RET               ; Retourner à l'appelant

        .END              ; Fin de la routine hamming_weight
