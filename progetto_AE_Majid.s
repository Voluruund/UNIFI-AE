.data 
myplaintext: .string "QuEsta Str1ng4 e' dI pr'0va"
blocKey: .string "A0 o0p!)"
mycypher: .string "ABCDE"
cyphertext: .string ""
sostK: .word -15

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
    beq t1 t2 D_ALGORITHM_A      # Se t1 = A (65) applico algoritmo A
    li t2 66
    beq t1 t2 D_ALGORITHM_B      # Se t1 = B (66) applico algoritmo B
    li t2 67
    beq t1 t2 D_ALGORITHM_C      # Se t1 = C (67) applico algoritmo C
    li t2 68
    beq t1 t2 D_ALGORITHM_D      # Se t1 = D (68) applico algoritmo D
    li t2 69
    beq t1 t2 D_ALGORITHM_E              # Se t1 = E (69) applico algoritmo E
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
    jal OCCORRENZE
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 1				# Carattere successivo 
    jal TO_STRING_CYPHER
    j WHILE_LOOP
    
ALGORITHM_D:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 
    jal DIZIONARIO
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
    
D_ALGORITHM_A:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 
    jal DECRYPT_ALGORITHM_A
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 -1				# Carattere precedente
    jal TO_STRING_CYPHER
    j D_WHILE_LOOP
    
D_ALGORITHM_B:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 
    jal DECRYPT_ALGORITHM_B
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 -1				# Carattere precedente
    jal TO_STRING_CYPHER
    j D_WHILE_LOOP
    
D_ALGORITHM_C:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 
    jal DECRYPT_ALGORITHM_C
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 -1				# Carattere precedente
    jal TO_STRING_CYPHER
    j D_WHILE_LOOP
    
D_ALGORITHM_D:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 
    jal DIZIONARIO
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 -1				# Carattere precedente
    jal TO_STRING_CYPHER
    j D_WHILE_LOOP

D_ALGORITHM_E:
    addi sp sp -4				# Si alloca spazio nella pila per salvare l'indice del ciclo
	sw t0 0(sp)					# Si salva l'indice nella pila 
    jal INVERSIONE
    lw t0 0(sp)					# Si ripristina il valore dell'indice
	addi sp sp 4				# Si ripristina il valore del puntatore della pila
	addi t0 t0 1				# Indice++
	addi s3 s3 -1				# Carattere precedente
    jal TO_STRING_CYPHER
    j D_WHILE_LOOP
    
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
	sb t6 0(s1)				    # Si salva il carattere criptato in s2 (indirizzo della stringa contenente il messaggio criptato)
	addi t1 t1 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cos? da poter leggere il carattere seguente
	jr ra
negative_module:
	addi t6 t6 26
	add t6 t6 a0
	sb t6 0(s1)				    # Si salva il carattere criptato in s2 (indirizzo della stringa contenente il messaggio criptato)
	addi t1 t1 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cos? da poter leggere il carattere seguente
	jr ra

# Procedura per decriptare l'algoritmo del cifrario di Cesare ------------------------------------------
DECRYPT_ALGORITHM_A:
    addi sp sp -8			    # Si alloca spazio nella pila per salvare il valore di della chiave contenuta in s1 
	sw s1 0(sp)				    # Salvo s1 nella pila (chiave da criptare)
	sw ra 4(sp)
	li t1 0				        # Contatore del While
	li t3 26				    # Valore di calcolo del modulo [f(x) % 26 (Mod 26)]
while_decrypt_cifrario_cesare:
    lb t0 0(s1)				             # Si carica in t0 il primo carattere da cifrare
	beq t1 s4 decrypt_end_while_cifrario # Se t1 = s4 esco dal ciclo
	li t2 64				             # @ = 64 ASCII (Carattere che precede 'A')
	bgt t0 t2 decrypt_uppercase_check  	 # Se maggiore di 64 controllo che sia maiuscola o minuscola
decrypt_other_char:
    sb t0 0(s1)				   
    addi t1 t1 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cosi da poter leggere il carattere seguente
	j while_decrypt_cifrario_cesare
decrypt_end_while_cifrario:
    lw s1 0(sp)				    # Si ripristina s1 (indirizzo alla testa del messaggio da criptare) nella pila
	lw ra 4(sp)				    # Si ripristina il valore di ra
	addi sp sp 8			    # Si ripristina il puntatore della pila
	jr ra				
decrypt_uppercase_check:
    li t2 90                            # ( Z ) nella tabella ASCII
	bgt t0 t2 decrypt_lowercase_check	# Se maggiore di 90 controllo che sia minuscola o un altro carattere
    li a0 65
	jal DECRYPT_SHIFT_CESARE
    j while_decrypt_cifrario_cesare
decrypt_lowercase_check:
    li t2 97
    blt t0 t2 decrypt_other_char        # Se fra 90 e 96 rimane invariato (Caratteri speciali)
	li t2 122
	bgt t0 t2 decrypt_other_char		# Se maggiore di 122 (z ASCII) rimane invariato
    li a0 97
    jal DECRYPT_SHIFT_CESARE
	j while_decrypt_cifrario_cesare
DECRYPT_SHIFT_CESARE:
    sub t6 t0 a0			    # Altrimenti vuol dire che e' un char maiuscolo quindi si esegue l'operazione per shiftare
	sub t6 t6 a2				# di 'sostK' caratteri --->
	rem t6 t6 t3				# ---> cyptherChar = [(currentChar - 65) + sostK]%26 + 65
	blt t6 zero decrypt_negative_module
	add t6 t6 a0
	sb t6 0(s1)				    # Si salva il carattere criptato in s2 (indirizzo della stringa contenente il messaggio criptato)
	addi t1 t1 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cos? da poter leggere il carattere seguente
	jr ra
decrypt_negative_module:
	addi t6 t6 26
	add t6 t6 a0
	sb t6 0(s1)				# Si salva il carattere criptato in s2 (indirizzo della stringa contenente il messaggio criptato)
	addi t1 t1 1			# Si incrementa il contatore del ciclo
	addi s1 s1 1			# Si aumenta l'indirizzo di s1 cos? da poter leggere il carattere seguente
	jr ra

# Procedura che calcola la crittografia tramite una chiave a blocchi (sostK)
CIFRARIO_BLOCCHI:
    addi sp sp -8			# Si alloca spazio nella pila per salvare il valore di s1 e s2 
	sw s1 0(sp)				# Indirizzo di s1 nella pila
	sw s2 4(sp)				# Indirizzo di s2 nella pila
    li t0 0                 # Contatore
    li t3 96                # Valore modulo = 96
    li t4 0                 # Contatore blocKey
check_while_cifrario_blocchi:
    beq t4 s5 load_blockey_address    # Se contatore = #blocKey salto
while_cifrario_blocchi:
    lb t1 0(s1)             # Carico in t1 il primo carattere della stringa in chiaro
    lb t2 0(s2)             # Carico in t2 il primo carattere di blocKey
    beq t0 s4 end_while_cifrario_blocchi
    add t5 t1 t2            # (carattereDaCifrare + carattereCifra)
    rem t5 t5 t3            # Modulo 96
    addi t5 t5 32           # Sommo 32
    sb t5 0(s1)             # Salvo il carattere criptato
    addi s1 s1 1            # Carattere in chiaro successivo
    addi s2 s2 1            # Carattere blocKey successivo
    addi t0 t0 1            # Contatore++
    addi t4 t4 1            # Contatore blocKey++
    j check_while_cifrario_blocchi
load_blockey_address:
    lw s2 4(sp)             # Ritorno all'indirizzo di partenza
    li t4 0                 # Reset contatore
    j while_cifrario_blocchi
end_while_cifrario_blocchi:
    lw s1 0(sp)             # Reset indirizzo di s1
    lw s2 4(sp)             # Reset indirizzo s2
    addi sp sp 8
    jr ra

# Procedura per decifrare l'algoritmo del cifrario a blocchi -----------------------------------
DECRYPT_ALGORITHM_B:
    addi sp sp -8			# Si alloca spazio nella pila per salvare il valore di s1 e s2 
	sw s1 0(sp)				# Indirizzo di s1 nella pila
	sw s2 4(sp)				# Indirizzo di s2 nella pila
    li t0 0                 # Contatore
    li t3 96                # Valore modulo = 96
    li t4 0                 # Contatore blocKey
decrypt_check_while_cifrario_blocchi:
    beq t4 s5 decrypt_load_blockey_address    # Se contatore = #blocKey salto
decrypt_while_cifrario_blocchi:
    lb t1 0(s1)             # Carico in t1 il primo carattere della stringa in chiaro
    lb t2 0(s2)             # Carico in t2 il primo carattere di blocKey
    beq t0 s4 decrypt_end_while_cifrario_blocchi
    sub t5 t1 t2
    addi t5 t5 -32           # sottraggo 32 prima del modulo
    blt t5 zero negative_module_blocchi
apply_module_blocchi:
    rem t5 t5 t3             # Modulo 96 
    li t6 32                 # controllo che il carattere sia superiore a 32
    #controlla i caratteri che decifrati finiscono sotto il valore 32
    bge t5 t6 continue_decrypt_blocchi
    add t5 t5 t3             # Sommo 96
continue_decrypt_blocchi: 
    sb t5 0(s1)             # Salvo il carattere criptato
    addi s1 s1 1            # Carattere in chiaro successivo
    addi s2 s2 1            # Carattere blocKey successivo
    addi t0 t0 1            # Contatore++
    addi t4 t4 1            # Contatore blocKey++
    j decrypt_check_while_cifrario_blocchi
decrypt_load_blockey_address:			
	lw s2 4(sp)             # Ritorno all'indirizzo di partenza
    li t4 0                 # Reset contatore		
	j decrypt_check_while_cifrario_blocchi
negative_module_blocchi:
    addi t5 t5 96
    ble t5 zero negative_module_blocchi
    j apply_module_blocchi
 decrypt_end_while_cifrario_blocchi:
    lw s1 0(sp)             # Reset indirizzo di s1
    lw s2 4(sp)             # Reset indirizzo s2
    addi sp sp 8
    jr ra
    
# Procedura che calcola la crittografia tramite l'algoritmo ad occorrenze --------------------------------
OCCORRENZE:
   addi sp sp -12			# Si alloca spazio per la pila
	sw s1 0(sp)				# Si salva l'indirizzo alla testa del messaggio
	sw s0 4(sp)				# Si salva l'indirizzo di s0 che avrà lunghezza variabile dalla stringa iniziale
	sw ra 8(sp)				# Si salva il valore di ra per non perderlo quando si chiamano altre procedure
	li t0 0				    # t0 indice del ciclo while
while_occorrenze:
	beq t0 s4 end_outer_while_C		# se t0 = lunghezzaStringa finisce il ciclo
	lb t1 0(s1)				        # t1 = carattereDaCifrare
	li t6 31				        # t6 = unit separator  (ASCII)
	beq t1 t6 other_char_occorrenze	# Se il currentChar == 31 saltiamo
	sb t1 0(s0)				        # Si salva il messaggio criptato
	addi s0 s0 1			        # Si incrementa s1 per passare al carattere successivo
	addi t3 t0 0			        # t3 indice del ciclo while interno
inner_while_occorrenze:
	beq t3 s4 end_inner_while_occorrenze		# Si itera per la lunghezza del messaggio
	lb t2 0(s1)				        # t2 = carattereDaComparare
	beq t1 t2 write_occorrenza		# Se i due caratteri sono uguali scrivo l'occorrenza
	addi s1 s1 1			        # Altrimenti si incrementa s1 per leggere il carattere successivo
	addi t3 t3 1			        # Inner while ++
	j inner_while_occorrenze		
write_occorrenza:
	li t6 45				        # t6 = - (ASCII)
	sb t6 0(s0)				        # Carico t6 per dividere il carattere dall'occorrenza
	addi t3 t3 1			        # Inner while ++
	li t6 9				            # t6 = 9 in caso la posizione sia > 10 vado al doubleDigit
	bgt t3 t6 write_occorrenza_doubledigit	
	addi t4 t3 48			        # Riporto al carattere ASCII sommando 48
	sb t4 1(s0)				        # Si salva il carattere nella stringa criptata in posizione successiva
	li t6 31				        # t6 = Unit Separator (ASCII), i caratteri del messaggio vanno da 32 a 127
	sb t6 0(s1)				        # Si salva t6 nella posizione del carattere appena controllato per poterlo saltare successivamente
	addi s1 s1 1			        # Leggo il carattere successivo
	addi s0 s0 2			        # Si incrementa s1 di 2 per passare al carattere successivo
	j inner_while_occorrenze
write_occorrenza_doubledigit:
	li t6 10                        #t6 = 10 divisore
	div t4 t3 t6			        # t4 = quoziente della divisione (PRIMA CIFRA)
	addi t4 t4 48			        # Riporto al carattere ASCII sommando 48
	rem t5 t3 t6			        # t5 = resto della divisione (SECONDA CIFRA)
	addi t5 t5 48			        # Riporto al carattere ASCII sommando 48
	sb t4 1(s0)				        # Si salva t4 nella stringa nella posizione successiva
	sb t5 2(s0)				        # Si salva t5 nella stringa nella posizione successiva alla successiva
	li t6 31				        # t6 = Unit Separator (ASCII), i caratteri del messaggio vanno da 32 a 127
	sb t6 0(s1)				        # Si salva t6 nella posizione del carattere appena controllato per poterlo saltare successivamente
	addi s1 s1 1			        # Leggo il carattere successivo
	addi s0 s0 3			        # Incremento s0 di 3 per inserire il carattere successivo
	j inner_while_occorrenze
end_inner_while_occorrenze:
	li t6 32				        # t6 = '' (ASCII)
	sb t6 0(s0)				        # Inserisco uno spazio fra le occorrenze per dividerle
	addi s0 s0 1			        # Incremento s0 di 1 per inserire il carattere successivo
	lw s1 0(sp)				        # Si ripristina l'indirizzo di s1 per il ciclo esterno
	addi s1 s1 1			        # Leggo il carattere successivo
	sw s1 0(sp)				        # Aggiorno la stack
	addi t0 t0 1			        # Ciclo esterno ++
	j while_occorrenze
other_char_occorrenze:
	lw s1 0(sp)				        # Si ripristina l'indirizzo di s1 per il ciclo esterno
	addi s1 s1 1			        # Leggo il carattere successivo
	sw s1 0(sp)				        # Aggiorno la stack
	addi t0 t0 1			        # Ciclo esterno ++
	j while_occorrenze
end_outer_while_C:
	li t6 0				            # t6 = null (ASCII) fine stringa
	sb t6 -1(s0)			        # Carico il fine stringa
	lw s1 4(sp)				        # Ripristino l'indirizzo di s1
	jal MYPLAINTEXT_SIZE			# Ricalcolo la lunghezza della stringa
	add s0 s1 s4			        # Aggiorno s0 per puntare alla fine di s1
	addi s0 s0 1			        # Spazio del fine stringa
	lw ra 8(sp)				        # Si ripristina il valore di ra per uscire correttamente dalla procedura
	addi sp sp 12			        # Si ripristina il puntatore alla testa della stack
	jr ra

# Procedura che calcola la decrittografia dell'algoritmo ad occorrenze ------------------------------------
DECRYPT_ALGORITHM_C:
    addi sp sp -12			# Si alloca spazio per la pila		
	sw s1 0(sp)				# Si salva il valore di s1
	sw s0 4(sp)				# Si salva il valore di s0
	sw ra 8(sp)				# Si salva il valore di ra
while_reverse_C:
	lb t1 0(s1)				# t1 = carattereDaDecifrare
check_position_reverse_C:
	addi s1 s1 2			# Si incrementa s1 di 2 cosi da poter leggere l'occorrenza siccessiva
	lb t2 0(s1)				# t2 = terzo carattere, che indica la posizione in cui inserire il carattere corrente
	lb t3 1(s1)				# t3 = quarto carattere, puo essere uno spazio, un trattino o un altro numero
	lb t5 2(s1)				# t5 = quarto carattere, se t3 = numero, t5 puo essere uno spazio, un trattino o un altro numero
	li t6 45
	beq t3 t6 write_single_position_check_again_reverse_C	# Se t3 = 45 ('-' in ascii), vuol dire che dopo t2 ce' un altra occorrenza, e la posizione corrente e' a singola cifra
	li t6 32
	beq t3 t6 write_single_position_next_char_reverse_C	# Se t3 = 32 (' ' in ascii), vuol dire che le occorrenze di questa lettera sono finite, e la posizione corrente e' a singola cifra
	li t6 0
	beq t3 t6 write_single_position_end_reverse_C		# Se t3 = 0 ('null' fine stringa in ascii), vuol dire la posizione corrente e' a singola cifra, e il messaggio e' finito
	li t6 45						# Altrimenti vuol dire che la posizione e' a doppia cifra, e quindi t3 = numero
	beq t5 t6 write_double_position_check_again_reverse_C	# Se t5 = 45, vuol dire che dopo t2 ce' un altra occorrenza
	li t6 32
	beq t5 t6 write_double_position_next_char_reverse_C	# Se t5 = 32, vuol dire che le occorrenze di questa lettera sono finite
	li t6 0
	beq t5 t6 write_double_position_end_reverse_C		# Se t5 = 0, vuol dire che dopo questa occorrenza il messaggio e' finito
write_single_position_check_again_reverse_C:
	jal ASCII_TO_INT_REVERSE_C
	j check_position_reverse_C
write_single_position_next_char_reverse_C:
	jal ASCII_TO_INT_REVERSE_C
	addi s1 s1 2			# Si aumenta s1 di due byte perche dobbiamo leggere il carattere successivo
	j while_reverse_C
write_single_position_end_reverse_C:
	jal ASCII_TO_INT_REVERSE_C
	j end_while_reverse_C
write_double_position_check_again_reverse_C:
	jal MERGE_2_ASCII_TO_INT_REVERSE_C
	addi s1 s1 1			# Si aumenta s1 di un soolo byte perche dobbiamo leggere la prossima occorrenza
	j check_position_reverse_C
write_double_position_next_char_reverse_C:
	jal MERGE_2_ASCII_TO_INT_REVERSE_C
	addi s1 s1 3			# Si aumenta s1 di 3 byte perche dobbiamo leggere il prossimo carattere
	j while_reverse_C
write_double_position_end_reverse_C:
	jal MERGE_2_ASCII_TO_INT_REVERSE_C
end_while_reverse_C:
	lw s1 4(sp)				# Si ripristina il valore di s0, salvandolo pero in s1 (che punta il messaggio criptato)
	jal MYPLAINTEXT_SIZE			# Chiama la procedura MYPLAINTEXT_LENGTH per calcolare la lunghezza del messaggio in chiaro
	#add s6 zero a0			# Si salva il valore di ritorno contenuto in a0, in s6
	add s0 s1 s4			# Aggiorniamo l'indirizzo di s0, nel caso dovessimo chiamare un'altra volta l'algoritmo C e avere bisogno di una stringa ancora piu lunga
	addi s0 s0 1			# Aumentiamo di uno cosi da lasciare spazio per il carattere fine stringa tra messaggio criptato e stringa ausiliaria
	lw ra 8(sp)				# Si ripristina il valore di ra
	jr ra				# Si esce dalla procedura
#Procedura per unire due caratteri asci in un numero intero e salvarlo nel messaggio criptato per l'algoritmo REVERSE_C
MERGE_2_ASCII_TO_INT_REVERSE_C:
	addi t2 t2 -48			# t2 = t2 - 49, convertiamo il carattere da ascii a intero
	addi t3 t3 -48			# t3 = t3 - 48, convertiamo il carattere da ascii a intero
	li t6 10
	mul t2 t2 t6			# t2 = t2 * 10, calcoliamo la parte decimale
	add t4 t2 t3			# t4 = t2 + t3, sommaimo parte decimale con le unita cosi da 'ricostruire' i due caratteri in un singolo numero intero
	addi t4 t4 -1			# Si sottrae uno perche gli indici per indicare la posizione partono da 0, mentre quelli delle occorrenze da 1
	add s0 s0 t4			# Si incrementa s0 di t2, ovvero la posizione indicata dall'occorrenza
	sb t1 0(s0)				# Si salva il carattere corrente in s0
	lw s0 4(sp)				# Si rispristina l'indirizzo di s0 cosi da poter inserire correttaemnte anche i caratteri succesivi
	jr ra
#Procedura per trasformare un numero da ascii a intero e salvarlo nel messaggio criptato per l'algoritmo REVERSE_C
ASCII_TO_INT_REVERSE_C:
	addi t2 t2 -49			# t2 = t2 - 49, convertiamo il carattere da ascii a intero
	add s0 s0 t2			# Si incrementa s0 di t2, ovvero la posizione indicata dall'occorrenza
	sb t1 0(s0)				# Si salva il carattere corrente in s0
	lw s0 4(sp)				# Si rispristina l'indirizzo di s0 cosi da poter inserire correttaemnte anche i caratteri succesivi
	jr ra





















   
# Procedura che calcola la crittografia tramite l'algoritmo dizionario -----------------------------------------------
DIZIONARIO:
    addi sp sp -4                            # Alloco spazio nella pila per salvare s1
    sw s1 0(sp)                              # Si salva il valore di s1 per poterlo ristabilire alla fine della procedura
    li t0 0                                  # Contatore del ciclo
while_dictionary:
    lb t1 0(s1)                              # Carico il carattere da cifrare
    beq t0 s4 end_while_dictionary           # Se t0 = lunghezzaMessaggio allora termino il ciclo
    li t2 65				                 # A = 65 ASCII
	bge t1 t2 uppercase_check_dictionary  	 # Se maggiore di 64 controllo che sia maiuscola o minuscola
    li t2 48                                 # 0 = 48 ASCII
    bge t1 t2 num_shift_dictionary   
other_char_dictionary:
    addi t0 t0 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cosi da poter leggere il carattere seguente
    j while_dictionary
num_shift_dictionary:
    li t2 57                    # 9 = 57 ASCII
    bgt t1 t2 other_char_dictionary
    sub t3 t2 t1                # s1 = noveASCII - numPartenza
    addi t3 t3 48               # riporto ai numeri ASCII
    sb t3 0(s1)
    addi t0 t0 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cosi da poter leggere il carattere seguente
    j while_dictionary
uppercase_check_dictionary:
    li t2 91                    # Carattere dopo la Z ASCII
    bge t1 t2 lowercase_check_dictionary
    li t2 90                    # Z = 90 (ASCII)
    sub t3 t2 t1                # Calcolo il carattere cifrato
    li t4 97                    # a = 97 (ASCII)
    add t3 t4 t3                # Riporto al carattere minuscolo
    sb t3 0(s1)
    addi t0 t0 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cosi da poter leggere il carattere seguente
    j while_dictionary
lowercase_check_dictionary:
    li t2 96                    # Carattere precedente a ASCII
    ble t1 t2 other_char_dictionary
    li t2 122                   # z = 122 (ASCII)
    sub t3 t2 t1                # Calcolo il carattere cifrato
    li t4 65                    # A = 65 (ASCII)
    add t3 t4 t3                # Riporto al carattere maiuscolo
    sb t3 0(s1)
    addi t0 t0 1			    # Si incrementa il contatore del ciclo
	addi s1 s1 1			    # Si aumenta l'indirizzo di s1 cosi da poter leggere il carattere seguente
    j while_dictionary
end_while_dictionary:
    lw s1 0(sp)              # Reset indirizzo di s1
    addi sp sp 4
    jr ra
    
# Procedura che calcola la crittografia tramite inversione della stringa -------------------------------------------------
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
    li a7 10						# ecall per terminare il programma
    ecall