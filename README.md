# RISC-V Using RIPES[^note]
###### [https://github.com/mortbopet/Ripes]


[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/Voluruund/Progetto_AE/graphs/commit-activity)
[![Only 32 Kb](https://badge-size.herokuapp.com/Naereen/StrapDown.js/master/strapdown.min.js)](https://github.com/Naereen/StrapDown.js/blob/master/strapdown.min.js)

Progetto sviluppato per l'esame di architetture degli elaboratori del primo anno del CdL Informatica dell'Università degli studi di Firenze.
Il progetto consiste nell'implementazione di 5 algoritmi di cifratura noti. La stringa di partenza è composta da caratteri compresi fra 27 e 127 (ASCII).

#### Algoritmo 1: Cifrario di Cesare
Il primo algoritmo è il cifrario di Cesare. Esso consiste nello shift alfabetico della stringa di x posizioni (positive o negative) dettate dalla variabile SostK.
L'algoritmo ignora i caratteri non compresi nel range durante l'esecuzione. I caratteri criptati verranno calcolati tramite le seguenti funzioni:
  
  - lettera maiuscola (A-Z, ASCII 65-90 compresi): 65 + [(cod(X)-65)+K] mod 26
  - lettera maiuscola (a-z, ASCII 97-122 compresi): 97 + [(cod(X)-97)+K] mod 26

#### Algoritmo 2: Cifrario a blocchi
Il secondo algoritmo è il cifrario a blocchi. Esso consiste nello shift alfabetico della stringa di x posizioni calcolate tramite la conversione del carattere corrente dettato dalla stringa ausiliaria blocKey. I caratteri criptati verrano calcolati tramite la seguente funzione:

  - For each bi in B (1 ≤ i ≤ nb), cbi = 32 + (cod(bij) + cod(keyj)) mod 96, 1 ≤ j ≤ k

#### Algoritmo 3: Cifrario ad occorrenze:
Il terzo algoritmo è il cifrario ad occorrenze. Esso consiste nella scrittura, a partire dal primo carattere, di una sequenza di stringhe separate da esattamente 1 spazio (ASCII 32) della forma:

  - Pt = “sempio di messaggio criptato -1”
  - Ct = “e-2-12 s-1-13-14 m-3-11 p-4-24 i-5-9-18-23 o-6-19-28 -7-10-20-29 d-8 a-15-26 g-16-17 c-21 r-22 t-25-27 --30 1-31”.

#### Algoritmo 4: Dizionario
Il quarto algoritmo è il dizionario. Questo algoritmo è auto invertente. Esso consiste nella mappatura di ogni carattere secondo una funzione predisposta inoltre ignora i caratteri non compresi nel range durante l'esecuzione:

  - lettera minuscola (min), viene sostituito con l’equivalente maiuscolo dell’alfabeto in ordine inverso es. Z = ct(a), A = ct(z).
  - lettera maiuscola (mai), viene sostituito con l’equivalente minuscolo dell’alfabeto in ordine inverso es. z = ct(A), y = ct(B), a =ct(Z).
  - numero (num), ct(ci) = 9 – num, cod(ct(ci) = ASCII(9) – ASCII(num) In tutti gli altri casi (sym), ci rimane invariato, ovvero ct(ci) = ci

#### Algoritmo 5: Inversione
Il quinto algoritmo è l'inversione della stringa. Questo algoritmo è auto invertente. Si noti come nel caso di parole palindrome, pt = ct.

  - Pt = BUONANOTTE 
  - Ct = ETTONANOUB
 
 
[^note]: Progetto architetture degli elaboratori anno accademico 2021/2022. 
