#Overview
The equestrian database I created is a specialized system designed to manage various aspects of equestrian activities, focusing on horse management, barn logistics, financial transactions, and show scheduling. This comprehensive database not only tracks key details about horses, barns, and shows but also integrates functionalities to manage and schedule horses for various events. 

#Tables and Information
1.	Horses: Contains detailed information about each horse, including their ID, name, gender, birth year, status, cumulative spendings, and associated barn ID. The horse’s name is unique to ensure each horse is distinctly identified while their ID is used to identify them in external international and national federation’s platforms.
2.	Barns:  provides information about the barn facilities, including an auto-incremented barn ID, name, location details (city and country), and its capacity. It also tracks the current availability of space in each barn, with constraints ensuring that availability remains within logical limits.
3.	Shows: records details of equestrian shows such as show ID, city, country, start and end dates, and the level of the show.
4.	Schedule: links horses to shows, keeping track of the schedule ID, horse ID, show ID, and the total number of classes the horse is participating in.
5.	Financials: manages transactions related horses, containing information like financial ID, date, horse ID, type of transaction (earning or spending), amount, and a description of the transaction.

#Views
1.	Horse Financials: provides a consolidated view of all financial transactions for each horse, making it easier to track and manage horse-related expenditures and earnings. Since the Financials table only lists the transactions, the horse financials view orders the table by horse, and it includes the horse’s name.
2.	Horse Schedule: combines information from the schedule and shows tables to give a comprehensive view of each horse's show schedule, including dates and locations.
3.	Barns Capacity: shows information of each barn's capacity and current availability, linking it to the horses housed in each barn.

#Stored Procedures
All the procedures check if the horse exists in the horses table or in specific cases if the barn exists and has capacity.
1.	View Financials: Retrieve detailed information about a horse's financials based on the name provided, useful for a detailed breakdown of a horse’s transactions.
2.	View Schedule: Retrieve detailed information about a horse's schedule based on the name provided, useful to see the schedule for a specific horse.
3.	View Barn: Retrieve detailed information about a barn based on the name provided, useful to see the horses that are stabled at a specific barn.
4.	Cancel Show: Allows for the deletion of a show based on its ID, useful to update the show table whenever a show gets cancelled.
5.	Update Horse Status: Updates the status of a horse, useful for changing horses' status. For example, when a horse gets retired, leased, or injured.
6.	Add Transaction: Records a financial transaction and adjusts the horse's total spending. Useful way to add an observation on the financials table and adjust the spendings column on the horse’s table.
7.	Sell Horse: Manages the sale of a horse, including financials and barn capacity adjustments.
8.	Buy Horse: Manages the purchase of a horse, adding the horse with all its information to the horses’ table, adds the financial information of purchase and adjusts barn capacity.
9.	Deceased Horse: Manages the scenario of a deceased horse, by updating its status and adjusting the barn’s capacity.
10.	Transfer Horse: Transfers a horse from one barn to another, updating barn capacities accordingly.
11.	Show Entry: Schedules a horse for a show after checking its availability for the selected dates.

#Limitations of the Database
The system assumes strict adherence to input formats and relies heavily on the correctness of the data provided. The current design does not account for real-time updates or integrations with external systems. Also, the way errors are checked is basic and it may require more robust handling for practical usage of the database. For example, horse’s names bust be unique and in real life it is possible to have two horses with the same name. It could be an option to adjust the procedures to use the horse id instead of the horse’s name, even though this would make it a little bit more complicated in real life since horse id is not commonly known by riders and barn managers.
