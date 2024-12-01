--	Question 1
create or replace procedure PlaceOrder (
	order_no int,
	item_no int,
	_quantity int
)
Language plpgsql
as $$
Begin
	If (Select quantity_in_store from Items where itemno = item_no) < _quantity Then
		Raise notice 'Only % products availible for Item %', (Select quantity from Items where itemno = item_no), item_no;
	Else
		Insert into Orderdetails (Orderno, itemno, quantity) 
		values (order_no, item_no, _quantity);

		Update Items
		set quantity_in_store = quantity_in_store - _quantity
		where itemno = item_no;
	End if;
End;
$$;

--	Question 2
CREATE OR REPLACE PROCEDURE CustomerSignup(
    customer_no VARCHAR(2),
    customer_name VARCHAR(30),
    city VARCHAR(3),
    phone VARCHAR(11),
    OUT flag INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Rule 1: Check if CustomerNo is unique
    IF EXISTS (SELECT 1 FROM Customers WHERE "CustomerNo" = customer_no) THEN
        flag := 1; -- Violation of Rule 1
        RETURN;
    END IF;

    -- Rule 2: Check if City is NULL
    IF city IS NULL THEN
        flag := 2; -- Violation of Rule 2
        RETURN;
    END IF;

    -- Rule 3: Check if Phone is 6 digits
    IF LENGTH(phone) != 6 THEN
        flag := 3; -- Violation of Rule 3
        RETURN;
    END IF;

    -- If all rules are satisfied, insert the customer
    INSERT INTO Customers ("CustomerNo", "Name", "City", "Phone")
    VALUES (customer_no, customer_name, city, phone);

    -- Set flag to 0 indicating success
    flag := 0;
END;
$$;

--	Question 3
CREATE OR REPLACE PROCEDURE CancelOrder(
    customer_no VARCHAR(2),
    order_no INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    customer_name VARCHAR(30);
BEGIN
    -- Check if the order exists for the given customer
    SELECT "Name" 
    INTO customer_name
    FROM "Customers"
    WHERE "CustomerNo" = customer_no;

    IF NOT FOUND THEN
        RAISE NOTICE 'Customer No % does not exist.', customer_no;
        RETURN;
    END IF;

    -- Verify if the customer placed the given order
    IF NOT EXISTS (
        SELECT 1 
        FROM "Order" 
        WHERE "OrderNo" = order_no AND "CustomerNo" = customer_no
    ) THEN
        RAISE NOTICE 'Order no % is not of % %', order_no, customer_no, customer_name;
        RETURN;
    END IF;

    -- Delete order details first (to maintain referential integrity)
    DELETE FROM "OrderDetails"
    WHERE "OrderNo" = order_no;

    -- Delete the order
    DELETE FROM "Order"
    WHERE "OrderNo" = order_no;

    -- Success message
    RAISE NOTICE 'Order no % for customer % % has been successfully canceled.', order_no, customer_no, customer_name;
END;
$$;

--	Question 4
CREATE OR REPLACE PROCEDURE GetCustomerPoints(
    customer_name VARCHAR(30),
    OUT total_points INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    customer_no VARCHAR(2);
    total_amount INT;
BEGIN
    -- Find the customer number based on the provided name
    SELECT "CustomerNo" 
    INTO customer_no
    FROM "Customers"
    WHERE "Name" = customer_name;

    -- Check if the customer exists
    IF NOT FOUND THEN
        RAISE NOTICE 'Customer % does not exist.', customer_name;
        total_points := 0;
        RETURN;
    END IF;

    -- Calculate the total amount spent by the customer
    SELECT COALESCE(SUM("Total_Items_Ordered" * od."Quantity"), 0) AS total_amount
    INTO total_amount
    FROM "Order" o
    JOIN "OrderDetails" od ON o."OrderNo" = od."OrderNo"
    WHERE o."CustomerNo" = customer_no;

    -- Calculate total points (1 point for every Rs. 100 spent)
    total_points := total_amount / 100;

    -- Return total points
    RAISE NOTICE 'Customer % has a total of % points.', customer_name, total_points;
END;
$$;
