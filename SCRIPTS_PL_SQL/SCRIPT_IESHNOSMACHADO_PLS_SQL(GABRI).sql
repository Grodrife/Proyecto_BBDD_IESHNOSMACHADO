------------------------------------------------------
-- Autor       : IES HERMANOS MACHADO
-- Descripci�n : Script 2 SCRIPT PLSQL - PROYECTO BBDD
-- Responsables : Fernando M�rquez Rodr�guez , Rafael Jos� Ossorio Lop�z, Victor Carrasco Artacho, Carlos Gonz�lez Ruiz, Gabriel Rodr�guez F�lix 
------------------------------------------------------

/*Mostrar para cada nif de cliente los contadores que tenga por contrato y a�adir el c�digo catastral de asociado a dicho contrato.
Adem�s, mostrar si un cliente tiene una direccion que no incluya un numero(S/N)*/

DECLARE
    CURSOR C_CLIENTE IS
        SELECT NIF,DIRECCION_DOMICILIO
        FROM CLIENTE;
        
    CURSOR C_CONTRATO(DATO_NIF CLIENTE.NIF%TYPE) IS
        SELECT COD_CONTADOR
        FROM CONTRATO
        WHERE NIF_CLIENTE = DATO_NIF;
        
    CURSOR C_CONTADOR(DATO_CODCONT CONTRATO.COD_CONTADOR%TYPE) IS
        SELECT COD_CATASTRAL
        FROM CONTADOR
        WHERE COD_CONTADOR = DATO_CODCONT;
        
    DATOS_C_CLIENTE C_CLIENTE%ROWTYPE;
    DATOS_C_CONTRATO C_CONTRATO%ROWTYPE;
    DATOS_C_CONTADOR C_CONTADOR%ROWTYPE;
    
BEGIN
    OPEN C_CLIENTE;
    LOOP
        FETCH C_CLIENTE INTO DATOS_C_CLIENTE;
        EXIT WHEN C_CLIENTE%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('NIF Cliente: ' || DATOS_C_CLIENTE.NIF);
            IF COMPROBAR_DIRECCION(DATOS_C_CLIENTE.DIRECCION_DOMICILIO)=0
            THEN
                DBMS_OUTPUT.PUT_LINE('(La direcci�n de este cliente no tiene n�mero)');
            END IF;
            OPEN C_CONTRATO(DATOS_C_CLIENTE.NIF);
            LOOP
                FETCH C_CONTRATO INTO DATOS_C_CONTRATO;
                EXIT WHEN C_CONTRATO%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE(CHR(9)||'+C�digo de contador: '||DATOS_C_CONTRATO.COD_CONTADOR);
                    OPEN C_CONTADOR(DATOS_C_CONTRATO.COD_CONTADOR);
                        FETCH C_CONTADOR INTO DATOS_C_CONTADOR;
                        EXIT WHEN C_CONTADOR%NOTFOUND;
                            DBMS_OUTPUT.PUT_LINE(CHR(9)||CHR(9)||'-C�digo catastral: '||DATOS_C_CONTADOR.COD_CATASTRAL);
                            DBMS_OUTPUT.PUT_LINE('');
                    CLOSE C_CONTADOR;
            END LOOP;
            CLOSE C_CONTRATO;
    END LOOP;
    CLOSE C_CLIENTE;
END;