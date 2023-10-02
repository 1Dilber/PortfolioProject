--SELECT *
--FROM PortfolioProject..DeathNumber
--ORDER BY 1, 3

--SELECT *
--FROM PortfolioProject..Vaccinations
--ORDER BY 1,3


--Comparison between Death by Alcohol and Drug use in Azerbaijan / How many times more?

SELECT Entity,Year, [Deaths that are from all causes attributed to alcohol use, in bo] as DeathByAlcohol,[Deaths that are from all causes attributed to drug use, in both ] as DeathByDrug, ([Deaths that are from all causes attributed to alcohol use, in bo]/[Deaths that are from all causes attributed to drug use, in both ]) as Times
from PortfolioProject..DeathNumber
where Entity LIKE 'Azerbaijan' 
order by 1, 2

--Countries with Highest Death number based on unsafe sanitation

SELECT Entity, MAX(cast([Deaths that are from all causes attributed to unsafe sanitation,] as int)) as HighestDeathBySanitation
from PortfolioProject..DeathNumber
GROUP BY Entity 
Order by HighestDeathBySanitation desc


-- Death by eating low fruit in 2019

SELECT Entity, Year, cast([Deaths that are from all causes attributed to diet low in fruits] as int) as DeathNumberByEatingLowFruit
from PortfolioProject..DeathNumber
WHERE Year = '2019'
order by DeathNumberByEatingLowFruit desc


--Global Numbers

Select Year, SUM(cast([Deaths that are from all causes attributed to child stunting, in] as int)) AS DeathNumberByTheChildStunting
FROM PortfolioProject..DeathNumber
Group by Year
Order by 1


--Child Death and Vaccination

SELECT D.Entity, D.Year, CONVERT (INT,[Deaths that are from all causes attributed to child stunting, in] ),   V.Entity, V.Year,[HepB3 (% of one-year-olds immunized)], SUM(CONVERT(int,[Deaths that are from all causes attributed to child stunting, in]))OVER (PARTITION BY D.Entity Order by D.Entity) as ChildDeath
FROM PortfolioProject..DeathNumber D
JOIN PortfolioProject..Vaccinations V
	ON D.Entity = V.Entity
	and D.Year = V.Year
Order by 1,2



--CTE

WITH StayVaccinated (Entity, Year,ChildDeath, [HepB3 (% of one-year-olds immunized)], TotalChildDeath)
as
(
SELECT D.Entity, D.Year, CONVERT (INT,[Deaths that are from all causes attributed to child stunting, in] ) AS ChildDeath, [HepB3 (% of one-year-olds immunized)] , SUM(CONVERT(int,[Deaths that are from all causes attributed to child stunting, in]))OVER (PARTITION BY D.Entity Order by D.Entity) as TotalChildDeath
FROM PortfolioProject..DeathNumber D
JOIN PortfolioProject..Vaccinations V
	ON D.Entity = V.Entity
	and D.Year = V.Year
)
SELECT*
FROM StayVaccinated



