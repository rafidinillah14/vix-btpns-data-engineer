-- Membuat Tabel Transaksi Baru Data Customer
SELECT 
	CLIENTNUM AS Clientnum, 
	[status] AS [Status], 
	CASE
		WHEN Customer_Age <= 30 THEN '21 - 30'
		WHEN Customer_Age <= 40 THEN '31 - 40'
		WHEN Customer_Age <= 50 THEN '41 - 50'
		WHEN Customer_Age <= 60 THEN '51 - 60'
		WHEN Customer_Age <= 70 THEN '61 - 70'
		WHEN Customer_Age > 70 THEN '70+'
	END AS Age_Category,
	Gender, Education_Level, Marital_Status, Dependent_count, Income_Category, Card_Category,
	CASE
		WHEN Months_on_book <= 12 THEN '1'
		WHEN Months_on_book <= 24 THEN '2'
		WHEN Months_on_book <= 36 THEN '3'
		WHEN Months_on_book <= 48 THEN '4'
		WHEN Months_on_book <= 60 THEN '5'
	END AS Years_on_Book,
	Total_Relationship_Count, Months_Inactive_12_mon, Contacts_Count_12_mon, Credit_Limit, Total_Revolving_Bal,
	Avg_Open_To_Buy, Total_Trans_Amt, Total_Trans_Ct, Avg_Utilization_Ratio
INTO data_customer_t
FROM customer_data_history h
	LEFT JOIN status_db s on h.idstatus = s.id
	LEFT JOIN education_db e on h.Educationid = e.id
	LEFT JOIN marital_db m on h.Maritalid  = m.id
	LEFT JOIN category_db c on h.card_categoryid  = c.id;
GO

SELECT * FROM data_customer_t;
GO

-- Membuat Query Proporsi Existing dan Attrited Customer
SELECT 
	[Status], 
	COUNT([Status]) AS Total_Customer,
	FORMAT(COUNT([Status]) * 100.0 / (SELECT COUNT(*) FROM data_customer_t),'N2')
FROM data_customer_t GROUP BY [Status];
GO

-------------------------------------------------------------------
-- DEMOGRAFI CUSTOMER
-------------------------------------------------------------------

-- Membuat Query Age Category pada Existing dan Attrited Customer
SELECT 
	Age_Category,
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Age_Category ORDER BY Age_Category;
GO

-- Membuat Query Gender pada Existing dan Attrited Customer
SELECT 
	Gender,  
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Gender ORDER BY Gender DESC;
GO

-- Membuat Query Education Level pada Existing dan Attrited Customer
SELECT 
	Education_Level,  
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Education_Level ORDER BY Rasio_Attrited_TotalAttrited DESC;
GO

-- Membuat Query Marital Status pada Existing dan Attrited Customer
SELECT 
	Marital_Status,  
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Marital_Status ORDER BY Rasio_Attrited_TotalAttrited DESC;
GO

-- Membuat Query Dependant Count pada Existing dan Attrited Customer
SELECT 
	Dependent_count,  
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Dependent_count ORDER BY Dependent_count;
GO

-- Membuat Query Income Category pada Existing dan Attrited Customer
SELECT 
	Income_Category,
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Income_Category ORDER BY Rasio_Attrited_TotalAttrited DESC;
GO

-------------------------------------------------------------------
-- HUBUNGAN KARTU KREDIT CUSTOMER
-------------------------------------------------------------------

-- Membuat Query Card Category
SELECT 
	Card_Category,
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Card_Category ORDER BY Rasio_Attrited_TotalAttrited DESC;
GO

-- Membuat Query Years on Book
SELECT 
	Years_on_Book,
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Years_on_Book ORDER BY Years_on_Book;
GO

-- Membuat Query Total Relationship Count
SELECT 
	Total_Relationship_Count,
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Total_Relationship_Count ORDER BY Total_Relationship_Count;
GO

-- Membuat Query Months Inactive in 12 months
SELECT 
	Months_Inactive_12_mon,
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Months_Inactive_12_mon ORDER BY Months_Inactive_12_mon;
GO

-- Membuat Query Contacts Count in 12 months
SELECT 
	Contacts_Count_12_mon,
	COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) AS Attrited_Customer,
	CAST(ROUND(COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) * 100.0 
		/ (SELECT COUNT(CASE WHEN [Status] = 'Attrited Customer' THEN 1 END) FROM data_customer_t)
		,2) AS DECIMAL (10,2)) AS Rasio_Attrited_TotalAttrited
FROM data_customer_t GROUP BY Contacts_Count_12_mon ORDER BY Contacts_Count_12_mon;
GO

-- Membuat Query Median Credit Limit
SELECT 
    [Status],
    ROUND(AVG(Credit_Limit), 2) AS Mean_Limit,
    AVG(Median_Limit) AS Median_Limit
FROM (
    SELECT 
        [Status],
        Credit_Limit,
        percentile_cont(0.5) WITHIN GROUP (ORDER BY Credit_Limit) OVER (PARTITION BY [Status]) AS Median_Limit
    FROM data_customer_t
	) AS Subquery
GROUP BY [Status];
GO

-- Membuat Query Total Revolving Balance
SELECT 
    [Status],
    ROUND(AVG(Total_Revolving_Bal), 2) AS Mean_Rev_Balance,
    AVG(Median_Rev_Balance) AS Median_Rev_Balance
FROM (
    SELECT 
        [Status],
        Total_Revolving_Bal,
        percentile_cont(0.5) WITHIN GROUP (ORDER BY Total_Revolving_Bal) OVER (PARTITION BY [Status]) AS Median_Rev_Balance
    FROM data_customer_t
	) AS Subquery
GROUP BY [Status];
GO

-- Membuat Query Average Open to Buy
SELECT 
    [Status],
    ROUND(AVG(Avg_Open_To_Buy), 2) AS Mean_Open_To_Buy,
    AVG(Median_Open_To_Buy) AS Median_Open_To_Buy
FROM (
    SELECT 
        [Status],
        Avg_Open_To_Buy,
        percentile_cont(0.5) WITHIN GROUP (ORDER BY Avg_Open_To_Buy) OVER (PARTITION BY [Status]) AS Median_Open_To_Buy
	FROM data_customer_t
	) AS Subquery
GROUP BY [Status];
GO

-- Membuat Query Total Transaction Amount, & Total Transaction Count
SELECT 
    [Status],
	ROUND(AVG(Total_Trans_Amt), 2) AS Mean_Total_Trans_Amt,
    AVG(Median_Total_Trans_Amt) AS Median_Total_Trans_Amt,
	ROUND(AVG(Total_Trans_Ct), 2) AS Mean_Total_Trans_Ct,
    AVG(Median_Total_Trans_Ct) AS Median_Total_Trans_Ct
FROM (
    SELECT 
        [Status],
		Total_Trans_Amt,
		percentile_cont(0.5) WITHIN GROUP (ORDER BY Total_Trans_Amt) OVER (PARTITION BY [Status]) AS Median_Total_Trans_Amt,
		Total_Trans_Ct,
		percentile_cont(0.5) WITHIN GROUP (ORDER BY Total_Trans_Ct) OVER (PARTITION BY [Status]) AS Median_Total_Trans_Ct
    FROM data_customer_t
	) AS Subquery
GROUP BY [Status];
GO
