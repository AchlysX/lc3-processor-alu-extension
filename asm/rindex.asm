        .ORIG x3000       ; Début de la routine rindex

rindex  AND R0, R0, #0    ; Initialiser R0 à 0 (par défaut si absent)

LOOP    LDR R3, R1, #0    ; Charger le caractère pointé par R1 dans R3
        BRz DONE          ; Si R3 == 0 (fin de la chaîne), sortie
        NOT R4, R3        ; Préparer la comparaison entre R3 et R2
        ADD R4, R4, R2    ; R4 = R3 - R2
        BRz UPDATE        ; Si R4 == 0, mettre à jour R0
        ADD R1, R1, #1    ; Avancer au caractère suivant
        BR LOOP           ; Reboucler

UPDATE  ADD R0, R1, #0    ; Stocker l'adresse actuelle dans R0
        ADD R1, R1, #1    ; Avancer au caractère suivant
        BR LOOP           ; Reboucler pour continuer la recherche

DONE    RET               ; Retour à l'appelant

        .END              ; Fin de la routine
