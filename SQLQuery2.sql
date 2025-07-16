-- view Customer Flight Activity--
select *
from [Customer Flight Activity]



--VIEW Status for each customer--

-- Total of Customer--
select count(ch.Loyalty_Number)  Tota_Customer
from [Customer Loyalty History] ch

--- Add New Column to View The Status Of Each Customer--
ALTER TABLE [Customer Loyalty History]
ADD Customer_Status VARCHAR(20);
UPDATE [Customer Loyalty History]
SET Customer_Status= CASE
    WHEN [Cancellation_Year] IS NULL THEN 'Active'
    ELSE 'Canceled'
END;
-- view Customer Loyalty History--
select ch.Loyalty_Number,ch.Customer_Status
from [Customer Loyalty History] ch


--Total_Active_Customer--
select count( distinct ch.Loyalty_Number)  Tota_Active_Customer  
from [Customer Loyalty History] ch
where Customer_Status ='Active'

--Total_Canceled_Customer--
select count( distinct ch.Loyalty_Number)  Tota_cancled_Customer  
from [Customer Loyalty History] ch
where Customer_Status ='Canceled'
--Total_Canceled_Customer_ber Year--
select count( distinct ch.Loyalty_Number)  Tota_cancled_Customer,ch.Cancellation_Year  
from [Customer Loyalty History] ch
where Customer_Status ='Canceled'
group by ch.Cancellation_Year
order by 1 desc

--Total_Flights--
select sum(ca.Total_Flights) Total_Flights
from [Customer Flight Activity] ca

--- Total Flights For Each Customer--
SELECT ca.[Loyalty_Number], SUM(Ca.[Total_Flights]) AS TotalFlights 
FROM [Customer Flight Activity] Ca
GROUP BY (Ca.[Loyalty_Number])
order by 2 desc

--Total_flights_Loyalty_card--
select sum(ca.Total_Flights) Total_flights_Loyalty_Nova, ch.Loyalty_Card
from [Customer Flight Activity] ca
inner join [Customer Loyalty History]ch 
on ch.Loyalty_Number=ca.Loyalty_Number
group by  ch.Loyalty_Card
order by 1 desc
---Total_flights_Enrollemnt_type---
select sum(ca.Total_Flights) Total_flights_Enrollemnt_type,ch.Enrollment_Type
from [Customer Flight Activity] ca
inner join [Customer Loyalty History]ch 
on ch.Loyalty_Number=ca.Loyalty_Number
group by ch.Enrollment_Type
order by 1 desc


--Total Customers by Education---
SELECT 
    Education, 
    COUNT(*) AS Total_Customers
FROM [Customer Loyalty History]
GROUP BY Education
ORDER BY Total_Customers DESC;
---Top 10 Customer by Total Flights--
select top 10 ca.[Loyalty_Number],SUM(Ca.[Total_Flights]) AS TotalFlights 
FROM [Customer Flight Activity] Ca
group by ca.Loyalty_Number
order by 2 desc
--information about the top 1 of cudtomer--
select *
from [Customer Loyalty History] ch
where ch.Loyalty_Number=336882


---Total Point of Top customer--
select ch.Loyalty_Number
,sum(ca.Points_Accumulated) Total_point_Accumulated
,sum(ca.Points_Redeemed) Total_point_Redeemed
,sum(ca.Dollar_Cost_Points_Redeemed) Total_Dollar_Accumulated
from [Customer Loyalty History] ch
inner join [Customer Flight Activity] ca
on ch.Loyalty_Number=ca.Loyalty_Number
where ch.Loyalty_Number=336882
group by ch.Loyalty_Number



---total point for all customers--
select sum(ca.Points_Accumulated)  Total_point
from [Customer Flight Activity] ca


---top 10 customer achive point--
select top 10 ch.Loyalty_Number
,ch.Loyalty_Card
,ch.Enrollment_Type
,sum(ca.Points_Accumulated) Total_point_Accumulated
,sum(ca.Total_Flights)Total_Flights
,sum(ca.Distance) Distance
from [Customer Loyalty History] ch
inner join [Customer Flight Activity] ca
on ca.Loyalty_Number=ch.Loyalty_Number
group by ch.Loyalty_Number,ch.Loyalty_Card,ch.Enrollment_Type
order by 4 desc


---top 10 customer achive Doller--
select top 10 ch.Loyalty_Number
,ch.Loyalty_Card
,ch.Enrollment_Type
,sum(ca.Total_Flights)Total_Flights
,sum(ca.Distance) Distance
,sum(ca.Points_Accumulated) Total_point_Accumulated
,sum(ca.Points_Redeemed) Total_point_Redeemed
,sum(ca.Dollar_Cost_Points_Redeemed) Doller_Redeemed
from [Customer Loyalty History] ch
inner join [Customer Flight Activity] ca
on ca.Loyalty_Number=ch.Loyalty_Number
group by ch.Loyalty_Number,ch.Loyalty_Card,ch.Enrollment_Type
order by 8 desc