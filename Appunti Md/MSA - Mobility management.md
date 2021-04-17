# MSA - Mobility management

- **Mobilità dei terminali:** mobilità di un dispositivo di calcolo e comunicazione, che per le sue caratteristiche fisiche intrinseche può essere agevolmente cambiato di posizione. La mobilità di questo oggetto crea problemi che andranno risolti
- **Mobilità personale:** non implica la mobilità dei terminali che portiamo fissi con noi. Sono scenari in cui, dato che una persona può trovarsi in vari posti durante la giornata, come riuscire a fare arrivare una comunicazione in ogni caso a questa persona, a prescindere dal fatto che porti continuamente con se un dispositivo che faccia da terminale per questa comunicazione
- **Mobilità di sessione:** problematiche relative al mantenimento di una sessione in corso, come streaming video, che ad un istante di tempo ha come endopoint un certo dispositivo, e come conseguenza di una delle due mobilità precedenti, si vuole garantire la persistenza di questa sessione ache nel caso del cambiamento di posizione dell'entità su cui questa sessione si poggia
- **Mobilità dei servizi:** si intende l'offrire ad un essere umano, nonostante i suoi cambi di posizione dovuti alla mobilità, la possibilità di trovare ovunque vada un ambiente sempre uniforme e familiare sui diritti di accesso, profili d'uso, costi da pagare ecc.

**Mobilità dei terminali**

- **Continutià della sessione:** se un terminale è coinvolto in una iterazione in corso, come garantire il mantemnimento della continuiyà della sessione nonostante la mobilità del terminale
- **Raggiungibilità del terminale:** come avviare una sessione indirizzata ad un terminale la cui posizione non è fissa nel tempo

**Mobilità a livello 2**

- Mobilità può essere gistaita a vari livelli. Livello 2 permette una gestione entro certi limiti, come visto per il protocollo 802.11
- Tutti gli handoff possono essere gestiti a livello 2 in modo semplice
  - In caso di transizione tra reti omogenee, la decisione su quando e come effettuare l'handoff è basata solo su considerazioni relative alla qualità del segnale percepito
  - In caso di transizione tra reti omogenee, la decisione se effettuare l'handoff può non essere solamente guidata da considerazioni sulla qualità, ma anche su aspetti come il risparmio energetico, il costo monetario e la sicurezza. Queste informazioni di cui tenere conto possono corrispondere al rilevamento di elementi particolari o dal valore che assumono determinati parametri

**Raggiungibilità dei nodi**

- Schema classificatorio in cui tutte le soluzioni che esploreremo possono essere viste come punti all'interno di uno spazio multidimensionale
- **Tracciamento della posizione di un terminale:** modalità con cui si può tenere traccia della posizione di un terminale e mantenere aggiornata l'informazione
  - **Approccio proattivo:** infrastruttura dedicata al problema della raggiungibilità è sempre impegnata a mantenere aggiornata l'informazione sulla posizione attuaale del nodo, a prescindere dall'esistenza o meno di una richiesta di localizzare quel nodo
    - *Vantaggi:* riduzione della latenza tra il nascere dell'esigenza comunicativa e la capacità di soddisfare quest'esigenza
    - *Svantaggi:* rischio di overhead eccessivo delle risorse impegnate nel sistema, considerando che alcune informazioni potrebbero essere inutili se dei nodi sono raramente contattati
    - E' una soluzione che in alcuni casi si riene vataggioso adottare
  - **Approccio reattivo:** non viene mantenuta nessuna informazione sulla posizione dei nodi. Il sistema reagisce alle richieste di localizzazione
    - *Svantaggi:* aumento della latenza e del ritardo nel rintracciare i nodi. Potenziale problemi della scalabilità, dovendo inondare la rete di messaggi, nel caso in cui non si agisce in modo intelligente
    - *Vantaggi:* risparmio notevole se approccio usato in modo corretto
  - **Approccio ibrido:** si utilizza un approccio pro attivo, ma con un livello di precisione della posizione ridotto ad un'intera regione. Aggiorno la posizione quando il nodo valica i confini della regione e passa ad una adiacente
    - Informazione sulla posizione aggiornata più raramente, dunque meno informazione che circola sulla rete ed un costo più basso
    - Quando qualcuno vorrà parlare con quel nodo, reagisco e mi occupo di localizzarlo in modo esatto all'interno della regione
    - L'ibridazione tra parte proattiva e reattiva può essere sia statica che dinamica. Nel secondo caso, la linea di confine tra i due approcci varia a seconda delle esigenze che si vanno a creare
- **Ampiezza del movimento del nodo:** quando parliamo di ampliezza ci interessiamo della dimensione  di ret di questi spostamenti. La distanza di rete è il numero di hop tra i router a cui afferiscono i singoli nodi mobili. A distanze fisiche piccole possono corrispondere distanze di rete molto amplie
  - **Micromobilità:** mobilità all'interno della stessa sottorete
  - **Macromobilità:** mobilità all'interno dello stesso dominio
  - **Mobilità globale:** mobilità all'interno di più domini differenti
- **Livello della pila protocollare:** le possibili soluzioni sono sotto il livello di rete, al livello di rete oppure ad un livello superiore
  - **Soluzioni sotto il livello di rete:** sono soluzioni all'interno di una rete di livello 2 omogenea, come la rete cellulare che abbiamo già visto. Si tratta di una singola entità omogenea che al suo interno può offrire una sua soluzione locale dedicata a risolvere il problema della mobilità all'interno di quella specifica rete
  - **Livello di rete** è il punto di unficazione della varietà di componenti che abbiamo sotto e sopra. Il vantaggio è di essere la soluzone unica, però soluzioni a livello di rete non riescono a cogliere alcune specificità dei livelli superiori, prendendo alla cieca decisioni rispetto alle esigenze particolari di sessioni in corso gestite da protocolli di livello superiore, portanando ad inefficienze che sarebbe meglio evitare. Altro problema è che soluzioni prese a questo livello possono causare inefficienze nell'instradamento complessivo dei pacchetti
  - **Soluzioni a livello superiore:** non si collocano unicamente a questo livello e necessitano un supporto dei livelli sottostanti. Sono soluzioni che riscono a tenere conto delle specifiche esigenze che vendono dal livello applicativo, relative ad una specifica modalit di interazione, però queste soluzioni cominciano ad essere ritagliate per uno specifico protocollo di trasporto e non sono universali. Possibile problema di sicurezza anche, in quanto aumentando quante più cose metto in campo, aumento i punti attraverso cui si può intromettere un tentativo di compromissione dell'integrità del sistema
- **Livello di coinvolgimento delle entità in gioco:** da un lato i nodi che si muovono e dall'altra l'infrastruttura eventualmente presente. 
  - **Soluzione completamente decentralizzata:** gli attori in gioco sono i nodi mobili, i punti terminali dell'interazione
    - Seguono una filosofia *end-to-end intelligence*, ciò che c'è in mezzo deve essere neutrale rispetto a ciò che avviene alle due estremità, e la risoluzione dei problemi è affidata ai due estremi, ad esempio la filosofia del protocollo TCP
    - Come approccio può avere i suoi vantaggi, però chiaramente richiede un coinvolgimento diretto dei nodi, che loro siano consapevoli di questo, e che su ogni nodo obile sia installata la logica applicativa di controllo per implementarel a soluzione scelta
  - **Soluzione con rete attor eprincipale:** l'infrastruttura entra in gioco e non è neutrale
    - Seguono una filosofia *network intelligence*
    - Il vantaggio è che i nodi terminali vengono allegeriti da gran parte delle responsabilità. Posson essere totalmente incosapevoli delle azioni che vengono intraprese, non richiedendo modifiche del loro stack protocollare
- **802.11:** soluzione di tipo proattivo, realizzata dal meccanismo di associazione e riassociazione tramite segnali di beacon. Dal punto di vista della portata, situazione di micromobilità, soluzione limitata al singolo ESS. Dal punto di vista del livello della pila protocollare siamo a livello 2, sotto il livello di rete. Gestione della soluzione data da una cooperazione forte tra l'infrastruttura ed il nodo stesso