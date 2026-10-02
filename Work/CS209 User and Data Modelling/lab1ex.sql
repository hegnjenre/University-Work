--This code will only run when all occurrences of <ENTER> are replaced with meaningful code.

CREATE OR REPLACE FUNCTION sum_rooms() RETURNS hmolicense.number_of_bedrooms%TYPE AS 

$$

DECLARE
   bedrooms hmolicense.number_of_bedrooms%TYPE;
   total hmolicense.number_of_bedrooms%TYPE;
   num CURSOR FOR select number_of_bedrooms from hmolicense;

BEGIN
 total = 0;
 OPEN num;
  LOOP 
  FETCH num INTO bedrooms;
    EXIT WHEN NOT FOUND; 
  total = total + bedrooms;
  END LOOP; 
 CLOSE num; 
 RETURN total;
END;
$$

LANGUAGE 'plpgsql';

