install.packages("arrow")
library(arrow)
#Am importat fifiserul parquet ce a fost pus la dispozitie cu ajutorul unei cai, punandu-l intr-un data-frame.
date <- read_parquet("C:/Users/Tibi/Desktop/date_veridion.parquet")
#Am afisat primele linii ale data-frameului pentru a vedea structura acestuia si daca l-am importat corect.
head(date)

# Primul pas a fost sa verific cate duplicate se afla in data-set pentru fiecare coloana a acestuia.
#Am utilizat functia duplicated si lapply, care trece prin fiecare coloana si returneaza numarul de duplicate.
duplicates_columns <- lapply(date, function(x) {
  sum(duplicated(x))  
})

#Urmand sa afisez aceste duplicate pentru a vedea situatia si cum va trebui sa o tratez.
duplicates_columns

#Am incacarcat pachetul util pentru manipularea si procesoarea datelor. Acesta contine functii de grupare,
#selectie, filtrare si sumarizare a datelor, functii de care m-am folosit pentru a rezolva provlema.




library(dplyr)

#Pentru consolidarea datelor, adica pentru obiectivul nostru final, am ales sa grupez datele in functie de anumite
#coloane, acele coloane pentru nu pot exista doua observatii la fel, adica fiecare rand al data-frame ului trebuie 
#sa fie unic. Url-ul paginii, titlul produsului, identificatorul si scurta descriere sunt cele mai relevante din acest
#punct de vedere al unicitatii.
#După gruparea datelor, putem aplica functia summarize pentru a combina informatiile din fiecare grup
#Functia paste combina valorile intr-un singur sir de carctere, iar unique se asigura ca valorile de tip
#duplicat sunt eliminate inainte de a le combina.

#Valorile de tip NA au fost gestionate diferit, cu ajutoru functiei ifelse am verificat daca o coloana contine valori
#de acest tip. Dacă exista valori valide, pastram prima valoare din grup cu first. Daca nu exista nici o valoare valida
#(adică toate sunt NA), vom pastra NA.
#Daca un produs are mai multe intrari pentru aceeasi coloana, vom pastra doar prima valoare din fiecare grup(first)
#In final cu drop am eliminat gruparea, pentru ca data-frameul sa fie de tipul celui importat si sa nu contina grupuri.

consolidated_data <- date %>%
  group_by(page_url, product_title, product_identifier, product_summary) %>%
  summarize(
    price = paste(unique(price), collapse = "; "),  
    description = paste(unique(description), collapse = "; "),  
    eco_friendly = paste(unique(eco_friendly), collapse = "; "),  
    ethical_and_sustainability_practices = paste(unique(ethical_and_sustainability_practices), collapse = "; "),  
    production_capacity = paste(unique(production_capacity), collapse = "; "),  
    materials = paste(unique(materials), collapse = "; "),  
    ingredients = paste(unique(ingredients), collapse = "; "),  
    manufacturing_countries = paste(unique(manufacturing_countries), collapse = "; "),  
    manufacturing_year = first(manufacturing_year),  
    manufacturing_type = first(manufacturing_type),  
    customization = paste(unique(customization), collapse = "; "),  
    packaging_type = ifelse(any(!is.na(packaging_type)), first(packaging_type), NA),  
    form = ifelse(any(!is.na(form)), first(form), NA),  
    size = ifelse(any(!is.na(size)), first(size), NA),
    color = ifelse(any(!is.na(color)), paste(unique(color), collapse = "; "), NA),  
    purity = paste(unique(purity), collapse = "; "), 
    energy_efficiency_exact_percentage = paste(unique(energy_efficiency$exact_percentage), collapse = "; "),  
    energy_efficiency_max_percentage = paste(unique(energy_efficiency$max_percentage), collapse = "; "),  
    energy_efficiency_min_percentage = paste(unique(energy_efficiency$min_percentage), collapse = "; "),  
    energy_efficiency_qualitative = paste(unique(energy_efficiency$qualitative), collapse = "; "),  
    energy_efficiency_standard_label = paste(unique(energy_efficiency$standard_label), collapse = "; "),  
    pressure_rating = paste(unique(pressure_rating), collapse = "; "),  
    power_rating = paste(unique(power_rating), collapse = "; "),  
    quality_standards_and_certifications = paste(unique(quality_standards_and_certifications), collapse = "; "),  
    miscellaneous_features = paste(unique(miscellaneous_features), collapse = "; "),  
    .groups = "drop"  
  )


#Tot cu ajutorul functiei head, datele finale au fost verificate pentru a verifica erorile
head(consolidated_data)
