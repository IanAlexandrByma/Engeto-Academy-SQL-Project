# Engeto-Academy-SQL-Project
## Repositář obsahující můj projekt o pěti otázkách.

**Otázky:**

**1.Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

**2.Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

**3.Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

**4.Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

**5.Má výška vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?**

**Odpovědi:**

## 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
    
    V horizontu měřených let došlo celkem 30 * k meziročnímu poklesu mzdy.
    Nejvíce případu datujeme do let 2008–2012(finanční krize) primárně v oblasti Těžba a dobývání  
    a oblastí spojené s přímými prodeji. 
    Poté v letech 2019-2020(začátek pandemie koronaviru) v oblasti Ubytování, stravování a pohostinství a Kulturní, zábavní a rekreační 
    činnosti.  
    Nejvyšší pokles 2012 Peněžnictví a pojišťovnictví (8.91 %). 
    Nejnižší pokles 2010 Kulturní, zábavní a rekreační činnosti (0.05 %). 
    Meziroční pokles nikdy nepřesáhl 10 %. Nejvyšší rozdíl je 4 478.5 Kč (2012, Peněžnictví a pojišťovnictví). 

## 1. Kolik je možné si koupit kilogramů chleba a litrů mléka za první a poslední srovnatelné období z dat, které jsou pro tyto údaje k dispozici?

    V roce 2006(první období s kompletními hodnotami) jsme za průměrnou výplatu  
    (20 677.0375 kč) mohli koupit: 
    1282.42 kg Chleba 
    1432.13 l Mléka 
    V roce 2018(poslední období s kompletními hodnotami) jsme za průměrnou výplatu  
    (32 485.0875kč) mohli koupit: 
    1340.24 kg Chleba  
    1639.07 l Mléka 
    Rozdíl je (2006–2018) 
    V roce 2018 jsme mohli za průměrnou výplatu koupit o 57.82 kg Chleba více než v roce 2006. 
    V roce 2018 jsme mohli za průměrnou výplatu koupit o 206.94 l Mléka více než v roce 2006. 

 ## 1. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)? 
 
    Nejnižší průměrný meziroční růst se objevuje u kategorie Cukr Krystalový (-1.92 %) tz. Zlevnil. 
 
 ## 1. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? 
 
    Cena potravin nikdy nevzrostla o deset procent a více nejblíže tomu pak byl rok 2011, 
    kdy ceny vzrostly o 6,73%, 
    a výplata pouze o 2.57%, 
    rozdíl 4.16%. 
    (Nejvyšší nárůst ceny potravin zaznamenal rok 2016(9.63 %), 
    ovšem i platy stouply o 6.84%, 
    tudíž rozdíl pouze 2.79 %). 

 ## 1. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo stejném roce výraznějším růstem?
   
    HDP(gross domestic product) neovlivňuje přímo průměrnou mzdu,
    lze ale říci že se vzrůstající či klesající hodnotou(GDP) roste i
    průměrná mzda ovšem ne úměrně vůči hodnotě GDP.
    Ještě menší má vliv na průměrnou cenu potravin.
    Hodnota ceny potravin do jisté míry hodnotu GDP kopíruje, 
    ale je zde patrný vliv externích(vnějších) faktorů (Poptávka, úroda).
    Nejpatrnější přímý vliv můžeme sledovat hned při prvním sledovaném období(2005-2006):
    GDP(2005,6.77%)
    Avg_Salary_Per_Year(2006,7.23%)
    Avg_Food_Price_Per_Year(2006,6.76%).
    Vliv GDP na obě hodnoty, lze sledovat maximálně v rozmezí dvou let.


## Engeto_Project_SQL

### Online Data Academy, part 1 (SQL).

Ahoj Matěji nebo Honzo.

Repositář obsahuje tyto následující soubory:
     
Soubor Readme.md obsahuje výzkumné otázky a odpovědi k nim + průvodní dopis.

Project: 
t_Ian_Alexandr_Byma_project_SQL_primary_final - obsahuje script pro vytvoření primární tabulky dle zadání:

czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.

czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.

czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.

czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.

czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.

t_Ian_Alexandr_Byma_project_SQL_secondary_final - obsahuje script pro vytvoření sekundární tabulky (tabulka economies):

economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
 
> [!IMPORTANT]
> Veškeré otázky a odpovědi jsou obsaženy jak v kódu Projektu, tak v samostatném Readme.md. (Přemýšlel jsem, jestli mám význam se u otázek více rozepisovat, ale nakonec jsem se rozhodl že jak kód Projektu, tak textový soubor bude obsahovat ty samé výstupy, aby byla odpověď zcela jasná. Pouze jsem někdy doplnil odpověď o podstatné informace nebo pokud byla odpověď ‘FALSE’, uvedl jsem  hodnotu, která byla k splnění limitů nejblíž.
> 
Děkuji za čas, který jste věnovali mému projektu a těším se na Váš názor, v projektu se pravděpodobně objeví i to co se Vám nebude      zas tak líbit, takže samozřejmě budu rád i za kritiku. :-)

   Alex
