# MSA - Mobility Management in Wireless WAN

#### **Hand-Off**

- **2G-2.5G-3G:**
  - Architettura gerarchica di riferimento. Alla radice abbiamo le MSC, a cui fanno capo entità di livello più basso, i BSC, a cu i a loro volta fanno capo entità di livello ancora più basso, i BTS. Spostardi all'interno di una rete realizzata in questo modo significa passare da una cella ad un'altra adiacente coperta da un'antenna (BTS) diversa
  - Hand-off possono essere di diverso tipo:
    - **Livello 1:** all'interno dello stesso BTS
    - **Livello 2:** BTS differente, ma all'interno dello stesso BSC
    - **Livello 3:** BTS differente, BSC differente ma all'interno dello stesso MSC
    - **Livello 4:** BTS differente, BSC differente ed MSC differente
- **4G:**
  - Entità che entrano in gioco sono MME e SGW, entitià indipendenti tra di loro, da un punto di vista di struttura gerarchica stanno allo stesso livello all'interno della parte core della rete
  - **MME:** si preoccupa di mantenere aggiornate le informazioni sulla posizione quando il nodo è in stato idle
  - **SGW:** entra in gioco primariamente quando il nodo mobile cambia posizione ed è impegnato in un'interazione con il suo partner
- Due singole antenne possono fare capo allo stesso MMEo e/o stesso SGW, dunque abbiamo quattro possibili hand-off dati dalle quattro configurazioni

#### **Architettura di sistema per la gestione della mobilità**

- **2G:** architettura di una rete di seconda generazione primariamente pensata per supportare traffico di tipo vocale. L'ifrastruttura per la gestione della mobilità è formata da MSC collegati da una rete sy cui ricolano messaggi di controllo
  - **MSC:** entità attivamente coinvolte. Sono presenti diversi MSC, ma solamente uno svolge il ruolo privilegiato che è il punto di contatto con l'architettura con il mondo esterno
  - **HLR/VLR:** struttura di memorizzazione per mantenere l'informazione sulla posizione dei nodi tramite un database a due livelli. HRL è la radice della gerarichia, a cui fanno capo i VLR, in associazione 1-1 con il singolo HRL
- **3G:** evoluzione della generazione precedente, la configurazione generale non cambia
  - **SGSN:** nuovo nome per indicare l'MSC
  - **GGSN:** nuovo nome per indicare l'MSC primario connesso direttamente alla rete inernet
  - Il colloquio tra le due euntità avviene tramite un backbone che utilizza il protocollo IP
  - Organizzazione che comincia ad essere sovrapponibile con l'architettura del Proxy Mobile IP, con GGSN sovrapponibile ad LMA e SGSN sovrapponibile a MAG
- **4G:** singole antenne si connettono direttamente al core della rete, viene rimosso un livello della gerarchia
  - **SGW:** nuovo nome per indicare SGSN
  - **PGW:** nuovo nome per indicare GGSN

#### **Mobility management in WWAN**

- **Requisiti:**
  - Trasparenza all'utente
  - Confidenzialità
  - Carico di sistema minimo per i messaggi di controllo
  - Scalabilità
- I requisiti vengono soddisfatti tramite due funzioni
  - **Tracciamento:** per mantere aggiornate le informazioni sulla posizione con un livello di precisione più o meno spinto
  - **Localizzazione:** per aggiornare con massima precisione il nodo mobile, nel caso in cui l'informazione fornita dal tracciamento non sia precisa

#### **Mobility Management sistemi 2G**

- All'organizzazione fisica gerarchica dobbiamo sovrapporre u ulteriore organizzazione logica, la ripartizione della totalità delle celle che si estendono sul territorio coperto dall'infrastruttura
- **Location area:** le celle vengono ripartire tra regioni formate da celle contigue tra di loro, sotto il controllo di un singolo MSC
- **Hand-off di tipo 3:**
  - **3.1:** due celle adiacenti fanno capo a due BSC differenti ma stessa LA
  - **3.2:** due celle adiacenti appartengono a delle LA differenti
- **VLR:** all'interno del VLR, associato ad ogni MSC, viene mantenuto per ogni nodo mobile un record che indica quel'è la LA in cui si trova attualmente il nodo mobile
- **HLR:** viene mantenuto per ogni nodo mobile un record che indica il VLR in cui è attualmente presente il nodo
- **Algoritmo di tracciamento:** viene attivato nel momento in cui un nodo mobile si accende e si connette ad una certa rete cellulare
  - Nodo mobile si connette ad un'antenna, determinando in questo modo la LA in cui il nodo si trova attualmente, grazie ad un segnale di beacon emesso periodicamente dall'antenna
  - Informazione viene inviata all'MSC a cui fa capo il BSC a cui è connesso l'utente, che aggiornerà la VLR con l'informazione relativa alla LA attuale del nodo
  - VLR inoltra informazione all'HLR, che memorizzerà la VLR attualmente associata al nodo mobile
  - Se il cambio di cella causa il camio della LA, ma mi trovo all'interno dello stesso MSC, allora va aggiornata solamente l'informazione presente ne VLR
  - Se il cambio di cella causa il cambio della LA e del MSC, allora allora l'informazione deve essere rimossa dal vecchio VLR e, oltre all'inserimento nel nuovo VLR, la nuova posizione deve essere propagata all'HLR per l'aggiornamento
  - Nel momento in cui il nodo moile è spento, nell'ultimo VLR viene registrato il fatto che il nodo mobile non è raggiungibile
  - Il vantaggio della riduzione del traffico viene pagato dalla mancanza di informazioni sulla precisione della posizione del nodo mobile
- **Algoritmo di localizzazione:** nel momento in cui qualcuno vuole contattare il nodo mobile, è necessario un algoritmo di reperimento del nodo mobile stesso
  - La ichiesta, originata da un'entità esterna, arriverà ad un certo MSC che rappresenta il punto di ingresso della rete
  - MSC manda query all'HLR di livello superiore per sapere qual'è il VLR che possiede le informazioni sulla posizione ccupata dal nodo mobile, usando come chiave l'identità del nodo
  - HLR riceve la richiesta di localizazione e la inoltra al VLR corrispondente, memorizzato all'interno della tabella con chiave corrispondente al nodo mobile
  - MSC associato al VLR che riceve la richiesta di localizzazione invia in parallelo a tutte le celle che fanno parte della LA indicata nel VLR un segnale che chiede al nobo mobile di farsi vivo
  - Se il nodo mobile risulta irrangiungibile, possono verificarsi due casi:
    - **Nodo spento:** VLR conosce lo stato di inattività del nodo mobile, dunque all'arrivo della richiesta di localizzazione il nodo mobile viene indicato come non raggiungibile
    - **Nodo entrato in una zona d'ombra:** prima di poter indicare il nodo mobile come non raggiungibile, bisogna attendere lo scadere di un timeout
- **Prestazioni degli algoritmi:** 
  - **Dimensione LA:** al minimo può essere formata da una singola cella. All'estremo opposto può essere formato dalla totalità dei nodi che fanno capo all'MSC. A seconda dei profili di uso e di mobilità può convenire dare peso ad un fattore o all'altro
    - **Costo tracciamento:** quanto più piccole sono le LA, maggiore è il traffico sulla rete, a causa dei messaggi di aggiornamento della LA del nodo. Discorso analogo dal punto di vista del consumo energetico
    - **Costo localizzazione:** quanto più grande è la LA, quante più celle riceveranno il messaggi odi localizzazione
  - **Modo di definizione dell'LA:** definizione statica, indipendente dalle azioni del modo mobile, o dinamica, in relazione alle attività del nodo mobile
    - **Statico:** modalità più semplice. Inconveniente è che si possono creare situazioni anomale, ad esempio nel caso in cui si crea un eccessivo traffico lungo la linea di confine tra due LA, andando a creare il così detto effetto ping-pong, quando tanti utenti si spostanno freqentemente a cavallo della linea di confine. Questo può geenrare traffico di controllo e di tracciamento notevole
    - **Dinamico:** la LA diventa un concetto legato al nodo mobile, ed ognuno ha la sua LA. Ad ogni nodo mobile viene assegnato un insieme di celle all'interno delle quali il nodo si trova. Nel momento in cui il nodo si accende gli viene associata una LA formata dalla cella in cui si trova e dalle celle circostanti. Quando il nodo mobile esce dall'insieme di celle definite, l'informazione deve essere aggiornata e ri-centrata, prendendo come centro la nuova posizione occupata e definendo un nuovo intorno
      - **L'aggiornamento può essere fatto in modo:**
        - **Reattivo:** quando esco dalla LA
        - **Pro-attivo:** prevedo il transito all'esterno della LA, tenendo conto degli spostamenti del nodo mobile, cercando di seguirlo nei suoi spostamenti, in modo da ridurre la necessità di aggiornare la sua posizione. Soluzione inizialmente esplorata in maniera teorica, ma riesumato a partire dalla quarta generazione

#### **Mobility Management sistemi 2.5/3G**

- Reti il cui il traffico dati assume un ruolo importante, se non prevalente
- **Routing area:** ripartizione delle celle che fanno capo ad uno stesso SGSN (MSC in 2G)
  - Sottoinsieme di celle adiacenti, contenuto all'interno delle Location area della rete 2G per supportare anche la generazione precedente
  - Traffico dati più intenso di quello supportato dalle reti di generazione precedente, dunque riduzione del traffico e maggiore precisione con sottoinsiemi più piccoli della precedente generazione
- **Routing pacchetti:** wireless dal nodo mobile fino alle BSS, controllore di primo livelo. Successivamente arriva al SGSN e, tramite backbone, al GGSN da cui viene instradato sulla rete internet verso il gateway della rete cellulare del destinatario. Da qui riemerge seguendo il percorso inverso
- **Algoritmo di tracciamento:** più articolata rispetto a quanto visto nella generazione 2. Viene introdotto modello a stati con tre stati.
  - **Modello a stati:**
    - **Idle:** nodo acceso ma inattivo, non riceve e non invia pacchetti
    - **Ready:** nodo riceve o invia messaggi e rimane in questo stato fin tanto che continua ad esserci traffico dati in modo significativo che coinvolge il nodo mobile
    - **Standby:** allo scadere del timer dello stato ready, il nodo passa in questo stato, da dove il nodo, al termine di un ulteriore timer, può tornare in stato ready oppure passare in idle
  - **Algoritmo:**
    - Nodo si accende, determina la sua attuale BTS, ed invia al suo SGSN l'informazione con il suo ID e la BTS a cui è attualmente connesso
    - SGSN inoltra informazione al suo GGSN, informandolo che è lui il responsabile della posizione del nodo mobile
    - Se il nodo è in stato *Ready* e cambia BTS, invia l'aggiornamento sulla nuova BTS al suo SGSN
    - Se il nodo è in stato *Standby* e cambia Routing Area, invia l'aggiornamento sulla nuova BTS al suo SGSN
    - Se il nodo cambia SGSN, allora il suo nuovo SGSN invia l'informazione al GGSN per l'aggiornamento dell'informazione precedentemente memorizzata
    - Se il nodo è in stato *Idle* non vengono effettuati aggiornamenti sulla sua posizione
- **Algoritmo di localizzazione**
  - GGSN riceve messaggio indirizzato al nodo mobile
  - GGSN invia il pacchetto al relativo SGSN, memorizzato nel suo database
  - SGSN ritrova l'informazione, memorizzata nel suo database, relativa alla BTS attuale del nodo
  - Se il nodo è nella BTS, invia il pacchetto al nodo
  - Altrimenti determina la BTS contattando tutte le BTS
  - Se il nodo non è presente nella routing area, viene indicato come non raggiungibile

#### **Mobility Management >= 4G**

- Eliminato un livello della gerarichia, in quanto ogni antenna parla direttamente con l'SGW corrispondente
- **Routing dei pacchetti:** antenna parla direttamente con la parte core della rete, SGW. Ognuno degli SGW si connette, tramite il backbone gestito usando protocolli di tipo IP, al agateway PGW che funge da punto di accesso con la rete esterna
- **Algoritmo di tracciamento:** viene introdotto il concetto di Tracking Area, analogo alla Location Area, ed il concetto di Tracking Area List
  - **TAL (Tracking Area List):** una tracking area  un'entità definita in maniera statica, dove l'insieme delle celle coperte da una certa infrastruttura di rete cellulare viene staticamente ripartita in un numero di TA. Una TAL è un concetto dinamico, si tratta di un'entità che viene associata ad ogni singolo nodo mobile in funzione del profilo di attività del nodo stesso
  - **TAU (Tracking Area Update):** vengono inviati per l'aggiornamento della posizione del nodo mobile in caso di cambio di cella che non è all'interno della Tracking Area o della Tracking Area List, oppure se il nodo mobile non si sposta viene inviato periodicamente un messaggio di resfresh per confermare la sua posizione ed il suo stato di attività
  - Lo scopo di questo meccanismo è quello di prevenire due problematiche caratterizzavano le generazioni precedenti, dove il concetto di TAL associata in modo dinamico non esisteva:
    - **Effetto ping-pong:** si verifica quando un nodo si muve ai confini tra due insiemi di celle continue distinti. Se mi rendo conto che il nodo mobile oscilla tra due o poche tracking area adiacenti, lo doto di una TAL formata dall'insieme delle tracking area tra cui sta oscillando
    - **Picco di richieste di aggiornamento:** ripartendo ti nodi in un certo numero di sottoinsiemi ed assegnando ad ogni sottoinsieme una TAL diversa riesco ad abbassare l'altezza del picco delle richieste di aggiornamento
  - **Algoritmo:**
    - L'idea è di usare un meccanismo a stati
    - Se il nodo è spento, non si fa nulla
    - Se il nodo è in stato *Idle*, gli aggiornamenti avvengono solo quando c'è un cambio di routing area o uscita dalla routing area list
    - Se il nodo è in stato *Connected*, gli aggiornamenti della posizione avvengono a livello di cambio di cella
- **Algoritmo di localizzazione:**
  - Pacchetto di richiesta al nodo mobile viene catturato dal PGW
  - Il pacchetto viene inoltrato all'SGW
  - Reindirizzamento verso il nodo mobile che richiederà più o meno sforzo a seconda della precisione con cui la posizione del nodo è nota

#### **Classificazione**

- **Tracciamento:**
  - **Ibrido:** 2G
  - **Adattivo:**
    - Statico, LA/RA: 2.5/3G
    - Dinamico, TAL: >= 4G
- **Portata:**
  - Limitata all'interno di un singolo diminio di rete
- **Livello:**
  - Licello 2
- **Entità coinvolte:**
  - Network based
