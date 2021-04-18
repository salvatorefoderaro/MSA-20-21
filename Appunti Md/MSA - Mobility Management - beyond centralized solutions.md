# MSA - Mobility Management: beyond centralized solutions

- Caratteristica comune alle soluzioni già viste è la gestione centralizzata della mobilità (**CMM - Centralized Mobility Management**). Introduce delle problematiche:
  - **Instradamento non ottimale:** qualunque sia la distanza di rete tra due nodi, lo scambio di messaggi deve sempre passare attraverso l'entità centrale
  - **Scalabilità:** quanto maggiore è la lunghezza del cammino, tanto maggiore è il numero di porzioni della rete interessate dal trafico del nodo mobile
  - **Affidabilità:** in presenza di un punto centralizzato, singhe point of failure, se fallisce l'entità centrale tutti i nodi sotto il suo controllo diventano irragiungibili
  - **Tendenza della rete:** tendenza della rete ad appiattirsi, che si trova a coesistere con una soluzione al problema della mobilità gerarchica
  - **Cecità rispetto alle reali esigenze di gestione della mobilità:** il numero di nodi mobili ha sueperato il numero di entità fisse, però molto spesso questi nodi usano la connessione wireless per praticità e comodità, però molti di questi nodi sono statici
- L'idea è quella di pensare a soluzioni alternative più efficaci che si allontani dallo schema centralizzato gerarchico, verso una soluzione più decentralizzata. L'idea è quella di risolvere i primi quattro problemi, usando come punto di ancoraggio del nodo mobile un luogo che non sia fisso ed unico, ma un luogo dinamico. Per l'ultimo problema, invece, provedere che i meccanismi della gestione della mobilità siano attivati su richiesta di qualche entitò in gioco

### **AR Anchoring**

- Il punto di ancoraggio del nodo mobile, il punto verso cui chi interagisce con il nodo indirizza i suoi messaggi, coincide con l'access router della rete in cui si trov il nodo mobile in cui inizia una sessione verso il suo partner
- Sono soluzioni limitate alla continuità della sessione, fintanto che il nodo mobile attiva una sessione
- Nel caso di cambio di posizione del nodo mobile:
  - Il parneter continua ad inviare i pacchetti verso la precednte rete del nodo mobile
  - L'access router della rete farà il forward dei pacchetti verso la nuova erete in cui si trova il nodo mobile, tramite il meccanismo del tunnel
  - Il nodo mobile informa il vecchio AR del cambio di posizione

### **CN Anchoring**

- Uno dei problemi del protocollo Mobile IP, e delle sue varianti, era quello dell'instradamento non ottimale causato dalla triangolazione
- L'idea per ridurre l'impatto negativo è quella di ridurre al minimo possibile la lunghezza dei lati del triangolo
- L'idea alla base della soluzione è che lo HA non è un'entità fissa e statica, ma è un'entità creata dinamicamente a seconda delle necessità
  - Lo HA viene creato nella stessa rete in cui si trova il nodo corrispondente del nodo mobile
  - HA assegna ad MN un CHoA, indirizzo IP di sessione
  - MN utilizza l'indirizzo IP del suo access point come CoA
  - Dal punto di vista di CN, MN è un nodo che sta all'interno della sua stessa rete

### **Host Routing**

- L'idea è di avere un routing personalizzato
- Ogni router possiede un entry che dice, nel momento in cui arriva un pacchetto indirizzato ad uno scpeficico nodo mobile, il prossimo hop, dove deve essere instradato
- Non c'è incapsulamento e l'instradamaneto è sempre pttimale, ma c'è l'overhead dal punto di vista dei messaggi di controllo, in quanto l'informazione sulla posizione del nodo mobile e sui suoi cambi di posizione vanno propagate sulla totalità della rete, su tutta la porzione di rete che si intende mantenere aggiornata sulla posizione del nodo mobile
- Questa soluzione risolve anche iil problema della raggiungibilità del nodo mobile