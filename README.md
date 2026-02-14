<h1 align="left">
  <img src="logo.webp" alt="ReVampAscent Logo" width="50" vertical-align="middle">
  ReVampAscent
</h1>


> **Piattaforma e-commerce smart per l'arredamento con integrazione di Intelligenza Artificiale.**

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white)

**ReVampAscent** è una piattaforma web di e-commerce dedicata alla vendita e all’acquisto di articoli di arredamento come **sedie, tavoli, letti, divani, armadi e complementi d’arredo**. 

Il sistema è progettato per offrire una gestione completa del catalogo, degli utenti e degli ordini, integrando funzionalità avanzate di **Intelligenza Artificiale** per l’automazione dell’inserimento degli articoli tramite immagini.

---

## 🎯 Obiettivo del Progetto
L’obiettivo principale è dimostrare l’integrazione di tecniche di **Machine Learning** e **Computer Vision** in un sistema informativo reale, combinando aspetti teorici e pratici.

Il progetto mette in pratica concetti fondamentali quali:
* **Classificazione supervisionata** e **Object Detection**.
* Valutazione delle prestazioni di un modello.
* **Architettura client-server** e separazione dei livelli applicativi.

---

## ✨ Funzionalità Principali

### 👤 Lato Utente (Registrato)
* **Catalogo:** Visualizzazione, filtraggio e consultazione dei prodotti.
* **Shopping:** Aggiunta articoli al carrello e completamento dell'acquisto.

### 🔑 Lato Amministratore
* **Gestione Catalogo:** Inserimento (manuale o automatico), modifica e rimozione articoli.
* **Validazione AI:** Sistema **Human-in-the-loop** per validare le informazioni proposte dal sistema di visione artificiale.

---

## 🧠 Funzionalità di Intelligenza Artificiale

### 1️⃣ Classificazione Automatica di un Oggetto
L'amministratore carica un'immagine con un singolo articolo. Il sistema utilizza un modello di **Machine Learning supervisionato** per suggerire la categoria (es. sedia, letto).
* **Teoria:** Coinvolge estrazione delle caratteristiche e l'uso di una **Confidence Score** per stimare l'affidabilità della predizione.

### 2️⃣ Object Detection Multi-Oggetto (YOLO)
Evoluzione basata su **YOLO (You Only Look Once)** per caricare immagini contenenti più articoli contemporaneamente. Per ogni oggetto rilevato il sistema genera:
* Una **Bounding Box**, una categoria e una **Confidence** associata.
* Un **Ritaglio (crop)** automatico dell'immagine originale per ogni singolo oggetto.
* **Flessibilità:** La soglia di confidence è configurabile per massimizzare il **Recall**.

---

## 🏗️ Architettura del Sistema
Il sistema segue un'architettura a livelli separati:

* **Frontend:** Realizzato in **JSP, HTML, CSS e JavaScript**.
* **Backend Applicativo:** Sviluppato in **Java (Servlet e JDBC)** con pattern **DAO**.
* **Modulo AI:** Implementato come microservizio in **Python (Flask)**. Espone **API REST** e comunica con il backend Java tramite chiamate **HTTP REST**.
* **Persistenza:** Database **MySQL** (memorizza i percorsi) e **Filesystem** (memorizza i file binari delle immagini) per garantire scalabilità.

---

## 📊 Dataset e Valutazione
Il dataset è stato creato e gestito tramite **Roboflow**, suddiviso in **Training, Validation e Test set**. 
Le prestazioni sono state valutate sul **Test Set** utilizzando metriche standard:
* **Precision & Recall**
* **Confusion Matrix**
* **mean Average Precision (mAP)**

---

## 🛠️ Tecnologie Utilizzate

| Settore | Tecnologie |
| :--- | :--- |
| **Backend** | Java, Servlet, JDBC, Apache Tomcat |
| **Frontend** | JSP, HTML5, CSS3, JavaScript |
| **AI** | Python, Flask, Roboflow API, YOLO, Pillow (PIL) |
| **Database** | MySQL |

---

## 📂 Struttura del Repository
* **Codice Java:** Logica di backend e gestione ordini.
* **Pagine JSP:** Risorse e interfaccia frontend.
* **Microservizio Python:** Servizio dedicato alle inferenze AI.
* **Configurazione:** File necessari al deploy del sistema.

---

## 👥 Membri del Team
* Antonio Aliberti
* Raffaella Di Pasquale
* Vincenzo Martucci

---

## 📝 Considerazioni Finali
Il progetto **ReVampAscent** dimostra come l'AI possa essere applicata con successo a scenari reali. L’approccio **human-in-the-loop** garantisce che l'automazione non sacrifichi l'affidabilità del catalogo, permettendo all'amministratore il pieno controllo sui dati inseriti.
