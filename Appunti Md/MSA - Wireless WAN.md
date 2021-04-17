# MSA - Wireless WAN

- Infrastruttura inizialmente pensata per supportare unicamente il traffico di tipo vocale in mobilità
- Metodologia di definizione dei percorsi di tipo circui switch, banda dell'ordine delle pochissime decine di Kb per secondo

**2G**
- Strutturazione gerarchica dell'architettura:
  - **MS:** dispositivo mobile
  - **BSS:** può essere visto come l'AP nelle reti WLAN. E' composto da:
    - **BTS:** antenne disperse sul erritorio
    - **BSC:** a cui fanno capo un certo numero di BTS
    - **MSC:** controlli di li alto livello a cui fanno capo i BSC
- Comunicazioni tra stazioni mobili e stazioni base avvengono via wireless. tipicamente le altre comunicazioni avengono via cavo tramite interfaccie definite nello standard
- Organizzazione TDMA in modalità circuit swich. Ogni nodo mobile ch si connette al nodo BTS riceve uno slot temporale che occupa una posizione fissa nel tempo. Il tempo è diviso in 8 slot successivi, un frame complessivamente ha durata di poco più di 4 millisecondi e mezzo. Per raddoppiare la capacità del canale è possibile assegnare un frame si ed uno no, con un leggero peggioramento della qualità
- Oltre alla condivisione del canale rispetto al tempo, si ha la condvisone rispetto allo spazio per consentire il riuso delle stesse frequenze. L'infrastruttura si deve fare carico della necessità di gestire la transizione tra una cella e quella adiacente dell'utente. Guardando la astruttura gerarchica, possiamo avere quattro tipi di spostamento:
  - 1. Nodo mobile passa da una cella ad un'altra adiacente che fa capo allo stesso BTS
  - 2. Nodo mobile passa da una cella ad un'altra adiacente che fa capo ad un BTS diverso ma allo stesso BSC
  - 3. Nodo mobile passa da una cella ad un'altra adiacente che fa capo ad un BTS diverso, ad un BSC diverso ma allo stesso MSC
  - 4. Nodo mobile passa da uuna cella ad un'altra adiacente che fa capo ad un BTS diverso, ad un BSC diverso ed ad un MSC diverso
- Lo scopo dell'hand off è garantire la non interruzione del canale wireless, sfruttadndo il fatto che il segnale wireless si attenua nel cil tempo, per cui nelle zone di onnfire tra duce celle c'è una zona di margine in cui i segnali di entrambi le antenne sono perebilili; all'interno di questa zona c'è il tempo per rilasciare il vecchio canale wirelesss ed agganciarsi alla nuova antenna
- **Problemi:** se voglio usare l'infrastruttura per uno scopo diverso da quello per cui era stata progettata, cioè per la trasmissione dei dati, i tassi di trasmissione garantiti sono relativamente bassi. Il modello economico prevalente era quello di addebitare costi relativi alla durata della comunicazione, poco plausibile per il traffico dati

**2.5G**

- Traffico vocale caratterizzato dalla presenza di tante pause mentre si svolge. Idea è qella di mettere del traffico dati in queste pause. Velocità nominali arrivano alle centinaia di Kb
- Prestazioni minime garantite, in media al meglio, mezzo secondo di latenza
- Oltre ad utilizzare gli slot non utilizzati, per trasmettere dati si può scegliere di riservare in modo permanente alcuni slot per trasmettere traffico dati
- Organizzazione TDMA ma con pacchetti dai nei slot inutilizzati (Circuit switch/Packet switch)
- Dal punto di vista della rete dati generale, una rete cellulare estesa quanto vogliamo viene vista dal punto di vista architetturale come una rete di livello 2, su cui poi si poggia una rete tipicamente IP. (X.25 nella slide era un concorrente di IP)

**3G**

- Idea è supportare bande di un'ordine di grandezza superiore, Mbit per secondo, per soggetti con velocità minore ai 10 km/h
- Evoluzione incrementale rispetto alla versione 2G. Il miglioramento delle prestazioni ha riguardato la parte strettamente wireless e le modalità di gestione del canale
- Si continua a manetere l'idea che redi di questo tipo devono supportare le reti precedenti, ma viene aggiunta una parte innovativa:
  - **Node B:** nuova denominazione per i BTS
  - **RNC:** nuova denominazione per i BSC
- Si passa da una gestione del canale TDMA ad una in cui alla condivisione in tempo si può affiancare anche la condizione in frequenza del canale wireless
- Protocollo GTP utilizzato per far parlare le varie entità in gioco, non solo limitato al core della rete (Circuit switch/Packet switch)

**4G**

- Salto di qualità dal punto di vista della banda e delle latenze
- **eNB:** nuova denominazione per Node B. Si rapporta direttamente al core della rete, è sparito un livello della gerarchia.

