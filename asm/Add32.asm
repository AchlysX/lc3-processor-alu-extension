; @param R1, R0 : Poids fort et faible du premier nombre
; @param R3, R2 : Poids fort et faible du second nombre
; @return R5, R4 : Poids fort et faible du résultat final
	.ORIG x3000                      ; Début du programme

	; Étape 1 : Addition des parties faibles
	ADD R4, R2, R0                  ; Somme des poids faibles (R2 + R0)

	; Étape 2 : Addition des parties fortes
	ADD R5, R3, R1                  ; Somme des poids forts (R3 + R1)

	; Étape 3 : Vérification de la retenue sur les poids faibles
	AND R0, R0, R0                  ; Analyser le bit de poids fort de R0
	BRn bit1                        ; Si ce bit est à 1, aller à la gestion spécifique (bit1)

	; Cas où le bit de poids fort de R0 est à 0
	AND R2, R2, R2                  ; Vérifier le bit de poids fort de R2
	BRzp fini                       ; Si les bits forts de R2 et R0 sont tous les deux 0, aucune retenue

	; Si un seul des deux bits forts est à 1,
	; examiner le bit de poids fort de R4 pour confirmer s'il y a une retenue.
testR4:	AND R4, R4, R4              ; Vérification du bit de poids fort de R4
	BRzp carry                      ; Si ce bit est à 1, on a une retenue
	BR fini                         ; Sinon, aucun ajustement nécessaire

	; Cas où le bit de poids fort de R0 est à 1
bit1:	AND R2, R2, R2               ; Vérification du bit de poids fort de R2
	BRzp testR4                    ; Si le bit fort de R2 est à 0, revenir à la vérification de R4

	; Si les bits forts de R2 et R0 sont tous les deux à 1,
	; une retenue est inévitable.
	; Étape 4 : Ajustement pour la retenue
carry:  ADD R5, R5, #1              ; Incrémenter R5 (poids fort) pour compenser la retenue

fini:	NOP                          ; Fin du traitement, aucune opération supplémentaire

	.END                            ; Fin du programme
