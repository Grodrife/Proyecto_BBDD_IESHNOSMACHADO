------------------------------------------------------
-- Autor       : IES HERMANOS MACHADO
-- Descripci�n : Script 2 CREACI�N FUNCI�N COMPROBAR_DIRECCION - PROYECTO BBDD
-- Responsables : Fernando M�rquez Rodr�guez , Rafael Jos� Ossorio Lop�z, Victor Carrasco Artacho, Carlos Gonz�lez Ruiz, Gabriel Rodr�guez F�lix 
------------------------------------------------------


CREATE FUNCTION COMPROBAR_DIRECCION(DIRECCION VARCHAR2) RETURN NUMBER
IS
    CONTIENE_NUMERO NUMBER(1);
BEGIN
    
    IF DIRECCION NOT LIKE '%S/N'
    THEN
    
        CONTIENE_NUMERO := 1;
        
    ELSE
        CONTIENE_NUMERO := 0;
        
    END IF;
    
    RETURN CONTIENE_NUMERO;
END COMPROBAR_DIRECCION;