USE ola;
SELECT * FROM ola_bookings;

-- What is the total number of successful bookings vs. cancelled bookings?
SELECT Booking_Status ,COUNT(Booking_ID) AS Total_No_Bookings FROM ola_bookings
GROUP BY Booking_status;

-- Which Vehicle_Type has the highest average Booking_Value?
SELECT Vehicle_Type, AVG(Booking_Value) AS Avg_Booking_Value  FROM ola_bookings
GROUP BY Vehicle_Type
ORDER BY Avg_Booking_Value DESC
LIMIT 1;

-- Find the top 5 Pickup_Location areas with the most ride requests.
SELECT Pickup_Location, COUNT(Booking_ID) AS Ride_Reqs FROM ola_bookings
GROUP BY Pickup_Location
ORDER BY Ride_Reqs DESC
LIMIT 5;

-- What is the total revenue generated in the last 30 days?
SELECT ROUND(SUM(Booking_Value),2) AS Total_Revenue FROM ola_bookings
Where Booking_Status = 'Success'
AND DATE >= DATE_SUB(CURDATE(),INTERVAL 30 DAY);

-- List all successful rides where the Ride_Distance was greater than 20km.
SELECT Booking_ID, Customer_ID, Vehicle_Type,Ride_Distance,Booking_Value FROM ola_bookings
WHERE Booking_Status = 'Success' AND Ride_Distance > 20
ORDER BY Ride_Distance DESC;

-- Which Payment_Method is most frequently used for rides over 500 INR?

SELECT Payment_Method, count(Booking_ID) AS Used_Payment_method from ola_bookings
WHERE Booking_value >= 500 
GROUP BY Payment_Method
ORDER BY Used_Payment_Method DESC;

-- Calculate the average Customer_Rating for each Vehicle_Type
SELECT Vehicle_Type, ROUND(AVG(Customer_Rating),2) AS Avg_Customer_Rating FROM ola_bookings
GROUP BY Vehicle_Type
ORDER BY Avg_Customer_Rating DESC;

-- Find the total number of rides cancelled by Drivers due to "Personal Reasons." 
-- canceled by driver due to Driver Refused
SELECT COUNT(Booking_ID) AS Canceled_ride_by_driver FROM ola_bookings
WHERE Canceled_By = 'Driver' AND Canceled_Reason = 'Driver refused' # as there is no 'personal reason mentined in dataset 
ORDER BY Canceled_ride_by_driver;

-- Identify the Customer_IDs who have booked more than 10 rides in a month. 
SELECT Customer_ID, MONTH(Date) AS Booking_Month,count(Booking_ID) AS Total_Rides FROM ola_bookings
GROUP BY Customer_ID, YEAR(Date),MONTH(Date)
HAVING COUNT(Booking_ID) > 5 #there are no rides more than 10 booked by customer
ORDER BY Total_Rides DESC;


-- Compare the average V_TAT (Vehicle Arrival Time) across different cities/locations.
SELECT Pickup_Location, AVG(V_TAT) AS Vehicle_Arrival_Time FROM ola_bookings 
GROUP BY Pickup_Location
ORDER BY Vehicle_Arrival_Time DESC;







