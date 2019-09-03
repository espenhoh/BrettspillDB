USE brettspill;


-- Statisk data 
-- Type spill
INSERT INTO brettspill.type_spill (type_spill_id, type_spill)
	VALUES (1,'Bosetterne')
	,(2,'Byer og riddere')
	,(3,'Sjøfarer')
	,(4,'Sjøfarer med byer og riddere')
	,(5,'Traders and barbarians ikke planlagt implementert')
	,(6,'Explorers and Pirates ikke planlagt implementert');



-- Testdata,'SJØFARER','SJØOGLAND','HANDELBARB','EXPLPIRAT'
INSERT INTO SPILLER (kallenavn, epost, passord, dato_registrert) 
	VALUES ('testbruker', 'test@test.com', 'test_passord', NOW());
INSERT INTO SPILLER (kallenavn, epost, passord, dato_registrert) 
	VALUES ('testbruker2', 'test@test2.com', 'test_passord', NOW());
    
insert into SPILL (spill_id, fk_type_spill_id, spillnavn, dato_fom, dato_tom)
	values (1,1, 'testspill', '2014-10-12 21:14:07', '2014-10-13 01:14:07');
insert into SPILL (spill_id, fk_type_spill_id, spillnavn, dato_fom, dato_tom)
	values (2,1, 'testspill', '2014-10-12 21:14:07', null);
insert into SPILL (spill_id, fk_type_spill_id, spillnavn, dato_fom, dato_tom)
	values (3,1, 'testspill', null , null);

SELECT spiller_id INTO @spiller FROM SPILLER WHERE kallenavn = 'testbruker';
SELECT spiller_id INTO @spiller2 FROM SPILLER WHERE kallenavn = 'testbruker2';

    
insert into SPILLER_I_SPILL (fk_spiller_id, fk_spill_id, farge, plassering)
	values (@spiller , 1, '#000000', 1);
insert into SPILLER_I_SPILL (fk_spiller_id, fk_spill_id, farge, plassering)
	values (@spiller2, 1, '#0000A0', 2);
insert into SPILLER_I_SPILL (fk_spiller_id, fk_spill_id, farge, plassering)
	values (@spiller , 2, '#000000', null);
insert into SPILLER_I_SPILL (fk_spiller_id, fk_spill_id, farge, plassering)
	values (@spiller2, 2, '#0000A0', null);
insert into SPILLER_I_SPILL (fk_spiller_id, fk_spill_id, farge, plassering)
	values (@spiller , 3, '#000000', null);
insert into SPILLER_I_SPILL (fk_spiller_id, fk_spill_id, farge, plassering)
	values (@spiller2, 3, '#0000A0', null);
	
UPDATE spill
inner join
(SELECT sis.fk_spill_id, min(sis.spiller_i_spill_id) sis_id FROM spiller_i_spill sis GROUP BY sis.fk_spill_id) sis
ON spill.spill_id = sis.fk_spill_id
SET spill.fk_leder = sis.sis_id;