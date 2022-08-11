.data 
myplaintext: .string "Abc' abc!"
blocKey: .string "OLE"
mycypher: .string "E"
cyphertext: .string ""
sostK: .word -5

.text
#MAIN PROCEDURE --------------------------------
lb a2 sostK
la s0 cyphertext 
la s1 myplaintext
la s2 blocKey
la s3 mycypher
li s4 0             # Lunghezza messaggio
li s5 0             # Lunghezza blocKey
li s6 0             # Lunghezza mycypher

jal MYPLAINTEXT_SIZE
jal BLOCKEY_SIZE
jal MYCYPHER_SIZE


li t0 0              # Contatore ciclo
jal TO_STRING

WHILE_LOOP:
    beq t0 s6 end_while_loop   # Se il contatore arriva al numero di caratteri termine il ciclo
    lb t1 0(s3)                # Primo byte (lettera) ovvero primo algoritmo
    li t2 65
    beq t1 t2 ALGORITHM_A      # Se t1 = A (65) applico algoritmo A
    li t2 66
    beq t1 t2 ALGORITHM_B      # Se t1 = B (66) applico algoritmo B
    li t2 67
    beq t1 t2 ALGORITHM_C      # Se t1 = C (67) applico algoritmo C
    li t2 68
    beq t1 t2 ALGORITHM_D      # Se t1 = D (68) applico algoritmo D
    li t2 69
    beq t1 t2 ALGORITHM_E      # Se t1 = E (69) applico algoritmo E
end_while_loop:
    li t0 0                    # Contatore del ciclo
    
D_WHILE_LOOP:
    beq t0 s6 END_DECRYPT_WHILE_LOOP
    lb t1 -1(s3)			   # Si carica s3-1, contiene la fine dell'indirizzo di mycypher
    li t2 65
    beq t1 t2 DECRYPT_ALGORITHM_A      # Se t1 = A (65) applico algoritmo A
    li t2 66
    beq t1 t2 DECRYPT_ALGORITHM_B      # Se t1 = B (66) applico algoritmo B
    li t2 67
    beq t1 t2 DECRYPT_ALGORITHM_C      # Se t1 = C (67) applico algoritmo C
    li t2 68
    beq t1 t2 DECRYPT_ALGORITHM_D      # Se t1 = D (68) applico algoritmo D
    li t2 69
    beq t1 t2 ALGORITHM_E              # Se t1 = E (69) applico algoritmo E
END_DECRYPT_WHILE_LOOP:
    j END
    
ALGORITHM_A:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 
    jal CIFRARIO_CESARE
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 1				# Carattere successivo
    jal TO_STRING_CYPHER
    j WHILE_LOOP
    
ALGORITHM_B:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila
    jal CIFRARIO_BLOCCHI
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 1				# Carattere successivo 
    jal TO_STRING_CYPHER
    j WHILE_LOOP
    
ALGORITHM_C:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila

    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 1				# Carattere successivo 
    jal TO_STRING_CYPHER
    j WHILE_LOOP
    
ALGORITHM_D:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 

    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 1				# Carattere successivo
    jal TO_STRING_CYPHER
    j WHILE_LOOP
    
ALGORITHM_E:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 
    jal INVERSIONE
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 1				# Carattere successivo
    jal TO_STRING_CYPHER
    j WHILE_LOOP

DECRYPT_ALGORITHM_A:
    
DECRYPT_ALGORITHM_B:
    
DECRYPT_ALGORITHM_C:
    
DECRYPT_ALGORITHM_D:
    
#Procedura che calcola la crittografia tramite il cifrario di Cesare ----------------------
CIFRARIO_CESARE:
    addi sp sp -8			    # Si alloca spazio nella pila per salvare il valore di della chiave contenuta in s1 
	sw s1 0(sp)				    # Salvo s1 nella pila (chiave da criptare)
	sw ra 4(sp)
	li t1 0				        # Contatore del While
	li t3 26				    # Valore di calcolo del modulo [f(x) % 26 (Mod 26)]
while_cifrario_cesare:
	lb t0 0(s1)				     # Si carica in t0 il primo carattere da cifrare
	beq t1 s4 end_while_cifrario # Se t1 = s4 esco dal ciclo
	li t2 64				     # @ = 64 ASCII (Carattere che precede 'A')
	bgt t0 t2 uppercase_check  	 # Se maggiore di 64 controllo che sia maiuscola o minuscola
other_char:
	addi t1 t1 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cosi da poter leggere il carattere seguente
	j while_cifrario_cesare
lowercase_check: 
    li t2 97
    blt t0 t2 other_char        # Se fra 90 e 96 rimane invariato (Caratteri speciali)
	li t2 122
	bgt t0 t2 other_char		# Se maggiore di 122 (z ASCII) rimane invariato
    li a0 97
    jal SHIFT_CESARE
	j while_cifrario_cesare
uppercase_check:
	li t2 90                    # ( Z ) nella tabella ASCII
	bgt t0 t2 lowercase_check	# Se maggiore di 90 controllo che sia minuscola o un altro carattere
    li a0 65
	jal SHIFT_CESARE
    j while_cifrario_cesare
end_while_cifrario:
	lw s1 0(sp)				    # Si ripristina s1 (indirizzo alla testa del messaggio da criptare) nella pila
	lw ra 4(sp)				    # Si ripristina il valore di ra
	addi sp sp 8			    # Si ripristina il puntatore della pila
	jr ra				

#Procedura che calcola lo shift alfabetico del cifrario di Cesare
SHIFT_CESARE:
	sub t6 t0 a0			    # Altrimenti vuol dire che e' un char maiuscolo quindi si esegue l'operazione per shiftare
	add t6 t6 a2				# di 'sostK' caratteri --->
	rem t6 t6 t3				# ---> cyptherChar = [(currentChar - 65) + sostK]%26 + 65
	blt t6 zero negative_module
	add t6 t6 a0
	sb t6 0(s1)				# Si salva il carattere criptato in s2 (indirizzo della stringa contenente il messaggio criptato)
	addi t1 t1 1			# Si incrementa il contatore del ciclo
	addi s1 s1 1			# Si aumenta l'indirizzo di s1 cos? da poter leggere il carattere seguente
	jr ra
negative_module:
	addi t6 t6 26
	add t6 t6 a0
	sb t6 0(s1)				# Si salva il carattere criptato in s2 (indirizzo della stringa contenente il messaggio criptato)
	addi t1 t1 1			# Si incrementa il contatore del ciclo
	addi s1 s1 1			# Si aumenta l'indirizzo di s1 cos? da poter leggere il carattere seguente
	jr ra

# Procedura che calcola la crittografia tramite una chiave a blocchi (sostK)
CIFRARIO_BLOCCHI:
    

# Procedura che calcola la crittografia tramite inversione della stringa 
INVERSIONE:
    addi sp sp -8                # Si alloca lo spazio nella pila per salvare i valori di s1
    sw s1 0(sp)                  # Si salva il valore di s1 per poterlo ristabilire alla fine della procedura
    sw s1 4(sp)                  # Si salva il valore di s1 per poterlo usare nella procedura
    li t0 0                      # Indice del ciclo
    li t6 2
    div t3 s4 t6			     # t3 = length/2
    
WHILE_INVERSIONE:
    beq t0 t3 END_WHILE_INVERSIONE   # Condizione di uscita, indice = length/2
    addi t0 t0 1                     # Contatore++
    lb t1 0(s1)                      # Carico il primo carattere da invertire
    sub t2 s4 t0                     # Sottraggo alla lunghezza del messaggio il contatore in modo da "puntare" al carattere da scambiare
    lw s1 0(sp)				         # Si ristabilisce l'indirizzo di s1 cosi da poter puntare alla seconda meta' del messaggio
    add s1 s1 t2                     # Punto al carattere opposto da invertire
    lb t2 0(s1)                      # Carico il carattere opposto da invertire
    sb t1 0(s1)                      # Sostituisco con il carattere salvato in s1
    lw s1 4(sp)                      # Ristabilisco l'indirizzo s1
    sb t2 0(s1)                      # Sostituisco con il carattere salvato in s2
    addi s1 s1 1			         # Si aumenta s1 di 1 cosi da poter leggere il carattere successivo
	sw s1 4(sp)				         # Si salva aggiorna l'indirizzo di s1 nella pila cosi da poterlo ripristinare al prossimo ciclo
	j WHILE_INVERSIONE
    
END_WHILE_INVERSIONE:
    lw s1 0(sp)				# Si ristabilisce l'indirizzo di s1
	addi sp sp 8			# Si ristabilisce il puntatore alla testa della pila
	jr ra				    # Si esce dalla procedura
    
#Procedura che calcola il numero di caratteri da cifrare ------------------------------
MYPLAINTEXT_SIZE:
    addi sp sp -4      # Spazio allocato nella pila
    sw s1 0(sp)        # Indirizzo alla testa del messaggio
    li t1 0            # Contatore
myplaintext_while_loop:
    lb t0 0(s1)        # Carico in t0 il primo byte della stringa
    beq t0 zero myplaintext_end_while_loop # Se trovo il valore 0 (end of string) salto
    addi t1 t1 1       # Contatore ++
    addi s1 s1 1       # Passo al carattere successivo
    j myplaintext_while_loop
myplaintext_end_while_loop:
    add s4 zero t1     # Salvo la lunghezza nel registro per il ritorno da procedure
    lw s1 0(sp)        # Reset di s1
    addi sp sp 4       # Puntatore in testa alla pila
    jr ra
    
#Procedura che calcola il numero di caratteri della chiave blocKey ------------------
BLOCKEY_SIZE:
    addi sp sp -4      # Spazio allocato nella pila
    sw s2 0(sp)        # Indirizzo alla testa del messaggio
blockey_while_loop:
    lb t0 0(s2)        # Carico in t0 il primo byte della stringa
    beq t0 zero blockey_end_while_loop  # Se trovo il valore 0 (end of string) salto
    addi s5 s5 1       # Contatore++
    addi s2 s2 1       # Passo al carattere successivo
    j blockey_while_loop
blockey_end_while_loop:
    lw s2 0(sp)        # Reset di s2
    addi sp sp 4       # Ripristino puntatore alla testa
    jr ra
    
#Procedura che calcola il numero di caratteri di mycypher -------------------------
MYCYPHER_SIZE:
    addi sp sp -4      # Spazio allocato nella pila
    sw s3 0(sp)        # Indirizzo alla testa del messaggio
mycypher_while_loop:
    lb t0 0(s3)        # Carico in t0 il primo byte della stringa
    beq t0 zero mycypher_end_while_loop
    addi s6 s6 1       # Contatore++
    addi s3 s3 1       # Passo al carattere successivo
    j mycypher_while_loop
mycypher_end_while_loop:
    lw s3 0(sp)        # Reset di s3
    addi sp sp 4       # Ripristino puntatore alla testa
    jr ra 
    
#Procedura che stampa la stringa
TO_STRING:
    la a0 myplaintext
    li a7 4
    ecall
    li a0 10					# Ecall newLine
	li a7 11
	ecall
	jr ra

#Procedura che stampa la stringa criptata -------------------------------------------------- TODO
TO_STRING_CYPHER:
    add a0 zero s1
    li a7 4
    ecall
    li a0 10
    li a7 11
    ecall
    jr ra
    
END:
    ecall