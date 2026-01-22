use Amazon;
SELECT * FROM amazon;
#Q1 Find the *total number of orders*.
SELECT COUNT(*) AS Total_orders from amazon;

#Q2 Count orders by *OrderStatus*.
SELECT  orderstatus, COUNT(*) AS Order_count from amazon
GROUP BY orderstatus;

#Q3 Find the *number of orders per year*.
SELECT EXTRACT(YEAR FROM OrderDate) AS Order_Year,
 COUNT(*) AS Order_Count FROM amazon 
 GROUP BY EXTRACT(YEAR FROM OrderDate);
 
 #Q4  Find the *number of orders per month*.
 SELECT EXTRACT(MONTH FROM OrderDate) AS Order_Month, 
 COUNT(*) AS Order_Count FROM amazon 
 GROUP BY EXTRACT(MONTH FROM OrderDate);

#Q5  Identify the *top 5 order dates* with the highest orders.
SELECT OrderDate, COUNT(*) AS Order_Count FROM amazon
 GROUP BY OrderDate ORDER BY Order_Count DESC LIMIT 5;
 
 #Q6 - Find the *average order value*.
 SELECT AVG(TotalAmount) AS Avg_Order_Value FROM amazon;
 
 #Q7 Find the *maximum and minimum TotalAmount*.
 SELECT MAX(totalamount) as max_amount, min(totalamount)as min_amount FROM amazon;
 
 #Q8 Count the number of *cancelled orders*.
 SELECT COUNT(*) as cancelled_order FROM amazon
  WHERE OrderStatus = "cancelled";
  
  #Q9 Calculate *total revenue from delivered orders only*.
  SELECT SUM(TotalAmount) AS Delivered_Revenue FROM amazon
  WHERE OrderStatus = "Delivered";
  
  #Q10 Find the *percentage of delivered vs cancelled orders*
  SELECT  OrderStatus,
   COUNT(*)* 100/ (SELECT COUNT(*) FROM amazon) AS percentage
   FROM Amazon WHERE OrderStatus IN ("Delivered", "Cancelled")
   GROUP BY OrderStatus;

#Q11 Find the *total number of unique customers*.
SELECT COUNT(DISTINCT CustomerID) AS Unique_customers FROM amazon;

#Q12 Find the *top 5 customers by total spending*.
SELECT CustomerID, SUM(TotalAmount) AS Total_Spending FROM amazon
GROUP BY CustomerID ORDER BY
Total_Spending DESC LIMIT 5 ;

#Q13 Find customers who placed *more than 5 orders*.
SELECT CustomerID, COUNT(*) AS Order_count FROM amazon
GROUP BY CustomerID HAVING COUNT(*) > 5;

#Q14 Calculate the *average spending per customer*.
SELECT AVG(Total_Spending) AS Avg_spending FROM 
(SELECT CustomerID, SUM(TotalAmount) as total_spending FROM
amazon GROUP BY CustomerID) as t;

#Q15  Find the *top 5 cities* by order count.
SELECT City,COUNT(*) astop_5_city   FROM amazon
GROUP BY City LIMIT 5 ;

#Q16 Calculate *total revenue by city*.
SELECT City, SUM(TotalAmount) total_revenue FROM amazon
GROUP BY City;

#Q17 Find the *top 5 states* by revenue.
SELECT State,COUNT(*) total_revenue   FROM amazon
GROUP BY State  LIMIT 5 ;

#Q18 Identify customers with *only one order*.
SELECT CustomerID FROM amazon 
GROUP BY CustomerID HAVING COUNT(*) = 1;

#Q19 Find customers who placed *orders in multiple years*.
SELECT CustomerID FROM amazon
GROUP BY CustomerID
HAVING COUNT(DISTINCT YEAR(OrderDate)) > 1;

#Q20 Find the *customer with the highest single order value*.
SELECT CustomerID, MAX(TotalAmount) AS max_order_value FROM amazon
GROUP BY CustomerID
ORDER BY max_order_value DESC
LIMIT 1;

#Q21 Find the *total quantity sold per category*.
SELECT Category, SUM(Quantity) AS total_quantity 
FROM amazon GROUP BY Category;

#Q22 Identify the *top 5 best-selling products by quantity*.
SELECT ProductID, SUM(Quantity) AS total_quantity FROM amazon 
GROUP BY ProductID ORDER BY total_quantity DESC LIMIT 5;

#Q23 Find the *total revenue per product*.
SELECT ProductID, SUM(TotalAmount) AS revenue FROM amazon
GROUP BY ProductID;

#Q24 Find the *top 3 categories by total revenue*.
SELECT Category, SUM(TotalAmount) AS total_revenue
 FROM amazon
GROUP BY Category
ORDER BY total_revenue DESC
LIMIT 3;

#Q25 Identify products with *zero discount*.
SELECT ProductID FROM amazon
WHERE Discount = 0;

#Q26 Find the *average unit price per category*.
SELECT Category, AVG(UnitPrice) AS avg_unit_price 
FROM amazon GROUP BY Category;

#Q27 Find the *most frequently ordered product*.
SELECT ProductID ,COUNT(*) AS order_count FROM amazon
GROUP BY ProductID ORDER BY order_count LIMIT 1;

#28 Find categories with *average order value greater than 5000*.
SELECT Category, AVG(TotalAmount) as order_value
FROM amazon GROUP BY Category HAVING AVG(TotalAmount) >5000;

#29 Count the number of *unique brands per category*.
SELECT Category , COUNT(DISTINCT Brand) as unique_brands FROM amazon
GROUP BY Category;

#30 Identify the *least sold product by quantity*.
SELECT ProductID , SUM(Quantity) As total_quantity
FROM amazon GROUP BY ProductID 
ORDER BY total_quantity ASC LIMIT 1;

#31 Calculate the *total discount amount* given.
SELECT SUM(Discount) AS total_discount FROM amazon;

#32 Find the *average discount per order*.
SELECT AVG(Discount) AS avg_discount FROM amazon;

#33 Find orders where *Discount > Tax*.
SELECT * FROM amazon WHERE Discount > Tax;

#34 Find orders where *ShippingCost > Discount*.
SELECT * FROM amazon WHERE ShippingCost > Discount;

#35 Calculate the *total tax collected*.
SELECT SUM(Tax) as total_tax FROM amazon;

#36 Find the *average tax per category*.
SELECT Category, AVG(Tax) as avg_tax FROM amazon
GROUP BY Category;

#37 Find the *highest discount given in a single order*.
SELECT MAX(Discount) as max_discount FROM amazon;

#38 Identify orders with *no shipping cost*.
SELECT * FROM amazon WHERE ShippingCost = 0;

#39 Calculate the *net revenue after discount and tax*.
SELECT SUM(TotalAmount - Discount + Tax) as net_revenue
FROM amazon;

#40 Find orders where *TotalAmount > 2 × UnitPrice*.
SELECT * FROM amazon WHERE TotalAmount > (2* UnitPrice);

#41 Count orders by *PaymentMethod*.
SELECT PaymentMethod , COUNT(*) AS order_count
FROM amazon GROUP BY PaymentMethod ;

#42 Find the *most used payment method*.
SELECT PaymentMethod , COUNT(*) as usage_count FROM amazon
GROUP BY PaymentMethod ORDER BY usage_count LIMIT 1;

#43 Calculate *total revenue per payment method*.
SELECT PaymentMethod , SUM(TotalAmount) as total_revenue
FROM amazon GROUP BY PaymentMethod;

#44 Find payment methods used in *cancelled orders*
SELECT DISTINCT PaymentMethod FROM amazon
WHERE OrderStatus = "Cancelled";

#45 Find the *average order value per payment method*.
SELECT PaymentMethod, AVG(TotalAmount) AS avg_order_value 
FROM amazon GROUP BY  PaymentMethod;

#46 Count the *number of unique sellers*.
SELECT COUNT(DISTINCT SellerID) AS unique_sellers FROM amazon;

#47 Find the *top 5 sellers by total revenue*.
SELECT SellerID, SUM(TotalAmount) AS total_revenue 
FROM amazon GROUP BY SellerID 
ORDER BY total_revenue DESC  LIMIT 5;

#48 Find sellers with *more than 100 orders*.
SELECT SellerID, COUNT(*) AS order_count 
FROM amazon GROUP BY SellerID 
HAVING COUNT(*) > 100;

#49 Calculate the *average order value per seller*.
SELECT SellerID, AVG(TotalAmount) AS avg_order_value 
FROM amazon GROUP BY SellerID;

#50 Identify sellers with *only cancelled orders*.
SELECT SellerID ,OrderStatus , COUNT(*) FROM amazon
GROUP BY SellerID ,OrderStatus 
 HAVING OrderStatus = "Cancelled" ;








