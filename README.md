--SOLUTIA LOGICA--

Pentru inceput, am instalat si incarcat pachetul necesar pentru fisierele de tip Parquet, normal folosit pentru dataseturi de dimensiuni mari, cum este si acesta cu care vom lucra.

Am importat fisierul Parquet care a fost pus la dispozitie cu ajutorul unei cai, punandu-l intr-un data frame. Am afisat primele linii ale data frame-ului pentru a vedea structura acestuia si daca l-am importat corect.

Primul pas a fost sa verific cate duplicate se afla in dataset pentru fiecare coloana a acestuia. Am utilizat functia duplicated si lapply, care trece prin fiecare coloana si returneaza numarul de duplicate. Am afisat aceste duplicate pentru a vedea situatia si cum va trebui sa o tratez.

Am incarcat pachetul util pentru manipularea si procesarea datelor. Acesta contine functii de grupare, selectie, filtrare si sumarizare a datelor, functii de care m-am folosit pentru a rezolva problema.

Pentru consolidarea datelor, adica pentru obiectivul nostru final, am ales sa grupez datele in functie de anumite coloane, acele coloane pentru care nu pot exista doua observatii la fel, adica fiecare rand al data frame-ului trebuie sa fie unic. URL-ul paginii, titlul produsului, identificatorul si scurta descriere sunt cele mai relevante din acest punct de vedere al unicitatii.

Dupa gruparea datelor, am aplicat functia summarize pentru a combina informatiile din fiecare grup. Functia paste combina valorile intr-un singur sir de caractere, iar unique se asigura ca valorile de tip duplicat sunt eliminate inainte de a le combina.

Valorile de tip NA au fost gestionate diferit. Cu ajutorul functiei ifelse, am verificat daca o coloana contine valori de acest tip. Daca exista valori valide, pastram prima valoare din grup cu first. Daca nu exista nicio valoare valida (adica toate sunt NA), vom pastra NA.

Daca un produs are mai multe intrari pentru aceeasi coloana, vom pastra doar prima valoare din fiecare grup (first). In final, cu ungroup am eliminat gruparea, pentru ca data frame-ul sa fie de tipul celui importat si sa nu contina grupuri.

Tot cu ajutorul functiei head, datele finale au fost verificate pentru a identifica eventualele erori. 


--OBSERVATII--



Formatul Parquet este eficient pentru stocarea si procesarea dataseturilor mari, fiind optimizat pentru citire rapida si dimensiune redusa. In acest proiect, acest format a fost esential pentru manipularea unui volum mare de date fara incarcarea excesiva a memoriei.

Detectarea valorilor duplicate  a fost realizata individual pentru fiecare coloana, pentru a evidentia unde apar suprapuneri de informatii. Nu s-au eliminat randuri duplicate complet, ci s-au consolidat doar valorile relevante din grupuri.

Gruparea pe coloane cheie (page_url, product_title, product_identifier, product_summary) a fost aleasa pentru a defini unice identitati de produs. Alegerea acestor coloane este esentiala pentru evitarea agregarii eronate.

Campurile cu valori lipsa (NA) au fost tratate cu grija, evitand inlocuirea lor cu valori eronate. Daca macar o valoare valida a fost gasita in grup, aceasta a fost pastrata Saltfel, s-a mentinut valoarea NA.

Coloanele de tip structurat , precum energy_efficiency, au fost prelucrate accesand subcampurile prin `$`. Acest lucru presupune ca datele au fost structurate ca liste sau tabele imbricate in cadrul coloanei. 

Agregarea folosind first s-a aplicat in special campurilor care nu aveau variatii semnificative in cadrul grupului sau unde doar o valoare este necesara pentru analiza ulterioara.



