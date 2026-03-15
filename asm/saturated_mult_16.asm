        .ORIG x3000       ; Début du programme

; Entrées :
; - R1 : Premier opérande (non signé)
; - R2 : Deuxième opérande (non signé)
; Sortie :
; - R0 : Produit saturé (résultat final)

saturated_mult_16
        AND R0, R0, #0      ; Initialiser R0 (produit final)
        AND R3, R3, #0      ; Accumulateur temporaire pour la somme partielle
        ADD R4, R1, #0      ; Charger le premier opérande (multiplicande) dans R4
        ADD R5, R2, #0      ; Charger le deuxième opérande (multiplicateur) dans R5

MULT_LOOP
        AND R6, R5, #1      ; Isoler le bit de poids faible de R5
        BRz SKIP_ADD        ; Si LSB == 0, passer l'addition
        ADD R3, R3, R4      ; Ajouter R4 au produit partiel (R3 += R4)
        ; Vérification de débordement
        BRp CHECK_OVERFLOW  ; Si R3 > 0xFFFF, saturer

SKIP_ADD
        ADD R4, R4, R4      ; Décalage à gauche de R4 (R4 *= 2)
        ADD R5, R5, #-1     ; Décalage à droite de R5 (R5 /= 2)
        BRp MULT_LOOP       ; Reboucler tant que R5 > 0

CHECK_OVERFLOW
        ; Si le produit dépasse 0xFFFF, le saturer à 0xFFFF
        NOT R6, R3          ; R6 = -R3
        ADD R6, R6, #1      ; Calcul de -R3
        ADD R6, R6, R3      ; Si R6 != 0, il y a débordement
        BRz NO_SATURATION
        ADD R3, R3, #-1     ; R3 = 0xFFFF (saturation)

NO_SATURATION
        ADD R0, R3, #0      ; Stocker le résultat final dans R0
        RET                 ; Retour à l'appelant

        .END                ; Fin du programme
