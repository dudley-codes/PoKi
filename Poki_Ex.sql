--1. What grades are stored in the database? Grades 1-5
--SELECT * FROM Grade

--2. What emotions may be associated with a poem? Anger, Fear, Sadness, Joy
--SELECT * FROM Emotion;

--3. How many poems are in the database? 32,842
--SELECT COUNT(Title) FROM Poem

--4 Sort authors alphabetically by name. What are the names of the top 76 authors?
--SELECT DISTINCT TOP 76 Name, iD FROM Author 
--ORDER BY Name

----5 Starting with the above query, add the grade of each of the authors.
--SELECT 
--		TOP 76 a.Name,
--		g.Name AS Grade
--FROM Author a
--	left join Grade g
--	ON g.Id = a.GradeId
--ORDER BY a.Name

------ 6 Starting with the above query, add the recorded gender of each of the authors.
--SELECT 
--		TOP 76 a.Name,
--		g.Name AS Grade,
--		ge.Name as Gender
--FROM Author a
--	left join Grade g
--	ON g.Id = a.GradeId
--	left join Gender ge
--	ON ge.Id = a.GenderId
--ORDER BY a.Name

----7 What is the total number of words in all poems in the database? 374,584
--SELECT SUM(WordCount) FROM Poem;

---- 8 Which poem has the fewest characters? Hi
--SELECT *
--FROM Poem
--WHERE CharCount = (
--		SELECT MIN(CharCount)
--		FROM Poem)

---- 9 How many authors are in the third grade? 2,344
--SELECT
--	COUNT(*)
--FROM 
--	Author
--WHERE 
--	GradeId = 3;

----10 How many total authors are in the first through third grades? 2,967
--SELECT
--	COUNT(*)
--FROM 
--	Author
--WHERE 
--	GradeId = 3 OR GradeId = 1 OR GradeId = 2;

--11 What is the total number of poems written by fourth graders? 10,806
--SELECT
--	COUNT(*)
--FROM 
--	Poem p
--	left join Author a
--	ON a.Id = p.AuthorId
--WHERE 
--	a.GradeId = 4;

--12 How many poems are there per grade? 1: 886, 2: 3,160, 3: 6,636, 4: 10,806, 5: 11,354
--SELECT 
--	COUNT(p.Id) AS PoemCount,
--	a.GradeId AS Grade
--FROM Poem p
--	left join Author a
--	ON a.Id = p.AuthorId
--GROUP BY a.GradeId

--13 How many authors are in each grade? (Order your results by grade starting with 1st Grade) 
--623	1st Grade
--1437	2nd Grade
--2344	3rd Grade
--3288	4th Grade
--3464	5th Grade
--SELECT 
--	COUNT(a.Id) AS AuthorCount,
--	g.Name AS Grade
--FROM 
--	Author a
--	left join Grade g
--	ON g.Id = a.GradeId
--GROUP BY g.Name
--ORDER BY g.Name ASC

--14 What is the title of the poem that has the most words?
--SELECT TOP 1 Title, WordCount
--FROM Poem
--ORDER BY WordCount desc;

--15 Which author(s) have the most poems? (Remember authors can have the same name.) Emily
--SELECT 
--	TOP 5 a.Name AS Name,
--	COUNT(p.AuthorId) AS PoemCount
--FROM Author a
--RIGHT JOIN Poem p
--ON a.Id = p.AuthorId
--GROUP BY a.Id, a.Name
--ORDER BY COUNT(a.Name) DESC

--16 How many poems have an emotion of sadness? 14,570
--SELECT COUNT(*)
--FROM Poem p
--LEFT JOIN PoemEmotion pe
--ON p.Id = pe.PoemId
--LEFT JOIN Emotion e
--ON e.Id = pe.EmotionId
--WHERE e.Name = 'sadness';

----17 How many poems are not associated with any emotion? 3368
--SELECT COUNT(*)
--FROM Poem p
--LEFT JOIN PoemEmotion pe
--ON p.Id = pe.PoemId
--LEFT JOIN Emotion e
--ON e.Id = pe.EmotionId
--WHERE e.Name IS NULL

--18 Which emotion is associated with the least number of poems?
--SELECT COUNT(*), e.Name
--FROM Poem p
--LEFT JOIN PoemEmotion pe
--ON p.Id = pe.PoemId
--LEFT JOIN Emotion e
--ON e.Id = pe.EmotionId
--GROUP BY e.Name
--ORDER BY COUNT(*) desc;

--19 Which grade has the largest number of poems with an emotion of joy?
--SELECT DISTINCT e.Name, g.Name, COUNT(*)
--FROM Poem p
--LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
--LEFT JOIN Emotion e ON e.Id = pe.EmotionId
--LEFT JOIN Author a ON p.AuthorId = a.Id
--LEFT JOIN Grade g ON g.Id = a.GradeId
--WHERE e.Name = 'joy'
--GROUP BY g.Name, e.Name
--ORDER BY COUNT(*) ASC

--20 Which gender has the least number of poems with an emotion of fear?
SELECT DISTINCT g.Name, COUNT(*) AS Count
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON p.AuthorId = a.Id
LEFT JOIN Gender g ON a.GenderId = g.Id
WHERE e.Name = 'fear'
GROUP BY g.Name