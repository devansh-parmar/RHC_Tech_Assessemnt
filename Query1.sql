WITH cteAdmissions 
AS (
    SELECT 
        AdmYear = YEAR(e.AdmissionDate)
        ,AdmMonth = MONTH(e.AdmissionDate)
        ,TotalAdm = COUNT(e.episode_id)
    FROM 
        Episodes as e
    WHERE 
        e.AdmissionDate >= DATEADD(YEAR, -2, GETDATE())
    GROUP BY 
        YEAR(e.AdmissionDate), 
        MONTH(e.AdmissionDate)
)
SELECT 
    a.AdmYear, 
    a.AdmMonth, 
    a.TotalAdm,
    Avg_Adm = AVG(a.TotalAdm) OVER (PARTITION BY a.AdmYear)
FROM 
    cteAdmissions as a
ORDER BY 1,2
