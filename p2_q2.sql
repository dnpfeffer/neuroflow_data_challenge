-- assumes you are using mysql for the LIMIT statement, can be changed for whatever sql you are using
-- also assumes that a patient has only one provider and takes the PHQ once
SELECT Providers.organization_name, AVG(Phq9.score) as avg_phq
FROM Providers
	INNER JOIN Phq9
	ON Providers.provider_id=Phq9.provider_id
GROUP BY Providers.organization_name
ORDER BY 2 DESC
LIMIT 5