SELECT * 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null 
ORDER BY 3,4

SELECT * 
FROM PortfolioProject..CovidVaccinations
ORDER BY 3, 4 

SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null 
ORDER BY 1,2


-- looking at Total Cases vs Total Deaths (shows likelihood of dying if you contract covid in your country)

SELECT distinct location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
where location like 'poland'
AND continent is not null 
ORDER BY 1,2


-- looking at the Total Cases vs Population (shows what percentage of population got Covid)

SELECT distinct location, date, total_cases, population, (total_cases/population)*100 as GotCovidPercentage
FROM PortfolioProject..CovidDeaths
--where location like 'poland'
WHERE continent is not null 
ORDER BY 1,2


--looking for Countries with highest infection rate compared to population

SELECT distinct location, population, MAX(total_cases)as HighestInfectionCount, MAX(total_cases/population)*100 as GotCovidPercentage
FROM PortfolioProject..CovidDeaths
--where location like 'poland'
WHERE continent is not null 
Group by location, population
ORDER BY GotCovidPercentage desc


-- showing countries with the highest death count per population

SELECT distinct location, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--where location like 'poland'
WHERE continent is not null 
Group by location 
ORDER BY TotalDeathCount desc


-- CONTINENT NUMBERS

-- showing continents with the highest deat count per population

SELECT distinct continent, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--where location like 'poland'
WHERE continent is not null
Group by continent 
ORDER BY TotalDeathCount desc

-- GLOBAL NUMBERS

SELECT  SUM(new_cases) as total_cases , SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage 
FROM PortfolioProject..CovidDeaths
--where location like 'poland'
WHERE continent is not null 
--Group by date
ORDER BY 1,2


--Queries to use in Tableau

-- 1.

SELECT  SUM(new_cases) as total_cases , SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage 
FROM PortfolioProject..CovidDeaths
--where location like 'poland'
WHERE continent is not null 
--Group by date
ORDER BY 1,2


-- 2.

SELECT location, SUM(new_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where continent is null
and location not in ('World', 'European Union', 'International', 'High income', 'Lower middle income', 'Upper middle income', 'Low income')
Group by location
Order by TotalDeathCount desc


-- 3.

Select location, population,  max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
Group by location, population
order by PercentPopulationInfected desc

-- 4.

SELECT location, population, date, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
Group by location, population, date
order by PercentPopulationInfected desc

