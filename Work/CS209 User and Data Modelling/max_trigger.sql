CREATE OR REPLACE FUNCTION max_size()
RETURNS trigger AS

$$
	DECLARE 
		currentCount NUMERIC;
	BEGIN
		SELECT count(*) INTO currentCount FROM Enrollment e WHERE e.Classcode = new.Classcode;
	
		
		IF currentCount >= (SELECT Max_Number FROM Class c WHERE c.Classcode = new.Classcode) THEN
			RAISE EXCEPTION 'MAX NUMBER OF ENROLLED STUDENTS IN CLASS %.', new.Title;
		END IF;
		RETURN NEW;
	END;
$$
LANGUAGE 'plpgsql';

