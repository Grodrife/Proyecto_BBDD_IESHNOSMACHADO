------------------------------------------------------
-- Autor       : IES HERMANOS MACHADO
-- Descripci�n : Script 3 SCRIPT PLSQL - PROYECTO BBDD
-- Responsables : Fernando M�rquez Rodr�guez , Rafael Jos� Ossorio Lop�z, Victor Carrasco Artacho, Carlos Gonz�lez Ruiz, Gabriel Rodr�guez F�lix 
------------------------------------------------------

/*Se mostrar� la informaci�n de contacto (tel�fono y email) de cada uno de los empleados asignados al departamento
encargado de gestionar el contrato de cada uno de los clientes, para facilitar a los encargados tener esa 
informaci�n al alcance de una manera r�pida.*/

DECLARE
    --Creaci�n de cursores
    CURSOR C_CLIENTE IS
        SELECT NIF
        FROM CLIENTE;
        
    CURSOR C_CONTRATO(DATO_NIF CLIENTE.NIF%TYPE) IS
        SELECT COD_DEPARTAMENTO
        FROM CONTRATO
        WHERE NIF_CLIENTE = DATO_NIF;
        
    CURSOR C_EMPLEADO(DATO_CODDEP EMPLEADO.COD_DEPARTAMENTO%TYPE) IS
        SELECT CODEMPLEADO, NUMERO_TELEFONO, EMAIL
        FROM EMPLEADO
        WHERE COD_DEPARTAMENTO = DATO_CODDEP;
        
    DATOS_C_CLIENTE C_CLIENTE%ROWTYPE;
    DATOS_C_CONTRATO C_CONTRATO%ROWTYPE;
    DATOS_C_EMPLEADO C_EMPLEADO%ROWTYPE;
    
BEGIN
    OPEN C_CLIENTE;
    LOOP
        --Navegamos por el cursor de clientes para obtener sus DNI y lo sacamos por consola.
        FETCH C_CLIENTE INTO DATOS_C_CLIENTE;
        EXIT WHEN C_CLIENTE%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('NIF Cliente: ' || DATOS_C_CLIENTE.NIF);       
        --Abrimos el cursor de contratos usando el DNI de la iteraci�n actual como par�metro.
        OPEN C_CONTRATO(DATOS_C_CLIENTE.NIF);
        LOOP
            FETCH C_CONTRATO INTO DATOS_C_CONTRATO;
            EXIT WHEN C_CONTRATO%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('');
            --Imprimimos la informaci�n referente al c�digo del departamento en el que estamos actualmente.
            DBMS_OUTPUT.PUT_LINE(CHR(9)|| 'Datos de contacto de los empleados del departamento ' || DATOS_C_CONTRATO.COD_DEPARTAMENTO);
            --Abrimos el cursor de empleados usando el c�digo de contrato de la iteraci�n actual
            OPEN C_EMPLEADO(DATOS_C_CONTRATO.COD_DEPARTAMENTO);
                LOOP
                    --En cada vuelta obtenemos los datos de los empleados y los sacamos por consola.
                    FETCH C_EMPLEADO INTO DATOS_C_EMPLEADO;
                    EXIT WHEN C_EMPLEADO%NOTFOUND;  
                    DBMS_OUTPUT.PUT_LINE(CHR(9)|| CHR(9)|| '+ Empleado n�mero ' || DATOS_C_EMPLEADO.CODEMPLEADO);
                    DBMS_OUTPUT.PUT_LINE(CHR(9)|| CHR(9)|| CHR(9)|| '- Tel�fono: '||DATOS_C_EMPLEADO.EMAIL);
                    DBMS_OUTPUT.PUT_LINE(CHR(9)|| CHR(9)|| CHR(9)|| '- Email: '||DATOS_C_EMPLEADO.EMAIL);
                    DBMS_OUTPUT.PUT_LINE('');
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('');
            CLOSE C_EMPLEADO;
        END LOOP;
        CLOSE C_CONTRATO;
    END LOOP;
    CLOSE C_CLIENTE;
END;