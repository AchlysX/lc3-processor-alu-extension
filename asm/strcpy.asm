        .ORIG x3000       ; Début de la routine strcpy

strcpy  LDR R3, R1, #0    ; Charger le caractère de la source dans R3
        STR R3, R2, #0    ; Copier le caractère dans la destination
        BRz DONE          ; Si R3 == 0 (caractère nul), fin de la copie
        ADD R1, R1, #1    ; Avancer l'adresse de la source
        ADD R2, R2, #1    ; Avancer l'adresse de la destination
        BR strcpy         ; Reboucler pour copier le caractère suivant

DONE    RET               ; Retour à l'appelant

        .END              ; Fin de la routine strcpy
