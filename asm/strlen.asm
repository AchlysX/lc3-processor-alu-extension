        .ORIG x3000       ; Début de la routine strlen

strlen  AND R0, R0, #0    ; Initialiser R0 à 0 (longueur de la chaîne)
LOOP    LDR R2, R1, #0    ; Charger le caractère pointé par R1 dans R2
        BRz DONE          ; Si R2 == 0 (caractère nul), terminer la boucle
        ADD R0, R0, #1    ; Incrémenter la longueur (R0 = R0 + 1)
        ADD R1, R1, #1    ; Avancer au caractère suivant (R1 = R1 + 1)
        BR LOOP           ; Répéter la boucle
DONE    RET               ; Retourner à l'appelant

        .END              ; Fin de la routine
