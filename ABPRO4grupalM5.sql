USE telovendo;

CREATE TABLE usuarios (
    id_usuario INT NOT NULL,
    nombre VARCHAR(50),
    PRIMARY KEY (id_usuario)
);

CREATE TABLE cuentas (
    id_cuenta INT NOT NULL,
    saldo INT,
    PRIMARY KEY (id_cuenta)
);
INSERT INTO usuarios (id_usuario, nombre)
VALUES
('1', 'Pedro'),
('2', 'Pablo'),
('3', 'Juan'),
('4', 'Diego');
INSERT INTO cuentas (id_cuenta, saldo)
VALUES
('1', '2000'),
('2', '3000'),
('3', '4000'),
('4', '5000');
select * from usuarios;
select * from cuentas;
-- ****************************************************************************************************************************
-- A.- Transfiera 200 TLV Coins desde un usuario A un usuario B.
SET @user_A := 'Pedro';
SET @user_B := 'Pablo';
SELECT @valor_ab:= 200 FROM cuentas, usuarios WHERE usuarios.nombre = @user_A and usuarios.id_usuario = cuentas.id_cuenta;
UPDATE cuentas, usuarios SET saldo = @valor_ab WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
-- ****************************************************************************************************************************
-- B.- ● Transfiera 150 TLV Coins desde un usuario B un usuario C.
SET @user_C := 'Juan';
SET @user_B := 'Pablo';
SELECT @valor_bc:= 150 FROM cuentas, usuarios WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
UPDATE cuentas, usuarios SET saldo = @valor_bc WHERE usuarios.nombre = @user_C and usuarios.id_usuario = cuentas.id_cuenta;
-- ****************************************************************************************************************************
-- C.- ● Transfiera 500 TLV Coins desde un usuario C un usuario D.
SET @user_C := 'Juan';
SET @user_D := 'Diego';
SELECT @valor_cd:= 500 FROM cuentas, usuarios WHERE usuarios.nombre = @user_A and usuarios.id_usuario = cuentas.id_cuenta;
UPDATE cuentas, usuarios SET saldo = @valor_cd WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
-- ****************************************************************************************************************************
-- D.- ● Transfiera 200 TLV Coins desde un usuario D un usuario A.
SET @user_D := 'Diego';
SET @user_A := 'Pedro';
SELECT @valor_da:= 200 FROM cuentas, usuarios WHERE usuarios.nombre = @user_A and usuarios.id_usuario = cuentas.id_cuenta;
UPDATE cuentas, usuarios SET saldo = @valor_da WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
-- ****************************************************************************************************************************
-- E.- En cada transacción, manualmente debe verificar que la cuenta tenga saldo suficiente.
SET @user_A := 'Pedro';
SELECT saldo, nombre FROM usuarios, cuentas WHERE usuarios.nombre = @user_A and usuarios.id_usuario = cuentas.id_cuenta;
SET @user_B := 'Pablo';
SELECT saldo, nombre FROM usuarios, cuentas WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
SET @user_C := 'Juan';
SELECT saldo, nombre FROM usuarios, cuentas WHERE usuarios.nombre = @user_C and usuarios.id_usuario = cuentas.id_cuenta;
SET @user_A := 'Diego';
SELECT saldo, nombre FROM usuarios, cuentas WHERE usuarios.nombre = @user_D and usuarios.id_usuario = cuentas.id_cuenta;
-- ****************************************************************************************************************************
-- F.- Verificar que la cuenta de destino exista.
SET @user_A := 'Pedro';
select id_cuenta, saldo, if(nombre = @user_A and id_usuario = id_cuenta, "Cuenta Existe", "Cuenta No Existe") as estado
from cuentas, usuarios;
SET @user_B := 'Pablo';
select id_cuenta, saldo, if(nombre = @user_B and id_usuario = id_cuenta, "Cuenta Existe", "Cuenta No Existe") as estado
from cuentas, usuarios;
SET @user_C := 'Juan';
select id_cuenta, saldo, if(nombre = @user_C and id_usuario = id_cuenta, "Cuenta Existe", "Cuenta No Existe") as estado
from cuentas, usuarios;
SET @user_D := 'Diego';
select id_cuenta, saldo, if(nombre = @user_D and id_usuario = id_cuenta, "Cuenta Existe", "Cuenta No Existe") as estado
from cuentas, usuarios;
-- ****************************************************************************************************************************
-- G.- Actualizar la cuenta de origen.   AND   -- H.- Actualizar la cuenta de destino.
start transaction;
SET @user_A := 'Pedro';
SET @user_B := 'Pablo';
select saldo from cuentas, usuarios where nombre = @user_A and id_usuario = id_cuenta;
update saldo set saldo = saldo - 200 where nombre = @user_A and id_usuario = id_cuenta;
select saldo from cuentas, usuarios where nombre = @user_B and id_usuario = id_cuenta;
update saldo set saldo = saldo + 200 where nombre = @user_B and id_usuario = id_cuenta;
commit;
start transaction;
SET @user_B := 'Pablo';
SET @user_C := 'Juan';
select saldo from cuentas, usuarios where nombre = @user_B and id_usuario = id_cuenta;
update saldo set saldo = saldo - 150 where nombre = @user_B and id_usuario = id_cuenta;
select saldo from cuentas, usuarios where nombre = @user_C and id_usuario = id_cuenta;
update saldo set saldo = saldo + 150 where nombre = @user_C and id_usuario = id_cuenta;
commit;
start transaction;
SET @user_C := 'Juan';
SET @user_D := 'Diego';
select saldo from cuentas, usuarios where nombre = @user_C and id_usuario = id_cuenta;
update saldo set saldo = saldo - 500 where nombre = @user_C and id_usuario = id_cuenta;
select saldo from cuentas, usuarios where nombre = @user_D and id_usuario = id_cuenta;
update saldo set saldo = saldo + 500 where nombre = @user_D and id_usuario = id_cuenta;
commit;
start transaction;
SET @user_D := 'Diego';
SET @user_A := 'Pedro';
select saldo from cuentas, usuarios where nombre = @user_D and id_usuario = id_cuenta;
update saldo set saldo = saldo - 200 where nombre = @user_D and id_usuario = id_cuenta;
select saldo from cuentas, usuarios where nombre = @user_A and id_usuario = id_cuenta;
update saldo set saldo = saldo + 200 where nombre = @user_A and id_usuario = id_cuenta;
commit;
select * from cuentas;

-- ****************************************************************************************************************************
-- I.-Deshaga la transacción que realiza el usuario A al usuario usuario B.
start transaction;
SET @user_A := 'Pedro';
SET @user_B := 'Pablo';
SELECT @valor_ab:= 200 FROM cuentas, usuarios WHERE usuarios.nombre = @user_A and usuarios.id_usuario = cuentas.id_cuenta;
UPDATE cuentas, usuarios SET saldo = @valor_ab WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
rollback;
-- ****************************************************************************************************************************
-- J.- Deshaga la transacción que realiza el usuario B al usuario usuario C.
start transaction;
SET @user_C := 'Juan';
SET @user_B := 'Pablo';
SELECT @valor_bc:= 150 FROM cuentas, usuarios WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
UPDATE cuentas, usuarios SET saldo = @valor_bc WHERE usuarios.nombre = @user_C and usuarios.id_usuario = cuentas.id_cuenta;
rollback;
-- ****************************************************************************************************************************
-- K.- Realice un commit de la transacción que realiza el usuario C al usuario usuario D.
start transaction;
SET @user_C := 'Juan';
SET @user_D := 'Diego';
SELECT @valor_cd:= 500 FROM cuentas, usuarios WHERE usuarios.nombre = @user_A and usuarios.id_usuario = cuentas.id_cuenta;
UPDATE cuentas, usuarios SET saldo = @valor_cd WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
commit;
-- ****************************************************************************************************************************
-- L.- Realice un commit de la transacción que realiza el usuario D al usuario usuario A.
start transaction;
SET @user_D := 'Diego';
SET @user_A := 'Pedro';
SELECT @valor_da:= 200 FROM cuentas, usuarios WHERE usuarios.nombre = @user_A and usuarios.id_usuario = cuentas.id_cuenta;
UPDATE cuentas, usuarios SET saldo = @valor_da WHERE usuarios.nombre = @user_B and usuarios.id_usuario = cuentas.id_cuenta;
commit;
-- ****************************************************************************************************************************