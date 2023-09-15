#Alessio Majid
#7073646

#prova di comandi extra
#ADD(1) ~ ADD(L) ~ ADD(a) ~ ADD(H) ~ ADD(:) ~ ADD(5) ~SDX~SORT~PRINT~DEL(a) ~DEL(J) ~PRI~SSX~REV~PRINT
#ADD(1) ~ SDX ~ ADD(F) ~ add(v) ~ ADD(v) ~ ADD ~ ADD(1) ~PRINT~SORT(a)~PRINT~DEL(vv) ~DEL(v) ~PRINT~REV~SSX~PRINT
#ADD(A) ~ADD(:) ~ADD(h) ~ADD(z) ~ ADD(;) ~ ADD(R) ~ ADD(4) ~ADD(a) ~ADD(b) ~ PRINT ~ DEL(4) ~ PRINT ~SORT ~ PRINT ~ REV ~ PRINT ~ SDX ~ PRINT ~ SSX ~ PRINT ~ SORT ~ PRINT

#prova comandi dati da specifiche
#ADD(1) ~ ADD(a) ~ ADD(a) ~ ADD(B) ~ ADD(;) ~ ADD(9) ~SSX~SORT~PRINT~DEL(b)~DEL(B) ~PRI~SDX~REV~PRINT
#ADD(1) ~ SSX ~ ADD(a) ~ add(B) ~ ADD(B) ~ ADD ~ ADD(9) ~PRINT~SORT(a)~PRINT~DEL(bb)~DEL(B) ~PRINT~REV~SDX~PRINT

.data 
listInput: .string "ADD(1) ~ SSX ~ ADD(a) ~ add(B) ~ ADD(B) ~ ADD ~ ADD(9) ~PRINT~SORT(a)~PRINT~DEL(bb)~DEL(B) ~PRINT~REV~SDX~PRINT"
#listInput: .string "ADD(1) ~ SDX ~ ADD(F) ~ add(v) ~ ADD(v) ~ ADD ~ ADD(1) ~PRINT~SORT(a)~PRINT~DEL(vv) ~DEL(v) ~PRINT~REV~SSX~PRINT"
#listInput: .string "ADD(A) ~ADD(:) ~ADD(h) ~ADD(z) ~ ADD(;) ~ ADD(R) ~ ADD(4) ~ADD(a) ~ADD(b) ~ PRINT ~ DEL(4) ~ PRINT ~SORT ~ PRINT ~ REV ~ PRINT ~ SDX ~ PRINT ~ SSX ~ PRINT ~ SORT ~ PRINT"
newline: .string "\n"

.text
la s0 listInput
li s1 0                                     #contatore per scorrere la stringa in input
li s2 0                                     #contatore numero comandi
li s3 30                                    #numero max comandi
li s4 0x00400000                            #indirizzo di memoria del primo elemento - PAHEAD
li s5 0x00400000                            #contatore di ciclo posizionale degli elementi
li s6 0                                     #numero di elementi nella lista concatenata
li s7 9                                     #flag

check_input:
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    beq t2 zero end_main                     #abbiamo raggiunto la fine della stringa
    beq s2 s3 end_main                       #abbiamo raggiunto il numero max di comandi ammessi
    li t3 32                                 #carico Space in un registro
    beq t2 t3 increment_counter              #se il char a cui punto ? uno spazio allora passo al char sucessivo                    
    li t3 65                                 #carico A in un registro
    beq t2 t3 check_add
    li t3 68                                 #carico D in un registro
    beq t2 t3 check_del
    li t3 80                                 #carico P in un registro
    beq t2 t3 check_print
    li t3 83                                 #carico S in un registro
    beq t2 t3 check_s
    li t3 82                                 #carico R in un registro
    beq t2 t3 check_rev
    j skip_command
    
check_add:
    beq s2 s3 skip_command                   #se sono al 31esimo comando non lo eseguo
    addi s1 s1 1                             #aumento il contatore
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 68                                 #carico la lettera D in un registro 
    bne t2 t3 skip_command
    addi s1 s1 1                             #aumento il contatore
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    bne t2 t3 skip_command
    addi s1 s1 1                             #aumento il contatore
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 40                                 #metto la tonda aperta in un registro
    bne t2 t3 skip_command
    addi s1 s1 1                             #aumento il contatore
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t4 32                                 #carico ASCII 32 (Space) in un registro
    li t5 125                                #carico ASCII 125 (}) in un registro
    blt t2 t4 skip_command                   #se il char e' minore di 32 salto
    bgt t2 t5 skip_command                   #se il char e' maggiore di } salto
    addi a0 t2 0                             #salvo in a0 il carattere
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 41                                 #controllo la validita' del comando
    bne t2 t3 skip_command
 
unique_ADD:
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                               #carico il carattere corrente per le verifiche
    li t5 126                                 #carico ASCII 126 (tilde) in un registro
    li t4 32                                  #carico ASCII 32 (Space) in un registro
    beq t2 t5 prepare_execute_ADD             #se trova un char tilde allora il comando e' corretto
    beq t2 zero ADD                           #sono arrivato qui, il comando e' corretto ma sono a fine stringa
    bne t2 t4 skip_command                    #se salto qui il comando non e' corretto
    j unique_ADD
       
prepare_execute_ADD:
    jal ADD
    li a0 0                                  #resetto l'argomento da passare alle funzioni
    addi s2 s2 1                             #numero di comandi++
    j increment_counter  

check_del:
    beq s2 s3 skip_command                   #se sono al 31esimo comando non lo eseguo
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 69                                 #carico la lettera E in un registro 
    bne t2 t3 skip_command                   #se la lettera non coincide il comando e' errato
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 76                                 #carico la lettera L in un registro
    bne t2 t3 skip_command                   #se la lettera non coincide il comando e' errato
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 40                                 #metto la tonda aperta in un registro
    bne t2 t3 skip_command                   #se la lettera non coincide il comando e' errato
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t4 32                                 #carico ASCII 32 (Space) in un registro
    li t5 125                                #carico ASCII } in un registro
    blt t2 t4 skip_command                   #se il char e' minore di 32 salto
    bgt t2 t5 skip_command                   #se il char e' maggiore di } salto
    addi a0 t2 0                             #salvo in a0 l'argomento della funzione
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 41                                 #metto la tonda chiusa in un registro
    bne t2 t3 skip_command                   #se la lettera non coincide il comando e' errato
 
unique_DEL:
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t5 126                                #carico ASCII 126 (tilde) in un registro
    li t4 32                                 #carico ASCII 32 (Space) in un registro
    beq t2 t5 prepare_execute_DEL            #se trova un char tilde allora il comando e' unico
    beq t2 zero DEL
    bne t2 t4 skip_command                   #se trova un char che non e' Space salta
    j unique_DEL                             #se arriva qui e' un comando unico
       
prepare_execute_DEL:
    jal DEL
    li a0 0                                  #resetto l'argomento da passare alle funzioni
    addi s2 s2 1                             #numero di comandi++
    j increment_counter  

check_print:
    beq s2 s3 skip_command                   #se sono al 31esimo comando non lo eseguo
    addi s1 s1 1                             #contatore++
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 82                                 #metto il char R in un registro
    bne t2 t3 skip_command                   #se la lettera non coincide il comando e' errato
    addi s1 s1 1                             #contatore++  
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 73                                 #metto il char I in un registro
    bne t2 t3 skip_command                   #se la lettera non coincide il comando e' errato
    addi s1 s1 1                             #contatore++ 
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 78                                 #metto il char N in un registro
    bne t2 t3 skip_command                   #se la lettera non coincide il comando e' errato
    addi s1 s1 1                             #contatore++ 
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 84                                 #metto il char T in un registro
    bne t2 t3 skip_command                   #se la lettera non coincide il comando e' errato

unique_PRINT:
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t5 126                                #carico ASCII 126 (tilde) in un registro
    li t4 32                                 #carico ASCII 32 (Space) in un registro
    beq t2 t5 prepare_execute_PRINT          #se trova un char tilde allora il comando e' unico
    beq t2 zero PRINT
    bne t2 t4 skip_command                   #se trova un char che non e' Space salta
    j unique_PRINT                           #se arriva qui e' un comando unico
       
prepare_execute_PRINT:
    jal PRINT
    li a0 0                                  #resetto l'argomento da passare alle funzioni
    addi s2 s2 1                             #numero di comandi++
    j increment_counter  

check_rev:
    beq s2 s3 skip_command                   #se sono al 31esimo comando non lo eseguo
    addi s1 s1 1                             #contatore++
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 69 
    bne t2 t3 skip_command
    addi s1 s1 1                             #contatore++
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 86
    bne t2 t3 skip_command
     
unique_REV:
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t5 126
    li t4 32
    beq t2 t5 prepare_execute_REV            #se trova un char tilde allora il comando e' unico
    beq t2 zero REV
    bne t2 t4 skip_command                   #se trova un char che non e' Space salta    j unique_REV
    
prepare_execute_REV:
    jal REV
    li a0 0                                  #resetto l'argomento da passare alle funzioni
    addi s2 s2 1                             #numero di comandi++
    j increment_counter             
             
check_s:
    addi s1 s1 1                             #contatore++
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 79                                 #metto il char O in un registro
    li t4 68                                 #metto il char D in un registro
    li t5 83                                 #metto il char S in un registro
    beq t2 t3 verify_SORT
    beq t2 t4 verify_SDX
    beq t2 t5 verify_SSX
    j skip_command

verify_SORT:
    beq s2 s3 skip_command                   #se sono al 31esimo comando non lo eseguo
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 82
    bne t2 t3 skip_command
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 84
    bne t2 t3 skip_command
    
unique_SORT:
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t5 126
    li t4 32
    beq t2 t5 prepare_execute_SORT           #se trova un char tilde allora il comando e' unico
    beq t2 zero SORT
    bne t2 t4 skip_command                   #se trova un char che non e' Space salta 
  
prepare_execute_SORT: 
    jal SORT
    li a0 0                                  #resetto l'argomento da passare alle funzioni
    addi s2 s2 1                             #numero di comandi++
    j increment_counter              
   
verify_SDX:
    beq s2 s3 skip_command                   #se sono al 31esimo comando non lo eseguo
    addi s1 s1 1                             #contatore++
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 88
    bne t2 t3 skip_command 
    
unique_SDX:  
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t5 126
    li t4 32
    beq t2 t5 prepare_execute_SDX            #se trova un char tilde allora il comando e' unico
    beq t2 zero SDX
    bne t2 t4 skip_command                   #se trova un char che non e' Space salta 
  
prepare_execute_SDX:
    jal SDX
    li a0 0
    addi s2 s2 1                             #numero di comandi++
    j increment_counter     
 
verify_SSX:
    beq s2 s3 skip_command                   #se sono al 31esimo comando non lo eseguo
    addi s1 s1 1                             #contatore++
    add t1 s0 s1 
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t3 88
    bne t2 t3 skip_command 
       
unique_SSX:
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    li t5 126
    li t4 32
    beq t2 t5 prepare_execute_SSX            #se trova un char tilde allora il comando e' unico
    beq t2 zero SSX
    bne t2 t4 skip_command                   #se trova un char che non e' Space salta 
      
prepare_execute_SSX:
    jal SSX
    li a0 0
    addi s2 s2 1                             #numero di comandi++
    j increment_counter      
  
skip_command:
    beq t2 zero end_main
    li t5 126                                #carico tilde in un registro
    beq t2 t5 increment_counter              #se il carattere a cui punto e' tilde
    addi s1 s1 1                             #contatore++
    add t1 s0 s1
    lb t2 0(t1)                              #carico il carattere corrente per le verifiche
    j skip_command
    
increment_counter:
    beq t2 zero end_main
    addi s1 s1 1                             #contatore++
    j check_input
     
ADD:
    beq s6 zero first_add                    #controllo che sia il primo elemento della catena
    sb a0 0(s5)                              #Salvo il byte passato come parametro
    sw s4 1(s5)                              #salvo il puntatore
    addi s6 s6 1 
    addi t6 s5 0                
    addi t6 t6 -5
    j search_previous
        
first_add:
    sb a0 0(s4)                               #Salvo il byte passato come parametro
    sw s4 1(s5)                               #salvo il puntatore 
    addi s5 s5 5                              #punto alla cella in cui andra' il prossimo elemento
    addi s6 s6 1                              #numero elementi ++
    jr ra    

search_previous:
    lb t3 0(t6)
    bne t3 s7 link_following
    addi t6 t6 -5
    j search_previous
    
link_following:
    sw s5 1(t6)
    addi s5 s5 5
    jr ra  

DEL:
    addi t0 s4 0
    addi t6 t0 5
    lb t3 0(t0)
    beq t3 a0 delete_first                    #funzione che rimuove SOLO il primo elemento

find:
    lb t3 0(t6)
    beq t3 a0 delete_found
    lw t4 1(t0)
    beq t4 s4 end_DEL
    beq t3 s7 skip_flag
    lw t4 1(t6)
    beq t4 s4 end_DEL
    addi t0 t6 0
    addi t6 t6 5
    j find

delete_found:
    sb s7 0(t6)
    lw t4 1(t6)
    beq t4 s4 change_pahead
    addi t6 t6 5
    addi s6 s6 -1
    j search_following  
    
change_pahead:
    sw s4 1(t0)
    jr ra
    
search_following:
    lb t3 0(t6)
    beq t3 a0 delete_found
    bne t3 s7 link
    addi t6 t6 5
    j search_following
    
link:
    sw t6 1(t0)
    lw t4 1(t6)
    beq t4 s4 end_DEL
    addi t6 t6 5
    j find                   

skip_flag:
    addi t6 t6 5
    j search_following
        
delete_first:
    lb t4 1
    beq s6 t4 reset
    lb t3 0(t0)
    beq t3 a0 delete_nth
    bne t3 s7 update_second
    addi t0 t0 5
    j delete_first
 
delete_nth:
    sb s7 0(t0)
    addi s6 s6 -1
    addi t0 t0 5
    j delete_first
   
update_second:
    addi t6 t0 0
    j find_last        

find_last:
    lb t3 0(t6)
    bne t3 s7 check_pointer
    addi t6 t6 5
    j find_last

check_pointer:
    lw t4 1(t6)
    beq t4 s4 link_to_head
    addi t6 t6 5
    j find_last

link_to_head:
    addi s4 t0 0
    sw s4 1(t6)
    j DEL
    
reset:
    sb s7 0(t0)
    addi s4 s5 0
    jr ra    

end_DEL:
    jr ra

PRINT:
    beq s6 zero end_print
    addi t6 s4 0
    
check:
    lb t3 0(t6)
    bne t3 s7 print_loop
    addi t6 t6 5
    j check
    
print_loop:
    lb a0 0(t6)
    li a7 11
    ecall
    lw t4 1(t6)
    beq t4 s4 end_print
    addi t6 t6 5
    j check
    
end_print:
    la a0 newline
    li a7 4
    ecall
    jr ra        

REV:
    beq s6 zero empty_chain
    addi sp sp -30                               #massimo numero di elementi 
    addi t6 s4 0
    
to_stack:
    lb t3 0(t6)
    bne t3 s7 add_to_stack   
    addi t6 t6 5
    j to_stack
       
add_to_stack:
    sb t3 0(sp)
    addi sp sp 1
    lw t4 1(t6)
    beq t4 s4 end_chain
    addi t6 t6 5
    j to_stack   
    
end_chain:
    addi sp sp -1
    addi t6 s4 0
    j to_chain

to_chain:
    lb t3 0(t6)
    bne t3 s7 add_to_chain
    addi t6 t6 5
    j to_chain
    
    
add_to_chain:
    lb t3 0(sp)
    sb t3 0(t6)
    addi sp sp -1
    lw t4 1(t6)
    beq t4 s4 end_stack
    addi t6 t6 5
    j to_chain            
    
empty_chain:
    jr ra    
    
end_stack:
    addi sp sp 30
    jr ra

SORT:
    lw s8, 1(s4)
    addi a6, s4, 0
    lw t3, 1(s4)
    beq t3, zero, end_sort                             #se non ci sono elementi termina 
    add t3, s4, zero
    lw t1, 1(t3)                                        
    beq t1, s4, end_sort                               #la lista contiene un solo elemento (gia' ordinato)
    
sorting_loop:
    lb t0, 0(t1)
    lb t2, 0(t3)
    li a2, 65                                           #carattere 'A' in codice ASCII
    li a3, 90                                           #carattere 'Z' in codice ASCII
    blt t2, a2, check_lowercase_first
    bgt t2, a3, check_lowercase_first
    li a4, 0                                            #se arrivo qui vuol dire che e' un carattere maiuscolo --> indicato con 0
    j check_uppercase_second
        
check_lowercase_first:
    li a2, 97                                           #carattere 'a' in codice ASCII
    li a3, 122                                          #carattere 'z' in codice ASCII
    blt t2, a2, check_number_first
    bgt t2, a3, check_number_first
    li a4, 1                                            #se arrivo fin qui vuol dire che e' un carattere minuscolo --> indicato con 1
    j check_uppercase_second
                      
check_number_first:
    li a2, 48                                           #carattere '0' in codice ASCII
    li a3, 57                                           #carattere '9' in codice ASCII
    blt t2, a2, check_extra_first
    bgt t2, a3, check_extra_first
    li a4, 2                                            #se arrivo fin qui vuol dire che e' un carattere numerico --> indicato con 2
    j check_uppercase_second
                
check_extra_first:
    li a4, 3                                            #se arrivo fin qui vuol dire che e' un carattere speciale --> indicato con 3
              
check_uppercase_second:
    li a2, 65                                           
    li a3, 90                                        
    blt t0, a2, check_lowercase_second
    bgt t0, a3, check_lowercase_second
    li a5, 0                                            #se arrivo fin qui vuol dire che e' un carattere maiuscolo --> indicato con 0
    j compare
        
check_lowercase_second:
    li a2, 97                                           #carattere 'a' in codice ASCII
    li a3, 122                                          #carattere 'z' in codice ASCII
    blt t0, a2, check_number_second
    bgt t0, a3, check_number_second
    li a5, 1                                            #se arrivo fin qui vuol dire che e' un carattere minuscolo --> indicato con 1
    j compare
                      
check_number_second:
    li a2, 48                                           #carattere '0' in codice ASCII
    li a3, 57                                           #carattere '9' in codice ASCII
    blt t0, a2, check_extra_second
    bgt t0, a3, check_extra_second
    li a5, 2                                            #se arrivo fin qui vuol dire che e' un carattere numerico --> indicato con 2
    j compare
                
check_extra_second:
    li a5, 3                                            #se arrivo fin qui vuol dire che e' un carattere speciale --> indicato con 3
                        
compare:
    bgt a4, a5, increment_loop                          #i due elementi appartengono a due categorie diverse
    beq a4, a5, compare_ASCII                           #i due elementi appartengono alla stessa categoria 
    sb t2, 0(t1)
    sb t0, 0(t3)
    j increment_loop
                   
compare_ASCII:
    blt t2, t0, increment_loop
    sb t2, 0(t1)
    sb t0, 0(t3)
                    
increment_loop:
    addi t3, t1, 0
    lw t1, 1(t1)                                        
    bne t1, a6, sorting_loop                            
    addi a6, t3, 0
    add t3, s4, zero
    lw t1, 1(t3)
    bne a6, s8, sorting_loop
                    
end_sort:
    jr ra

SDX:
    beq s6 zero end_SDX
    li t0 1
    beq s6 t0 end_SDX
    li s9 0x00600000
    addi t0 s9 0
    addi t6 s4 0
    
stringify_SDX:
    lb t3 0(t6)
    bne t3 s7 to_string_SDX
    addi t6 t6 5
    j stringify_SDX
    
to_string_SDX:
    sb t3 0(t0)
    lw t4 1(t6)
    beq t4 s4 save_last_SDX
    addi t0 t0 1
    addi t6 t6 5
    j stringify_SDX     

save_last_SDX:
    lb t1 0(t0)                            #salvo l'ultimo char
    sb s7 0(t0)                            #metto il flag al posto dell'ultimo elemento
    li s10 0x00525000                      #stringa shiftata
    addi t0 s10 0
    sb t1 0(t0)                            #setto l'ultimo char come primo nella stringa shiftata
    addi t1 s9 0
    addi t0 t0 1
    j execute_SDX
    
execute_SDX:
    lb t2 0(t1)                            #carico il carattere corrente per le verifiche
    beq t2 s7 flag_SDX
    sb t2 0(t0)
    addi t0 t0 1
    addi t1 t1 1
    j execute_SDX
    
flag_SDX:
    sb s7 0(t0)
    j back_in_chain_SDX    
    
back_in_chain_SDX:
    addi t0 s10 0
    addi t6 s4 0
    j string_to_chain_SDX    

string_to_chain_SDX:
    lb t1 0(t0)                            #carica in un registro i valori della stringa
    beq t1 s7 end_SDX
    lb t2 0(t6)                            #controlla se il nodo cancellato logicamente
    beq t2 s7 next_SDX
    sb t1 0(t6)
    addi t0 t0 1
    addi t6 t6 5
    j string_to_chain_SDX

next_SDX:
    addi t6 t6 5
    j string_to_chain_SDX

end_SDX:
    jr ra  

SSX:
    beq s6 zero end_SSX
    li t0 1
    beq s6 t0 end_SSX
    li s9 0x00600000
    addi t0 s9 0
    addi t6 s4 0
     
stringify__SSX:
    lb t3 0(t6)
    bne t3 s7 to_string__SSX
    addi t6 t6 5
    j stringify__SSX
    
to_string__SSX:
    sb t3 0(t0)
    lw t4 1(t6)
    beq t4 s4 save_first_SSX
    addi t0 t0 1
    addi t6 t6 5
    j stringify__SSX     

save_first_SSX:
    addi t0 t0 1
    sb s7 0(t0)                        #metto il flag alla fine di s9
    addi t0 s9 0
    lb t1 0(t0)                        #salvo il primo carattere che poi sara' l'ultimo
    li s10 0x00525000
    addi t2 s10 0
    addi t0 t0 1
    j execute_SSX
    
execute_SSX:
    lb t3 0(t0)
    beq t3 s7 last_SSX
    sb t3 0(t2)
    addi t2 t2 1
    addi t0 t0 1
    j execute_SSX
    
last_SSX:
    sb t1 0(t2)
    addi t2 t2 1
    sb s7 0(t2)
    j back_in_chain_SSX   
    
back_in_chain_SSX:
    addi t0 s10 0
    addi t6 s4 0
    j string_to_chain_SSX    

string_to_chain_SSX:
    lb t1 0(t0)                            #carica in un registro i valori della stringa
    beq t1 s7 end_SSX
    lb t2 0(t6)                            #controlla se e' un nodo cancellato logicamente
    beq t2 s7 next_SSX
    sb t1 0(t6)
    addi t0 t0 1
    addi t6 t6 5
    j string_to_chain_SSX

next_SSX:
    addi t6 t6 5
    j string_to_chain_SSX

end_SSX:
    jr ra  

end_main:
    li a7 10
    ecall                               #programma termina con successo (exit code 0)