/*SELECT date,SUM(total_cases), SUM(new_cases), SUM(new_deaths), (SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE new_cases <> 0 AND new_deaths<> 0
GROUP BY date
ORDER BY date*/

--looking at total population vs vaccination

/*SELECT  cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
SUM(CAST(new_vaccinations AS BIGINT)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths AS cd
JOIN PortfolioProject..CovidVaccinations AS cv
	ON cd.location = cv.location
	and cd.date = cv.date
WHERE cd.continent IS NOT NULL 
ORDER BY 1,2*/

--creating a #temptable

DROP TABLE IF EXISTS #temptable
CREATE TABLE #temptable
(
continent nvarchar(225),
location nvarchar(225),
Date datetime,
population numeric,
new_vacc numeric,
Rollingpeoplevaccinated numeric
)

INSERT INTO #temptable 

SELECT cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
SUM(CAST(new_vaccinations AS BIGINT)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths AS cd
JOIN PortfolioProject..CovidVaccinations AS cv
	ON cd.location = cv.location
	and cd.date = cv.date
--WHERE cd.continent IS NOT NULL 


SELECT*, (Rollingpeoplevaccinated/population)*100
FROM #temptable
WHERE continent LIKE 'Europe'
ORDER BY 1,2


--create view to store data for later visualizations 

CREATE VIEW temptable AS
SELECT cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
SUM(CAST(new_vaccinations AS BIGINT)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths AS cd
JOIN PortfolioProject..CovidVaccinations AS cv
	ON cd.location = cv.location
	and cd.date = cv.date
WHERE cd.continent IS NOT NULL 

SELECT*
FROM temptable



