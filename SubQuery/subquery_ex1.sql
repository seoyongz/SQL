SELECT M.MEMBER_NAME, R.REVIEW_TEXT, DATE_FORMAT(R.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
FROM MEMBER_PROFILE AS M 
    JOIN REST_REVIEW AS R
ON M.MEMBER_ID = R.MEMBER_ID
WHERE R.MEMBER_ID IN (SELECT MEMBER_ID FROM REST_REVIEW
                      GROUP BY MEMBER_ID
                      HAVING COUNT(*) = (SELECT MAX(COUNT) 
                                         FROM (SELECT COUNT(*) AS COUNT 
                                               FROM REST_REVIEW
                                               GROUP BY MEMBER_ID) AS TMP1
                                        )
                    )
ORDER BY R.REVIEW_DATE, R.REVIEW_TEXT;