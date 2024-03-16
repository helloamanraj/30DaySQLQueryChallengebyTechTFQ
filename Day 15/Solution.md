```sql
SELECT c1.friend1, c2.friend2, COUNT(*) AS common_friends_count
FROM friends c1
JOIN friends c2 ON c1.friend2 = c2.friend2 AND c1.friend1 < c2.friend1
GROUP BY c1.friend1, c2.friend2;
```