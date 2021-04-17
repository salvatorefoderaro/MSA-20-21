# MSA - Wireless Communication

**Infrastruttura**

- Rete con infrastruttura
  - E' richiesta la presenza di Access Point oltre agli host. La comunicazione è tra gli host e l'AP, non c'è comunicazione diretta tra gli host. I singoli AP possono essere collegati ad altre reti
  - Le funzionalità sono centralizzate nell'AP
  - Non è presente il problema del *terminale nascosto*
  - La gestione è semplificata, ma si ha meno flessibilità, per esempio per un deploy rapido
- Rete senza infrastruttura
  - Non è richiesta la presenza di AP, ma sono necessari meccanismi per risolvere il problema del *terminale nascosto*
  - La comunicazione avviene direttamente tramite host, ed ognuno deve implementare il protocollo MAC e maccanismi per risolvere il problema del *terminale nascosto e sovraesposto*
  - Il design risulta più complesso
  - Il deployment è molto più flessibile rispetto al caso precedente
  - **NB:** una rete del genere non per forza è una rete mobile

**Multiplexing**

La banda wireless è limitata e deve essere condivisa. In che modo posso effettuare la condivisione?

- **FDM (Frequency Division Multiplexing)**
  - Lo spettro di frequenze viene diviso in bande di frequenza più piccole. Ottengo sicuramente meno banda, però posso utilizzarla per tutto quanto il tempo che voglio
  - Non è richiesto nessun tipo di coordinamento dinamico, in quanto l'assegnamento avviene in modo statico
  - Si tratta però di un soluzione non flessibile, oltre ad avere uno spreco di banda quando una certa porzione risulta non utilizzata
- **TDM (Time Division Multiplexing):**
  - L'intero spettro di frequenza viene assegnato per un tempo preciso. Ottengo tutta la banda a disposizione, ma posso utilizzarla solamente per un tempo predefinito
  - Lo svantaggio è che è richiesta una sincronizzazione molto precisa tra le varie entità che condividono il canale
- **TFDM (Time and Frequency Multiplex):**
  - Si tratta di una combinazione dei due metodi visti in precedenza. Un entità riceve una certa frequenza di banda per un determinato tempo prestabilito
  - Il sistema offre un grado maggiore di sicurezza in quanto per esempio, ad ogni assegnazione è possibile dare all'entità una frequenza differente, in modo da offrire protezione contro intercettazioni su una singola frequenza
  - Il sistema è stato utilizzato per la tecnologia GSM
  - Come prima per il TDM, è richiesta una coordinazione molto precisa, in questo caso tramite un controller centralizzato
- **CDM (Code Division Multiplex):**
  - Ogni entità utilizza l'intero canale per tutto quanto il tempo, ma possiede un codice unico
  - Ogni trasmettitore modula il proprio segnale con un codice ortogonale a quello delle altre emtità. In questo modo chi riceve il segnale, conoscendo il codice, può estrarre solamente la parte di segnale di sua competenza
  - Di contro ho la necessità di avere una più complessa ricezione del segnale, oltre ad uno spreco di banda in quanto il codice che trasmetto è comunque informazione non utile per il ricevitore finale
- **SDM (Space Division Multiplexing):**
  - Tecnica che viene usata in congiunzione alle tre viste prima
  - Partiziono lo spazio in regioni, assegnando ad ogni regione adiacente una frequenza differente
  - Se modulo la potenza del segnale emesso e distanzio in modo appropriato le stazioni che utilizzano la stessa frequenza, posso effettuare più comunicazioni in contemporanea senza avere interferenze, potendo in questo modo supportare un numero maggiore di utenti
  - Un'approssimazione della realtà può essere fatta con delle celle esagonali. L'assegnamento delle frequenze può esssere fatto in modo statico o dinamico, potendo in questo ultimo modo offrire una capacità maggiore alle celle con il maggior carico
  - Muovendomi osservo che la qualità del segnale si attenua da una parte e migliora dall'altra, c'è una zona di confine in cui riesco a percepire entrambi i segnali e posso effettuare il passaggio senza che la connessione crolli. L'ampiezza temporale della zona di confine dipende dalla velocità di spostamento e della potenza del segnale, dunque nella progettazzione delle reti bisogna trovare un compromesso adeguato tra la velocità che si intende supportare e la potenza del segnale

**Multiplexing - Protocolli**

- **Protocolli statici:**
  - La divisione della banda viene effettuata secondo le tecniche FDM/TDM/CDM (e SDM)
  - E' richiesta un'infrastruttura ed un coordinamento centralizzato
  - Non ho collisioni e non ho traffico di controllo che va a ridurre la banda disponibile, ma c'è la concreta possibilità di avere della banda non utilizzata in quanto assegno una porzione di banda ad un potenziale utilizzatore, che però può anche essere inattivo
- **Protocolli randomici:**
  - Non è necessariamente richiesta un'infrastruttura ed offre semplicità per quanto riguarda la progettazione
  - **CSMA/CA (MACA):**
    - Ho collisioni, non ho banda utilizzata e non ho traffico di controllo, anche se i messaggi RTS e CTS del protocollo MACA introducono dell'overhead, anche se tracurabile per pacchetti di grani dimensioni
    - Protocollo basato su contesa che risolve il problema del terminale nascosto ed esposto senza l'utilizzo di un Access Point (TDM)
    - Se sento il canale libero aspetto un certo tempo casuale. Chi tra tutti estrae il valore minore può proseguire con la trasmissione
    - Il mittente invia un messaggio *RTS (Request to send)* al mittente, con informazioni su mittente, destinatario e durata della trasmissione, che viene ascoltato da tutti sul canale
    - Il destinatario risponde con un messaggio *CS (Clear to send)* al mittente, con le stesse informazioni dell'RTS ricevuto, che viene ascoltato da tutti sul canale
    - **Problema terminale nascosto:**
      - A e C vogliono trasmettere a B, ma nessuno dei due riesce a rendersi conto che il canale è occupato dall'altro
      - A invia RTS a B, che non viene ricevuto da C. Ma quando A risponde con CTS, questo viene ascoltato anche da C e quindi quest'ultimo attenderà prima di trasmettere un tempo almeno pari alla durata della trasmissione indicata nel messaggio CTS ricevuto
      - **NB:** il problema può essere presente nelle reti con infrastruttura solamente se due nodi che stanno diametralmente opposti rispetto all'AP trasmettono in contemporanea
    - **Problema terminale esposto:**
      - B vuole trasmettere ad A. La trasmissione viene ascoltata da C, ma C vuole trasmettere ad un altro nodo, quindi potrebbe farlo senza dare problemi all'altra comunicazione
      - B invia RTS ad A, che viene ricevuto anche da C. A risponde con CTS, ma non essendo ricevuto da C, quest'ultimo nodo sa di poter trasmettere ad un altro nodo qualsiasi
      - **NB:** il problema non è presente nelle reti con infrastruttura
    - Viene utilizzato in modo pozionale per il protocollo 802.11, solamente se la dimensione dei pacchetti è superiore ad una certa soglia. Altrimenti l'overhead introdotto dai due messaggi non sarebbe più trascurabile
- **Protocolli basati su meccanismi di prenotazione:**
  - Nelle reti con infrastruttura abbiamo un access point che raccoglio le richieste dei permessi di trasmettere e poi, segunendo la sua politica, emette uno ad uno ai vari richiedenti i permessi di trasmissione
  - Nelle reti senza infrastruttura è necessario un protocollo di elezione del master, in quanto di base la rete è P2P. Questo è l'esempio per 