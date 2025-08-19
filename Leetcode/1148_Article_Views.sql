/*
Table: Views

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+

Notes:
- There is no primary key in this table (duplicate rows may exist).
- Each row indicates that some viewer viewed an article (written by some author) on a given date.
- If author_id = viewer_id, it means the author viewed their own article.

Task:
Write a query to find all authors that viewed at least one of their own articles.
Return the result sorted by id in ascending order.
*/


SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id ASC;
