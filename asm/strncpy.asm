        .ORIG x3000       ; Début de la routine strncpy

strncpy BRz DONE          ; Si R0 == 0, aucun caractère à copier, fin immédiate

COPY_LOOP
        LDR R3, R1, #0    ; Charger le caractère de la source dans R3
        STR R3, R2, #0    ; Copier le caractère dans la destination
        BRz DONE          ; Si R3 == 0 (caractère nul), fin de la chaîne

        ADD R1, R1, #1    ; Avancer l'adresse de la source
        ADD R2, R2, #1    ; Avancer l'adresse de la destination
        ADD R0, R0, #-1   ; Décrémenter le compteur de caractères
        BRp COPY_LOOP     ; Reboucler tant que R0 > 0

DONE    RET               ; Retour à l'appelant

        .END              ; Fin de la routine strncpy
