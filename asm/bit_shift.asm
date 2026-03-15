        .ORIG x3000       ; Début de la routine bit_shift

; Entrées :
; - R1 : Registre à décaler
; - R0 : Nombre de décalages (positif = gauche, négatif = droite)
; Sortie :
; - R1 : Résultat après le décalage

bit_shift
        AND R2, R2, #0    ; R2 = 0, compteur de décalages
        ADD R2, R0, #0    ; Charger k dans R2
        BRz DONE          ; Si k == 0, rien à faire, on termine
        BRp SHIFT_LEFT    ; Si k > 0, décaler à gauche
        NOT R2, R2        ; Si k < 0, calculer -k (inverser les bits)
        ADD R2, R2, #1
        BR SHIFT_RIGHT    ; Aller au décalage à droite

SHIFT_LEFT
        ADD R3, R2, #0    ; Charger le compteur de décalages
LEFT_LOOP
        ADD R1, R1, R1    ; Décalage à gauche (R1 = R1 << 1)
        ADD R3, R3, #-1   ; Décrémenter le compteur
        BRp LEFT_LOOP     ; Répéter jusqu'à R3 == 0
        BR DONE

SHIFT_RIGHT
        ADD R3, R2, #0    ; Charger le compteur de décalages
RIGHT_LOOP
        AND R4, R1, #1    ; Vérifier le bit LSB avant de décaler
        ADD R1, R1, #-1   ; Décalage à droite (R1 = R1 >> 1)
        BRz RIGHT_NEXT    ; Si le bit LSB était 0, continuer
        AND R4, R4, #0    ; Réinitialisation (remplir avec 0)
RIGHT_NEXT
        ADD R3, R3, #-1   ; Décrémenter le compteur
        BRp RIGHT_LOOP    ; Répéter jusqu'à R3 == 0

DONE    RET               ; Retour à l'appelant

        .END              ; Fin de la routine bit_shift
