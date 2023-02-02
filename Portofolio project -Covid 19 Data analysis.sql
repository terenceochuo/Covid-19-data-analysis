select *
from Portfolio_project..CovidDeaths
order  by 3,4

--select *
--from Portfolio_project..CovidVaccinations
--order  by 3,4

--Select Data that we are going to be using
select location,date,total_cases,new_cases,total_deaths,population
from Portfolio_project..CovidDeaths
order  by 1,2

--Looking at Total Cases vs Total Deaths
---Shows likelihood ofdying if you contract covid in your country
Select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from Portfolio_project..CovidDeaths
where location like '%states%'
order by 1,2

--- Loooking at Total Cases vs Population
---Shows what percentage of population got Covid

Select location,date,total_cases,population,(total_cases/population)*100 as CasesPercentage
from Portfolio_project..CovidDeaths
where location like '%states%'
order by 1,2

---Looking at Countries with Highest Infection Rate compared to Population

Select location,population,MAX(total_cases) AS HighestInfectionCount,MAX(total_cases/population)*100 as PercentagePopulationInfected
from Portfolio_project..CovidDeaths
---where location like '%states%'
Group by location,population
order by PercentagePopulationInfected desc

---Showing Countries with Highest Death Count per Population

Select location,MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolio_project..CovidDeaths
---where location like '%states%'
where continent is  null
Group by location
order by TotalDeathCount desc

---Let's Break Things down by continent
---showing the continent with the highest death count per population

Select continent,MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolio_project..CovidDeaths
---where location like '%states%'
where continent is not null
Group by continent
order by TotalDeathCount desc

---Global numbers
select SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Portfolio_project..CovidDeaths
where continent is not null
order by 1,2

--- Looking at Total Population Vs Vaccinations
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
from Portfolio_project..CovidDeaths dea
join Portfolio_project..CovidVaccinations vac
on dea.location  = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3
