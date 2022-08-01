.data 
myplaintext: .string "StringaProva"
blocKey: .string "OLE"
mycypher: .string "ABCDE"
cyphertext: .string ""
sostK: .word 3

.text
#MAIN PROCEDURE --------------------------------
lb a2 sostK
la s0 cyphertext 
la s1 myplaintext
la s2 blocKey
la s3 mycypher
li s4 0             #lunghezza messaggio
li s5 0             #lunghezza blocKey
li s6 0             #lunghezza mycypher

jal MYPLAINTEXT_SIZE
add s4 zero a0      #salvo il valore di ritorno contenuto in a0

#Procedura che calcola il numero di caratteri da cifrare ------------------------------
MYPLAINTEXT_SIZE:
    addi sp sp -4      #spazio allocato nella pila
    sw s1 0(sp)        #indirizzo alla testa del messaggio
    li t1 0            #contatore
myplaintext_while_loop:
    lb t0 0(s1)        #carico in t0 il primo byte della stringa
    beq t0 zero myplaintext_end_while_loop #se trovo il valore 0 (end of string) salto
    addi t1 t1 1       #contatore ++
    addi s1 s1 1       #passo al carattere successivo
    j myplaintext_while_loop
myplaintext_end_while_loop:
    add a0 zero t1     #salvo la lunghezza nel registro per il ritorno da procedure
    lw s1 0(sp)        #reset di s1
    addi sp sp 4       #puntatore in testa alla pila
    jr ra
    
#Procedura che calcola il numero di caratteri della chiave blocKey ------------------
BLOCKEY_SIZE:
    addi sp sp -4      #spazio allocato nella pila
    sw s2 0(sp)        #indirizzo alla testa del messaggio
blockey_while_loop:
    lb t0 0(s2)        #carico in t0 il primo byte della stringa
    beq t0 zero blockey_end_while_loop  #se trovo il valore 0 (end of string) salto
    addi s5 s5 1       #contatore++
    addi s2 s2 1       #passo al carattere successivo
    j blockey_while_loop
blockey_end_while_loop:
    lw s2 0(sp)        #reset di s2
    addi sp sp 4       #ripristino puntatore alla testa
    
#Procedura che calcola il numero di caratteri di mycypher -------------------------
MYCYPHER_SIZE:
    addi sp sp -4      #spazio allocato nella pila
    sw s3 0(sp)        #indirizzo alla testa del messaggio
mycypher_while_loop:
    lb t0 0(s3)        #carico in t0 il primo byte della stringa
    beq t0 zero mycypher_end_while_loop
    addi s6 s6 1       #contatore++
    addi s3 s3 1       #passo al carattere successivo
    j mycypher_while_loop
mycypher_end_while_loop:
    lw s3 0(sp)        #reset di s3
    addi sp sp 4       #ripristino puntatore alla testa
 