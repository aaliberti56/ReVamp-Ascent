ReVampAscent è una piattaforma web di e-commerce dedicata alla vendita e all’acquisto di articoli di arredamento come sedie, tavoli, letti, divani, armadi e complementi d’arredo.
Il sistema è stato progettato per offrire una gestione completa del catalogo prodotti, degli utenti e degli ordini, integrando funzionalità avanzate di Intelligenza Artificiale per l’automazione dell’inserimento degli articoli tramite immagini.

L’obiettivo principale del progetto è dimostrare come le tecniche di Machine Learning e Computer Vision possano essere integrate in un sistema informativo reale, combinando aspetti teorici e pratici trattati durante il corso.

Obiettivo del Progetto

L’obiettivo del progetto è realizzare un’applicazione web completa che permetta:

la consultazione di un catalogo di prodotti di arredamento;

la gestione degli acquisti da parte degli utenti;

l’amministrazione del catalogo da parte di un utente amministratore;

l’integrazione di funzionalità di Intelligenza Artificiale per il riconoscimento automatico degli articoli a partire da immagini.

Il progetto mette in pratica concetti fondamentali quali:

classificazione supervisionata;

object detection;

valutazione delle prestazioni di un modello;

architettura client-server;

separazione dei livelli applicativi.

Funzionalità Principali del Sito

Il sito consente agli utenti registrati di:

visualizzare il catalogo degli articoli;

filtrare e consultare i prodotti;

aggiungere articoli al carrello;

completare un acquisto.

L’amministratore del sistema può:

inserire articoli manualmente;

inserire articoli automaticamente tramite immagini;

modificare e rimuovere articoli esistenti;

validare le informazioni proposte dal sistema AI.

Funzionalità di Intelligenza Artificiale

Nel progetto sono state implementate due funzionalità basate su Intelligenza Artificiale.

Prima Funzionalità – Classificazione Automatica di un Oggetto

La prima funzionalità permette all’amministratore di caricare un’immagine contenente un singolo articolo di arredamento.
Il sistema utilizza un modello di Machine Learning supervisionato per classificare l’oggetto e suggerire automaticamente la categoria di appartenenza (ad esempio: sedia, letto, tavolo).

Dal punto di vista teorico, questa funzionalità coinvolge:

problemi di classificazione;

apprendimento supervisionato;

estrazione delle caratteristiche;

utilizzo di una confidence score per stimare l’affidabilità della predizione.

Il risultato della classificazione non è vincolante: l’amministratore può confermare o modificare manualmente la categoria proposta.

Seconda Funzionalità – Object Detection Multi-Oggetto (YOLO)

La seconda funzionalità rappresenta l’evoluzione della prima ed è basata sull’Object Detection.
Il sistema permette di caricare un’immagine contenente più articoli di arredamento contemporaneamente. Il modello AI individua automaticamente tutti gli oggetti presenti nell’immagine, generando per ciascuno:

una bounding box;

una categoria;

una confidence associata;

un ritaglio (crop) dell’immagine originale.

Ogni oggetto individuato viene trattato come un articolo indipendente e mostrato all’amministratore, che può modificarne i dati prima dell’inserimento definitivo nel database.

Dal punto di vista teorico, questa funzionalità coinvolge:

Object Detection;

localizzazione e classificazione simultanea;

bounding box;

confidence threshold;

precision e recall;

mean Average Precision (mAP);

compromesso tra falsi positivi e falsi negativi;

approccio human-in-the-loop.

La soglia di confidence è configurabile per aumentare il recall, accettando predizioni meno sicure che vengono successivamente validate manualmente.

Architettura del Sistema

Il sistema è strutturato secondo un’architettura a livelli.

Il frontend è realizzato utilizzando JSP, HTML, CSS e JavaScript, ed è responsabile dell’interazione con l’utente e della visualizzazione dei dati.

Il backend applicativo è sviluppato in Java utilizzando Servlet e JDBC, con adozione del pattern DAO per l’accesso ai dati e la gestione della persistenza su database relazionale.

Il modulo di Intelligenza Artificiale è implementato come microservizio separato in Python tramite Flask. Questo servizio espone API REST che ricevono immagini, invocano il modello YOLO addestrato e restituiscono i risultati in formato JSON.

La comunicazione tra backend Java e servizio AI avviene tramite chiamate HTTP REST.

Gestione delle Immagini e Persistenza

Le immagini degli articoli vengono salvate in modo persistente nel filesystem del server, all’interno di una cartella dedicata.
Nel database viene memorizzato esclusivamente il percorso dell’immagine, evitando il salvataggio diretto dei file binari nel database e migliorando le prestazioni e la scalabilità del sistema.

Dataset e Addestramento del Modello

Il dataset utilizzato per l’addestramento del modello di Object Detection è stato creato e gestito tramite Roboflow.
Il dataset è stato suddiviso in:

training set;

validation set;

test set.

Il modello è stato addestrato utilizzando immagini annotate manualmente, ed è stato possibile estendere il dataset aggiungendo nuove immagini e riaddestrando il modello.

Valutazione delle Prestazioni

Le prestazioni del modello sono state valutate utilizzando:

Precision;

Recall;

Confusion Matrix;

mean Average Precision (mAP).

Le metriche sono state calcolate sul test set, mai utilizzato durante la fase di addestramento, garantendo una valutazione corretta delle prestazioni del modello.

Tecnologie Utilizzate

Backend:

Java

Servlet

JDBC

Apache Tomcat

Frontend:

JSP

HTML5

CSS3

JavaScript

Intelligenza Artificiale:

Python

Flask

Roboflow API

YOLO

Pillow (PIL)

Database:

MySQL

Struttura del Repository

Il repository GitHub contiene:

il codice sorgente Java del backend;

le pagine JSP e le risorse frontend;

il microservizio Python per l’Intelligenza Artificiale;

i file di configurazione;

il presente file README con la descrizione completa del progetto.
