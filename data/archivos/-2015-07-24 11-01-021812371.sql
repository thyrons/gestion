
CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
SET search_path = public, pg_catalog;
SET client_encoding=LATIN1;
CREATE FUNCTION fn_log_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF (TG_TABLE_NAME = 'bitacora') THEN
    IF (TG_OP = 'DELETE') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'D', (OLD.id_bitacora,OLD.id_archivo,OLD.fecha_cambio,OLD.asunto_cambio,OLD.id_departamento,OLD.id_usuario,OLD.observaciones,OLD.peso,OLD.referencia,OLD.tipo), NULL, now(), USER);
      RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'U', (OLD.id_bitacora,OLD.id_archivo,OLD.fecha_cambio,OLD.asunto_cambio,OLD.id_departamento,OLD.id_usuario,OLD.observaciones,OLD.peso,OLD.referencia,OLD.tipo) ,(NEW.id_bitacora,NEW.id_archivo,NEW.fecha_cambio,NEW.asunto_cambio,NEW.id_departamento,NEW.id_usuario,NEW.observaciones,NEW.peso,NEW.referencia,NEW.tipo) , now(), USER);
      RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'I', NULL, (NEW.id_bitacora,NEW.id_archivo,NEW.fecha_cambio,NEW.asunto_cambio,NEW.id_departamento,NEW.id_usuario,NEW.observaciones,NEW.peso,NEW.referencia,NEW.tipo), now(), USER);
      RETURN NEW;
    END IF;
    RETURN NULL;
  else  
    IF (TG_OP = 'DELETE') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'D', OLD, NULL, now(), USER);
      RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'U', OLD, NEW, now(), USER);
      RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'I', NULL, NEW, now(), USER);
      RETURN NEW;
    END IF;
    RETURN NULL;
  
  end if;
END;
$$;
LANGUAGE 'plpgsql' VOLATILE COST 100;
ALTER FUNCTION public.fn_log_audit() OWNER TO postgres;
--
-- Estrutura de la tabla 'accesos'
--

DROP TABLE accesos CASCADE;
CREATE TABLE accesos (
id_acceso int4 NOT NULL,
id_usuario int4,
id_aplicacion int4,
estado text
);

--
-- Creating data for 'accesos'
--


--
-- Estrutura de la tabla 'aplicaciones'
--

DROP TABLE aplicaciones CASCADE;
CREATE TABLE aplicaciones (
id_aplicacion int4 NOT NULL,
nombre_aplicacion text,
direccion text
);

--
-- Creating data for 'aplicaciones'
--


--
-- Estrutura de la tabla 'archivo'
--

DROP TABLE archivo CASCADE;
CREATE TABLE archivo (
id_archivo int4 NOT NULL,
nombre_archivo text,
codigo_archivo text,
id_tipo_doc int4,
id_creador int4,
estado text
);

--
-- Creating data for 'archivo'
--


--
-- Estrutura de la tabla 'auditoria_sistema'
--

DROP TABLE auditoria_sistema CASCADE;
CREATE TABLE auditoria_sistema (
id_sistema int4 NOT NULL,
usuario text,
fecha_cambio text,
tabla text,
operacion text,
anterior text,
nuevo text,
observacion text
);

--
-- Creating data for 'auditoria_sistema'
--


--
-- Estrutura de la tabla 'bitacora
--

DROP TABLE bitacora CASCADE;
CREATE TABLE bitacora (
id_bitacora int4 NOT NULL,
id_archivo int4,
fecha_cambio text,
asunto_cambio text,
id_departamento int4,
id_usuario int4,
archivo_bytea bytea,
observaciones text,
peso text,
referencia text,
tipo text
);

--
-- Creating data for 'bitacora'
--


--
-- Estrutura de la tabla  'categorias'
--

DROP TABLE categorias CASCADE;
CREATE TABLE categorias (
id_categoria int4 NOT NULL,
nombre_categoria text,
codigo_categoria text,
estado text
);

--
-- Creating data for 'categorias'
--


--
-- Estrutura de la tabla 'ciudad'
--

DROP TABLE ciudad CASCADE;
CREATE TABLE ciudad (
id_ciudad int4 NOT NULL,
nombre_ciudad text,
id_provincia int4
);

--
-- Creating data for 'ciudad'
--


--
-- Estrutura de la tabla 'clave'
--

DROP TABLE clave CASCADE;
CREATE TABLE clave (
id_clave int4 NOT NULL,
clave text,
usuario int4
);

--
-- Creating data for 'clave'
--


--
-- Estrutura de la tabla 'departamento'
--

DROP TABLE departamento CASCADE;
CREATE TABLE departamento (
id_departamento int4 NOT NULL,
codigo_departamento text,
nombre_departamento text,
estado text
);

--
-- Creating data for 'departamento'
--


--
-- Estrutura de la tabla 'medio_recepcion'
--

DROP TABLE medio_recepcion CASCADE;
CREATE TABLE medio_recepcion (
id_medio int4 NOT NULL,
codigo_medio text,
nombre_medio text,
estado text
);

--
-- Creating data for 'medio_recepcion'
--


--
-- Estrutura de la tabla 'metas'
--

DROP TABLE metas CASCADE;
CREATE TABLE metas (
id_meta int4 NOT NULL,
nombre_meta text,
descripcion_meta text,
id_archivo int4
);

--
-- Creating data for 'metas'
--


--
-- Estrutura de la tabla 'pais'
--

DROP TABLE pais CASCADE;
CREATE TABLE pais (
id_pais int4 NOT NULL,
nombre_pais text
);

--
-- Creating data for 'pais'
--


--
-- Estrutura de la tabla 'provincias'
--

DROP TABLE provincias CASCADE;
CREATE TABLE provincias (
id_provincia int4 NOT NULL,
nombre_provincia text,
id_pais int4
);

--
-- Creating data for 'provincias'
--


--
-- Estrutura de la tabla 'recibidos'
--

DROP TABLE recibidos CASCADE;
CREATE TABLE recibidos (
id_recibido int4 NOT NULL,
id_archivo int4,
id_usuarios int4,
estado text,
leido int4
);

--
-- Creating data for 'recibidos'
--


--
-- Estrutura de la tabla 'tipo_documento'
--

DROP TABLE tipo_documento CASCADE;
CREATE TABLE tipo_documento (
id_tipo_documento int4 NOT NULL,
codigo_doc text,
nombre_doc text,
estado_doc text
);

--
-- Creating data for 'tipo_documento'
--


--
-- Estrutura de la tabla 'tbl_audit'
--

DROP TABLE tbl_audit CASCADE;
CREATE SEQUENCE tbl_audit_pk_audit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE tbl_audit (
pk_audit int4 NOT NULL DEFAULT nextval('tbl_audit_pk_audit_seq'::regclass) ,
nombre_tabla text NOT NULL,
operacion character(1) NOT NULL,
valor_anterior text,
valor_nuevo text,
fecha_cambio timestamp NOT NULL,
usuario text NOT NULL
);

--
-- Creating data for 'tbl_audit'
--


--
-- Estrutura de la tabla 'tipo_documento'
--

DROP TABLE tipo_documento CASCADE;
CREATE TABLE tipo_documento (
id_tipo_documento int4 NOT NULL,
codigo_doc text,
nombre_doc text,
estado_doc text
);

--
-- Creating data for 'tipo_documento'
--


--
-- Estrutura de la tabla 'tipo_usuario'
--

DROP TABLE tipo_usuario CASCADE;
CREATE TABLE tipo_usuario (
id_tipo_usuario int4 NOT NULL,
nombre_tipo text
);

--
-- Creating data for 'tipo_usuario'
--


--
-- Estrutura de la tabla 'usuario'
--

DROP TABLE usuario CASCADE;
CREATE TABLE usuario (
id_usuario int4 NOT NULL,
cod_usuario text,
nombres_usuario text,
direccion_usuario text,
id_ciudad int4,
telefono_usuario text,
celular_usuario text,
email_usuario text,
id_tipo_user int4,
nick_usuario text,
fecha text,
institucion text,
id_categoria int4,
id_departamento int4,
tipo_sangre text,
fecha_nacimiento text,
sexo text,
estado_civil text
);

--
-- Creating data for 'usuario'
--


CREATE TRIGGER tbl_accesos_tg_audit AFTER INSERT OR DELETE OR UPDATE ON accesos FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_aplicaciones_tg_audit AFTER INSERT OR DELETE OR UPDATE ON aplicaciones FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_archivo_tg_audit AFTER INSERT OR DELETE OR UPDATE ON archivo FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_bitacora_tg_audit AFTER INSERT OR DELETE OR UPDATE ON bitacora FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_categorias_tg_audit AFTER INSERT OR DELETE OR UPDATE ON categorias FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_ciudad_tg_audit AFTER INSERT OR DELETE OR UPDATE ON ciudad FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_clave_tg_audit AFTER INSERT OR DELETE OR UPDATE ON clave FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_departamento_tg_audit AFTER INSERT OR DELETE OR UPDATE ON departamento FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_medio_recepcion_tg_audit AFTER INSERT OR DELETE OR UPDATE ON medio_recepcion FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_metas_tg_audit AFTER INSERT OR DELETE OR UPDATE ON metas FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_pais_tg_audit AFTER INSERT OR DELETE OR UPDATE ON pais FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_provincias_tg_audit AFTER INSERT OR DELETE OR UPDATE ON provincias FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_recibidos_tg_audit AFTER INSERT OR DELETE OR UPDATE ON recibidos FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_tipo_documento_tg_audit AFTER INSERT OR DELETE OR UPDATE ON tipo_documento FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_tipo_usuario_tg_audit AFTER INSERT OR DELETE OR UPDATE ON tipo_usuario FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tbl_usuario_tg_audit AFTER INSERT OR DELETE OR UPDATE ON usuario FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();