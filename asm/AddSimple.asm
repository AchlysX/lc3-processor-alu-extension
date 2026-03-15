     .ORIG x3000                      ; Début du programme
     
     ; Initialisation des valeurs
     LDR R0, R6, #0                  ; Charger la valeur de test 5 dans R0
     LDR R1, R6, #1                  ; Charger la valeur de test 6 dans R1

     ; Effectuer les opérations
     ADD R2, R0, R1                  ; Additionner R0 et R1, stocker le résultat dans R2

     ; Stocker le résultat
     STR R2, R6, #2                  ; Stocker le résultat de R2 dans la mémoire

     HALT                            ; Fin du programme

     ; Données de test en mémoire
     .FILL #5                        ; Valeur à charger dans R0
     .FILL #6                        ; Valeur à charger dans R1
     .BLKW #1                        ; Réserver un espace mémoire pour le résultat
     
     .END                            ; Fin du programme
