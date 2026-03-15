        .ORIG x3000       ; Début de la routine overflow_predict

; Entrées :
; - R1 : Premier opérande (entier non signé)
; - R2 : Deuxième opérande (entier non signé)
; Sortie :
; - R0 : Résultat (négatif, 0 ou positif)

overflow_predict
        ; Trouver le MSB de R1
        ADD R3, R1, #0      ; Copier R1 dans R3
        JSR find_msb        ; Appeler la routine pour trouver le MSB
        ADD R4, R0, #0      ; Sauvegarder le MSB de R1 dans R4

        ; Trouver le MSB de R2
        ADD R3, R2, #0      ; Copier R2 dans R3
        JSR find_msb        ; Appeler la routine pour trouver le MSB
        ADD R5, R0, #0      ; Sauvegarder le MSB de R2 dans R5

        ; Vérifier si la somme des positions des MSB dépasse 15
        ADD R6, R4, R5      ; R6 = MSB_R1 + MSB_R2
        ADD R6, R6, #-15    ; Si R6 > 0, débordement certain

        ; Encodage des résultats
        BRp OVERFLOW        ; Si positif, débordement certain
        BRz RISK            ; Si nul, risque de débordement
        BRn NO_OVERFLOW     ; Si négatif, pas de débordement

OVERFLOW
        ADD R0, R0, #1      ; R0 = 1 (dépassement certain)
        RET

RISK
        AND R0, R0, #0      ; R0 = 0 (risque de débordement)
        RET

NO_OVERFLOW
        ADD R0, R0, #-1     ; R0 = -1 (pas de débordement)
        RET

; Routine pour trouver le MSB d'un registre dans R3
; Retourne la position du MSB dans R0
find_msb
        AND R0, R0, #0      ; Initialiser R0 à 0

MSB_LOOP
        LD R7, MSB_MASK     ; Charger la valeur 0x8000 dans R7
        AND R4, R3, R7      ; Isoler le MSB de R3
        BRp MSB_FOUND       ; Si MSB trouvé, quitter
        ADD R0, R0, #1      ; Incrémenter la position du MSB
        ADD R3, R3, R3      ; Décalage à gauche (R3 <<= 1)
        BR MSB_LOOP

MSB_FOUND
        RET                 ; Retourner avec la position dans R0

; Masques et constantes
MSB_MASK .FILL x8000        ; Masque pour isoler le MSB

        .END                ; Fin du programme
