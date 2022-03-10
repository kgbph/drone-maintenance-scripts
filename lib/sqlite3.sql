PRAGMA foreign_keys = ON;

WITH n_build_ids_per_repo AS (
SELECT
	build_id
FROM
	(
	SELECT
		build_id,
		build_repo_id,
		DENSE_RANK() OVER (PARTITION BY build_repo_id
	ORDER BY
		build_id DESC) AS rank
	FROM
		builds
  ) AS t
WHERE
	t.rank <= 50
)
DELETE
FROM
	builds
WHERE
	builds.build_id NOT IN (
	SELECT
		build_id
	FROM
		n_build_ids_per_repo);
