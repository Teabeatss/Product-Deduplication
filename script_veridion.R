# Instalarea si incarcarea pachetului arrow, necesar pentru citirea fisierelor de tip .parquet
install.packages("arrow")
install.packages("arrow")
library(arrow)
date <- read_parquet("C:/Users/Tibi/Desktop/date_veridion.parquet")
head(date)

# lapply aplica functia duplicated() pentru fiecare coloana in parte
duplicates_columns <- lapply(date, function(x) {
  sum(duplicated(x))  
})

duplicates_columns

library(dplyr)
# Consolidarea datelor prin grupare pe coloanele esentiale care definesc un produs unic
consolidated_data <- date %>%
  group_by(page_url, product_title, product_identifier, product_summary) %>% # grupare dupa identificatorii unici ai produsului
  summarize(
    # Combinarea valorilor unice din fiecare grup cu separator "; "
    price = paste(unique(price), collapse = "; "),  
    description = paste(unique(description), collapse = "; "),  
    eco_friendly = paste(unique(eco_friendly), collapse = "; "),  
    ethical_and_sustainability_practices = paste(unique(ethical_and_sustainability_practices), collapse = "; "),  
    production_capacity = paste(unique(production_capacity), collapse = "; "),  
    materials = paste(unique(materials), collapse = "; "),  
    ingredients = paste(unique(ingredients), collapse = "; "),  
    manufacturing_countries = paste(unique(manufacturing_countries), collapse = "; "),
    
    # Selectarea primei valori din grup pentru campuri care nu au multiple variante
    
    manufacturing_year = first(manufacturing_year),  
    manufacturing_type = first(manufacturing_type),  
    customization = paste(unique(customization), collapse = "; "), 
    
    # verificam daca exista valori nenule in grup, daca da, luam prima valoare, altfel returnam NA
    
    packaging_type = ifelse(any(!is.na(packaging_type)), first(packaging_type), NA),  
    form = ifelse(any(!is.na(form)), first(form), NA),  
    size = ifelse(any(!is.na(size)), first(size), NA),
    
    #Daca valorile nu sunt toate NA, le concatenam pe cele unice, altfel returnam NA
    
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
    
    # Eliminam gruparea pentru ca rezultatul sa fie un data frame obisnuit
    
    .groups = "drop"  
  )

head(consolidated_data)
