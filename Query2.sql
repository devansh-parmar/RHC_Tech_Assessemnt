WITH ctePtileCalc 
AS ( 
    SELECT 
         e.PrincipalDiagnosis,
        ,e.Sex
        ,P25 = PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY e._TotalCharges) OVER (PARTITION BY e.PrincipalDiagnosis, e.Sex)
        ,P50 = PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY e._TotalCharges) OVER (PARTITION BY e.PrincipalDiagnosis, e.Sex)
        ,P75 = PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY e._TotalCharges) OVER (PARTITION BY e.PrincipalDiagnosis, e.Sex)
	   ,e._TotalCharges
    FROM   Episodes as e)
SELECT 
    p.PrincipalDiagnosis,
    p.Sex,
    Mean_Total_Cost = AVG(p._TotalCharges)
    Mean_P25 = AVG(p.P25)
    Mean_P50 = AVG(p.P50)
    Mean_P75 = AVG(p.P75)
FROM 
    ctePtileCalc as p
GROUP BY    p.PrincipalDiagnosis, p.Sex
ORDER BY    1, 2
