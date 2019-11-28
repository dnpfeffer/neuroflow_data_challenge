-- assumes you are using mysql for the IFNULL statement, can be changed for whatever sql you are using
-- the IFNULL is needed for months that had people join and no one has done an exercise yet
-- displays only months that people joined on
SELECT users_month_created.month, IFNULL(users_exercised_on_creation.amount, 0)/users_month_created.amount * 100 AS percent
FROM
	(
		SELECT users.created_at AS month, COUNT(*) AS amount
		FROM users
		GROUP BY users.created_at
	) AS users_month_created
	LEFT JOIN 
				(
					SELECT users.created_at AS month, COUNT(*) AS amount
					FROM users
						INNER JOIN exercises
						ON users.user_id=exercises.user_id 
						AND users.created_at=exercises.exercise_completion_date 
					GROUP BY users.created_at
				) AS users_exercised_on_creation
	ON users_month_created.month=users_exercised_on_creation.month
GROUP BY users_month_created.month;