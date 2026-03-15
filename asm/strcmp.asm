        .ORIG x3000       ; Début de la routine strcmp

strcmp  AND R0, R0, #0    ; Initialiser R0 à 0 (égalité par défaut)

LOOP    LDR R3, R1, #0    ; Charger le caractère de la chaîne 1 dans R3
        LDR R4, R2, #0    ; Charger le caractère de la chaîne 2 dans R4

        ; Vérifier si les deux caractères sont terminés
        BRz BOTH_ENDS     ; Si R3 == 0 ET R4 == 0, les deux chaînes sont égales
        ; Comparer les fins de chaînes (l'une terminée, l'autre non)
        BRz CHAIN2_ENDS   ; Si R3 == 0, chaîne 1 est plus petite
        BRz CHAIN1_ENDS   ; Si R4 == 0, chaîne 1 est plus grande

        ; Comparer les deux caractères
        NOT R5, R3        ; R5 = -R3
        ADD R5, R5, R4    ; R5 = R4 - R3
        BRz NEXT_CHAR     ; Si R5 == 0, les caractères sont égaux
        BRp CHAIN1_GREATER ; Si R5 > 0, chaîne 1 est plus grande
        BR CHAIN1_SMALLER ; Sinon, chaîne 1 est plus petite

NEXT_CHAR
        ADD R1, R1, #1    ; Avancer dans la chaîne 1
        ADD R2, R2, #1    ; Avancer dans la chaîne 2
        BR LOOP           ; Reboucler

BOTH_ENDS
        AND R0, R0, #0    ; Les chaînes sont égales (R0 = 0)
        RET

CHAIN1_ENDS
        ADD R0, R0, #1    ; Chaîne 1 est plus grande
        RET

CHAIN2_ENDS
        ADD R0, R0, #-1   ; Chaîne 1 est plus petite
        RET

CHAIN1_GREATER
        ADD R0, R0, #1    ; Chaîne 1 est plus grande
        RET

CHAIN1_SMALLER
        ADD R0, R0, #-1   ; Chaîne 1 est plus petite
        RET

        .END              ; Fin de la routine strcmp
