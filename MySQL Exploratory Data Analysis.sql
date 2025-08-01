--Goal is to see how much did people got layoff by companies during the hight of the pandemic
 
 -- 1.Identify the time period with the most layoffs and spot any major spikes.
 -- 2.Analyze layoffs by company and country
 -- Find which companies had the most layoffs and which countries were hit hardest.
 -- 3.Identify complete workforce cuts (100% laid off)
 -- Highlight companies that shut down completely or cut all staff.
 -- 4.Measure layoffs over time (monthly and yearly)
-- Track how layoffs evolved over months/years and calculate a rolling total.
--  5.Explore layoffs by funding stage
--  Understand whether early-stage or late-stage companies were more affected.
 -- Spot top companies hit hardest by year
-- 6. Rank the top 5 companies with the highest layoffs 
 
 
 SELECT *
 FROM layoffs_staging2; 
 
 
 SELECT MAX(total_laid_off), MAX(percentage_laid_off)
 FROM layoffs_staging2;  
 
  SELECT * 
 FROM layoffs_staging2
 WHERE percentage_laid_off = 1
 ORDER BY funds_raised_millions DESC;
 
 SELECT company, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY company
 ORDER BY 2 DESC;
 
 SELECT MIN(`date`), MAX(`date`) 
 FROM layoffs_staging2;
 
 
SELECT country, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY country
 ORDER BY 2 DESC;
 
 SELECT * 
 FROM layoffs_staging2;
 
 SELECT YEAR( `date`), SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY YEAR( `date`)
 ORDER BY 1 DESC;
 
 
SELECT stage, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY stage
 ORDER BY 2 DESC;


 SELECT company, AVG(percentage_laid_off)
 FROM layoffs_staging2
 GROUP BY company
 ORDER BY 2 DESC;




SELECT SUBSTRING(`date`, 1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2 
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2 
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off
,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;
 
 
 
SELECT company, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY company
 ORDER BY 2 DESC; 

 
SELECT company, YEAR(`date`), SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY company, YEAR(`date`) 
 ORDER BY 3 DESC; 
 
WITH Company_Year (Company, years, total_laid_off) AS
 (
 SELECT company, YEAR(`date`), SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY company, YEAR(`date`) 
 ), Company_Year_Rank AS
 (SELECT *,
 DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
 FROM Company_Year
 WHERE years IS NOT NULL
 )
 SELECT *
 FROM Company_Year_Rank
 WHERE Ranking <= 5
;
 

 
 
 
 
 
 
