
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

INSERT INTO accesos VALUES ('1','1','1','0');
INSERT INTO accesos VALUES ('2','1','2','0');
INSERT INTO accesos VALUES ('3','1','3','0');
INSERT INTO accesos VALUES ('4','1','4','0');
INSERT INTO accesos VALUES ('5','1','5','0');
INSERT INTO accesos VALUES ('6','1','6','0');
INSERT INTO accesos VALUES ('7','1','7','0');
INSERT INTO accesos VALUES ('8','1','8','0');
INSERT INTO accesos VALUES ('9','1','9','0');
INSERT INTO accesos VALUES ('10','1','10','0');
INSERT INTO accesos VALUES ('11','1','11','0');
INSERT INTO accesos VALUES ('12','1','12','0');
INSERT INTO accesos VALUES ('13','1','13','0');
INSERT INTO accesos VALUES ('14','1','14','0');
INSERT INTO accesos VALUES ('15','1','15','0');
INSERT INTO accesos VALUES ('16','1','16','0');
INSERT INTO accesos VALUES ('17','1','17','0');
INSERT INTO accesos VALUES ('18','1','18','0');
INSERT INTO accesos VALUES ('19','1','19','0');
INSERT INTO accesos VALUES ('20','1','20','0');
INSERT INTO accesos VALUES ('21','2','1','0');
INSERT INTO accesos VALUES ('22','2','2','0');
INSERT INTO accesos VALUES ('23','2','3','0');
INSERT INTO accesos VALUES ('24','2','4','0');
INSERT INTO accesos VALUES ('25','2','5','1');
INSERT INTO accesos VALUES ('26','2','6','0');
INSERT INTO accesos VALUES ('27','2','7','1');
INSERT INTO accesos VALUES ('28','2','8','1');
INSERT INTO accesos VALUES ('29','2','9','1');
INSERT INTO accesos VALUES ('30','2','10','0');
INSERT INTO accesos VALUES ('31','2','11','1');
INSERT INTO accesos VALUES ('32','2','12','0');
INSERT INTO accesos VALUES ('33','2','13','0');
INSERT INTO accesos VALUES ('34','2','14','0');
INSERT INTO accesos VALUES ('35','2','15','0');
INSERT INTO accesos VALUES ('36','2','16','0');
INSERT INTO accesos VALUES ('37','2','17','0');
INSERT INTO accesos VALUES ('38','2','18','0');
INSERT INTO accesos VALUES ('39','2','19','0');
INSERT INTO accesos VALUES ('40','2','20','0');


--
-- Creating index for 'accesos'
--

ALTER TABLE ONLY  accesos  ADD CONSTRAINT  accesos_pkey  PRIMARY KEY  (id_acceso);

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

INSERT INTO aplicaciones VALUES ('1','Envio','envio');
INSERT INTO aplicaciones VALUES ('2','Recibidos','inbox');
INSERT INTO aplicaciones VALUES ('3','Enviados','enviados');
INSERT INTO aplicaciones VALUES ('4','Buscar Archivos','inbox/buscar_archivos.php');
INSERT INTO aplicaciones VALUES ('5','Categorias','categorias');
INSERT INTO aplicaciones VALUES ('6','Departamentos','departamentos');
INSERT INTO aplicaciones VALUES ('10','Pais','pais');
INSERT INTO aplicaciones VALUES ('11','Provincia','provincia');
INSERT INTO aplicaciones VALUES ('12','Ciudad','ciudad');
INSERT INTO aplicaciones VALUES ('13','Reportes Usuario','reportes_usuario/usuario.php');
INSERT INTO aplicaciones VALUES ('15','Nuevos Usuarios','usuarios');
INSERT INTO aplicaciones VALUES ('17','Buscar Archivos','buscar_archivos');
INSERT INTO aplicaciones VALUES ('18','Backup','backup');
INSERT INTO aplicaciones VALUES ('19','Dashboard General','reportes_generales/dashboard.php');
INSERT INTO aplicaciones VALUES ('20','Reportes Generales','reportes_generales/generales.php');
INSERT INTO aplicaciones VALUES ('16','Permisos Usuarios','permisos');
INSERT INTO aplicaciones VALUES ('14','Dashboard Usuario','reportes_usuario/dashboard.php');
INSERT INTO aplicaciones VALUES ('9','Tipos de Usuarios','tipo_usaurio');
INSERT INTO aplicaciones VALUES ('8','Tipo de  Documento','tipo_documento');
INSERT INTO aplicaciones VALUES ('7','Medios de Recepcion','medio_recepcion');


--
-- Creating index for 'aplicaciones'
--

ALTER TABLE ONLY  aplicaciones  ADD CONSTRAINT  aplicaciones_pkey  PRIMARY KEY  (id_aplicacion);

--
-- Estrutura de la tabla 'archivo'
--

DROP TABLE archivo CASCADE;
CREATE TABLE archivo (
id_archivo int4 NOT NULL,
nombre_archivo text,
codigo_archivo text,
origen int4,
fuente_usuario text,
fecha_creacion timestamp with time zone,
estado int4
);

--
-- Creating data for 'archivo'
--

INSERT INTO archivo VALUES ('2','qw','q-2015-07-06-SD-2-2','1','1','2016-07-06 15:10:36-05','0');
INSERT INTO archivo VALUES ('1','ENVIOS DE LOS DATOS PERSONALES PARA SU RESPECTIVOA RECEPCIONE LA OFICNA','I-2015-07-06-pdf-1-1','1','1','2015-07-06 15:10:14-05','0');
INSERT INTO archivo VALUES ('3','GHGJ','F-2015-07-20-doc-3-3','1','1','2015-07-20 12:51:14-05','0');
INSERT INTO archivo VALUES ('4','fhfgh','I-2015-07-20-xlsx-4-4','1','1','2015-07-20 12:52:46-05','0');
INSERT INTO archivo VALUES ('5','qwe','P-2015-07-20-pptx-5-5','1','1','2015-07-20 12:53:51-05','0');
INSERT INTO archivo VALUES ('6','rer','S-2015-07-20-jpg-6-6','1','1','2015-07-20 12:54:29-05','0');


--
-- Creating index for 'archivo'
--

ALTER TABLE ONLY  archivo  ADD CONSTRAINT  archivo_pkey  PRIMARY KEY  (id_archivo);

--
-- Estrutura de la tabla 'auditoria_sistema'
--

DROP TABLE auditoria_sistema CASCADE;
CREATE TABLE auditoria_sistema (
id_sistema int4 NOT NULL,
usuario text,
tabla text,
operacion text,
anterior text[],
nuevo text[],
id_registro text,
ip_cliente text,
ip_servidor text,
fecha_creacion timestamp with time zone,
observacion text,
estado text
);

--
-- Creating data for 'auditoria_sistema'
--

INSERT INTO auditoria_sistema VALUES ('1','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-05-15 15:05:28-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('2','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-05-18 09:58:48-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('3','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-05-22 12:45:46-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('4','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-05-26 10:15:43-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('5','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-05-26 11:17:29-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('6','1','archivo','Insert','{""}','{"(11,\"ENVIOS DATOS\",E-2015-05-26-SD-11-11,1,1,\"2015-05-26 15:50:08-05\",0)"}','11','::1','::1','2015-05-26 15:50:08-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('7','1','bitacora','Insert','{""}','{"(11,11,\"2015-05-26 15:50:08-05\",\"CAMBIOS GENERLA\",1,1,1,\"<p><strong>CAMBIOS EN LOS BAESADADAD</strong></p>

<ul>
	<li>
	<h2 style=\"\"font-style:italic;\"\">asdasd</h2>
	</li>
</ul>

<p><strong><s>asdsfasfasf</s></strong></p>
\",\"\",\"\",\"\",0)"}','11','::1','::1','2015-05-26 15:50:08-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('8','1','enviados','Insert','{""}','{"(16,11,11,\"2015-05-26 15:50:08-05\",0,0,1)"}','16','::1','::1','2015-05-26 15:50:08-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('9','1','enviados','Insert','{""}','{"(17,11,11,\"2015-05-26 15:50:08-05\",0,0,2)"}','17','::1','::1','2015-05-26 15:50:08-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('10','1','recibidos','Insert','{""}','{"(11,11,11,\"2015-05-26 15:50:08-05\",1,\"{\"\"1,2\"\"}\")"}','11','::1','::1','2015-05-26 15:50:08-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('11','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-05-28 10:41:35-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('12','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-05-29 11:01:17-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('13','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-01 15:41:17-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('14','2','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-01 17:45:10-05','Ingreso al sistema por el usuario natyk','0');
INSERT INTO auditoria_sistema VALUES ('15','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-02 10:43:34-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('16','1','archivo','Insert','{""}','{"(12,qweqwe,q-2015-06-02-SD-12-12,1,1,\"2015-06-02 12:05:55-05\",0)"}','12','::1','::1','2015-06-02 12:05:55-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('17','1','bitacora','Insert','{""}','{"(12,12,\"2015-06-02 12:05:55-05\",qweqweqwe,1,1,1,\"<p>qweqw qweqweqw</p>
\",\"\",\"\",\"\",0)"}','12','::1','::1','2015-06-02 12:05:55-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('18','1','enviados','Insert','{""}','{"(18,12,12,\"2015-06-02 12:05:55-05\",0,0,1)"}','18','::1','::1','2015-06-02 12:05:55-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('19','1','recibidos','Insert','{""}','{"(12,12,12,\"2015-06-02 12:05:55-05\",1,{1})"}','12','::1','::1','2015-06-02 12:05:55-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('20','1','archivo','Insert','{""}','{"(13,ewqeqwe,e-2015-06-02-SD-13-13,1,1,\"2015-06-02 12:06:08-05\",0)"}','13','::1','::1','2015-06-02 12:06:08-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('21','1','bitacora','Insert','{""}','{"(13,13,\"2015-06-02 12:06:08-05\",123123,1,1,1,\"<p>qweqwe qweqweqeq</p>
\",\"\",\"\",\"\",0)"}','13','::1','::1','2015-06-02 12:06:08-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('22','1','enviados','Insert','{""}','{"(19,13,13,\"2015-06-02 12:06:08-05\",0,0,1)"}','19','::1','::1','2015-06-02 12:06:08-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('23','1','recibidos','Insert','{""}','{"(13,13,13,\"2015-06-02 12:06:08-05\",1,{1})"}','13','::1','::1','2015-06-02 12:06:08-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('24','1','archivo','Insert','{""}','{"(14,12312,1-2015-06-02-SD-14-14,1,1,\"2015-06-02 12:06:48-05\",0)"}','14','::1','::1','2015-06-02 12:06:48-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('25','1','bitacora','Insert','{""}','{"(14,14,\"2015-06-02 12:06:48-05\",123123,1,1,1,\"\",\"\",\"\",\"\",0)"}','14','::1','::1','2015-06-02 12:06:48-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('26','1','enviados','Insert','{""}','{"(20,14,14,\"2015-06-02 12:06:48-05\",0,0,1)"}','20','::1','::1','2015-06-02 12:06:48-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('27','1','recibidos','Insert','{""}','{"(14,14,14,\"2015-06-02 12:06:48-05\",1,{1})"}','14','::1','::1','2015-06-02 12:06:48-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('28','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 14:59:42-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('29','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 14:59:52-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('30','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 15:06:53-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('31','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 15:07:51-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('32','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 15:08:13-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('33','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 15:08:30-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('34','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 15:10:08-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('35','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 15:10:19-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('36','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 15:13:55-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('37','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-04 17:29:11-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('38','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-05 17:08:45-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('39','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-17 10:42:39-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('40','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-17 10:43:36-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('41','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-17 10:43:52-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('42','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-17 10:44:25-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('43','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-17 12:43:25-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('44','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-18 14:05:57-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('45','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:37:04-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('46','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:37:13-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('47','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:37:18-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('48','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:38:25-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('49','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:39:46-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('50','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:40:00-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('51','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:41:37-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('52','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:42:30-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('53','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:42:43-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('54','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:44:29-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('55','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 15:57:29-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('56','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:17:44-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('57','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:17:48-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('58','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:18:22-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('59','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:49:40-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('60','1','archivo','Insert','{""}','{"(1,qqqqweqw,2-2015-06-18-jpg-1-1,1,1,\"2015-06-18 16:53:10-05\",0)"}','1','::1','::1','2015-06-18 16:53:10-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('61','1','bitacora','Insert','{""}','{"(1,1,\"2015-06-18 16:53:10-05\",123123,1,1,1,\"<p>werwerwerwer</p>
\",1502474,20141117_1102421653101.jpg,jpg,0)"}','1','::1','::1','2015-06-18 16:53:10-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('62','1','metas','Insert','{""}','{"(1,nombre,20141117_110242.jpg,1)"}','1','::1','::1','2015-06-18 16:53:10-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('63','1','metas','Insert','{""}','{"(1,nombre,20141117_110242.jpg,1)"}','2','::1','::1','2015-06-18 16:53:10-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('64','1','metas','Insert','{""}','{"(1,nombre,20141117_110242.jpg,1)"}','3','::1','::1','2015-06-18 16:53:10-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('65','1','enviados','Insert','{""}','{"(1,1,1,\"2015-06-18 16:53:10-05\",0,0,1)"}','1','::1','::1','2015-06-18 16:53:10-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('66','1','enviados','Insert','{""}','{"(2,1,1,\"2015-06-18 16:53:10-05\",0,0,2)"}','2','::1','::1','2015-06-18 16:53:10-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('67','1','recibidos','Insert','{""}','{"(1,1,1,\"2015-06-18 16:53:10-05\",1,\"{\"\"1,2\"\"}\")"}','1','::1','::1','2015-06-18 16:53:10-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('68','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:53:29-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('69','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:53:34-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('70','1','archivo','Insert','{""}','{"(2,234234,2-2015-06-18-SD-2-2,1,1,\"2015-06-18 16:53:44-05\",0)"}','2','::1','::1','2015-06-18 16:53:44-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('71','1','bitacora','Insert','{""}','{"(2,2,\"2015-06-18 16:53:44-05\",qweqweqwe,1,1,1,\"\",\"\",\"\",\"\",0)"}','2','::1','::1','2015-06-18 16:53:44-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('72','1','enviados','Insert','{""}','{"(3,2,2,\"2015-06-18 16:53:44-05\",0,0,2)"}','3','::1','::1','2015-06-18 16:53:44-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('73','1','recibidos','Insert','{""}','{"(2,2,2,\"2015-06-18 16:53:44-05\",1,{2})"}','2','::1','::1','2015-06-18 16:53:44-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('74','1','archivo','Insert','{""}','{"(3,htyhty,h-2015-06-18-SD-3-3,1,1,\"2015-06-18 16:54:04-05\",0)"}','3','::1','::1','2015-06-18 16:54:04-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('75','1','bitacora','Insert','{""}','{"(3,3,\"2015-06-18 16:54:04-05\",htyhtyhtyh,1,1,1,\"\",\"\",\"\",\"\",0)"}','3','::1','::1','2015-06-18 16:54:04-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('76','1','enviados','Insert','{""}','{"(4,3,3,\"2015-06-18 16:54:04-05\",0,0,1)"}','4','::1','::1','2015-06-18 16:54:04-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('77','1','enviados','Insert','{""}','{"(5,3,3,\"2015-06-18 16:54:04-05\",0,0,2)"}','5','::1','::1','2015-06-18 16:54:04-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('78','1','recibidos','Insert','{""}','{"(3,3,3,\"2015-06-18 16:54:04-05\",1,\"{\"\"1,2\"\"}\")"}','3','::1','::1','2015-06-18 16:54:04-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('79','1','archivo','Insert','{""}','{"(4,123123123,1-2015-06-18-SD-4-4,1,1,\"2015-06-18 16:54:33-05\",0)"}','4','::1','::1','2015-06-18 16:54:33-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('80','1','bitacora','Insert','{""}','{"(4,4,\"2015-06-18 16:54:33-05\",2222222222222,1,1,1,\"<p>2222222222222</p>
\",\"\",\"\",\"\",0)"}','4','::1','::1','2015-06-18 16:54:33-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('81','1','enviados','Insert','{""}','{"(6,4,4,\"2015-06-18 16:54:33-05\",0,0,1)"}','6','::1','::1','2015-06-18 16:54:33-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('82','1','recibidos','Insert','{""}','{"(4,4,4,\"2015-06-18 16:54:33-05\",1,{1})"}','4','::1','::1','2015-06-18 16:54:33-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('83','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:55:38-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('84','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:55:42-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('85','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:55:45-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('86','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 16:55:49-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('87','1','archivo','Insert','{""}','{"(5,werwerwe,w-2015-06-18-SD-5-5,1,1,\"2015-06-18 17:03:58-05\",0)"}','5','::1','::1','2015-06-18 17:03:58-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('88','1','bitacora','Insert','{""}','{"(5,5,\"2015-06-18 17:03:58-05\",123123,1,1,1,\"<p>213123123</p>
\",\"\",\"\",\"\",0)"}','5','::1','::1','2015-06-18 17:03:58-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('89','1','enviados','Insert','{""}','{"(7,5,5,\"2015-06-18 17:03:58-05\",0,0,2)"}','7','::1','::1','2015-06-18 17:03:58-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('90','1','recibidos','Insert','{""}','{"(5,5,5,\"2015-06-18 17:03:58-05\",1,{2})"}','5','::1','::1','2015-06-18 17:03:58-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('91','1','archivo','Insert','{""}','{"(6,123123,1-2015-06-18-SD-6-6,1,1,\"2015-06-18 17:04:07-05\",0)"}','6','::1','::1','2015-06-18 17:04:07-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('92','1','bitacora','Insert','{""}','{"(6,6,\"2015-06-18 17:04:07-05\",1123weqwe,1,1,1,\"<p>eqweqwe</p>
\",\"\",\"\",\"\",0)"}','6','::1','::1','2015-06-18 17:04:07-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('93','1','enviados','Insert','{""}','{"(8,6,6,\"2015-06-18 17:04:07-05\",0,0,1)"}','8','::1','::1','2015-06-18 17:04:07-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('94','1','enviados','Insert','{""}','{"(9,6,6,\"2015-06-18 17:04:07-05\",0,0,2)"}','9','::1','::1','2015-06-18 17:04:07-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('95','1','recibidos','Insert','{""}','{"(6,6,6,\"2015-06-18 17:04:07-05\",1,\"{\"\"1,2\"\"}\")"}','6','::1','::1','2015-06-18 17:04:07-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('96','1','archivo','Insert','{""}','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','7','::1','::1','2015-06-18 17:04:33-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('97','1','bitacora','Insert','{""}','{"(7,7,\"2015-06-18 17:04:33-05\",4234234234,1,1,1,\"<p>234234</p>
\",\"\",\"\",\"\",0)"}','7','::1','::1','2015-06-18 17:04:33-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('98','1','enviados','Insert','{""}','{"(10,7,7,\"2015-06-18 17:04:33-05\",0,0,1)"}','10','::1','::1','2015-06-18 17:04:33-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('99','1','recibidos','Insert','{""}','{"(7,7,7,\"2015-06-18 17:04:33-05\",1,{1})"}','7','::1','::1','2015-06-18 17:04:33-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('100','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 17:04:43-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('101','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 17:05:36-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('102','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 17:11:12-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('103','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 17:11:46-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('104','2','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-18 17:16:43-05','Ingreso al sistema por el usuario natyk','0');
INSERT INTO auditoria_sistema VALUES ('105','2','archivo','Insert','{""}','{"(8,12312,1-2015-06-18-SD-8-8,1,2,\"2015-06-18 17:16:59-05\",0)"}','8','::1','::1','2015-06-18 17:16:59-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('106','2','bitacora','Insert','{""}','{"(8,8,\"2015-06-18 17:16:59-05\",3QWEQWEQWE,2,1,1,\"\",\"\",\"\",\"\",0)"}','8','::1','::1','2015-06-18 17:16:59-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('107','2','enviados','Insert','{""}','{"(11,8,8,\"2015-06-18 17:16:59-05\",0,0,2)"}','11','::1','::1','2015-06-18 17:16:59-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('108','2','recibidos','Insert','{""}','{"(8,8,8,\"2015-06-18 17:16:59-05\",2,{2})"}','8','::1','::1','2015-06-18 17:16:59-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('109','2','archivo','Insert','{""}','{"(9,23123,2-2015-06-18-SD-9-9,1,2,\"2015-06-18 17:17:06-05\",0)"}','9','::1','::1','2015-06-18 17:17:06-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('110','2','bitacora','Insert','{""}','{"(9,9,\"2015-06-18 17:17:06-05\",123123,2,1,1,\"\",\"\",\"\",\"\",0)"}','9','::1','::1','2015-06-18 17:17:06-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('111','2','enviados','Insert','{""}','{"(12,9,9,\"2015-06-18 17:17:06-05\",0,0,1)"}','12','::1','::1','2015-06-18 17:17:06-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('112','2','recibidos','Insert','{""}','{"(9,9,9,\"2015-06-18 17:17:06-05\",2,{1})"}','9','::1','::1','2015-06-18 17:17:06-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('113','2','archivo','Insert','{""}','{"(10,123123,1-2015-06-18-SD-10-10,1,2,\"2015-06-18 17:17:15-05\",0)"}','10','::1','::1','2015-06-18 17:17:15-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('114','2','bitacora','Insert','{""}','{"(10,10,\"2015-06-18 17:17:15-05\",WEQE,2,1,1,\"<p>QWE</p>
\",\"\",\"\",\"\",0)"}','10','::1','::1','2015-06-18 17:17:15-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('115','2','enviados','Insert','{""}','{"(13,10,10,\"2015-06-18 17:17:15-05\",0,0,1)"}','13','::1','::1','2015-06-18 17:17:15-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('116','2','enviados','Insert','{""}','{"(14,10,10,\"2015-06-18 17:17:15-05\",0,0,2)"}','14','::1','::1','2015-06-18 17:17:15-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('117','2','recibidos','Insert','{""}','{"(10,10,10,\"2015-06-18 17:17:15-05\",2,\"{\"\"1,2\"\"}\")"}','10','::1','::1','2015-06-18 17:17:15-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('118','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-18 17:17:37-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('119','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 17:17:43-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('120','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 17:18:19-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('121','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 17:19:09-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('122','1','archivo','Update','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','7','::1','::1','2015-06-18 18:22:08-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('123','1','bitacora','Insert','{""}','{"(11,7,\"2015-06-18 18:22:08-05\",4234234234,1,1,1,\"<p>234</p>
\",\"\",\"\",\"\",0)"}','11','::1','::1','2015-06-18 18:22:08-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('124','1','enviados','Insert','{""}','{"(15,7,11,\"2015-06-18 18:22:08-05\",0,0,1)"}','15','::1','::1','2015-06-18 18:22:08-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('125','1','recibidos','Insert','{""}','{"(11,7,11,\"2015-06-18 18:22:08-05\",1,{1})"}','11','::1','::1','2015-06-18 18:22:08-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('126','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 18:22:19-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('127','1','archivo','Update','{"(15,7,11,\"2015-06-18 18:22:08-05\",0,0,1)"}','{"(15,7,11,\"2015-06-18 18:22:08-05\",0,1,1)"}',NULL,'::1','::1','2015-06-18 18:22:19-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('128','1','archivo','Update','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','7','::1','::1','2015-06-18 18:24:59-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('129','1','bitacora','Insert','{""}','{"(12,7,\"2015-06-18 18:24:59-05\",4234234234,1,1,1,\"\",\"\",\"\",\"\",0)"}','12','::1','::1','2015-06-18 18:24:59-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('130','1','enviados','Insert','{""}','{"(16,7,12,\"2015-06-18 18:24:59-05\",0,0,1)"}','16','::1','::1','2015-06-18 18:24:59-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('131','1','recibidos','Insert','{""}','{"(12,7,12,\"2015-06-18 18:24:59-05\",1,{1})"}','12','::1','::1','2015-06-18 18:24:59-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('132','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 18:25:12-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('133','1','enviados','Update','{"(16,7,12,\"2015-06-18 18:24:59-05\",0,0,1)"}','{"(16,7,12,\"2015-06-18 18:24:59-05\",0,1,1)"}',NULL,'::1','::1','2015-06-18 18:25:12-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('134','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-18 18:29:20-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('135','1','enviados','Update','{"(16,7,12,\"2015-06-18 18:24:59-05\",0,1,1)"}','{"(16,7,12,\"2015-06-18 18:24:59-05\",0,1,1)"}',NULL,'::1','::1','2015-06-18 18:29:20-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('136','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-19 09:52:19-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('137','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 09:52:28-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('138','1','enviados','Update','{"(16,7,12,\"2015-06-18 18:24:59-05\",0,1,1)"}','{"(16,7,12,\"2015-06-18 18:24:59-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 09:52:28-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('139','1','archivo','Update','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','7','::1','::1','2015-06-19 10:02:04-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('140','1','bitacora','Insert','{""}','{"(13,7,\"2015-06-19 10:02:04-05\",4234234234,1,1,1,\"\",\"\",\"\",\"\",0)"}','13','::1','::1','2015-06-19 10:02:04-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('141','1','enviados','Insert','{""}','{"(17,7,13,\"2015-06-19 10:02:04-05\",0,0,1)"}','17','::1','::1','2015-06-19 10:02:04-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('142','1','recibidos','Insert','{""}','{"(13,7,13,\"2015-06-19 10:02:04-05\",1,{1})"}','13','::1','::1','2015-06-19 10:02:04-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('143','1','archivo','Update','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','7','::1','::1','2015-06-19 10:03:02-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('144','1','bitacora','Insert','{""}','{"(14,7,\"2015-06-19 10:03:02-05\",4234234234,1,1,1,\"\",\"\",\"\",\"\",0)"}','14','::1','::1','2015-06-19 10:03:02-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('145','1','enviados','Insert','{""}','{"(18,7,14,\"2015-06-19 10:03:02-05\",0,0,1)"}','18','::1','::1','2015-06-19 10:03:02-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('146','1','recibidos','Insert','{""}','{"(14,7,14,\"2015-06-19 10:03:02-05\",1,{1})"}','14','::1','::1','2015-06-19 10:03:02-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('147','1','archivo','Update','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','7','::1','::1','2015-06-19 10:07:46-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('148','1','bitacora','Insert','{""}','{"(15,7,\"2015-06-19 10:07:46-05\",4234234234,1,1,1,\"\",\"\",\"\",\"\",0)"}','15','::1','::1','2015-06-19 10:07:46-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('149','1','enviados','Insert','{""}','{"(19,7,15,\"2015-06-19 10:07:46-05\",0,0,1)"}','19','::1','::1','2015-06-19 10:07:46-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('150','1','recibidos','Insert','{""}','{"(15,7,15,\"2015-06-19 10:07:46-05\",1,{1})"}','15','::1','::1','2015-06-19 10:07:46-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('210','1','enviados','Update','{"(23,11,18,\"2015-06-19 10:16:48-05\",0,0,1)"}','{"(23,11,18,\"2015-06-19 10:16:48-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 14:29:55-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('151','1','archivo','Update','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",0)"}','{"(7,423423,4-2015-06-18-SD-7-7,1,1,\"2015-06-18 17:04:33-05\",1)"}','7','::1','::1','2015-06-19 10:10:32-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('152','1','bitacora','Insert','{""}','{"(16,7,\"2015-06-19 10:10:32-05\",4234234234,1,1,1,\"\",\"\",\"\",\"\",0)"}','16','::1','::1','2015-06-19 10:10:32-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('153','1','enviados','Insert','{""}','{"(20,7,16,\"2015-06-19 10:10:32-05\",0,0,1)"}','20','::1','::1','2015-06-19 10:10:32-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('154','1','recibidos','Insert','{""}','{"(16,7,16,\"2015-06-19 10:10:32-05\",1,{1})"}','16','::1','::1','2015-06-19 10:10:32-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('155','1','archivo','Update','{"(1,qqqqweqw,2-2015-06-18-jpg-1-1,1,1,\"2015-06-18 16:53:10-05\",0)"}','{"(1,qqqqweqw,2-2015-06-18-jpg-1-1,1,1,\"2015-06-18 16:53:10-05\",0)"}','1','::1','::1','2015-06-19 10:13:55-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('156','1','bitacora','Insert','{""}','{"(17,1,\"2015-06-19 10:13:55-05\",123123,1,1,1,\"\",1502474,20141117_1102421653101.jpg,jpg,0)"}','17','::1','::1','2015-06-19 10:13:55-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('157','1','enviados','Insert','{""}','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,0,1)"}','21','::1','::1','2015-06-19 10:13:55-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('158','1','enviados','Insert','{""}','{"(22,1,17,\"2015-06-19 10:13:55-05\",0,0,2)"}','22','::1','::1','2015-06-19 10:13:55-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('159','1','recibidos','Insert','{""}','{"(17,1,17,\"2015-06-19 10:13:55-05\",1,\"{\"\"1,2\"\"}\")"}','17','::1','::1','2015-06-19 10:13:55-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('160','1','archivo','Insert','{""}','{"(11,123,1-2015-06-19-SD-11-18,1,1,\"2015-06-19 10:16:48-05\",0)"}','11','::1','::1','2015-06-19 10:16:48-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('161','1','bitacora','Insert','{""}','{"(18,11,\"2015-06-19 10:16:48-05\",23123,1,1,1,\"\",\"\",\"\",\"\",0)"}','18','::1','::1','2015-06-19 10:16:48-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('162','1','enviados','Insert','{""}','{"(23,11,18,\"2015-06-19 10:16:48-05\",0,0,1)"}','23','::1','::1','2015-06-19 10:16:48-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('163','1','recibidos','Insert','{""}','{"(18,11,18,\"2015-06-19 10:16:48-05\",1,{1})"}','18','::1','::1','2015-06-19 10:16:48-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('164','1','archivo','Insert','{""}','{"(12,2312,2-2015-06-19-SD-12-19,1,1,\"2015-06-19 10:17:21-05\",0)"}','12','::1','::1','2015-06-19 10:17:21-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('165','1','bitacora','Insert','{""}','{"(19,12,\"2015-06-19 10:17:21-05\",123,1,1,1,\"\",\"\",\"\",\"\",0)"}','19','::1','::1','2015-06-19 10:17:21-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('166','1','enviados','Insert','{""}','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,0,1)"}','24','::1','::1','2015-06-19 10:17:21-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('167','1','recibidos','Insert','{""}','{"(19,12,19,\"2015-06-19 10:17:21-05\",1,{1})"}','19','::1','::1','2015-06-19 10:17:21-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('168','1','usuario','Insert','{""}','{"(3,1113,123123,qweq,1,\"\",\"\",\"\",1,qweqwe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:18:29-05\",Cédula,2222222222)"}','3','::1','::1','2015-06-19 10:18:29-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('169','1','clave','Insert','{""}','{"(3,MTIzMTIzMTIz,3)"}','3','::1','::1','2015-06-19 10:18:29-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('170','1','usuario','Insert','{""}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1234567897)"}','4','::1','::1','2015-06-19 10:22:14-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('171','1','clave','Insert','{""}','{"(4,MTIzMTIzMTIz,4)"}','4','::1','::1','2015-06-19 10:22:14-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('172','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1234567897)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,2222222222)"}','5','::1','::1','2015-06-19 10:22:55-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('173','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,2222222222)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1234567897)"}','5','::1','::1','2015-06-19 10:23:24-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('174','1','usuario','Update','{"(3,1113,123123,qweq,1,\"\",\"\",\"\",1,qweqwe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:18:29-05\",Cédula,2222222222)"}','{"(3,1113,123123,qweq,1,\"\",\"\",\"\",1,qweqwe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:18:29-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:24:16-05','Modificación del registro 3 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('175','1','usuario','Update','{"(1,AAW01,\"Willi Alfonso Narvaez Iñahuazo\",\"Otavalo Lass\",2,\"\",\"\",\"\",1,admin,\"Uniandes Ibarra\",1,1,\"2015-04-27 15:36:52-05\",Cédula,1002910345)"}','{"(1,AAW01,\"Willi Alfonso Narvaez Iñahuazo\",\"Otavalo Lass\",2,\"\",\"\",\"\",1,admin,\"Uniandes Ibarra\",1,1,\"2015-04-27 15:36:52-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:24:58-05','Modificación del registro 1 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('176','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1234567897)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1234567897)"}','5','::1','::1','2015-06-19 10:25:05-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('177','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1234567897)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1234567897)"}','5','::1','::1','2015-06-19 10:26:10-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('178','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1234567897)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:26:21-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('179','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:26:36-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('180','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:27:08-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('181','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:27:12-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('182','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:27:48-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('183','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:28:00-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('184','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:28:41-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('185','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:28:45-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('186','1','usuario','Update','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','{"(4,1114,123qweqw,123we,1,\"\",\"\",\"\",1,wewewe,\"Uniandes Ibarra\",1,1,\"2015-06-19 10:22:14-05\",Cédula,1002910345)"}','5','::1','::1','2015-06-19 10:28:50-05','Modificación del registro 4 la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('187','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 11:35:53-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('188','1','enviados','Update','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,0,1)"}','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 11:35:53-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('189','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 11:40:45-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('190','1','enviados','Update','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 11:40:45-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('191','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 11:41:08-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('192','1','enviados','Update','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 11:41:08-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('193','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 11:41:16-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('194','1','enviados','Update','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 11:41:16-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('195','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 11:41:53-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('196','1','enviados','Update','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 11:41:53-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('197','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 12:09:57-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('198','1','enviados','Update','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,0,1)"}','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 12:09:57-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('199','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 12:10:09-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('200','1','enviados','Update','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 12:10:09-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('201','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 12:10:20-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('202','1','enviados','Update','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 12:10:20-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('203','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 12:10:38-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('204','1','enviados','Update','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 12:10:38-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('205','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 12:10:42-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('206','1','enviados','Update','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 12:10:42-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('207','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 14:29:49-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('208','1','enviados','Update','{"(20,7,16,\"2015-06-19 10:10:32-05\",0,0,1)"}','{"(20,7,16,\"2015-06-19 10:10:32-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 14:29:49-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('209','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 14:29:55-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('211','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 14:34:20-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('212','1','enviados','Update','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}','{"(21,1,17,\"2015-06-19 10:13:55-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 14:34:20-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('213','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 15:00:26-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('214','1','enviados','Update','{"(19,7,15,\"2015-06-19 10:07:46-05\",0,0,1)"}','{"(19,7,15,\"2015-06-19 10:07:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 15:00:26-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('215','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 15:00:31-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('216','1','enviados','Update','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 15:00:31-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('217','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 15:00:47-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('218','1','enviados','Update','{"(18,7,14,\"2015-06-19 10:03:02-05\",0,0,1)"}','{"(18,7,14,\"2015-06-19 10:03:02-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 15:00:47-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('219','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 15:00:51-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('220','1','enviados','Update','{"(23,11,18,\"2015-06-19 10:16:48-05\",0,1,1)"}','{"(23,11,18,\"2015-06-19 10:16:48-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 15:00:51-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('221','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 15:01:27-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('222','1','enviados','Update','{"(23,11,18,\"2015-06-19 10:16:48-05\",0,1,1)"}','{"(23,11,18,\"2015-06-19 10:16:48-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 15:01:27-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('223','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 15:01:35-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('224','1','enviados','Update','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}','{"(24,12,19,\"2015-06-19 10:17:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 15:01:35-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('225','1','archivo','Insert','{""}','{"(13,werw,V-2015-06-19-sesx-13-20,1,1,\"2015-06-19 15:06:22-05\",0)"}','13','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('226','1','bitacora','Insert','{""}','{"(20,13,\"2015-06-19 15:06:22-05\",werwer,1,1,1,\"<p>qweqwe</p>
\",136277,\"Vocal and Guitar with Metronome15062213.sesx\",sesx,0)"}','20','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('227','1','metas','Insert','{""}','{""}','4','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('228','1','metas','Insert','{""}','{""}','5','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('229','1','metas','Insert','{""}','{""}','6','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('230','1','enviados','Insert','{""}','{"(25,13,20,\"2015-06-19 15:06:22-05\",0,0,1)"}','25','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('231','1','enviados','Insert','{""}','{"(26,13,20,\"2015-06-19 15:06:22-05\",0,0,2)"}','26','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('232','1','enviados','Insert','{""}','{"(27,13,20,\"2015-06-19 15:06:22-05\",0,0,3)"}','27','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('233','1','enviados','Insert','{""}','{"(28,13,20,\"2015-06-19 15:06:22-05\",0,0,4)"}','28','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('234','1','recibidos','Insert','{""}','{"(20,13,20,\"2015-06-19 15:06:22-05\",1,\"{\"\"1,2,3,4\"\"}\")"}','20','::1','::1','2015-06-19 15:06:22-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('235','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 15:06:36-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('236','1','enviados','Update','{"(25,13,20,\"2015-06-19 15:06:22-05\",0,0,1)"}','{"(25,13,20,\"2015-06-19 15:06:22-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 15:06:36-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('237','1','archivo','Insert','{""}','{"(14,234,2-2015-06-19-sesx-14-21,1,1,\"2015-06-19 15:06:58-05\",0)"}','14','::1','::1','2015-06-19 15:06:58-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('238','1','bitacora','Insert','{""}','{"(21,14,\"2015-06-19 15:06:58-05\",234,1,1,1,\"\",308625,\"24 Track Music Session15065814.sesx\",sesx,0)"}','21','::1','::1','2015-06-19 15:06:58-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('239','1','metas','Insert','{""}','{""}','7','::1','::1','2015-06-19 15:06:58-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('240','1','metas','Insert','{""}','{""}','8','::1','::1','2015-06-19 15:06:58-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('241','1','metas','Insert','{""}','{""}','9','::1','::1','2015-06-19 15:06:58-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('242','1','enviados','Insert','{""}','{"(29,14,21,\"2015-06-19 15:06:58-05\",0,0,1)"}','29','::1','::1','2015-06-19 15:06:58-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('243','1','enviados','Insert','{""}','{"(30,14,21,\"2015-06-19 15:06:58-05\",0,0,3)"}','30','::1','::1','2015-06-19 15:06:58-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('244','1','recibidos','Insert','{""}','{"(21,14,21,\"2015-06-19 15:06:58-05\",1,\"{\"\"1,3\"\"}\")"}','21','::1','::1','2015-06-19 15:06:58-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('245','1','archivo','Insert','{""}','{"(15,wer,2-2015-06-19-sesx-15-22,1,1,\"2015-06-19 15:07:40-05\",0)"}','15','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('246','1','bitacora','Insert','{""}','{"(22,15,\"2015-06-19 15:07:40-05\",wer,1,1,1,\"<p>werwer</p>
\",308625,\"24 Track Music Session15074015.sesx\",sesx,0)"}','22','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('247','1','metas','Insert','{""}','{""}','10','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('248','1','metas','Insert','{""}','{""}','11','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('249','1','metas','Insert','{""}','{""}','12','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('250','1','enviados','Insert','{""}','{"(31,15,22,\"2015-06-19 15:07:40-05\",0,0,1)"}','31','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('251','1','enviados','Insert','{""}','{"(32,15,22,\"2015-06-19 15:07:40-05\",0,0,2)"}','32','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('252','1','enviados','Insert','{""}','{"(33,15,22,\"2015-06-19 15:07:40-05\",0,0,3)"}','33','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('253','1','enviados','Insert','{""}','{"(34,15,22,\"2015-06-19 15:07:40-05\",0,0,4)"}','34','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('254','1','recibidos','Insert','{""}','{"(22,15,22,\"2015-06-19 15:07:40-05\",1,\"{\"\"1,2,3,4\"\"}\")"}','22','::1','::1','2015-06-19 15:07:40-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('255','1','archivo','Insert','{""}','{"(16,123,2-2015-06-19-sesx-16-23,1,1,\"2015-06-19 15:09:09-05\",0)"}','16','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('256','1','bitacora','Insert','{""}','{"(23,16,\"2015-06-19 15:09:09-05\",123,1,1,1,\"\",308625,\"24 Track Music Session15090916.sesx\",sesx,0)"}','23','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('257','1','metas','Insert','{""}','{""}','13','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('258','1','metas','Insert','{""}','{""}','14','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('259','1','metas','Insert','{""}','{""}','15','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('260','1','enviados','Insert','{""}','{"(35,16,23,\"2015-06-19 15:09:09-05\",0,0,1)"}','35','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('261','1','enviados','Insert','{""}','{"(36,16,23,\"2015-06-19 15:09:09-05\",0,0,2)"}','36','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('262','1','enviados','Insert','{""}','{"(37,16,23,\"2015-06-19 15:09:09-05\",0,0,3)"}','37','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('263','1','enviados','Insert','{""}','{"(38,16,23,\"2015-06-19 15:09:09-05\",0,0,4)"}','38','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('264','1','recibidos','Insert','{""}','{"(23,16,23,\"2015-06-19 15:09:09-05\",1,\"{\"\"1,2,3,4\"\"}\")"}','23','::1','::1','2015-06-19 15:09:09-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('265','1','archivo','Insert','{""}','{"(17,wer,2-2015-06-19-sesx-17-24,1,1,\"2015-06-19 15:10:41-05\",0)"}','17','::1','::1','2015-06-19 15:10:41-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('266','1','bitacora','Insert','{""}','{"(24,17,\"2015-06-19 15:10:41-05\",wer,1,1,1,\"\",308625,\"24 Track Music Session15104117.sesx\",sesx,0)"}','24','::1','::1','2015-06-19 15:10:41-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('267','1','metas','Insert','{""}','{""}','16','::1','::1','2015-06-19 15:10:41-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('268','1','metas','Insert','{""}','{"(17,tipo,sesx,17)"}','17','::1','::1','2015-06-19 15:10:41-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('269','1','metas','Insert','{""}','{"(17,tipo,sesx,17)"}','18','::1','::1','2015-06-19 15:10:41-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('270','1','enviados','Insert','{""}','{"(39,17,24,\"2015-06-19 15:10:41-05\",0,0,1)"}','39','::1','::1','2015-06-19 15:10:41-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('271','1','recibidos','Insert','{""}','{"(24,17,24,\"2015-06-19 15:10:41-05\",1,{1})"}','24','::1','::1','2015-06-19 15:10:41-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('272','1','archivo','Insert','{""}','{"(18,234,2-2015-06-19-sesx-18-25,1,1,\"2015-06-19 15:11:34-05\",0)"}','18','::1','::1','2015-06-19 15:11:34-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('273','1','bitacora','Insert','{""}','{"(25,18,\"2015-06-19 15:11:34-05\",234,1,1,1,\"\",308625,\"24 Track Music Session15113418.sesx\",sesx,0)"}','25','::1','::1','2015-06-19 15:11:34-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('274','1','metas','Insert','{""}','{"(18,tamaño,308625,17)"}','19','::1','::1','2015-06-19 15:11:34-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('275','1','metas','Insert','{""}','{"(18,tamaño,308625,17)"}','20','::1','::1','2015-06-19 15:11:34-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('276','1','metas','Insert','{""}','{"(18,tamaño,308625,17)"}','21','::1','::1','2015-06-19 15:11:34-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('277','1','enviados','Insert','{""}','{"(40,18,25,\"2015-06-19 15:11:34-05\",0,0,1)"}','40','::1','::1','2015-06-19 15:11:34-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('278','1','recibidos','Insert','{""}','{"(25,18,25,\"2015-06-19 15:11:34-05\",1,{1})"}','25','::1','::1','2015-06-19 15:11:34-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('279','1','archivo','Insert','{""}','{"(19,234,2-2015-06-19-sesx-19-26,1,1,\"2015-06-19 15:12:00-05\",0)"}','19','::1','::1','2015-06-19 15:12:00-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('280','1','bitacora','Insert','{""}','{"(26,19,\"2015-06-19 15:12:00-05\",234,1,1,1,\"<p>2</p>
\",308625,\"24 Track Music Session15120019.sesx\",sesx,0)"}','26','::1','::1','2015-06-19 15:12:00-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('281','1','metas','Insert','{""}','{"(19,nombre,\"24 Track Music Session.sesx\",18)"}','22','::1','::1','2015-06-19 15:12:00-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('282','1','metas','Insert','{""}','{"(19,nombre,\"24 Track Music Session.sesx\",18)"}','23','::1','::1','2015-06-19 15:12:00-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('283','1','metas','Insert','{""}','{"(19,nombre,\"24 Track Music Session.sesx\",18)"}','24','::1','::1','2015-06-19 15:12:00-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('318','1','metas','Insert','{""}','{"(23,tipo,sesx,19)"}','36','::1','::1','2015-06-19 15:13:48-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('284','1','enviados','Insert','{""}','{"(41,19,26,\"2015-06-19 15:12:00-05\",0,0,1)"}','41','::1','::1','2015-06-19 15:12:00-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('285','1','enviados','Insert','{""}','{"(42,19,26,\"2015-06-19 15:12:00-05\",0,0,3)"}','42','::1','::1','2015-06-19 15:12:00-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('286','1','recibidos','Insert','{""}','{"(26,19,26,\"2015-06-19 15:12:00-05\",1,\"{\"\"1,3\"\"}\")"}','26','::1','::1','2015-06-19 15:12:00-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('287','1','archivo','Insert','{""}','{"(20,234,2-2015-06-19-sesx-20-27,1,1,\"2015-06-19 15:12:17-05\",0)"}','20','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('288','1','bitacora','Insert','{""}','{"(27,20,\"2015-06-19 15:12:17-05\",234,1,1,1,\"<p>234234</p>
\",308625,\"24 Track Music Session15121720.sesx\",sesx,0)"}','27','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('289','1','metas','Insert','{""}','{"(20,tipo,sesx,18)"}','25','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('290','1','metas','Insert','{""}','{"(20,tipo,sesx,18)"}','26','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('291','1','metas','Insert','{""}','{"(20,tipo,sesx,18)"}','27','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('292','1','enviados','Insert','{""}','{"(43,20,27,\"2015-06-19 15:12:17-05\",0,0,1)"}','43','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('293','1','enviados','Insert','{""}','{"(44,20,27,\"2015-06-19 15:12:17-05\",0,0,2)"}','44','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('294','1','enviados','Insert','{""}','{"(45,20,27,\"2015-06-19 15:12:17-05\",0,0,3)"}','45','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('295','1','enviados','Insert','{""}','{"(46,20,27,\"2015-06-19 15:12:17-05\",0,0,4)"}','46','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('296','1','recibidos','Insert','{""}','{"(27,20,27,\"2015-06-19 15:12:17-05\",1,\"{\"\"1,2,3,4\"\"}\")"}','27','::1','::1','2015-06-19 15:12:17-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('297','1','archivo','Insert','{""}','{"(21,345,2-2015-06-19-sesx-21-28,1,1,\"2015-06-19 15:12:35-05\",0)"}','21','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('298','1','bitacora','Insert','{""}','{"(28,21,\"2015-06-19 15:12:35-05\",345345,1,1,1,\"\",308625,\"24 Track Music Session15123521.sesx\",sesx,0)"}','28','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('299','1','metas','Insert','{""}','{"(21,tamaño,308625,18)"}','28','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('300','1','metas','Insert','{""}','{"(21,tamaño,308625,18)"}','29','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('301','1','metas','Insert','{""}','{"(21,tamaño,308625,18)"}','30','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('302','1','enviados','Insert','{""}','{"(47,21,28,\"2015-06-19 15:12:35-05\",0,0,1)"}','47','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('303','1','enviados','Insert','{""}','{"(48,21,28,\"2015-06-19 15:12:35-05\",0,0,2)"}','48','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('304','1','enviados','Insert','{""}','{"(49,21,28,\"2015-06-19 15:12:35-05\",0,0,3)"}','49','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('305','1','enviados','Insert','{""}','{"(50,21,28,\"2015-06-19 15:12:35-05\",0,0,4)"}','50','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('306','1','recibidos','Insert','{""}','{"(28,21,28,\"2015-06-19 15:12:35-05\",1,\"{\"\"1,2,3,4\"\"}\")"}','28','::1','::1','2015-06-19 15:12:35-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('307','1','archivo','Insert','{""}','{"(22,asdqwe,2-2015-06-19-sesx-22-29,1,1,\"2015-06-19 15:13:08-05\",0)"}','22','::1','::1','2015-06-19 15:13:08-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('308','1','bitacora','Insert','{""}','{"(29,22,\"2015-06-19 15:13:08-05\",qweqwe,1,1,1,\"\",308625,\"24 Track Music Session15130822.sesx\",sesx,0)"}','29','::1','::1','2015-06-19 15:13:08-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('309','1','metas','Insert','{""}','{"(22,nombre,\"24 Track Music Session.sesx\",19)"}','31','::1','::1','2015-06-19 15:13:08-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('310','1','metas','Insert','{""}','{"(22,nombre,\"24 Track Music Session.sesx\",19)"}','32','::1','::1','2015-06-19 15:13:08-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('311','1','metas','Insert','{""}','{"(22,nombre,\"24 Track Music Session.sesx\",19)"}','33','::1','::1','2015-06-19 15:13:08-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('312','1','enviados','Insert','{""}','{"(51,22,29,\"2015-06-19 15:13:08-05\",0,0,1)"}','51','::1','::1','2015-06-19 15:13:08-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('313','1','recibidos','Insert','{""}','{"(29,22,29,\"2015-06-19 15:13:08-05\",1,{1})"}','29','::1','::1','2015-06-19 15:13:08-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('314','1','archivo','Insert','{""}','{"(23,wrer,2-2015-06-19-sesx-23-30,1,1,\"2015-06-19 15:13:48-05\",0)"}','23','::1','::1','2015-06-19 15:13:48-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('315','1','bitacora','Insert','{""}','{"(30,23,\"2015-06-19 15:13:48-05\",wer,1,1,1,\"<p>werwer</p>
\",308625,\"24 Track Music Session15134823.sesx\",sesx,0)"}','30','::1','::1','2015-06-19 15:13:48-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('316','1','metas','Insert','{""}','{"(23,tipo,sesx,19)"}','34','::1','::1','2015-06-19 15:13:48-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('317','1','metas','Insert','{""}','{"(23,tipo,sesx,19)"}','35','::1','::1','2015-06-19 15:13:48-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('319','1','enviados','Insert','{""}','{"(52,23,30,\"2015-06-19 15:13:48-05\",0,0,2)"}','52','::1','::1','2015-06-19 15:13:48-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('320','1','enviados','Insert','{""}','{"(53,23,30,\"2015-06-19 15:13:48-05\",0,0,3)"}','53','::1','::1','2015-06-19 15:13:48-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('321','1','recibidos','Insert','{""}','{"(30,23,30,\"2015-06-19 15:13:48-05\",1,\"{\"\"2,3\"\"}\")"}','30','::1','::1','2015-06-19 15:13:48-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('322','1','archivo','Insert','{""}','{"(24,wer,2-2015-06-19-sesx-24-31,1,1,\"2015-06-19 15:14:02-05\",0)"}','24','::1','::1','2015-06-19 15:14:02-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('323','1','bitacora','Insert','{""}','{"(31,24,\"2015-06-19 15:14:02-05\",wer,1,1,1,\"\",308625,\"24 Track Music Session15140224.sesx\",sesx,0)"}','31','::1','::1','2015-06-19 15:14:02-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('324','1','metas','Insert','{""}','{"(24,tamaño,308625,19)"}','37','::1','::1','2015-06-19 15:14:02-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('325','1','metas','Insert','{""}','{"(24,tamaño,308625,19)"}','38','::1','::1','2015-06-19 15:14:02-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('326','1','metas','Insert','{""}','{"(24,tamaño,308625,19)"}','39','::1','::1','2015-06-19 15:14:02-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('327','1','enviados','Insert','{""}','{"(54,24,31,\"2015-06-19 15:14:02-05\",0,0,2)"}','54','::1','::1','2015-06-19 15:14:02-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('328','1','recibidos','Insert','{""}','{"(31,24,31,\"2015-06-19 15:14:02-05\",1,{2})"}','31','::1','::1','2015-06-19 15:14:02-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('329','1','archivo','Insert','{""}','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",0)"}','25','::1','::1','2015-06-19 15:14:25-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('330','1','bitacora','Insert','{""}','{"(32,25,\"2015-06-19 15:14:25-05\",234,1,1,1,\"<p>234</p>
\",308625,\"24 Track Music Session15142525.sesx\",sesx,0)"}','32','::1','::1','2015-06-19 15:14:25-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('331','1','metas','Insert','{""}','{"(25,nombre,\"24 Track Music Session.sesx\",20)"}','40','::1','::1','2015-06-19 15:14:25-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('332','1','metas','Insert','{""}','{"(25,nombre,\"24 Track Music Session.sesx\",20)"}','41','::1','::1','2015-06-19 15:14:25-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('333','1','metas','Insert','{""}','{"(25,nombre,\"24 Track Music Session.sesx\",20)"}','42','::1','::1','2015-06-19 15:14:25-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('334','1','enviados','Insert','{""}','{"(55,25,32,\"2015-06-19 15:14:25-05\",0,0,1)"}','55','::1','::1','2015-06-19 15:14:25-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('335','1','enviados','Insert','{""}','{"(56,25,32,\"2015-06-19 15:14:25-05\",0,0,4)"}','56','::1','::1','2015-06-19 15:14:25-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('336','1','recibidos','Insert','{""}','{"(32,25,32,\"2015-06-19 15:14:25-05\",1,\"{\"\"1,4\"\"}\")"}','32','::1','::1','2015-06-19 15:14:25-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('337','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-19 15:14:35-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('338','1','enviados','Update','{"(55,25,32,\"2015-06-19 15:14:25-05\",0,0,1)"}','{"(55,25,32,\"2015-06-19 15:14:25-05\",0,1,1)"}',NULL,'::1','::1','2015-06-19 15:14:35-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('339','1','archivo','Update','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",0)"}','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",0)"}','25','::1','::1','2015-06-19 15:14:43-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('340','1','bitacora','Insert','{""}','{"(33,25,\"2015-06-19 15:14:43-05\",234,1,1,1,\"\",308625,\"24 Track Music Session15142525.sesx\",sesx,0)"}','33','::1','::1','2015-06-19 15:14:43-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('341','1','enviados','Insert','{""}','{"(57,25,33,\"2015-06-19 15:14:43-05\",0,0,4)"}','57','::1','::1','2015-06-19 15:14:43-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('342','1','enviados','Insert','{""}','{"(58,25,33,\"2015-06-19 15:14:43-05\",0,0,1)"}','58','::1','::1','2015-06-19 15:14:43-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('343','1','recibidos','Insert','{""}','{"(33,25,33,\"2015-06-19 15:14:43-05\",1,\"{\"\"4,1\"\"}\")"}','33','::1','::1','2015-06-19 15:14:43-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('344','1','archivo','Insert','{""}','{"(26,qwe,2-2015-06-19-sesx-26-34,1,1,\"2015-06-19 15:43:32-05\",0)"}','26','::1','::1','2015-06-19 15:43:32-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('345','1','bitacora','Insert','{""}','{"(34,26,\"2015-06-19 15:43:32-05\",qwe,1,1,1,\"<p>qwe</p>
\",308625,\"24 Track Music Session15433226.sesx\",sesx,0)"}','34','::1','::1','2015-06-19 15:43:32-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('346','1','metas','Insert','{""}','{"(26,tipo,sesx,20)"}','43','::1','::1','2015-06-19 15:43:32-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('347','1','metas','Insert','{""}','{"(26,tipo,sesx,20)"}','44','::1','::1','2015-06-19 15:43:32-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('348','1','metas','Insert','{""}','{"(26,tipo,sesx,20)"}','45','::1','::1','2015-06-19 15:43:32-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('349','1','enviados','Insert','{""}','{"(59,26,34,\"2015-06-19 15:43:32-05\",0,0,1)"}','59','::1','::1','2015-06-19 15:43:32-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('350','1','recibidos','Insert','{""}','{"(34,26,34,\"2015-06-19 15:43:32-05\",1,{1})"}','34','::1','::1','2015-06-19 15:43:32-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('351','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 09:55:03-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('352','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 09:56:01-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('353','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 09:57:12-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('354','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:00:01-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('355','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:04:36-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('356','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:04:53-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('357','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:05:29-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('358','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:05:38-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('359','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:05:51-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('360','2','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:07:00-05','Ingreso al sistema por el usuario natyk','0');
INSERT INTO auditoria_sistema VALUES ('361','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:08:47-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('362','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:15:12-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('363','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:16:04-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('364','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:16:18-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('365','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-22 10:25:22-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('366','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:10:11-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('367','1','enviados','Update','{"(59,26,34,\"2015-06-19 15:43:32-05\",0,0,1)"}','{"(59,26,34,\"2015-06-19 15:43:32-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:10:11-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('368','1','archivo','Update','{"(26,qwe,2-2015-06-19-sesx-26-34,1,1,\"2015-06-19 15:43:32-05\",0)"}','{"(26,qwe,2-2015-06-19-sesx-26-34,1,1,\"2015-06-19 15:43:32-05\",1)"}','26','::1','::1','2015-06-22 13:10:21-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('369','1','bitacora','Insert','{""}','{"(35,26,\"2015-06-22 13:10:21-05\",qwe,1,1,1,\"<p>asdasd</p>
\",308625,\"24 Track Music Session15433226.sesx\",sesx,0)"}','35','::1','::1','2015-06-22 13:10:21-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('370','1','enviados','Insert','{""}','{"(60,26,35,\"2015-06-22 13:10:21-05\",0,0,1)"}','60','::1','::1','2015-06-22 13:10:21-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('371','1','recibidos','Insert','{""}','{"(35,26,35,\"2015-06-22 13:10:21-05\",1,{1})"}','35','::1','::1','2015-06-22 13:10:21-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('372','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:10:49-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('373','1','enviados','Update','{"(59,26,34,\"2015-06-19 15:43:32-05\",0,1,1)"}','{"(59,26,34,\"2015-06-19 15:43:32-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:10:49-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('374','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:16:23-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('375','1','enviados','Update','{"(60,26,35,\"2015-06-22 13:10:21-05\",0,0,1)"}','{"(60,26,35,\"2015-06-22 13:10:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:16:23-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('376','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:16:33-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('377','1','enviados','Update','{"(60,26,35,\"2015-06-22 13:10:21-05\",0,1,1)"}','{"(60,26,35,\"2015-06-22 13:10:21-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:16:33-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('378','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:16:37-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('379','1','enviados','Update','{"(58,25,33,\"2015-06-19 15:14:43-05\",0,0,1)"}','{"(58,25,33,\"2015-06-19 15:14:43-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:16:37-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('380','1','archivo','Update','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",0)"}','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",0)"}','25','::1','::1','2015-06-22 13:16:47-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('381','1','bitacora','Insert','{""}','{"(36,25,\"2015-06-22 13:16:47-05\",234,1,1,1,\"\",308625,\"24 Track Music Session15142525.sesx\",sesx,0)"}','36','::1','::1','2015-06-22 13:16:47-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('382','1','enviados','Insert','{""}','{"(61,25,36,\"2015-06-22 13:16:47-05\",0,0,1)"}','61','::1','::1','2015-06-22 13:16:47-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('383','1','enviados','Insert','{""}','{"(62,25,36,\"2015-06-22 13:16:47-05\",0,0,4)"}','62','::1','::1','2015-06-22 13:16:47-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('384','1','recibidos','Insert','{""}','{"(36,25,36,\"2015-06-22 13:16:47-05\",1,\"{\"\"1,4\"\"}\")"}','36','::1','::1','2015-06-22 13:16:47-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('385','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:18:18-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('386','1','enviados','Update','{"(61,25,36,\"2015-06-22 13:16:47-05\",0,0,1)"}','{"(61,25,36,\"2015-06-22 13:16:47-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:18:18-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('387','1','archivo','Update','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",0)"}','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",0)"}','25','::1','::1','2015-06-22 13:18:25-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('388','1','bitacora','Insert','{""}','{"(37,25,\"2015-06-22 13:18:25-05\",234,1,1,1,\"\",308625,\"24 Track Music Session15142525.sesx\",sesx,0)"}','37','::1','::1','2015-06-22 13:18:25-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('389','1','enviados','Insert','{""}','{"(63,25,37,\"2015-06-22 13:18:25-05\",0,0,1)"}','63','::1','::1','2015-06-22 13:18:25-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('390','1','enviados','Insert','{""}','{"(64,25,37,\"2015-06-22 13:18:25-05\",0,0,4)"}','64','::1','::1','2015-06-22 13:18:25-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('546','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('391','1','recibidos','Insert','{""}','{"(37,25,37,\"2015-06-22 13:18:25-05\",1,\"{\"\"1,4\"\"}\")"}','37','::1','::1','2015-06-22 13:18:25-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('392','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:20:12-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('393','1','enviados','Update','{"(61,25,36,\"2015-06-22 13:16:47-05\",0,1,1)"}','{"(61,25,36,\"2015-06-22 13:16:47-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:20:12-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('394','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:20:15-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('395','1','enviados','Update','{"(58,25,33,\"2015-06-19 15:14:43-05\",0,1,1)"}','{"(58,25,33,\"2015-06-19 15:14:43-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:20:15-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('396','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:23:38-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('397','1','enviados','Update','{"(63,25,37,\"2015-06-22 13:18:25-05\",0,0,1)"}','{"(63,25,37,\"2015-06-22 13:18:25-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:23:38-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('398','1','archivo','Update','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",0)"}','{"(25,234,2-2015-06-19-sesx-25-32,1,1,\"2015-06-19 15:14:25-05\",1)"}','25','::1','::1','2015-06-22 13:23:46-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('399','1','bitacora','Insert','{""}','{"(38,25,\"2015-06-22 13:23:46-05\",234,1,1,1,\"\",308625,\"24 Track Music Session15142525.sesx\",sesx,1)"}','38','::1','::1','2015-06-22 13:23:46-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('400','1','enviados','Insert','{""}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,0,1)"}','65','::1','::1','2015-06-22 13:23:46-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('401','1','enviados','Insert','{""}','{"(66,25,38,\"2015-06-22 13:23:46-05\",0,0,4)"}','66','::1','::1','2015-06-22 13:23:46-05','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('402','1','recibidos','Insert','{""}','{"(38,25,38,\"2015-06-22 13:23:46-05\",1,\"{\"\"1,4\"\"}\")"}','38','::1','::1','2015-06-22 13:23:46-05','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('403','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 13:36:18-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('404','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,0,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 13:36:18-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('405','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 15:20:58-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('406','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:07:34-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('407','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:07:34-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('408','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:07:59-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('409','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:07:59-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('410','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:08:08-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('411','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:08:08-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('412','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:08:15-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('413','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:08:15-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('414','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:08:28-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('415','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:08:28-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('416','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:08:29-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('417','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:08:29-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('418','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:08:30-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('419','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:08:30-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('420','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:08:31-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('421','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:08:31-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('422','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:08:32-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('423','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:08:32-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('424','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:08:33-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('425','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:08:33-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('426','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:14:25-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('427','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:14:25-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('428','1','archivo','Update','{""}','{""}',NULL,'::1','::1','2015-06-22 16:15:52-05','Modificación del estado del archivo','0');
INSERT INTO auditoria_sistema VALUES ('429','1','enviados','Update','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}','{"(65,25,38,\"2015-06-22 13:23:46-05\",0,1,1)"}',NULL,'::1','::1','2015-06-22 16:15:52-05','Archivo visto por el usuario correspondiente','0');
INSERT INTO auditoria_sistema VALUES ('430','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-23 11:47:39-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('431','1','archivo','Insert','{""}','{"(1,wer,r-2015-06-23-backup-1-1,1,1,\"2015-06-23 12:55:10-05\",0)"}','1','::1','::1','2015-06-23 12:55:10-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('432','1','bitacora','Insert','{""}','{"(1,1,\"2015-06-23 12:55:10-05\",wer,1,1,1,\"<p>qweq</p>
\",18369,reservacion1255101.backup,backup,0)"}','1','::1','::1','2015-06-23 12:55:10-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('433','1','metas','Insert','{""}','{"(1,nombre,reservacion.backup,1)"}','1','::1','::1','2015-06-23 12:55:10-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('434','1','metas','Insert','{""}','{"(1,nombre,reservacion.backup,1)"}','2','::1','::1','2015-06-23 12:55:10-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('435','1','metas','Insert','{""}','{"(1,nombre,reservacion.backup,1)"}','3','::1','::1','2015-06-23 12:55:10-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('436','1','enviados','Insert','{""}','{"(1,1,1,\"2015-06-23 12:55:10-05\",0,0,1)"}','1','::1','::1','2015-06-23 12:55:10-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('437','1','recibidos','Insert','{""}','{"(1,1,1,\"2015-06-23 12:55:10-05\",1,{1})"}','1','::1','::1','2015-06-23 12:55:10-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('438','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-23 15:02:41-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('439','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-06-24 10:24:42-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('440','1','archivo','Insert','{""}','{"(2,wqe,w-2015-06-24-SD-2-2,1,1,\"2015-06-24 10:36:07-05\",0)"}','2','::1','::1','2015-06-24 10:36:07-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('441','1','bitacora','Insert','{""}','{"(2,2,\"2015-06-24 10:36:07-05\",qweqwe,1,1,1,\"<p>qweqwe</p>
\",\"\",\"\",\"\",0)"}','2','::1','::1','2015-06-24 10:36:07-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('442','1','enviados','Insert','{""}','{"(2,2,2,\"2015-06-24 10:36:07-05\",0,0,1)"}','2','::1','::1','2015-06-24 10:36:07-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('443','1','enviados','Insert','{""}','{"(3,2,2,\"2015-06-24 10:36:07-05\",0,0,2)"}','3','::1','::1','2015-06-24 10:36:07-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('444','1','recibidos','Insert','{""}','{"(2,2,2,\"2015-06-24 10:36:07-05\",1,\"{\"\"1,2\"\"}\")"}','2','::1','::1','2015-06-24 10:36:07-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('445','1','archivo','Insert','{""}','{"(3,qwe,q-2015-06-24-SD-3-3,1,1,\"2015-06-24 11:21:33-05\",0)"}','3','::1','::1','2015-06-24 11:21:33-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('446','1','bitacora','Insert','{""}','{"(3,3,\"2015-06-24 11:21:33-05\",qwe,1,1,1,\"<p>wewe</p>
\",0,\"\",\"\",0)"}','3','::1','::1','2015-06-24 11:21:33-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('447','1','enviados','Insert','{""}','{"(4,3,3,\"2015-06-24 11:21:33-05\",0,0,1)"}','4','::1','::1','2015-06-24 11:21:33-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('448','1','recibidos','Insert','{""}','{"(3,3,3,\"2015-06-24 11:21:33-05\",1,{1})"}','3','::1','::1','2015-06-24 11:21:33-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('449','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-06 10:00:31-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('450','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-06 11:34:36-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('451','1','archivo','Insert','{""}','{"(1,qwe,d-2015-07-06-txt-1-1,1,1,\"2015-07-06 15:09:30-05\",0)"}','1','::1','::1','2015-07-06 15:09:30-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('452','1','bitacora','Insert','{""}','{"(1,1,\"2015-07-06 15:09:30-05\",qwe,1,1,1,\"<p>qweqwe</p>
\",0,\"descarga (11)1509301.txt\",txt,0)"}','1','::1','::1','2015-07-06 15:09:30-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('453','1','metas','Insert','{""}','{"(1,nombre,\"descarga (11).txt\",1)"}','1','::1','::1','2015-07-06 15:09:30-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('454','1','metas','Insert','{""}','{"(1,nombre,\"descarga (11).txt\",1)"}','2','::1','::1','2015-07-06 15:09:30-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('455','1','metas','Insert','{""}','{"(1,nombre,\"descarga (11).txt\",1)"}','3','::1','::1','2015-07-06 15:09:30-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('456','1','enviados','Insert','{""}','{"(1,1,1,\"2015-07-06 15:09:30-05\",0,0,1)"}','1','::1','::1','2015-07-06 15:09:30-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('457','1','recibidos','Insert','{""}','{"(1,1,1,\"2015-07-06 15:09:30-05\",1,{1})"}','1','::1','::1','2015-07-06 15:09:30-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('458','1','archivo','Insert','{""}','{"(1,eqw,I-2015-07-06-pdf-1-1,1,1,\"2015-07-06 15:10:14-05\",0)"}','1','::1','::1','2015-07-06 15:10:14-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('459','1','bitacora','Insert','{""}','{"(1,1,\"2015-07-06 15:10:14-05\",qweq,1,1,1,\"<p>qweqwe</p>
\",4006,\"Inicio - TOTORA SISA1510141.pdf\",pdf,0)"}','1','::1','::1','2015-07-06 15:10:14-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('460','1','metas','Insert','{""}','{"(1,nombre,\"Inicio - TOTORA SISA.pdf\",1)"}','1','::1','::1','2015-07-06 15:10:14-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('461','1','metas','Insert','{""}','{"(1,nombre,\"Inicio - TOTORA SISA.pdf\",1)"}','2','::1','::1','2015-07-06 15:10:14-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('462','1','metas','Insert','{""}','{"(1,nombre,\"Inicio - TOTORA SISA.pdf\",1)"}','3','::1','::1','2015-07-06 15:10:14-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('463','1','enviados','Insert','{""}','{"(1,1,1,\"2015-07-06 15:10:14-05\",0,0,1)"}','1','::1','::1','2015-07-06 15:10:14-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('464','1','recibidos','Insert','{""}','{"(1,1,1,\"2015-07-06 15:10:14-05\",1,{1})"}','1','::1','::1','2015-07-06 15:10:14-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('465','1','archivo','Insert','{""}','{"(2,qw,q-2015-07-06-SD-2-2,1,1,\"2015-07-06 15:10:36-05\",0)"}','2','::1','::1','2015-07-06 15:10:36-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('466','1','bitacora','Insert','{""}','{"(2,2,\"2015-07-06 15:10:36-05\",qwe,1,1,1,\"<p>qweqw</p>
\",0,\"\",\"\",0)"}','2','::1','::1','2015-07-06 15:10:36-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('467','1','enviados','Insert','{""}','{"(2,2,2,\"2015-07-06 15:10:36-05\",0,0,2)"}','2','::1','::1','2015-07-06 15:10:36-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('468','1','recibidos','Insert','{""}','{"(2,2,2,\"2015-07-06 15:10:36-05\",1,{2})"}','2','::1','::1','2015-07-06 15:10:36-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('469','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-10 14:11:48-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('470','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-15 10:03:35-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('471','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-15 10:31:59-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('472','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-17 09:55:44-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('473','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-20 10:20:14-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('474','1','archivo','Insert','{""}','{"(3,GHGJ,F-2015-07-20-doc-3-3,1,1,\"2015-07-20 12:51:14-05\",0)"}','3','::1','::1','2015-07-20 12:51:14-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('475','1','bitacora','Insert','{""}','{"(3,3,\"2015-07-20 12:51:14-05\",JHGHJGHJ,1,1,1,\"\",195584,FICHA_TECNICA_DEVIVA1251143.doc,doc,0)"}','3','::1','::1','2015-07-20 12:51:14-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('476','1','metas','Insert','{""}','{"(3,tamaño,4006,1)"}','4','::1','::1','2015-07-20 12:51:14-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('477','1','metas','Insert','{""}','{"(3,tamaño,4006,1)"}','5','::1','::1','2015-07-20 12:51:14-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('478','1','metas','Insert','{""}','{"(3,tamaño,4006,1)"}','6','::1','::1','2015-07-20 12:51:14-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('479','1','enviados','Insert','{""}','{"(3,3,3,\"2015-07-20 12:51:14-05\",0,0,1)"}','3','::1','::1','2015-07-20 12:51:14-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('480','1','enviados','Insert','{""}','{"(4,3,3,\"2015-07-20 12:51:14-05\",0,0,2)"}','4','::1','::1','2015-07-20 12:51:14-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('481','1','recibidos','Insert','{""}','{"(3,3,3,\"2015-07-20 12:51:14-05\",1,\"{\"\"1,2\"\"}\")"}','3','::1','::1','2015-07-20 12:51:14-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('482','1','archivo','Insert','{""}','{"(4,fhfgh,I-2015-07-20-xlsx-4-4,1,1,\"2015-07-20 12:52:46-05\",0)"}','4','::1','::1','2015-07-20 12:52:46-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('483','1','bitacora','Insert','{""}','{"(4,4,\"2015-07-20 12:52:46-05\",ghfgh,1,1,1,\"\",14996,INFORMATICA1504241252464.xlsx,xlsx,0)"}','4','::1','::1','2015-07-20 12:52:46-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('484','1','metas','Insert','{""}','{"(4,nombre,FICHA_TECNICA_DEVIVA.doc,3)"}','7','::1','::1','2015-07-20 12:52:46-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('485','1','metas','Insert','{""}','{"(4,nombre,FICHA_TECNICA_DEVIVA.doc,3)"}','8','::1','::1','2015-07-20 12:52:46-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('486','1','metas','Insert','{""}','{"(4,nombre,FICHA_TECNICA_DEVIVA.doc,3)"}','9','::1','::1','2015-07-20 12:52:46-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('487','1','enviados','Insert','{""}','{"(5,4,4,\"2015-07-20 12:52:46-05\",0,0,1)"}','5','::1','::1','2015-07-20 12:52:46-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('488','1','recibidos','Insert','{""}','{"(4,4,4,\"2015-07-20 12:52:46-05\",1,{1})"}','4','::1','::1','2015-07-20 12:52:46-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('489','1','archivo','Insert','{""}','{"(5,qwe,P-2015-07-20-pptx-5-5,1,1,\"2015-07-20 12:53:51-05\",0)"}','5','::1','::1','2015-07-20 12:53:51-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('490','1','bitacora','Insert','{""}','{"(5,5,\"2015-07-20 12:53:51-05\",qweqwe,1,1,1,\"<p>qwe</p>
\",29795,Presentación11253515.pptx,pptx,0)"}','5','::1','::1','2015-07-20 12:53:51-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('491','1','metas','Insert','{""}','{"(5,tipo,doc,3)"}','10','::1','::1','2015-07-20 12:53:51-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('492','1','metas','Insert','{""}','{"(5,tipo,doc,3)"}','11','::1','::1','2015-07-20 12:53:51-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('493','1','metas','Insert','{""}','{"(5,tipo,doc,3)"}','12','::1','::1','2015-07-20 12:53:51-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('494','1','enviados','Insert','{""}','{"(6,5,5,\"2015-07-20 12:53:51-05\",0,0,1)"}','6','::1','::1','2015-07-20 12:53:51-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('495','1','recibidos','Insert','{""}','{"(5,5,5,\"2015-07-20 12:53:51-05\",1,{1})"}','5','::1','::1','2015-07-20 12:53:51-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('496','1','archivo','Insert','{""}','{"(6,rer,S-2015-07-20-jpg-6-6,1,1,\"2015-07-20 12:54:29-05\",0)"}','6','::1','::1','2015-07-20 12:54:29-05','Inserción de datos en la tabla archivo','0');
INSERT INTO auditoria_sistema VALUES ('497','1','bitacora','Insert','{""}','{"(6,6,\"2015-07-20 12:54:29-05\",erwer,1,1,1,\"\",119726,\"Sin título-11254296.jpg\",jpg,0)"}','6','::1','::1','2015-07-20 12:54:29-05','Inserción de datos en la tabla bitacora','0');
INSERT INTO auditoria_sistema VALUES ('498','1','metas','Insert','{""}','{"(6,tamaño,195584,3)"}','13','::1','::1','2015-07-20 12:54:29-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('499','1','metas','Insert','{""}','{"(6,tamaño,195584,3)"}','14','::1','::1','2015-07-20 12:54:29-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('500','1','metas','Insert','{""}','{"(6,tamaño,195584,3)"}','15','::1','::1','2015-07-20 12:54:29-05','Inserción de datos en la tabla meta','0');
INSERT INTO auditoria_sistema VALUES ('501','1','enviados','Insert','{""}','{"(7,6,6,\"2015-07-20 12:54:29-05\",0,0,1)"}','7','::1','::1','2015-07-20 12:54:29-05','Inserción de datos en la tabla enviados. Envió del documento a los respectivos usuarios','0');
INSERT INTO auditoria_sistema VALUES ('502','1','recibidos','Insert','{""}','{"(6,6,6,\"2015-07-20 12:54:29-05\",1,{1})"}','6','::1','::1','2015-07-20 12:54:29-05','Inserción de datos en la tabla recibidos. Usuarios a los que se envio el archivo','0');
INSERT INTO auditoria_sistema VALUES ('503','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-22 14:51:39-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('504','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-23 14:49:57-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('505','1','usuario','Insert','{""}','{"(5,E115,Eqweqw,qweqwe,1,\"\",\"\",\"\",1,123123,\"Uniandes Ibarra\",1,1,\"2015-07-23 16:14:00-05\",Cédula,1002910345)"}','5','::1','::1','2015-07-23 16:14:00-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('506','1','clave','Insert','{""}','{"(5,MTIzMTIz,5)"}','5','::1','::1','2015-07-23 16:14:00-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('507','1','usuario','Insert','{""}','{"(3,E113,Eqweqwe,qweqwe,1,\"\",\"\",\"\",1,qweqwe,\"Uniandes Ibarra\",1,1,\"2015-07-23 16:14:32-05\",Cédula,1002910345)"}','3','::1','::1','2015-07-23 16:14:32-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('508','1','clave','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:14:32-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('509','1','usuario','Insert','{""}','{"(3,Q113,Qweqwe,qwe,1,\"\",\"\",\"\",1,123123,\"Uniandes Ibarra\",1,1,\"2015-07-23 16:20:00-05\",Cédula,1002910345)"}','3','::1','::1','2015-07-23 16:20:00-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('510','1','clave','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('511','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('512','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('513','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('514','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('515','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('516','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('517','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('518','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('519','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('520','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('521','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('522','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('523','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('524','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('525','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('526','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('527','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('528','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('529','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('530','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:00-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('531','1','usuario','Insert','{""}','{"(3,Q113,Qwe,123123,1,\"\",\"\",\"\",1,123123,qweqwe,1,1,\"2015-07-23 16:20:58-05\",Cédula,1002910345)"}','3','::1','::1','2015-07-23 16:20:58-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('532','1','clave','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('533','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('534','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('535','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('536','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('537','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('538','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('539','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('540','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('541','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('542','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('543','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('544','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('545','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('547','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('548','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('549','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('550','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('551','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('552','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:20:58-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('553','1','usuario','Insert','{""}','{"(3,Q113,Qweqwe,qweqw,1,\"\",\"\",\"\",1,123123,\"Uniandes Ibarra\",1,1,\"2015-07-23 16:21:34-05\",Cédula,1002910345)"}','3','::1','::1','2015-07-23 16:21:34-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('554','1','clave','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('555','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('556','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('557','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('558','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('559','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('560','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('561','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('562','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('563','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('564','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('565','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('566','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('567','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('568','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('569','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('570','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('571','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('572','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('573','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('574','1','accesos','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:21:34-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('575','1','usuario','Insert','{""}','{"(3,Q113,Qweqwe,qweqwe,1,\"\",\"\",\"\",1,123123,\"Uniandes Ibarra\",1,1,\"2015-07-23 16:22:25-05\",Cédula,1002910345)"}','3','::1','::1','2015-07-23 16:22:25-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('576','1','clave','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:22:25-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('577','1','accesos','Insert','{""}','{"(21,3,1,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('578','1','accesos','Insert','{""}','{"(22,3,2,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('579','1','accesos','Insert','{""}','{"(23,3,3,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('580','1','accesos','Insert','{""}','{"(24,3,4,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('581','1','accesos','Insert','{""}','{"(25,3,5,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('582','1','accesos','Insert','{""}','{"(26,3,6,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('583','1','accesos','Insert','{""}','{"(27,3,7,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('584','1','accesos','Insert','{""}','{"(28,3,8,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('585','1','accesos','Insert','{""}','{"(29,3,9,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('586','1','accesos','Insert','{""}','{"(30,3,10,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('587','1','accesos','Insert','{""}','{"(31,3,11,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('588','1','accesos','Insert','{""}','{"(32,3,12,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('589','1','accesos','Insert','{""}','{"(33,3,13,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('590','1','accesos','Insert','{""}','{"(34,3,14,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('591','1','accesos','Insert','{""}','{"(35,3,15,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('592','1','accesos','Insert','{""}','{"(36,3,16,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('593','1','accesos','Insert','{""}','{"(37,3,17,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('594','1','accesos','Insert','{""}','{"(38,3,18,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('595','1','accesos','Insert','{""}','{"(39,3,19,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('596','1','accesos','Insert','{""}','{"(40,3,20,0)"}','3','::1','::1','2015-07-23 16:22:25-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('597','1','usuario','Insert','{""}','{"(3,Q113,Qweqw,qweqw,1,\"\",\"\",\"\",2,123123,\"Uniandes Ibarra\",1,1,\"2015-07-23 16:25:09-05\",\"\",1002910345)"}','3','::1','::1','2015-07-23 16:25:09-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('598','1','clave','Insert','{""}','{""}','3','::1','::1','2015-07-23 16:25:09-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('599','1','accesos','Insert','{""}','{"(21,3,1,0)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('600','1','accesos','Insert','{""}','{"(22,3,2,0)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('601','1','accesos','Insert','{""}','{"(23,3,3,0)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('602','1','accesos','Insert','{""}','{"(24,3,4,0)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('603','1','accesos','Insert','{""}','{"(25,3,5,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('604','1','accesos','Insert','{""}','{"(26,3,6,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('605','1','accesos','Insert','{""}','{"(27,3,7,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('606','1','accesos','Insert','{""}','{"(28,3,8,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('607','1','accesos','Insert','{""}','{"(29,3,9,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('608','1','accesos','Insert','{""}','{"(30,3,10,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('609','1','accesos','Insert','{""}','{"(31,3,11,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('610','1','accesos','Insert','{""}','{"(32,3,12,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('611','1','accesos','Insert','{""}','{"(33,3,13,0)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('612','1','accesos','Insert','{""}','{"(34,3,14,0)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('613','1','accesos','Insert','{""}','{"(35,3,15,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('614','1','accesos','Insert','{""}','{"(36,3,16,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('615','1','accesos','Insert','{""}','{"(37,3,17,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('616','1','accesos','Insert','{""}','{"(38,3,18,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('617','1','accesos','Insert','{""}','{"(39,3,19,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('618','1','accesos','Insert','{""}','{"(40,3,20,1)"}','3','::1','::1','2015-07-23 16:25:09-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('619','1','pais','Insert','{""}','{"(237,\"\",\"\")"}','237','::1','::1','2015-07-23 16:29:41-05','Inserción de datos en la tabla pais','0');
INSERT INTO auditoria_sistema VALUES ('620','1','usuario','Insert','{""}','{"(2,Q112,Qweqwe,123,1,\"\",\"\",\"\",1,123,\"Uniandes Ibarra\",1,1,\"2015-07-23 17:01:52-05\",Cédula,1002910345)"}','2','::1','::1','2015-07-23 17:01:52-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('621','1','clave','Insert','{""}','{""}','2','::1','::1','2015-07-23 17:01:52-05','Inserción de datos en la tabla usuario','0');
INSERT INTO auditoria_sistema VALUES ('622','1','accesos','Insert','{""}','{"(21,2,1,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('623','1','accesos','Insert','{""}','{"(22,2,2,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('624','1','accesos','Insert','{""}','{"(23,2,3,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('625','1','accesos','Insert','{""}','{"(24,2,4,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('626','1','accesos','Insert','{""}','{"(25,2,5,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('627','1','accesos','Insert','{""}','{"(26,2,6,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('628','1','accesos','Insert','{""}','{"(27,2,7,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('629','1','accesos','Insert','{""}','{"(28,2,8,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('630','1','accesos','Insert','{""}','{"(29,2,9,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('631','1','accesos','Insert','{""}','{"(30,2,10,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('632','1','accesos','Insert','{""}','{"(31,2,11,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('633','1','accesos','Insert','{""}','{"(32,2,12,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('634','1','accesos','Insert','{""}','{"(33,2,13,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('635','1','accesos','Insert','{""}','{"(34,2,14,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('636','1','accesos','Insert','{""}','{"(35,2,15,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('637','1','accesos','Insert','{""}','{"(36,2,16,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('638','1','accesos','Insert','{""}','{"(37,2,17,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('639','1','accesos','Insert','{""}','{"(38,2,18,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('640','1','accesos','Insert','{""}','{"(39,2,19,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('641','1','accesos','Insert','{""}','{"(40,2,20,0)"}','2','::1','::1','2015-07-23 17:01:52-05','Creacion de los permisos para el usuario','0');
INSERT INTO auditoria_sistema VALUES ('642','1','usuario','Login','{""}','{""}',NULL,'::1','::1','2015-07-24 10:58:17-05','Ingreso al sistema por el usuario admin','0');
INSERT INTO auditoria_sistema VALUES ('643',NULL,'auditoria_sistema','Backup','{""}','{""}',NULL,'::1','::1','2015-07-24 00:00:00-05','Backup de la base de datos','0');
INSERT INTO auditoria_sistema VALUES ('644',NULL,'auditoria_sistema','Backup','{""}','{""}',NULL,'::1','::1','2015-07-24 00:00:00-05','Backup de la base de datos','0');
INSERT INTO auditoria_sistema VALUES ('645',NULL,'auditoria_sistema','Backup','{""}','{""}',NULL,'::1','::1','2015-07-24 00:00:00-05','Backup de la base de datos','0');
INSERT INTO auditoria_sistema VALUES ('646',NULL,'auditoria_sistema','Backup','{""}','{""}',NULL,'::1','::1','2015-07-24 00:00:00-05','Backup de la base de datos','0');
INSERT INTO auditoria_sistema VALUES ('647',NULL,'auditoria_sistema','Backup','{""}','{""}',NULL,'::1','::1','2015-07-24 00:00:00-05','Backup de la base de datos','0');
INSERT INTO auditoria_sistema VALUES ('648',NULL,'auditoria_sistema','Backup','{""}','{""}',NULL,'::1','::1','2015-07-24 00:00:00-05','Backup de la base de datos','0');
INSERT INTO auditoria_sistema VALUES ('649',NULL,'auditoria_sistema','Backup','{""}','{""}',NULL,'::1','::1','2015-07-24 00:00:00-05','Backup de la base de datos','0');
INSERT INTO auditoria_sistema VALUES ('650',NULL,'auditoria_sistema','Backup','{""}','{""}',NULL,'::1','::1','2015-07-24 00:00:00-05','Backup de la base de datos','0');


--
-- Creating index for 'auditoria_sistema'
--

ALTER TABLE ONLY  auditoria_sistema  ADD CONSTRAINT  auditoria_sistema_pkey  PRIMARY KEY  (id_sistema);

--
-- Estrutura de la tabla 'bitacora
--

DROP TABLE bitacora CASCADE;
CREATE TABLE bitacora (
id_bitacora int4 NOT NULL,
id_archivo int4,
fecha_cambio timestamp with time zone,
asunto_cambio text,
id_usuario int4,
id_tipo_documento int4,
id_medio_recepcion int4,
archivo_bytea bytea,
observaciones text,
peso text,
referencia text,
tipo text,
estado int4
);

--
-- Creating data for 'bitacora'
--

INSERT INTO bitacora VALUES ('2','2','2015-07-06 15:10:36-05','qwe','1','2','1','\x','<p>qweqw</p>
','100',NULL,NULL,'0');
INSERT INTO bitacora VALUES ('1','1','2015-07-06 15:10:14-05','qweqDFLJS ÑK JKJ SKÑ ÑKJQOROE WÑIWJEROPU  UWRUW PI','1','1','1','\x','<p>qweqwe</p>
','4006','Inicio - TOTORA SISA1510141.pdf','pdf','0');
INSERT INTO bitacora VALUES ('3','3','2015-07-20 12:51:14-05','JHGHJGHJ','1','1','1','\x',NULL,'195584','FICHA_TECNICA_DEVIVA1251143.doc','doc','0');
INSERT INTO bitacora VALUES ('4','4','2015-07-20 12:52:46-05','ghfgh','1','1','1','\x',NULL,'14996','INFORMATICA1504241252464.xlsx','xlsx','0');
INSERT INTO bitacora VALUES ('5','5','2015-07-20 12:53:51-05','qweqwe','1','1','1','\x','<p>qwe</p>
','29795','Presentación11253515.pptx','pptx','0');
INSERT INTO bitacora VALUES ('6','6','2015-07-20 12:54:29-05','erwer','1','1','1','\x',NULL,'119726','Sin título-11254296.jpg','jpg','0');


--
-- Creating index for 'bitacora'
--

ALTER TABLE ONLY  bitacora  ADD CONSTRAINT  bitacora_pkey  PRIMARY KEY  (id_bitacora);

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

INSERT INTO categorias VALUES ('1','Administrador','ADM','0');
INSERT INTO categorias VALUES ('2','Usuarios','USER','1');


--
-- Creating index for 'categorias'
--

ALTER TABLE ONLY  categorias  ADD CONSTRAINT  categorias_pkey  PRIMARY KEY  (id_categoria);

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

INSERT INTO ciudad VALUES ('2','Chordeleg','1');
INSERT INTO ciudad VALUES ('3','Cuenca','1');
INSERT INTO ciudad VALUES ('4','El Pan','1');
INSERT INTO ciudad VALUES ('5','Giron','1');
INSERT INTO ciudad VALUES ('6','Guachapala','1');
INSERT INTO ciudad VALUES ('7','Gualaceo','1');
INSERT INTO ciudad VALUES ('8','Nabon','1');
INSERT INTO ciudad VALUES ('9','Oña','1');
INSERT INTO ciudad VALUES ('10','Paute','1');
INSERT INTO ciudad VALUES ('11','Pucara','1');
INSERT INTO ciudad VALUES ('12','San Fernando','1');
INSERT INTO ciudad VALUES ('13','Santa Isabel','1');
INSERT INTO ciudad VALUES ('14','Sevilla De Oro','1');
INSERT INTO ciudad VALUES ('15','Sigsig','1');
INSERT INTO ciudad VALUES ('16','Caluma','2');
INSERT INTO ciudad VALUES ('17','Chillanes','2');
INSERT INTO ciudad VALUES ('18','Chimbo','2');
INSERT INTO ciudad VALUES ('19','Echeandia','2');
INSERT INTO ciudad VALUES ('20','Guaranda','2');
INSERT INTO ciudad VALUES ('21','Las Naves','2');
INSERT INTO ciudad VALUES ('22','San Miguel','2');
INSERT INTO ciudad VALUES ('23','Azogues','3');
INSERT INTO ciudad VALUES ('24','Biblian','3');
INSERT INTO ciudad VALUES ('25','Cañar','3');
INSERT INTO ciudad VALUES ('26','Deleg','3');
INSERT INTO ciudad VALUES ('27','La Troncal','3');
INSERT INTO ciudad VALUES ('28','Suscal','3');
INSERT INTO ciudad VALUES ('29','Tambo','3');
INSERT INTO ciudad VALUES ('30','Espejo','4');
INSERT INTO ciudad VALUES ('31','Mira','4');
INSERT INTO ciudad VALUES ('32','Montufar','4');
INSERT INTO ciudad VALUES ('33','San Pedro De Huaca','4');
INSERT INTO ciudad VALUES ('34','Tulcan','4');
INSERT INTO ciudad VALUES ('35','Alausi','5');
INSERT INTO ciudad VALUES ('36','Chambo','5');
INSERT INTO ciudad VALUES ('37','Chunchi','5');
INSERT INTO ciudad VALUES ('38','Colta','5');
INSERT INTO ciudad VALUES ('39','Cumanda','5');
INSERT INTO ciudad VALUES ('40','Guamote','5');
INSERT INTO ciudad VALUES ('41','Guano','5');
INSERT INTO ciudad VALUES ('42','Pallatanga','5');
INSERT INTO ciudad VALUES ('43','Penipe','5');
INSERT INTO ciudad VALUES ('44','Riobamba','5');
INSERT INTO ciudad VALUES ('45','La Mana','6');
INSERT INTO ciudad VALUES ('46','Latacunga','6');
INSERT INTO ciudad VALUES ('47','Pangua','6');
INSERT INTO ciudad VALUES ('48','Pujili','6');
INSERT INTO ciudad VALUES ('49','Salcedo','6');
INSERT INTO ciudad VALUES ('50','Saquisili','6');
INSERT INTO ciudad VALUES ('51','Sigchos','6');
INSERT INTO ciudad VALUES ('52','Arenillas','7');
INSERT INTO ciudad VALUES ('53','Atahualpa','7');
INSERT INTO ciudad VALUES ('54','Balsas','7');
INSERT INTO ciudad VALUES ('55','Chilla','7');
INSERT INTO ciudad VALUES ('56','El Guabo','7');
INSERT INTO ciudad VALUES ('57','Huaquillas','7');
INSERT INTO ciudad VALUES ('58','Las Lajas','7');
INSERT INTO ciudad VALUES ('59','Machala','7');
INSERT INTO ciudad VALUES ('60','Marcabeli','7');
INSERT INTO ciudad VALUES ('61','Pasaje','7');
INSERT INTO ciudad VALUES ('62','Pinas','7');
INSERT INTO ciudad VALUES ('63','Portovelo','7');
INSERT INTO ciudad VALUES ('64','Santa Rosa','7');
INSERT INTO ciudad VALUES ('65','Zaruma','7');
INSERT INTO ciudad VALUES ('66','Atacames','8');
INSERT INTO ciudad VALUES ('67','Eloy Alfaro','8');
INSERT INTO ciudad VALUES ('68','Esmeraldas','8');
INSERT INTO ciudad VALUES ('69','Muisne','8');
INSERT INTO ciudad VALUES ('70','Quininde','8');
INSERT INTO ciudad VALUES ('71','Rio Verde','8');
INSERT INTO ciudad VALUES ('72','San Lorenzo','8');
INSERT INTO ciudad VALUES ('73','Isabela','9');
INSERT INTO ciudad VALUES ('74','San Cristobal','9');
INSERT INTO ciudad VALUES ('75','Santa Cruz','9');
INSERT INTO ciudad VALUES ('76','Alfredo Baquerizo Moreno (Jujan)','10');
INSERT INTO ciudad VALUES ('77','Balao','10');
INSERT INTO ciudad VALUES ('78','Balzar','10');
INSERT INTO ciudad VALUES ('79','Colimes','10');
INSERT INTO ciudad VALUES ('80','Daule','10');
INSERT INTO ciudad VALUES ('81','Duran','10');
INSERT INTO ciudad VALUES ('82','El Triunfo','10');
INSERT INTO ciudad VALUES ('83','Empalme','10');
INSERT INTO ciudad VALUES ('84','General Antonio Elizalde (Bucay)','10');
INSERT INTO ciudad VALUES ('85','General Villamil (Playas)','10');
INSERT INTO ciudad VALUES ('86','Guayaquil','10');
INSERT INTO ciudad VALUES ('87','Isidro Ayora','10');
INSERT INTO ciudad VALUES ('88','Lomas De Sargentillo','10');
INSERT INTO ciudad VALUES ('89','Marcelino Mariduena','10');
INSERT INTO ciudad VALUES ('90','Milagro','10');
INSERT INTO ciudad VALUES ('91','Naranjal','10');
INSERT INTO ciudad VALUES ('92','Naranjito','10');
INSERT INTO ciudad VALUES ('93','Nobol (Narcisa De Jesus)','10');
INSERT INTO ciudad VALUES ('94','Palestina','10');
INSERT INTO ciudad VALUES ('95','Pedro Carbo','10');
INSERT INTO ciudad VALUES ('96','Samborondon','10');
INSERT INTO ciudad VALUES ('97','Santa Lucia','10');
INSERT INTO ciudad VALUES ('98','Simon Bolivar','10');
INSERT INTO ciudad VALUES ('99','Urbina Jado (Salitre)','10');
INSERT INTO ciudad VALUES ('100','Yaguachi','10');
INSERT INTO ciudad VALUES ('101','Atuntaqui (Antonio Ante)','11');
INSERT INTO ciudad VALUES ('102','Cotacachi','11');
INSERT INTO ciudad VALUES ('103','Ibarra','11');
INSERT INTO ciudad VALUES ('104','Otavalo','11');
INSERT INTO ciudad VALUES ('105','Pimampiro','11');
INSERT INTO ciudad VALUES ('106','Urcuqui','11');
INSERT INTO ciudad VALUES ('107','Calvas (Cariamanga)','12');
INSERT INTO ciudad VALUES ('108','Catamayo','12');
INSERT INTO ciudad VALUES ('109','Celica','12');
INSERT INTO ciudad VALUES ('110','Chaguarpamba','12');
INSERT INTO ciudad VALUES ('111','Espindola','12');
INSERT INTO ciudad VALUES ('112','Gonzanama','12');
INSERT INTO ciudad VALUES ('113','Loja','12');
INSERT INTO ciudad VALUES ('114','Macara','12');
INSERT INTO ciudad VALUES ('115','Paltas (Catacocha)','12');
INSERT INTO ciudad VALUES ('116','Pindal','12');
INSERT INTO ciudad VALUES ('117','Puyango (Alamor)','12');
INSERT INTO ciudad VALUES ('118','Quilanga','12');
INSERT INTO ciudad VALUES ('119','Saraguro','12');
INSERT INTO ciudad VALUES ('120','Sozoranga','12');
INSERT INTO ciudad VALUES ('121','Zapotillo','12');
INSERT INTO ciudad VALUES ('122','Baba','13');
INSERT INTO ciudad VALUES ('123','Babahoyo','13');
INSERT INTO ciudad VALUES ('124','Buena Fe','13');
INSERT INTO ciudad VALUES ('125','Mocache','13');
INSERT INTO ciudad VALUES ('126','Montalvo','13');
INSERT INTO ciudad VALUES ('127','Palenque','13');
INSERT INTO ciudad VALUES ('128','Pueblo Viejo','13');
INSERT INTO ciudad VALUES ('129','Quevedo','13');
INSERT INTO ciudad VALUES ('130','Urdaneta','13');
INSERT INTO ciudad VALUES ('131','Valencia','13');
INSERT INTO ciudad VALUES ('132','Ventanas','13');
INSERT INTO ciudad VALUES ('133','Vinces','13');
INSERT INTO ciudad VALUES ('134','24 De Mayo','14');
INSERT INTO ciudad VALUES ('135','Bolivar','14');
INSERT INTO ciudad VALUES ('136','Chone','14');
INSERT INTO ciudad VALUES ('137','El Carmen','14');
INSERT INTO ciudad VALUES ('138','Flavio Alfaro','14');
INSERT INTO ciudad VALUES ('139','Jama','14');
INSERT INTO ciudad VALUES ('140','Jaramijo','14');
INSERT INTO ciudad VALUES ('141','Jipijapa','14');
INSERT INTO ciudad VALUES ('142','Junin','14');
INSERT INTO ciudad VALUES ('143','Manta','14');
INSERT INTO ciudad VALUES ('144','Montecristi','14');
INSERT INTO ciudad VALUES ('145','Olmedo','14');
INSERT INTO ciudad VALUES ('146','Pajan','14');
INSERT INTO ciudad VALUES ('147','Pedernales','14');
INSERT INTO ciudad VALUES ('148','Pichincha','14');
INSERT INTO ciudad VALUES ('149','Portoviejo','14');
INSERT INTO ciudad VALUES ('1','Camilo Ponce','1');
INSERT INTO ciudad VALUES ('150','Puerto Lopez','14');
INSERT INTO ciudad VALUES ('151','Rocafuerte','14');
INSERT INTO ciudad VALUES ('152','San Vicente','14');
INSERT INTO ciudad VALUES ('153','Santa Ana','14');
INSERT INTO ciudad VALUES ('154','Sucre','14');
INSERT INTO ciudad VALUES ('155','Tosagua','14');
INSERT INTO ciudad VALUES ('156','Gualaquiza','15');
INSERT INTO ciudad VALUES ('157','Huamboya','15');
INSERT INTO ciudad VALUES ('158','Limon indanza','15');
INSERT INTO ciudad VALUES ('159','Logroño','15');
INSERT INTO ciudad VALUES ('160','Morona','15');
INSERT INTO ciudad VALUES ('161','Pablo VI','15');
INSERT INTO ciudad VALUES ('162','Palora','15');
INSERT INTO ciudad VALUES ('163','San Juan Bosco','15');
INSERT INTO ciudad VALUES ('164','Santiago','15');
INSERT INTO ciudad VALUES ('165','Sucua','15');
INSERT INTO ciudad VALUES ('166','Taisha','15');
INSERT INTO ciudad VALUES ('167','Twintza','15');
INSERT INTO ciudad VALUES ('168','Archidona','16');
INSERT INTO ciudad VALUES ('169','Carlos J. Arosemena','16');
INSERT INTO ciudad VALUES ('170','El Chaco','16');
INSERT INTO ciudad VALUES ('171','Quijos','16');
INSERT INTO ciudad VALUES ('172','Tena','16');
INSERT INTO ciudad VALUES ('173','Aguarico','17');
INSERT INTO ciudad VALUES ('174','La Joya De Los Sachas','17');
INSERT INTO ciudad VALUES ('175','Loreto','17');
INSERT INTO ciudad VALUES ('176','Orellana','17');
INSERT INTO ciudad VALUES ('177','Arajuno','18');
INSERT INTO ciudad VALUES ('178','Mera','18');
INSERT INTO ciudad VALUES ('179','Pastaza','18');
INSERT INTO ciudad VALUES ('180','Santa Clara','18');
INSERT INTO ciudad VALUES ('181','Cayambe','19');
INSERT INTO ciudad VALUES ('182','Mejia','19');
INSERT INTO ciudad VALUES ('183','Pedro Moncayo','19');
INSERT INTO ciudad VALUES ('184','Pedro Vicente Maldonado','19');
INSERT INTO ciudad VALUES ('185','Puerto Quito','19');
INSERT INTO ciudad VALUES ('186','Quito','19');
INSERT INTO ciudad VALUES ('187','Rumiñahui','19');
INSERT INTO ciudad VALUES ('188','San Miguel De Los Bancos','19');
INSERT INTO ciudad VALUES ('189','La Libertad','20');
INSERT INTO ciudad VALUES ('190','Salinas','20');
INSERT INTO ciudad VALUES ('191','Santa Elena','20');
INSERT INTO ciudad VALUES ('192','Santo Domingo De Los Tsáchilas','21');
INSERT INTO ciudad VALUES ('193','Cascales','22');
INSERT INTO ciudad VALUES ('194','Cuyabeno','22');
INSERT INTO ciudad VALUES ('195','Gonzalo Pizarro','22');
INSERT INTO ciudad VALUES ('196','Lago Agrio','22');
INSERT INTO ciudad VALUES ('197','Putumayo','22');
INSERT INTO ciudad VALUES ('198','Shushufindi','22');
INSERT INTO ciudad VALUES ('199','Sucumbios','22');
INSERT INTO ciudad VALUES ('200','Ambato','23');
INSERT INTO ciudad VALUES ('201','Baños De Agua Santa','23');
INSERT INTO ciudad VALUES ('202','Cevallos','23');
INSERT INTO ciudad VALUES ('203','Mocha','23');
INSERT INTO ciudad VALUES ('204','Patate','23');
INSERT INTO ciudad VALUES ('205','Quero','23');
INSERT INTO ciudad VALUES ('206','San Pedro De Pelileo','23');
INSERT INTO ciudad VALUES ('207','Santiago De Pillaro','23');
INSERT INTO ciudad VALUES ('208','Tisaleo','23');
INSERT INTO ciudad VALUES ('209','Centinela Del Condor','24');
INSERT INTO ciudad VALUES ('210','Chinchipe','24');
INSERT INTO ciudad VALUES ('211','El Pangui','24');
INSERT INTO ciudad VALUES ('212','Nangaritza','24');
INSERT INTO ciudad VALUES ('213','Palanda','24');
INSERT INTO ciudad VALUES ('214','Yacuambi','24');
INSERT INTO ciudad VALUES ('215','Yantzaza','24');
INSERT INTO ciudad VALUES ('216','Zamora','24');


--
-- Creating index for 'ciudad'
--

ALTER TABLE ONLY  ciudad  ADD CONSTRAINT  ciudad_pkey  PRIMARY KEY  (id_ciudad);

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

INSERT INTO clave VALUES ('1','YWRtaW4=','1');
INSERT INTO clave VALUES ('2','YWRtaW4=','2');
INSERT INTO clave VALUES ('3','MTIzMTIzMTIz','3');
INSERT INTO clave VALUES ('4','MTIzMTIzMTIz','4');
INSERT INTO clave VALUES ('5','MTIzMTIz','5');


--
-- Creating index for 'clave'
--

ALTER TABLE ONLY  clave  ADD CONSTRAINT  clave_pkey  PRIMARY KEY  (id_clave);

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

INSERT INTO departamento VALUES ('3','FIN','FINANCIERO','0');
INSERT INTO departamento VALUES ('4','DOC','DOCTORADO','0');
INSERT INTO departamento VALUES ('1','ADM','Administrador','1');
INSERT INTO departamento VALUES ('2','SEC','Secretaria Administrativa','0');


--
-- Creating index for 'departamento'
--

ALTER TABLE ONLY  departamento  ADD CONSTRAINT  departamento_pkey  PRIMARY KEY  (id_departamento);

--
-- Estrutura de la tabla 'enviados'
--

DROP TABLE enviados CASCADE;
CREATE TABLE enviados (
id_envio int4 NOT NULL,
id_archivo int4,
id_bitacora int4,
fecha timestamp with time zone,
estado int4,
leido int4,
id_usuario text
);

--
-- Creating data for 'enviados'
--

INSERT INTO enviados VALUES ('1','1','1','2015-07-06 15:10:14-05','0','0','1');
INSERT INTO enviados VALUES ('2','2','2','2015-07-06 15:10:36-05','0','0','2');
INSERT INTO enviados VALUES ('3','3','3','2015-07-20 12:51:14-05','0','0','1');
INSERT INTO enviados VALUES ('4','3','3','2015-07-20 12:51:14-05','0','0','2');
INSERT INTO enviados VALUES ('5','4','4','2015-07-20 12:52:46-05','0','0','1');
INSERT INTO enviados VALUES ('6','5','5','2015-07-20 12:53:51-05','0','0','1');
INSERT INTO enviados VALUES ('7','6','6','2015-07-20 12:54:29-05','0','0','1');


--
-- Creating index for 'enviados'
--

ALTER TABLE ONLY  enviados  ADD CONSTRAINT  enviados_pkey  PRIMARY KEY  (id_envio);

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

INSERT INTO medio_recepcion VALUES ('1','EMAIL','Correo Electronico','0');
INSERT INTO medio_recepcion VALUES ('2','FIS','Físico','0');


--
-- Creating index for 'medio_recepcion'
--

ALTER TABLE ONLY  medio_recepcion  ADD CONSTRAINT  medio_recepcion_pkey  PRIMARY KEY  (id_medio);

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

INSERT INTO metas VALUES ('1','nombre','Inicio - TOTORA SISA.pdf','1');
INSERT INTO metas VALUES ('2','tipo','pdf','1');
INSERT INTO metas VALUES ('3','tamaño','4006','1');
INSERT INTO metas VALUES ('4','nombre','FICHA_TECNICA_DEVIVA.doc','3');
INSERT INTO metas VALUES ('5','tipo','doc','3');
INSERT INTO metas VALUES ('6','tamaño','195584','3');
INSERT INTO metas VALUES ('7','nombre','INFORMATICA150424.xlsx','4');
INSERT INTO metas VALUES ('8','tipo','xlsx','4');
INSERT INTO metas VALUES ('9','tamaño','14996','4');
INSERT INTO metas VALUES ('10','nombre','Presentación1.pptx','5');
INSERT INTO metas VALUES ('11','tipo','pptx','5');
INSERT INTO metas VALUES ('12','tamaño','29795','5');
INSERT INTO metas VALUES ('13','nombre','Sin título-1.jpg','6');
INSERT INTO metas VALUES ('14','tipo','jpg','6');
INSERT INTO metas VALUES ('15','tamaño','119726','6');


--
-- Creating index for 'metas'
--

ALTER TABLE ONLY  metas  ADD CONSTRAINT  metas_pkey  PRIMARY KEY  (id_meta);

--
-- Estrutura de la tabla 'pais'
--

DROP TABLE pais CASCADE;
CREATE TABLE pais (
id_pais int4 NOT NULL,
codigo_pais text,
nombre_pais text
);

--
-- Creating data for 'pais'
--

INSERT INTO pais VALUES ('69','(+220)','Gambia');
INSERT INTO pais VALUES ('100','(+61)','Islas Cocos');
INSERT INTO pais VALUES ('5','(+244)','Angola');
INSERT INTO pais VALUES ('4','(+376)','Andorra');
INSERT INTO pais VALUES ('6','(+672)','Antártida');
INSERT INTO pais VALUES ('8','(+599)','Antiguas Antillas Holandesas');
INSERT INTO pais VALUES ('28','(+267)','Botsuana');
INSERT INTO pais VALUES ('29','(+55)','Brasil');
INSERT INTO pais VALUES ('30','(+673)','Brunéi');
INSERT INTO pais VALUES ('31','(+359)','Bulgaria');
INSERT INTO pais VALUES ('32','(+226)','Burkina Faso');
INSERT INTO pais VALUES ('33','(+257)','Burundi');
INSERT INTO pais VALUES ('34','(+975)','Bután');
INSERT INTO pais VALUES ('35','(+238)','Cabo Verde');
INSERT INTO pais VALUES ('36','(+855)','Camboya');
INSERT INTO pais VALUES ('9','(+966)','Arabia Saudí');
INSERT INTO pais VALUES ('10','(+213)','Argelia');
INSERT INTO pais VALUES ('37','(+237)','Camerún');
INSERT INTO pais VALUES ('11','(+54)','Argentina');
INSERT INTO pais VALUES ('12','(+374)','Armenia');
INSERT INTO pais VALUES ('38','(+1)','Canadá');
INSERT INTO pais VALUES ('13','(+297)','Aruba');
INSERT INTO pais VALUES ('14','(+61)','Australia');
INSERT INTO pais VALUES ('15','(+43)','Austria');
INSERT INTO pais VALUES ('16','(+970)','Autoridad Palestina');
INSERT INTO pais VALUES ('17','(+972)','Autoridad Palestina');
INSERT INTO pais VALUES ('39','(+57)','Colombia');
INSERT INTO pais VALUES ('18','(+994)','Azerbaiyán');
INSERT INTO pais VALUES ('19','(+880)','Bangladesh');
INSERT INTO pais VALUES ('20','(+1)','Barbados');
INSERT INTO pais VALUES ('40','(+269)','Comoras');
INSERT INTO pais VALUES ('42','(+850)','Corea del Norte');
INSERT INTO pais VALUES ('21','(+375)','Belarús');
INSERT INTO pais VALUES ('22','(+32)','Bélgica');
INSERT INTO pais VALUES ('23','(+501)','Belice');
INSERT INTO pais VALUES ('43','(+82)','Corea del Sur');
INSERT INTO pais VALUES ('24','(+229)','Benín');
INSERT INTO pais VALUES ('25','(+1)','Bermudas');
INSERT INTO pais VALUES ('44','(+506)','Costa Rica');
INSERT INTO pais VALUES ('46','(+53)','Cuba');
INSERT INTO pais VALUES ('47','(+235)','Chad');
INSERT INTO pais VALUES ('48','(+56)','Chile');
INSERT INTO pais VALUES ('49','(+86)','China');
INSERT INTO pais VALUES ('50','(+357)','Chipre');
INSERT INTO pais VALUES ('51','(+45)','Dinamarca');
INSERT INTO pais VALUES ('52','(+1)','Dominica');
INSERT INTO pais VALUES ('54','(+20)','Egipto');
INSERT INTO pais VALUES ('55','(+503)','El Salvador');
INSERT INTO pais VALUES ('56','(+971)','Emiratos Árabes Unidos');
INSERT INTO pais VALUES ('57','(+291)','Eritrea');
INSERT INTO pais VALUES ('58','(+421)','Eslovaquia');
INSERT INTO pais VALUES ('59','(+386)','Eslovenia');
INSERT INTO pais VALUES ('45','(Hrvatska)','Croacia');
INSERT INTO pais VALUES ('60','(+34)','España');
INSERT INTO pais VALUES ('61','(+1)','Estados Unidos');
INSERT INTO pais VALUES ('62','(+372)','Estonia');
INSERT INTO pais VALUES ('26','(+591)','Bolivia');
INSERT INTO pais VALUES ('27','(+387)','Bosnia y Herzegovina');
INSERT INTO pais VALUES ('41','(RDC)','Congo');
INSERT INTO pais VALUES ('63','(+251)','Etiopía');
INSERT INTO pais VALUES ('64','(+389)','Ex-República Yugoslava de Macedonia');
INSERT INTO pais VALUES ('65','(+63)','Filipinas');
INSERT INTO pais VALUES ('66','(+358)','Finlandia');
INSERT INTO pais VALUES ('67','(+33)','Francia');
INSERT INTO pais VALUES ('68','(+241)','Gabón');
INSERT INTO pais VALUES ('70','(+995)','Georgia');
INSERT INTO pais VALUES ('71','(+233)','Ghana');
INSERT INTO pais VALUES ('72','(+350)','Gibraltar');
INSERT INTO pais VALUES ('73','(+1)','Granada');
INSERT INTO pais VALUES ('74','(+30)','Grecia');
INSERT INTO pais VALUES ('75','(+299)','Groenlandia');
INSERT INTO pais VALUES ('76','(+590))','Guadalupe');
INSERT INTO pais VALUES ('77','(+1)','Guam');
INSERT INTO pais VALUES ('78','(+502)','Guatemala');
INSERT INTO pais VALUES ('79','(+594)','Guayana Francesa');
INSERT INTO pais VALUES ('80','(+44)','Guernsey');
INSERT INTO pais VALUES ('81','(+224)','Guinea');
INSERT INTO pais VALUES ('83','(+245)','Guinea-Bissau');
INSERT INTO pais VALUES ('82','(+240)','Guinea Ecuatorial');
INSERT INTO pais VALUES ('84','(+592)','Guyana');
INSERT INTO pais VALUES ('85','(+509)','Haití');
INSERT INTO pais VALUES ('86','(+504)','Honduras');
INSERT INTO pais VALUES ('121','(+996)','Kirguistán');
INSERT INTO pais VALUES ('122','(+686)','Kiribati');
INSERT INTO pais VALUES ('123','(+965)','Kuwait');
INSERT INTO pais VALUES ('124','(+856)','Laos');
INSERT INTO pais VALUES ('125','(+1)','Las Bahamas');
INSERT INTO pais VALUES ('126','(+266)','Lesoto');
INSERT INTO pais VALUES ('127','(+371)','Letonia');
INSERT INTO pais VALUES ('128','(+961)','Líbano');
INSERT INTO pais VALUES ('129','(+231)','Liberia');
INSERT INTO pais VALUES ('130','(+218)','Libia');
INSERT INTO pais VALUES ('131','(+423)','Liechtenstein');
INSERT INTO pais VALUES ('132','(+370)','Lituania');
INSERT INTO pais VALUES ('133','(+352)','Luxemburgo');
INSERT INTO pais VALUES ('134','(+853)','Macao RAE');
INSERT INTO pais VALUES ('135','(+261)','Madagascar');
INSERT INTO pais VALUES ('136','(+60)','Malasia');
INSERT INTO pais VALUES ('137','(+265)','Malawi');
INSERT INTO pais VALUES ('138','(+960)','Maldivas');
INSERT INTO pais VALUES ('87','(+852)','Hong Kong RAE');
INSERT INTO pais VALUES ('88','(+36)','Hungría');
INSERT INTO pais VALUES ('89','(+91)','India');
INSERT INTO pais VALUES ('90','(+62)','Indonesia');
INSERT INTO pais VALUES ('91','(+964)','Irak');
INSERT INTO pais VALUES ('92','(+98)','Irán');
INSERT INTO pais VALUES ('93','(+353)','Irlanda');
INSERT INTO pais VALUES ('94','(+247)','Isla Ascensión');
INSERT INTO pais VALUES ('95','(+47)','Isla Bouvet');
INSERT INTO pais VALUES ('96','(+61)','Isla Christmas');
INSERT INTO pais VALUES ('97','(+44)','Isla de Man');
INSERT INTO pais VALUES ('98','(+354)','Islandia');
INSERT INTO pais VALUES ('99','(+1)','Islas Caimán');
INSERT INTO pais VALUES ('101','(+682)','Islas Cook');
INSERT INTO pais VALUES ('102','(+298)','Islas Feroe');
INSERT INTO pais VALUES ('103','(+679)','Islas Fiji');
INSERT INTO pais VALUES ('104','(+500)','Islas Malvinas');
INSERT INTO pais VALUES ('105','(1+)','Islas Marianas del Norte');
INSERT INTO pais VALUES ('106','(+692)','Islas Marshall');
INSERT INTO pais VALUES ('107','(+1)','Islas menores alejadas de los Estados Unidos');
INSERT INTO pais VALUES ('108','(+77)','Islas Salomón');
INSERT INTO pais VALUES ('109','(+1)','Islas Turcas y Caicos');
INSERT INTO pais VALUES ('139','(+223)','Malí');
INSERT INTO pais VALUES ('110','(+1)','Islas Vírgenes Británicas');
INSERT INTO pais VALUES ('111','(+1)','Islas Vírgenes, EE.UU.');
INSERT INTO pais VALUES ('140','(+356)','Malta');
INSERT INTO pais VALUES ('141','(+212)','Marruecos');
INSERT INTO pais VALUES ('112','(+972)','Israel');
INSERT INTO pais VALUES ('113','(+39)','Italia');
INSERT INTO pais VALUES ('114','(+1)','Jamaica');
INSERT INTO pais VALUES ('115','(+47)','Jan Mayen');
INSERT INTO pais VALUES ('116','(+81)','Japón');
INSERT INTO pais VALUES ('117','(+44)','Jersey');
INSERT INTO pais VALUES ('118','(+962)','Jordania');
INSERT INTO pais VALUES ('119','(+7)','Kazajistán');
INSERT INTO pais VALUES ('120','(+254)','Kenia');
INSERT INTO pais VALUES ('142','(+596)','Martinica');
INSERT INTO pais VALUES ('143','(+230)','Mauricio');
INSERT INTO pais VALUES ('144','(+222)','Mauritania');
INSERT INTO pais VALUES ('145','(+262)','Mayotte');
INSERT INTO pais VALUES ('146','(+52)','México');
INSERT INTO pais VALUES ('147','(+691)','Micronesia');
INSERT INTO pais VALUES ('148','(+373)','Moldova');
INSERT INTO pais VALUES ('149','(+377)','Mónaco');
INSERT INTO pais VALUES ('150','(+976)','Mongolia');
INSERT INTO pais VALUES ('151','(+382)','Montenegro');
INSERT INTO pais VALUES ('152','(+1)','Montserrat');
INSERT INTO pais VALUES ('153','(+258)','Mozambique');
INSERT INTO pais VALUES ('7','(+1)','Antigua Y Barbuda');
INSERT INTO pais VALUES ('53','(+593)','Ecuador');
INSERT INTO pais VALUES ('2','(+355)','Albania');
INSERT INTO pais VALUES ('154','(+95)','Myanmar');
INSERT INTO pais VALUES ('155','(+264)','Namibia');
INSERT INTO pais VALUES ('156','(+674)','Nauru');
INSERT INTO pais VALUES ('157','(+977)','Nepal');
INSERT INTO pais VALUES ('158','(+505)','Nicaragua');
INSERT INTO pais VALUES ('159','(+227)','Níger');
INSERT INTO pais VALUES ('160','(+234)','Nigeria');
INSERT INTO pais VALUES ('161','(+683)','Niue');
INSERT INTO pais VALUES ('162','(+47)','Noruega');
INSERT INTO pais VALUES ('163','(+687)','Nueva Caledonia');
INSERT INTO pais VALUES ('164','(+64)','Nueva Zelanda');
INSERT INTO pais VALUES ('217','(+690)','Tokelau');
INSERT INTO pais VALUES ('165','(+968)','Omán');
INSERT INTO pais VALUES ('166','(+31)','Países Bajos');
INSERT INTO pais VALUES ('218','(+676)','Tonga');
INSERT INTO pais VALUES ('167','(+92)','Pakistán');
INSERT INTO pais VALUES ('168','(+680)','Palaos');
INSERT INTO pais VALUES ('219','(+1)','Trinidad y Tobago');
INSERT INTO pais VALUES ('169','(+507)','Panamá');
INSERT INTO pais VALUES ('170','(+675)','Papúa Nueva Guinea');
INSERT INTO pais VALUES ('171','(+595)','Paraguay');
INSERT INTO pais VALUES ('172','(+51)','Perú');
INSERT INTO pais VALUES ('173','(+689)','Polinesia Francesa');
INSERT INTO pais VALUES ('174','(+48)','Polonia');
INSERT INTO pais VALUES ('175','(+351)','Portugal');
INSERT INTO pais VALUES ('176','(+974)','Qatar');
INSERT INTO pais VALUES ('220','(+290)','Tristán da Cunha');
INSERT INTO pais VALUES ('177','(+973)','Reino de Baréin');
INSERT INTO pais VALUES ('178','(+44)','Reino Unido');
INSERT INTO pais VALUES ('221','(+216)','Túnez');
INSERT INTO pais VALUES ('222','(+993)','Turkmenistán');
INSERT INTO pais VALUES ('223','(+60)','Turquía');
INSERT INTO pais VALUES ('224','(+688)','Tuvalu');
INSERT INTO pais VALUES ('225','(+380)','Ucrania');
INSERT INTO pais VALUES ('226','(+256)','Uganda');
INSERT INTO pais VALUES ('227','(+598)','Uruguay');
INSERT INTO pais VALUES ('228','(+998)','Uzbekistán');
INSERT INTO pais VALUES ('229','(+678)','Vanuatu');
INSERT INTO pais VALUES ('230','(+58)','Venezuela');
INSERT INTO pais VALUES ('231','(+84)','Vietnam');
INSERT INTO pais VALUES ('232','(+681))','Wallis y Futuna');
INSERT INTO pais VALUES ('233','(+967)','Yemen');
INSERT INTO pais VALUES ('234','(+253)','Yibuti');
INSERT INTO pais VALUES ('235','(+260)','Zambia');
INSERT INTO pais VALUES ('236','(+263)','Zimbabue');
INSERT INTO pais VALUES ('179','(+236)','República Centroafricana');
INSERT INTO pais VALUES ('180','(+420)','República Checa');
INSERT INTO pais VALUES ('181','(+242)','República del Congo');
INSERT INTO pais VALUES ('182','(+1)','República Dominicana');
INSERT INTO pais VALUES ('183','(+262)','Reunión');
INSERT INTO pais VALUES ('184','(+250)','Ruanda');
INSERT INTO pais VALUES ('185','(+40)','Rumania');
INSERT INTO pais VALUES ('186','(+7)','Rusia');
INSERT INTO pais VALUES ('187','(+1)','Saint Kitts y Nevis');
INSERT INTO pais VALUES ('188','(+685)','Samoa');
INSERT INTO pais VALUES ('189','(+378)','San Marino');
INSERT INTO pais VALUES ('190','(+508)','San Pedro y Miquelón');
INSERT INTO pais VALUES ('191','(+1)','San Vicente y las Granadinas');
INSERT INTO pais VALUES ('192','(+290)','Santa Elena, Ascensión y Tristán de Acuña');
INSERT INTO pais VALUES ('193','(+1)','Santa Lucía');
INSERT INTO pais VALUES ('195','(+239)','Santo Tomé y Príncipe');
INSERT INTO pais VALUES ('196','(+221)','Senegal');
INSERT INTO pais VALUES ('197','(+381)','Serbia');
INSERT INTO pais VALUES ('198','(+248)','Seychelles');
INSERT INTO pais VALUES ('199','(+232)','Sierra Leona');
INSERT INTO pais VALUES ('200','(+65)','Singapur');
INSERT INTO pais VALUES ('201','(+963)','Siria');
INSERT INTO pais VALUES ('202','(+252)','Somalia');
INSERT INTO pais VALUES ('203','(+94)','Sri Lanka');
INSERT INTO pais VALUES ('204','(+268)','Suazilandia');
INSERT INTO pais VALUES ('205','(+27)','Sudáfrica');
INSERT INTO pais VALUES ('206','(+249)','Sudán');
INSERT INTO pais VALUES ('207','(+46)','Suecia');
INSERT INTO pais VALUES ('208','(+41)','Suiza');
INSERT INTO pais VALUES ('194','(Ciudad del Vaticano)','Santa Sede');
INSERT INTO pais VALUES ('209','(+597)','Surinam');
INSERT INTO pais VALUES ('210','(+66)','Tailandia');
INSERT INTO pais VALUES ('211','(+886)','Taiwán');
INSERT INTO pais VALUES ('212','(+255)','Tanzania');
INSERT INTO pais VALUES ('213','(+992)','Tayikistán');
INSERT INTO pais VALUES ('214','(+44)','Territorio Británico del Océano Índico');
INSERT INTO pais VALUES ('215','(+670)','Timor-Leste');
INSERT INTO pais VALUES ('216','(+228)','Togo');
INSERT INTO pais VALUES ('1','(+93)','Afganistán');
INSERT INTO pais VALUES ('3','(+49)','Alemania');
INSERT INTO pais VALUES ('237',NULL,NULL);


--
-- Creating index for 'pais'
--

ALTER TABLE ONLY  pais  ADD CONSTRAINT  pais_pkey  PRIMARY KEY  (id_pais);

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

INSERT INTO provincias VALUES ('3','Cañar','53');
INSERT INTO provincias VALUES ('4','Carchi','53');
INSERT INTO provincias VALUES ('6','Cotopaxi','53');
INSERT INTO provincias VALUES ('7','El Oro','53');
INSERT INTO provincias VALUES ('8','Esmeraldas','53');
INSERT INTO provincias VALUES ('9','Galápagos','53');
INSERT INTO provincias VALUES ('10','Guayas','53');
INSERT INTO provincias VALUES ('11','Imbabura','53');
INSERT INTO provincias VALUES ('12','Loja','53');
INSERT INTO provincias VALUES ('13','Los Ríos','53');
INSERT INTO provincias VALUES ('14','Manabí','53');
INSERT INTO provincias VALUES ('15','Morona Santiago','53');
INSERT INTO provincias VALUES ('16','Napo','53');
INSERT INTO provincias VALUES ('17','Orellana','53');
INSERT INTO provincias VALUES ('18','	Pastaza','53');
INSERT INTO provincias VALUES ('19','Pichincha','53');
INSERT INTO provincias VALUES ('20','Santa Elena','53');
INSERT INTO provincias VALUES ('21','Santo Domingo de los Tsáchilas','53');
INSERT INTO provincias VALUES ('22','Sucumbíos','53');
INSERT INTO provincias VALUES ('23','Tungurahua','53');
INSERT INTO provincias VALUES ('1','Azuay','53');
INSERT INTO provincias VALUES ('24','Zamora Chinchipe','53');
INSERT INTO provincias VALUES ('5','Chimborazo','53');
INSERT INTO provincias VALUES ('2','Bolívar','53');


--
-- Creating index for 'provincias'
--

ALTER TABLE ONLY  provincias  ADD CONSTRAINT  provincias_pkey  PRIMARY KEY  (id_provincia);

--
-- Estrutura de la tabla 'recibidos'
--

DROP TABLE recibidos CASCADE;
CREATE TABLE recibidos (
id_recibido int4 NOT NULL,
id_archivo int4,
id_bitacora int4,
fecha timestamp with time zone,
id_usuario int4,
usuarios text[]
);

--
-- Creating data for 'recibidos'
--

INSERT INTO recibidos VALUES ('1','1','1','2015-07-06 15:10:14-05','1','{1}');
INSERT INTO recibidos VALUES ('2','2','2','2015-07-06 15:10:36-05','1','{2}');
INSERT INTO recibidos VALUES ('3','3','3','2015-07-20 12:51:14-05','1','{"1,2"}');
INSERT INTO recibidos VALUES ('4','4','4','2015-07-20 12:52:46-05','1','{1}');
INSERT INTO recibidos VALUES ('5','5','5','2015-07-20 12:53:51-05','1','{1}');
INSERT INTO recibidos VALUES ('6','6','6','2015-07-20 12:54:29-05','1','{1}');


--
-- Creating index for 'recibidos'
--

ALTER TABLE ONLY  recibidos  ADD CONSTRAINT  recibidos_pkey  PRIMARY KEY  (id_recibido);

--
-- Estrutura de la tabla 'tbl_audit'
--

DROP TABLE tbl_audit CASCADE;
CREATE SEQUENCE tbl_audit_pk_audit_seq
    START WITH 3604
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

INSERT INTO tbl_audit VALUES ('2724','bitacora','U','(1,1,"2015-05-06 09:14:08-05","audios oficina",2,1,1,"",134686,fc0914081.png,png,0)','(1,1,"2015-05-06 09:14:08-05","audios oficina",2,1,1,"""<p>qweqwe</p>
""",134686,fc0914081.png,png,0)','2015-05-26 15:48:34.3','postgres');
INSERT INTO tbl_audit VALUES ('2725','bitacora','U','(1,1,"2015-05-06 09:14:08-05","audios oficina",2,1,1,"""<p>qweqwe</p>
""",134686,fc0914081.png,png,0)','(1,1,"2015-05-06 09:14:08-05","audios oficina",2,1,1,"<p>qweqwe</p>
",134686,fc0914081.png,png,0)','2015-05-26 15:48:38.956','postgres');
INSERT INTO tbl_audit VALUES ('2726','archivo','I',NULL,'(11,"ENVIOS DATOS",E-2015-05-26-SD-11-11,1,1,"2015-05-26 15:50:08-05",0)','2015-05-26 15:50:08.18','postgres');
INSERT INTO tbl_audit VALUES ('2727','bitacora','I',NULL,'(11,11,"2015-05-26 15:50:08-05","CAMBIOS GENERLA",1,1,1,"<p><strong>CAMBIOS EN LOS BAESADADAD</strong></p>

<ul>
	<li>
	<h2 style=""font-style:italic;"">asdasd</h2>
	</li>
</ul>

<p><strong><s>asdsfasfasf</s></strong></p>
","","","",0)','2015-05-26 15:50:08.313','postgres');
INSERT INTO tbl_audit VALUES ('2728','recibidos','I',NULL,'(11,11,11,"2015-05-26 15:50:08-05",1,"{""1,2""}")','2015-05-26 15:50:08.384','postgres');
INSERT INTO tbl_audit VALUES ('2729','archivo','I',NULL,'(12,qweqwe,q-2015-06-02-SD-12-12,1,1,"2015-06-02 12:05:55-05",0)','2015-06-02 12:05:56.015','postgres');
INSERT INTO tbl_audit VALUES ('2730','bitacora','I',NULL,'(12,12,"2015-06-02 12:05:55-05",qweqweqwe,1,1,1,"<p>qweqw qweqweqw</p>
","","","",0)','2015-06-02 12:05:56.412','postgres');
INSERT INTO tbl_audit VALUES ('2731','recibidos','I',NULL,'(12,12,12,"2015-06-02 12:05:55-05",1,{1})','2015-06-02 12:05:56.523','postgres');
INSERT INTO tbl_audit VALUES ('2732','archivo','I',NULL,'(13,ewqeqwe,e-2015-06-02-SD-13-13,1,1,"2015-06-02 12:06:08-05",0)','2015-06-02 12:06:08.843','postgres');
INSERT INTO tbl_audit VALUES ('2733','bitacora','I',NULL,'(13,13,"2015-06-02 12:06:08-05",123123,1,1,1,"<p>qweqwe qweqweqeq</p>
","","","",0)','2015-06-02 12:06:08.849','postgres');
INSERT INTO tbl_audit VALUES ('2734','recibidos','I',NULL,'(13,13,13,"2015-06-02 12:06:08-05",1,{1})','2015-06-02 12:06:08.856','postgres');
INSERT INTO tbl_audit VALUES ('2735','archivo','I',NULL,'(14,12312,1-2015-06-02-SD-14-14,1,1,"2015-06-02 12:06:48-05",0)','2015-06-02 12:06:48.394','postgres');
INSERT INTO tbl_audit VALUES ('2736','bitacora','I',NULL,'(14,14,"2015-06-02 12:06:48-05",123123,1,1,1,"","","","",0)','2015-06-02 12:06:48.421','postgres');
INSERT INTO tbl_audit VALUES ('2737','recibidos','I',NULL,'(14,14,14,"2015-06-02 12:06:48-05",1,{1})','2015-06-02 12:06:48.429','postgres');
INSERT INTO tbl_audit VALUES ('2738','bitacora','U','(3,3,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"",128657,3.fw0914483.png,png,0)','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"",128657,3.fw0914483.png,png,0)','2015-06-04 17:10:30.818','postgres');
INSERT INTO tbl_audit VALUES ('2739','bitacora','U','(4,4,"2015-05-06 09:15:42-05","word de dota",1,1,1,"<p>qweqwe</p>
",90289,imndic0915424.wma,wma,0)','(4,2,"2015-05-06 09:15:42-05","word de dota",1,1,1,"<p>qweqwe</p>
",90289,imndic0915424.wma,wma,0)','2015-06-04 17:11:02.042','postgres');
INSERT INTO tbl_audit VALUES ('2740','bitacora','U','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"",128657,3.fw0914483.png,png,0)','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"<p>Sin observaciones</p>",128657,3.fw0914483.png,png,0)','2015-06-04 17:12:46.448','postgres');
INSERT INTO tbl_audit VALUES ('2741','bitacora','U','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"<p>Sin observaciones</p>",128657,3.fw0914483.png,png,0)','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,,128657,3.fw0914483.png,png,0)','2015-06-04 17:14:37.479','postgres');
INSERT INTO tbl_audit VALUES ('2742','bitacora','U','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,,128657,3.fw0914483.png,png,0)','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"",128657,3.fw0914483.png,png,0)','2015-06-04 17:14:39.751','postgres');
INSERT INTO tbl_audit VALUES ('2743','bitacora','U','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"",128657,3.fw0914483.png,png,0)','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,,128657,3.fw0914483.png,png,0)','2015-06-04 17:15:02.358','postgres');
INSERT INTO tbl_audit VALUES ('2744','bitacora','U','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,,128657,3.fw0914483.png,png,0)','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"",128657,3.fw0914483.png,png,0)','2015-06-04 17:16:44.765','postgres');
INSERT INTO tbl_audit VALUES ('2745','bitacora','U','(11,11,"2015-05-26 15:50:08-05","CAMBIOS GENERLA",1,1,1,"<p><strong>CAMBIOS EN LOS BAESADADAD</strong></p>

<ul>
	<li>
	<h2 style=""font-style:italic;"">asdasd</h2>
	</li>
</ul>

<p><strong><s>asdsfasfasf</s></strong></p>
","","","",0)','(11,2,"2015-05-26 15:50:08-05","CAMBIOS GENERLA",1,1,1,"<p><strong>CAMBIOS EN LOS BAESADADAD</strong></p>

<ul>
	<li>
	<h2 style=""font-style:italic;"">asdasd</h2>
	</li>
</ul>

<p><strong><s>asdsfasfasf</s></strong></p>
","","","",0)','2015-06-04 17:18:43.878','postgres');
INSERT INTO tbl_audit VALUES ('2746','bitacora','U','(12,12,"2015-06-02 12:05:55-05",qweqweqwe,1,1,1,"<p>qweqw qweqweqw</p>
","","","",0)','(12,2,"2015-06-02 12:05:55-05",qweqweqwe,1,1,1,"<p>qweqw qweqweqw</p>
","","","",0)','2015-06-04 17:18:45.571','postgres');
INSERT INTO tbl_audit VALUES ('2747','archivo','D','(14,12312,1-2015-06-02-SD-14-14,1,1,"2015-06-02 12:06:48-05",0)',NULL,'2015-06-18 16:52:31.141','postgres');
INSERT INTO tbl_audit VALUES ('2748','bitacora','D','(14,14,"2015-06-02 12:06:48-05",123123,1,1,1,"","","","",0)',NULL,'2015-06-18 16:52:31.141','postgres');
INSERT INTO tbl_audit VALUES ('2749','recibidos','D','(14,14,14,"2015-06-02 12:06:48-05",1,{1})',NULL,'2015-06-18 16:52:31.141','postgres');
INSERT INTO tbl_audit VALUES ('2750','archivo','D','(13,ewqeqwe,e-2015-06-02-SD-13-13,1,1,"2015-06-02 12:06:08-05",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2751','bitacora','D','(13,13,"2015-06-02 12:06:08-05",123123,1,1,1,"<p>qweqwe qweqweqeq</p>
","","","",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2752','recibidos','D','(13,13,13,"2015-06-02 12:06:08-05",1,{1})',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2753','archivo','D','(12,qweqwe,q-2015-06-02-SD-12-12,1,1,"2015-06-02 12:05:55-05",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2754','recibidos','D','(12,12,12,"2015-06-02 12:05:55-05",1,{1})',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2755','archivo','D','(11,"ENVIOS DATOS",E-2015-05-26-SD-11-11,1,1,"2015-05-26 15:50:08-05",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2756','recibidos','D','(11,11,11,"2015-05-26 15:50:08-05",1,"{""1,2""}")',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2757','archivo','D','(10,qweq,q-2015-05-06-SD-10-10,1,1,"2015-05-06 15:13:04-05",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2758','bitacora','D','(10,10,"2015-05-06 15:13:04-05",123123123,1,1,1,"","","","",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2759','recibidos','D','(10,10,10,"2015-05-06 15:13:04-05",1,"{""1,2""}")',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2760','archivo','D','(9,qweqwe,q-2015-05-06-SD-9-9,1,1,"2015-05-06 15:12:55-05",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2761','bitacora','D','(9,9,"2015-05-06 15:12:55-05",123,1,1,1,"","","","",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2762','recibidos','D','(9,9,9,"2015-05-06 15:12:55-05",1,"{""1,2""}")',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2763','archivo','D','(8,qweqweqwe,q-2015-05-06-SD-8-8,1,1,"2015-05-06 10:56:35-05",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2764','bitacora','D','(8,8,"2015-05-06 10:56:35-05",123123,1,1,1,"","","","",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2765','recibidos','D','(8,8,8,"2015-05-06 10:56:35-05",1,"{""1,2""}")',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2766','archivo','D','(7,sdasd,f-2015-05-06-png-7-7,1,1,"2015-05-06 09:56:18-05",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2767','bitacora','D','(7,7,"2015-05-06 09:56:18-05",Asd,1,1,1,"",134686,fc0956187.png,png,0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2768','metas','D','(13,nombre,fc.png,7)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2769','metas','D','(14,tipo,png,7)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2770','metas','D','(15,tamaño,134686,7)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2771','recibidos','D','(7,7,7,"2015-05-06 09:56:18-05",1,{2})',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2772','archivo','D','(6,"Carta a la direccion",c-2015-05-06-png-6-6,1,1,"2015-05-06 09:16:12-05",0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2773','bitacora','D','(6,6,"2015-05-06 09:16:12-05","cartas al publico",1,1,1,"<p>qweqwe</p>
",2349,call50916126.png,png,0)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2774','metas','D','(10,nombre,call5.png,6)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2775','metas','D','(11,tipo,png,6)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2776','metas','D','(12,tamaño,2349,6)',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2777','recibidos','D','(6,6,6,"2015-05-06 09:16:12-05",1,{2})',NULL,'2015-06-18 16:52:31.21','postgres');
INSERT INTO tbl_audit VALUES ('2778','archivo','D','(5,"Correo electronico de direccion ",q-2015-05-06-SD-5-5,1,1,"2015-05-06 09:15:56-05",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2779','bitacora','D','(5,5,"2015-05-06 09:15:56-05","correos gerencias",1,1,1,"<p>qweqwe</p>
","","","",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2780','recibidos','D','(5,5,5,"2015-05-06 09:15:56-05",1,"{""1,2""}")',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2781','archivo','D','(4,"Word para oficinas",i-2015-05-06-wma-4-4,1,1,"2015-05-06 09:15:42-05",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2782','metas','D','(7,nombre,imndic.wma,4)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2783','metas','D','(8,tipo,wma,4)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2784','metas','D','(9,tamaño,90289,4)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2785','recibidos','D','(4,4,4,"2015-05-06 09:15:42-05",1,{1})',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2786','archivo','D','(3,"Pdf para empresas",3-2015-05-06-png-3-3,1,2,"2015-05-06 09:14:48-05",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2787','metas','D','(4,nombre,3.fw.png,3)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2788','metas','D','(5,tipo,png,3)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2789','metas','D','(6,tamaño,128657,3)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2790','recibidos','D','(3,3,3,"2015-05-06 09:14:48-05",2,{1})',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2791','archivo','D','(2,"Documento de video",q-2015-05-06-SD-2-2,1,2,"2015-05-06 09:14:32-05",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2792','bitacora','D','(2,2,"2015-05-06 09:14:32-05","oficios generales",2,1,1,"<p>qweqwe</p>
","","","",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2793','bitacora','D','(4,2,"2015-05-06 09:15:42-05","word de dota",1,1,1,"<p>qweqwe</p>
",90289,imndic0915424.wma,wma,0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2794','bitacora','D','(3,2,"2015-05-06 09:14:48-05","pdf de oficina",2,1,1,"",128657,3.fw0914483.png,png,0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2795','bitacora','D','(11,2,"2015-05-26 15:50:08-05","CAMBIOS GENERLA",1,1,1,"<p><strong>CAMBIOS EN LOS BAESADADAD</strong></p>

<ul>
	<li>
	<h2 style=""font-style:italic;"">asdasd</h2>
	</li>
</ul>

<p><strong><s>asdsfasfasf</s></strong></p>
","","","",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2796','bitacora','D','(12,2,"2015-06-02 12:05:55-05",qweqweqwe,1,1,1,"<p>qweqw qweqweqw</p>
","","","",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2797','recibidos','D','(2,2,2,"2015-05-06 09:14:32-05",2,{2})',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2798','archivo','D','(1,"Archivo audio",f-2015-05-06-png-1-1,1,2,"2015-05-06 09:14:08-05",0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2799','bitacora','D','(1,1,"2015-05-06 09:14:08-05","audios oficina",2,1,1,"<p>qweqwe</p>
",134686,fc0914081.png,png,0)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2800','metas','D','(1,nombre,fc.png,1)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2801','metas','D','(2,tipo,png,1)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2802','metas','D','(3,tamaño,134686,1)',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2803','recibidos','D','(1,1,1,"2015-05-06 09:14:08-05",2,"{""1,2""}")',NULL,'2015-06-18 16:52:31.226','postgres');
INSERT INTO tbl_audit VALUES ('2804','archivo','I',NULL,'(1,qqqqweqw,2-2015-06-18-jpg-1-1,1,1,"2015-06-18 16:53:10-05",0)','2015-06-18 16:53:10.957','postgres');
INSERT INTO tbl_audit VALUES ('2805','bitacora','I',NULL,'(1,1,"2015-06-18 16:53:10-05",123123,1,1,1,"<p>werwerwerwer</p>
",1502474,20141117_1102421653101.jpg,jpg,0)','2015-06-18 16:53:10.992','postgres');
INSERT INTO tbl_audit VALUES ('2806','metas','I',NULL,'(1,nombre,20141117_110242.jpg,1)','2015-06-18 16:53:11.02','postgres');
INSERT INTO tbl_audit VALUES ('2807','metas','I',NULL,'(2,tipo,jpg,1)','2015-06-18 16:53:11.028','postgres');
INSERT INTO tbl_audit VALUES ('2808','metas','I',NULL,'(3,tamaño,1502474,1)','2015-06-18 16:53:11.029','postgres');
INSERT INTO tbl_audit VALUES ('2809','recibidos','I',NULL,'(1,1,1,"2015-06-18 16:53:10-05",1,"{""1,2""}")','2015-06-18 16:53:11.041','postgres');
INSERT INTO tbl_audit VALUES ('2810','archivo','I',NULL,'(2,234234,2-2015-06-18-SD-2-2,1,1,"2015-06-18 16:53:44-05",0)','2015-06-18 16:53:44.698','postgres');
INSERT INTO tbl_audit VALUES ('2811','bitacora','I',NULL,'(2,2,"2015-06-18 16:53:44-05",qweqweqwe,1,1,1,"","","","",0)','2015-06-18 16:53:44.707','postgres');
INSERT INTO tbl_audit VALUES ('2812','recibidos','I',NULL,'(2,2,2,"2015-06-18 16:53:44-05",1,{2})','2015-06-18 16:53:44.718','postgres');
INSERT INTO tbl_audit VALUES ('2813','archivo','I',NULL,'(3,htyhty,h-2015-06-18-SD-3-3,1,1,"2015-06-18 16:54:04-05",0)','2015-06-18 16:54:04.594','postgres');
INSERT INTO tbl_audit VALUES ('2814','bitacora','I',NULL,'(3,3,"2015-06-18 16:54:04-05",htyhtyhtyh,1,1,1,"","","","",0)','2015-06-18 16:54:04.603','postgres');
INSERT INTO tbl_audit VALUES ('2815','recibidos','I',NULL,'(3,3,3,"2015-06-18 16:54:04-05",1,"{""1,2""}")','2015-06-18 16:54:04.614','postgres');
INSERT INTO tbl_audit VALUES ('2816','archivo','I',NULL,'(4,123123123,1-2015-06-18-SD-4-4,1,1,"2015-06-18 16:54:33-05",0)','2015-06-18 16:54:33.801','postgres');
INSERT INTO tbl_audit VALUES ('2817','bitacora','I',NULL,'(4,4,"2015-06-18 16:54:33-05",2222222222222,1,1,1,"<p>2222222222222</p>
","","","",0)','2015-06-18 16:54:33.805','postgres');
INSERT INTO tbl_audit VALUES ('2818','recibidos','I',NULL,'(4,4,4,"2015-06-18 16:54:33-05",1,{1})','2015-06-18 16:54:33.805','postgres');
INSERT INTO tbl_audit VALUES ('2819','archivo','I',NULL,'(5,werwerwe,w-2015-06-18-SD-5-5,1,1,"2015-06-18 17:03:58-05",0)','2015-06-18 17:03:58.482','postgres');
INSERT INTO tbl_audit VALUES ('2820','bitacora','I',NULL,'(5,5,"2015-06-18 17:03:58-05",123123,1,1,1,"<p>213123123</p>
","","","",0)','2015-06-18 17:03:58.498','postgres');
INSERT INTO tbl_audit VALUES ('2821','recibidos','I',NULL,'(5,5,5,"2015-06-18 17:03:58-05",1,{2})','2015-06-18 17:03:58.508','postgres');
INSERT INTO tbl_audit VALUES ('2822','archivo','I',NULL,'(6,123123,1-2015-06-18-SD-6-6,1,1,"2015-06-18 17:04:07-05",0)','2015-06-18 17:04:07.518','postgres');
INSERT INTO tbl_audit VALUES ('2823','bitacora','I',NULL,'(6,6,"2015-06-18 17:04:07-05",1123weqwe,1,1,1,"<p>eqweqwe</p>
","","","",0)','2015-06-18 17:04:07.527','postgres');
INSERT INTO tbl_audit VALUES ('2824','recibidos','I',NULL,'(6,6,6,"2015-06-18 17:04:07-05",1,"{""1,2""}")','2015-06-18 17:04:07.539','postgres');
INSERT INTO tbl_audit VALUES ('2825','archivo','I',NULL,'(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','2015-06-18 17:04:33.143','postgres');
INSERT INTO tbl_audit VALUES ('2826','bitacora','I',NULL,'(7,7,"2015-06-18 17:04:33-05",4234234234,1,1,1,"<p>234234</p>
","","","",0)','2015-06-18 17:04:33.15','postgres');
INSERT INTO tbl_audit VALUES ('2827','recibidos','I',NULL,'(7,7,7,"2015-06-18 17:04:33-05",1,{1})','2015-06-18 17:04:33.159','postgres');
INSERT INTO tbl_audit VALUES ('2828','archivo','I',NULL,'(8,12312,1-2015-06-18-SD-8-8,1,2,"2015-06-18 17:16:59-05",0)','2015-06-18 17:16:59.569','postgres');
INSERT INTO tbl_audit VALUES ('2829','bitacora','I',NULL,'(8,8,"2015-06-18 17:16:59-05",3QWEQWEQWE,2,1,1,"","","","",0)','2015-06-18 17:16:59.589','postgres');
INSERT INTO tbl_audit VALUES ('2830','recibidos','I',NULL,'(8,8,8,"2015-06-18 17:16:59-05",2,{2})','2015-06-18 17:16:59.6','postgres');
INSERT INTO tbl_audit VALUES ('2831','archivo','I',NULL,'(9,23123,2-2015-06-18-SD-9-9,1,2,"2015-06-18 17:17:06-05",0)','2015-06-18 17:17:06.898','postgres');
INSERT INTO tbl_audit VALUES ('2832','bitacora','I',NULL,'(9,9,"2015-06-18 17:17:06-05",123123,2,1,1,"","","","",0)','2015-06-18 17:17:06.906','postgres');
INSERT INTO tbl_audit VALUES ('2833','recibidos','I',NULL,'(9,9,9,"2015-06-18 17:17:06-05",2,{1})','2015-06-18 17:17:06.917','postgres');
INSERT INTO tbl_audit VALUES ('2834','archivo','I',NULL,'(10,123123,1-2015-06-18-SD-10-10,1,2,"2015-06-18 17:17:15-05",0)','2015-06-18 17:17:15.896','postgres');
INSERT INTO tbl_audit VALUES ('2835','bitacora','I',NULL,'(10,10,"2015-06-18 17:17:15-05",WEQE,2,1,1,"<p>QWE</p>
","","","",0)','2015-06-18 17:17:15.903','postgres');
INSERT INTO tbl_audit VALUES ('2836','recibidos','I',NULL,'(10,10,10,"2015-06-18 17:17:15-05",2,"{""1,2""}")','2015-06-18 17:17:15.903','postgres');
INSERT INTO tbl_audit VALUES ('2837','archivo','U','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','2015-06-18 18:22:08.635','postgres');
INSERT INTO tbl_audit VALUES ('2838','bitacora','I',NULL,'(11,7,"2015-06-18 18:22:08-05",4234234234,1,1,1,"<p>234</p>
","","","",0)','2015-06-18 18:22:08.653','postgres');
INSERT INTO tbl_audit VALUES ('2839','recibidos','I',NULL,'(11,7,11,"2015-06-18 18:22:08-05",1,{1})','2015-06-18 18:22:08.653','postgres');
INSERT INTO tbl_audit VALUES ('2840','archivo','U','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','2015-06-18 18:24:59.807','postgres');
INSERT INTO tbl_audit VALUES ('2841','bitacora','I',NULL,'(12,7,"2015-06-18 18:24:59-05",4234234234,1,1,1,"","","","",0)','2015-06-18 18:24:59.818','postgres');
INSERT INTO tbl_audit VALUES ('2842','recibidos','I',NULL,'(12,7,12,"2015-06-18 18:24:59-05",1,{1})','2015-06-18 18:24:59.83','postgres');
INSERT INTO tbl_audit VALUES ('2843','archivo','U','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','2015-06-19 10:02:04.152','postgres');
INSERT INTO tbl_audit VALUES ('2844','bitacora','I',NULL,'(13,7,"2015-06-19 10:02:04-05",4234234234,1,1,1,"","","","",0)','2015-06-19 10:02:04.256','postgres');
INSERT INTO tbl_audit VALUES ('2845','recibidos','I',NULL,'(13,7,13,"2015-06-19 10:02:04-05",1,{1})','2015-06-19 10:02:04.287','postgres');
INSERT INTO tbl_audit VALUES ('2846','archivo','U','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','2015-06-19 10:03:02.849','postgres');
INSERT INTO tbl_audit VALUES ('2847','bitacora','I',NULL,'(14,7,"2015-06-19 10:03:02-05",4234234234,1,1,1,"","","","",0)','2015-06-19 10:03:02.849','postgres');
INSERT INTO tbl_audit VALUES ('2848','recibidos','I',NULL,'(14,7,14,"2015-06-19 10:03:02-05",1,{1})','2015-06-19 10:03:02.849','postgres');
INSERT INTO tbl_audit VALUES ('2849','archivo','U','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','2015-06-19 10:07:46.816','postgres');
INSERT INTO tbl_audit VALUES ('2850','bitacora','I',NULL,'(15,7,"2015-06-19 10:07:46-05",4234234234,1,1,1,"","","","",0)','2015-06-19 10:07:46.834','postgres');
INSERT INTO tbl_audit VALUES ('2851','recibidos','I',NULL,'(15,7,15,"2015-06-19 10:07:46-05",1,{1})','2015-06-19 10:07:46.834','postgres');
INSERT INTO tbl_audit VALUES ('2852','archivo','U','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",0)','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",1)','2015-06-19 10:10:32.433','postgres');
INSERT INTO tbl_audit VALUES ('2853','bitacora','I',NULL,'(16,7,"2015-06-19 10:10:32-05",4234234234,1,1,1,"","","","",0)','2015-06-19 10:10:32.462','postgres');
INSERT INTO tbl_audit VALUES ('2854','recibidos','I',NULL,'(16,7,16,"2015-06-19 10:10:32-05",1,{1})','2015-06-19 10:10:32.469','postgres');
INSERT INTO tbl_audit VALUES ('2855','archivo','U','(1,qqqqweqw,2-2015-06-18-jpg-1-1,1,1,"2015-06-18 16:53:10-05",0)','(1,qqqqweqw,2-2015-06-18-jpg-1-1,1,1,"2015-06-18 16:53:10-05",0)','2015-06-19 10:13:55.731','postgres');
INSERT INTO tbl_audit VALUES ('2856','bitacora','I',NULL,'(17,1,"2015-06-19 10:13:55-05",123123,1,1,1,"",1502474,20141117_1102421653101.jpg,jpg,0)','2015-06-19 10:13:55.739','postgres');
INSERT INTO tbl_audit VALUES ('2857','recibidos','I',NULL,'(17,1,17,"2015-06-19 10:13:55-05",1,"{""1,2""}")','2015-06-19 10:13:55.748','postgres');
INSERT INTO tbl_audit VALUES ('2858','archivo','I',NULL,'(11,123,1-2015-06-19-SD-11-18,1,1,"2015-06-19 10:16:48-05",0)','2015-06-19 10:16:48.558','postgres');
INSERT INTO tbl_audit VALUES ('2859','bitacora','I',NULL,'(18,11,"2015-06-19 10:16:48-05",23123,1,1,1,"","","","",0)','2015-06-19 10:16:48.577','postgres');
INSERT INTO tbl_audit VALUES ('2860','recibidos','I',NULL,'(18,11,18,"2015-06-19 10:16:48-05",1,{1})','2015-06-19 10:16:48.577','postgres');
INSERT INTO tbl_audit VALUES ('2861','archivo','I',NULL,'(12,2312,2-2015-06-19-SD-12-19,1,1,"2015-06-19 10:17:21-05",0)','2015-06-19 10:17:21.389','postgres');
INSERT INTO tbl_audit VALUES ('2862','bitacora','I',NULL,'(19,12,"2015-06-19 10:17:21-05",123,1,1,1,"","","","",0)','2015-06-19 10:17:21.399','postgres');
INSERT INTO tbl_audit VALUES ('2863','recibidos','I',NULL,'(19,12,19,"2015-06-19 10:17:21-05",1,{1})','2015-06-19 10:17:21.408','postgres');
INSERT INTO tbl_audit VALUES ('2864','usuario','I',NULL,'(3,1113,123123,qweq,1,"","","",1,qweqwe,"Uniandes Ibarra",1,1,"2015-06-19 10:18:29-05",Cédula,2222222222)','2015-06-19 10:18:29.165','postgres');
INSERT INTO tbl_audit VALUES ('2865','clave','I',NULL,'(3,MTIzMTIzMTIz,3)','2015-06-19 10:18:29.207','postgres');
INSERT INTO tbl_audit VALUES ('2866','usuario','I',NULL,'(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1234567897)','2015-06-19 10:22:14.014','postgres');
INSERT INTO tbl_audit VALUES ('2867','clave','I',NULL,'(4,MTIzMTIzMTIz,4)','2015-06-19 10:22:14.022','postgres');
INSERT INTO tbl_audit VALUES ('2868','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1234567897)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,2222222222)','2015-06-19 10:22:55.026','postgres');
INSERT INTO tbl_audit VALUES ('2869','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,2222222222)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1234567897)','2015-06-19 10:23:24.334','postgres');
INSERT INTO tbl_audit VALUES ('2870','usuario','U','(3,1113,123123,qweq,1,"","","",1,qweqwe,"Uniandes Ibarra",1,1,"2015-06-19 10:18:29-05",Cédula,2222222222)','(3,1113,123123,qweq,1,"","","",1,qweqwe,"Uniandes Ibarra",1,1,"2015-06-19 10:18:29-05",Cédula,1002910345)','2015-06-19 10:24:16.217','postgres');
INSERT INTO tbl_audit VALUES ('2871','usuario','U','(1,AAW01,"Willi Alfonso Narvaez Iñahuazo","Otavalo Lass",2,"","","",1,admin,"Uniandes Ibarra",1,1,"2015-04-27 15:36:52-05",Cédula,1002910345)','(1,AAW01,"Willi Alfonso Narvaez Iñahuazo","Otavalo Lass",2,"","","",1,admin,"Uniandes Ibarra",1,1,"2015-04-27 15:36:52-05",Cédula,1002910345)','2015-06-19 10:24:58.321','postgres');
INSERT INTO tbl_audit VALUES ('2872','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1234567897)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1234567897)','2015-06-19 10:25:05.028','postgres');
INSERT INTO tbl_audit VALUES ('2873','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1234567897)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1234567897)','2015-06-19 10:26:10.452','postgres');
INSERT INTO tbl_audit VALUES ('2874','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1234567897)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:26:21.334','postgres');
INSERT INTO tbl_audit VALUES ('2875','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:26:36.86','postgres');
INSERT INTO tbl_audit VALUES ('2876','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:27:08.229','postgres');
INSERT INTO tbl_audit VALUES ('2877','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:27:12.683','postgres');
INSERT INTO tbl_audit VALUES ('2878','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:27:48.745','postgres');
INSERT INTO tbl_audit VALUES ('2879','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:28:00.78','postgres');
INSERT INTO tbl_audit VALUES ('2943','archivo','I',NULL,'(23,wrer,2-2015-06-19-sesx-23-30,1,1,"2015-06-19 15:13:48-05",0)','2015-06-19 15:13:48.987','postgres');
INSERT INTO tbl_audit VALUES ('2880','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:28:41.973','postgres');
INSERT INTO tbl_audit VALUES ('2881','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:28:45.842','postgres');
INSERT INTO tbl_audit VALUES ('2882','usuario','U','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)','2015-06-19 10:28:50.472','postgres');
INSERT INTO tbl_audit VALUES ('2883','archivo','I',NULL,'(13,werw,V-2015-06-19-sesx-13-20,1,1,"2015-06-19 15:06:22-05",0)','2015-06-19 15:06:22.831','postgres');
INSERT INTO tbl_audit VALUES ('2884','bitacora','I',NULL,'(20,13,"2015-06-19 15:06:22-05",werwer,1,1,1,"<p>qweqwe</p>
",136277,"Vocal and Guitar with Metronome15062213.sesx",sesx,0)','2015-06-19 15:06:22.848','postgres');
INSERT INTO tbl_audit VALUES ('2885','metas','I',NULL,'(4,nombre,"Vocal and Guitar with Metronome.sesx",13)','2015-06-19 15:06:22.86','postgres');
INSERT INTO tbl_audit VALUES ('2886','metas','I',NULL,'(5,tipo,sesx,13)','2015-06-19 15:06:22.869','postgres');
INSERT INTO tbl_audit VALUES ('2887','metas','I',NULL,'(6,tamaño,136277,13)','2015-06-19 15:06:22.872','postgres');
INSERT INTO tbl_audit VALUES ('2888','recibidos','I',NULL,'(20,13,20,"2015-06-19 15:06:22-05",1,"{""1,2,3,4""}")','2015-06-19 15:06:22.885','postgres');
INSERT INTO tbl_audit VALUES ('2889','archivo','I',NULL,'(14,234,2-2015-06-19-sesx-14-21,1,1,"2015-06-19 15:06:58-05",0)','2015-06-19 15:06:58.805','postgres');
INSERT INTO tbl_audit VALUES ('2890','bitacora','I',NULL,'(21,14,"2015-06-19 15:06:58-05",234,1,1,1,"",308625,"24 Track Music Session15065814.sesx",sesx,0)','2015-06-19 15:06:58.813','postgres');
INSERT INTO tbl_audit VALUES ('2891','metas','I',NULL,'(7,nombre,"24 Track Music Session.sesx",14)','2015-06-19 15:06:58.819','postgres');
INSERT INTO tbl_audit VALUES ('2892','metas','I',NULL,'(8,tipo,sesx,14)','2015-06-19 15:06:58.824','postgres');
INSERT INTO tbl_audit VALUES ('2893','metas','I',NULL,'(9,tamaño,308625,14)','2015-06-19 15:06:58.828','postgres');
INSERT INTO tbl_audit VALUES ('2894','recibidos','I',NULL,'(21,14,21,"2015-06-19 15:06:58-05",1,"{""1,3""}")','2015-06-19 15:06:58.837','postgres');
INSERT INTO tbl_audit VALUES ('2895','archivo','I',NULL,'(15,wer,2-2015-06-19-sesx-15-22,1,1,"2015-06-19 15:07:40-05",0)','2015-06-19 15:07:40.378','postgres');
INSERT INTO tbl_audit VALUES ('2896','bitacora','I',NULL,'(22,15,"2015-06-19 15:07:40-05",wer,1,1,1,"<p>werwer</p>
",308625,"24 Track Music Session15074015.sesx",sesx,0)','2015-06-19 15:07:40.385','postgres');
INSERT INTO tbl_audit VALUES ('2897','metas','I',NULL,'(10,nombre,"24 Track Music Session.sesx",15)','2015-06-19 15:07:40.391','postgres');
INSERT INTO tbl_audit VALUES ('2898','metas','I',NULL,'(11,tipo,sesx,15)','2015-06-19 15:07:40.396','postgres');
INSERT INTO tbl_audit VALUES ('2899','metas','I',NULL,'(12,tamaño,308625,15)','2015-06-19 15:07:40.399','postgres');
INSERT INTO tbl_audit VALUES ('2900','recibidos','I',NULL,'(22,15,22,"2015-06-19 15:07:40-05",1,"{""1,2,3,4""}")','2015-06-19 15:07:40.411','postgres');
INSERT INTO tbl_audit VALUES ('2901','archivo','I',NULL,'(16,123,2-2015-06-19-sesx-16-23,1,1,"2015-06-19 15:09:09-05",0)','2015-06-19 15:09:09.821','postgres');
INSERT INTO tbl_audit VALUES ('2902','bitacora','I',NULL,'(23,16,"2015-06-19 15:09:09-05",123,1,1,1,"",308625,"24 Track Music Session15090916.sesx",sesx,0)','2015-06-19 15:09:09.834','postgres');
INSERT INTO tbl_audit VALUES ('2903','metas','I',NULL,'(13,nombre,"24 Track Music Session.sesx",16)','2015-06-19 15:09:09.839','postgres');
INSERT INTO tbl_audit VALUES ('2904','metas','I',NULL,'(14,tipo,sesx,16)','2015-06-19 15:09:09.844','postgres');
INSERT INTO tbl_audit VALUES ('2905','metas','I',NULL,'(15,tamaño,308625,16)','2015-06-19 15:09:09.848','postgres');
INSERT INTO tbl_audit VALUES ('2906','recibidos','I',NULL,'(23,16,23,"2015-06-19 15:09:09-05",1,"{""1,2,3,4""}")','2015-06-19 15:09:09.861','postgres');
INSERT INTO tbl_audit VALUES ('2907','archivo','I',NULL,'(17,wer,2-2015-06-19-sesx-17-24,1,1,"2015-06-19 15:10:41-05",0)','2015-06-19 15:10:41.598','postgres');
INSERT INTO tbl_audit VALUES ('2908','bitacora','I',NULL,'(24,17,"2015-06-19 15:10:41-05",wer,1,1,1,"",308625,"24 Track Music Session15104117.sesx",sesx,0)','2015-06-19 15:10:41.605','postgres');
INSERT INTO tbl_audit VALUES ('2909','metas','I',NULL,'(16,nombre,"24 Track Music Session.sesx",17)','2015-06-19 15:10:41.612','postgres');
INSERT INTO tbl_audit VALUES ('2910','metas','I',NULL,'(17,tipo,sesx,17)','2015-06-19 15:10:41.616','postgres');
INSERT INTO tbl_audit VALUES ('2911','metas','I',NULL,'(18,tamaño,308625,17)','2015-06-19 15:10:41.618','postgres');
INSERT INTO tbl_audit VALUES ('2912','recibidos','I',NULL,'(24,17,24,"2015-06-19 15:10:41-05",1,{1})','2015-06-19 15:10:41.623','postgres');
INSERT INTO tbl_audit VALUES ('2913','archivo','I',NULL,'(18,234,2-2015-06-19-sesx-18-25,1,1,"2015-06-19 15:11:34-05",0)','2015-06-19 15:11:34.803','postgres');
INSERT INTO tbl_audit VALUES ('2914','bitacora','I',NULL,'(25,18,"2015-06-19 15:11:34-05",234,1,1,1,"",308625,"24 Track Music Session15113418.sesx",sesx,0)','2015-06-19 15:11:34.811','postgres');
INSERT INTO tbl_audit VALUES ('2915','metas','I',NULL,'(19,nombre,"24 Track Music Session.sesx",18)','2015-06-19 15:11:34.817','postgres');
INSERT INTO tbl_audit VALUES ('2916','metas','I',NULL,'(20,tipo,sesx,18)','2015-06-19 15:11:34.819','postgres');
INSERT INTO tbl_audit VALUES ('2917','metas','I',NULL,'(21,tamaño,308625,18)','2015-06-19 15:11:34.82','postgres');
INSERT INTO tbl_audit VALUES ('2918','recibidos','I',NULL,'(25,18,25,"2015-06-19 15:11:34-05",1,{1})','2015-06-19 15:11:34.825','postgres');
INSERT INTO tbl_audit VALUES ('2919','archivo','I',NULL,'(19,234,2-2015-06-19-sesx-19-26,1,1,"2015-06-19 15:12:00-05",0)','2015-06-19 15:12:00.316','postgres');
INSERT INTO tbl_audit VALUES ('2920','bitacora','I',NULL,'(26,19,"2015-06-19 15:12:00-05",234,1,1,1,"<p>2</p>
",308625,"24 Track Music Session15120019.sesx",sesx,0)','2015-06-19 15:12:00.323','postgres');
INSERT INTO tbl_audit VALUES ('2921','metas','I',NULL,'(22,nombre,"24 Track Music Session.sesx",19)','2015-06-19 15:12:00.346','postgres');
INSERT INTO tbl_audit VALUES ('2922','metas','I',NULL,'(23,tipo,sesx,19)','2015-06-19 15:12:00.348','postgres');
INSERT INTO tbl_audit VALUES ('2923','metas','I',NULL,'(24,tamaño,308625,19)','2015-06-19 15:12:00.35','postgres');
INSERT INTO tbl_audit VALUES ('2924','recibidos','I',NULL,'(26,19,26,"2015-06-19 15:12:00-05",1,"{""1,3""}")','2015-06-19 15:12:00.357','postgres');
INSERT INTO tbl_audit VALUES ('2925','archivo','I',NULL,'(20,234,2-2015-06-19-sesx-20-27,1,1,"2015-06-19 15:12:17-05",0)','2015-06-19 15:12:17.239','postgres');
INSERT INTO tbl_audit VALUES ('2926','bitacora','I',NULL,'(27,20,"2015-06-19 15:12:17-05",234,1,1,1,"<p>234234</p>
",308625,"24 Track Music Session15121720.sesx",sesx,0)','2015-06-19 15:12:17.246','postgres');
INSERT INTO tbl_audit VALUES ('2927','metas','I',NULL,'(25,nombre,"24 Track Music Session.sesx",20)','2015-06-19 15:12:17.252','postgres');
INSERT INTO tbl_audit VALUES ('2928','metas','I',NULL,'(26,tipo,sesx,20)','2015-06-19 15:12:17.255','postgres');
INSERT INTO tbl_audit VALUES ('2929','metas','I',NULL,'(27,tamaño,308625,20)','2015-06-19 15:12:17.256','postgres');
INSERT INTO tbl_audit VALUES ('2930','recibidos','I',NULL,'(27,20,27,"2015-06-19 15:12:17-05",1,"{""1,2,3,4""}")','2015-06-19 15:12:17.265','postgres');
INSERT INTO tbl_audit VALUES ('2931','archivo','I',NULL,'(21,345,2-2015-06-19-sesx-21-28,1,1,"2015-06-19 15:12:35-05",0)','2015-06-19 15:12:35.865','postgres');
INSERT INTO tbl_audit VALUES ('2932','bitacora','I',NULL,'(28,21,"2015-06-19 15:12:35-05",345345,1,1,1,"",308625,"24 Track Music Session15123521.sesx",sesx,0)','2015-06-19 15:12:35.873','postgres');
INSERT INTO tbl_audit VALUES ('2933','metas','I',NULL,'(28,nombre,"24 Track Music Session.sesx",21)','2015-06-19 15:12:35.881','postgres');
INSERT INTO tbl_audit VALUES ('2934','metas','I',NULL,'(29,tipo,sesx,21)','2015-06-19 15:12:35.884','postgres');
INSERT INTO tbl_audit VALUES ('2935','metas','I',NULL,'(30,tamaño,308625,21)','2015-06-19 15:12:35.885','postgres');
INSERT INTO tbl_audit VALUES ('2936','recibidos','I',NULL,'(28,21,28,"2015-06-19 15:12:35-05",1,"{""1,2,3,4""}")','2015-06-19 15:12:35.893','postgres');
INSERT INTO tbl_audit VALUES ('2937','archivo','I',NULL,'(22,asdqwe,2-2015-06-19-sesx-22-29,1,1,"2015-06-19 15:13:08-05",0)','2015-06-19 15:13:08.938','postgres');
INSERT INTO tbl_audit VALUES ('2938','bitacora','I',NULL,'(29,22,"2015-06-19 15:13:08-05",qweqwe,1,1,1,"",308625,"24 Track Music Session15130822.sesx",sesx,0)','2015-06-19 15:13:08.946','postgres');
INSERT INTO tbl_audit VALUES ('2939','metas','I',NULL,'(31,nombre,"24 Track Music Session.sesx",22)','2015-06-19 15:13:08.951','postgres');
INSERT INTO tbl_audit VALUES ('2940','metas','I',NULL,'(32,tipo,sesx,22)','2015-06-19 15:13:08.953','postgres');
INSERT INTO tbl_audit VALUES ('2941','metas','I',NULL,'(33,tamaño,308625,22)','2015-06-19 15:13:08.955','postgres');
INSERT INTO tbl_audit VALUES ('2942','recibidos','I',NULL,'(29,22,29,"2015-06-19 15:13:08-05",1,{1})','2015-06-19 15:13:08.961','postgres');
INSERT INTO tbl_audit VALUES ('2944','bitacora','I',NULL,'(30,23,"2015-06-19 15:13:48-05",wer,1,1,1,"<p>werwer</p>
",308625,"24 Track Music Session15134823.sesx",sesx,0)','2015-06-19 15:13:48.994','postgres');
INSERT INTO tbl_audit VALUES ('2945','metas','I',NULL,'(34,nombre,"24 Track Music Session.sesx",23)','2015-06-19 15:13:48.999','postgres');
INSERT INTO tbl_audit VALUES ('2946','metas','I',NULL,'(35,tipo,sesx,23)','2015-06-19 15:13:49.002','postgres');
INSERT INTO tbl_audit VALUES ('2947','metas','I',NULL,'(36,tamaño,308625,23)','2015-06-19 15:13:49.003','postgres');
INSERT INTO tbl_audit VALUES ('2948','recibidos','I',NULL,'(30,23,30,"2015-06-19 15:13:48-05",1,"{""2,3""}")','2015-06-19 15:13:49.011','postgres');
INSERT INTO tbl_audit VALUES ('2949','archivo','I',NULL,'(24,wer,2-2015-06-19-sesx-24-31,1,1,"2015-06-19 15:14:02-05",0)','2015-06-19 15:14:02.555','postgres');
INSERT INTO tbl_audit VALUES ('2950','bitacora','I',NULL,'(31,24,"2015-06-19 15:14:02-05",wer,1,1,1,"",308625,"24 Track Music Session15140224.sesx",sesx,0)','2015-06-19 15:14:02.562','postgres');
INSERT INTO tbl_audit VALUES ('2951','metas','I',NULL,'(37,nombre,"24 Track Music Session.sesx",24)','2015-06-19 15:14:02.571','postgres');
INSERT INTO tbl_audit VALUES ('2952','metas','I',NULL,'(38,tipo,sesx,24)','2015-06-19 15:14:02.573','postgres');
INSERT INTO tbl_audit VALUES ('2953','metas','I',NULL,'(39,tamaño,308625,24)','2015-06-19 15:14:02.574','postgres');
INSERT INTO tbl_audit VALUES ('2954','recibidos','I',NULL,'(31,24,31,"2015-06-19 15:14:02-05",1,{2})','2015-06-19 15:14:02.581','postgres');
INSERT INTO tbl_audit VALUES ('2955','archivo','I',NULL,'(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",0)','2015-06-19 15:14:25.18','postgres');
INSERT INTO tbl_audit VALUES ('2956','bitacora','I',NULL,'(32,25,"2015-06-19 15:14:25-05",234,1,1,1,"<p>234</p>
",308625,"24 Track Music Session15142525.sesx",sesx,0)','2015-06-19 15:14:25.187','postgres');
INSERT INTO tbl_audit VALUES ('2957','metas','I',NULL,'(40,nombre,"24 Track Music Session.sesx",25)','2015-06-19 15:14:25.193','postgres');
INSERT INTO tbl_audit VALUES ('2958','metas','I',NULL,'(41,tipo,sesx,25)','2015-06-19 15:14:25.196','postgres');
INSERT INTO tbl_audit VALUES ('2959','metas','I',NULL,'(42,tamaño,308625,25)','2015-06-19 15:14:25.198','postgres');
INSERT INTO tbl_audit VALUES ('2960','recibidos','I',NULL,'(32,25,32,"2015-06-19 15:14:25-05",1,"{""1,4""}")','2015-06-19 15:14:25.206','postgres');
INSERT INTO tbl_audit VALUES ('2961','archivo','U','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",0)','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",0)','2015-06-19 15:14:43.025','postgres');
INSERT INTO tbl_audit VALUES ('2962','bitacora','I',NULL,'(33,25,"2015-06-19 15:14:43-05",234,1,1,1,"",308625,"24 Track Music Session15142525.sesx",sesx,0)','2015-06-19 15:14:43.033','postgres');
INSERT INTO tbl_audit VALUES ('2963','recibidos','I',NULL,'(33,25,33,"2015-06-19 15:14:43-05",1,"{""4,1""}")','2015-06-19 15:14:43.038','postgres');
INSERT INTO tbl_audit VALUES ('2964','archivo','I',NULL,'(26,qwe,2-2015-06-19-sesx-26-34,1,1,"2015-06-19 15:43:32-05",0)','2015-06-19 15:43:32.564','postgres');
INSERT INTO tbl_audit VALUES ('2965','bitacora','I',NULL,'(34,26,"2015-06-19 15:43:32-05",qwe,1,1,1,"<p>qwe</p>
",308625,"24 Track Music Session15433226.sesx",sesx,0)','2015-06-19 15:43:32.578','postgres');
INSERT INTO tbl_audit VALUES ('2966','metas','I',NULL,'(43,nombre,"24 Track Music Session.sesx",26)','2015-06-19 15:43:32.584','postgres');
INSERT INTO tbl_audit VALUES ('2967','metas','I',NULL,'(44,tipo,sesx,26)','2015-06-19 15:43:32.587','postgres');
INSERT INTO tbl_audit VALUES ('2968','metas','I',NULL,'(45,tamaño,308625,26)','2015-06-19 15:43:32.588','postgres');
INSERT INTO tbl_audit VALUES ('2969','recibidos','I',NULL,'(34,26,34,"2015-06-19 15:43:32-05",1,{1})','2015-06-19 15:43:32.595','postgres');
INSERT INTO tbl_audit VALUES ('2970','archivo','U','(26,qwe,2-2015-06-19-sesx-26-34,1,1,"2015-06-19 15:43:32-05",0)','(26,qwe,2-2015-06-19-sesx-26-34,1,1,"2015-06-19 15:43:32-05",1)','2015-06-22 13:10:21.849','postgres');
INSERT INTO tbl_audit VALUES ('2971','bitacora','I',NULL,'(35,26,"2015-06-22 13:10:21-05",qwe,1,1,1,"<p>asdasd</p>
",308625,"24 Track Music Session15433226.sesx",sesx,0)','2015-06-22 13:10:21.896','postgres');
INSERT INTO tbl_audit VALUES ('2972','recibidos','I',NULL,'(35,26,35,"2015-06-22 13:10:21-05",1,{1})','2015-06-22 13:10:21.934','postgres');
INSERT INTO tbl_audit VALUES ('2973','archivo','U','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",0)','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",0)','2015-06-22 13:16:47.153','postgres');
INSERT INTO tbl_audit VALUES ('2974','bitacora','I',NULL,'(36,25,"2015-06-22 13:16:47-05",234,1,1,1,"",308625,"24 Track Music Session15142525.sesx",sesx,0)','2015-06-22 13:16:47.161','postgres');
INSERT INTO tbl_audit VALUES ('2975','recibidos','I',NULL,'(36,25,36,"2015-06-22 13:16:47-05",1,"{""1,4""}")','2015-06-22 13:16:47.17','postgres');
INSERT INTO tbl_audit VALUES ('2976','archivo','U','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",0)','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",0)','2015-06-22 13:18:25.301','postgres');
INSERT INTO tbl_audit VALUES ('2977','bitacora','I',NULL,'(37,25,"2015-06-22 13:18:25-05",234,1,1,1,"",308625,"24 Track Music Session15142525.sesx",sesx,0)','2015-06-22 13:18:25.308','postgres');
INSERT INTO tbl_audit VALUES ('2978','recibidos','I',NULL,'(37,25,37,"2015-06-22 13:18:25-05",1,"{""1,4""}")','2015-06-22 13:18:25.317','postgres');
INSERT INTO tbl_audit VALUES ('2979','archivo','U','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",0)','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",1)','2015-06-22 13:23:46.602','postgres');
INSERT INTO tbl_audit VALUES ('2980','bitacora','I',NULL,'(38,25,"2015-06-22 13:23:46-05",234,1,1,1,"",308625,"24 Track Music Session15142525.sesx",sesx,1)','2015-06-22 13:23:46.611','postgres');
INSERT INTO tbl_audit VALUES ('2981','recibidos','I',NULL,'(38,25,38,"2015-06-22 13:23:46-05",1,"{""1,4""}")','2015-06-22 13:23:46.621','postgres');
INSERT INTO tbl_audit VALUES ('2982','bitacora','U','(1,1,"2015-06-18 16:53:10-05",123123,1,1,1,"<p>werwerwerwer</p>
",1502474,20141117_1102421653101.jpg,jpg,0)','(1,1,"2015-06-18 16:53:10-05",123123,1,1,1,"<p>werwerwerwer</p>
",1502474,20141117_1102421653101.txt,jpg,0)','2015-06-23 11:54:04.451','postgres');
INSERT INTO tbl_audit VALUES ('2983','bitacora','U','(1,1,"2015-06-18 16:53:10-05",123123,1,1,1,"<p>werwerwerwer</p>
",1502474,20141117_1102421653101.txt,jpg,0)','(1,1,"2015-06-18 16:53:10-05",123123,1,1,1,"<p>werwerwerwer</p>
",1502474,20141117_1102421653101.txt,txt,0)','2015-06-23 11:54:07.044','postgres');
INSERT INTO tbl_audit VALUES ('2984','bitacora','U','(17,1,"2015-06-19 10:13:55-05",123123,1,1,1,"",1502474,20141117_1102421653101.jpg,jpg,0)','(17,1,"2015-06-19 10:13:55-05",123123,1,1,1,"",1502474,20141117_1102421653101.txt,jpg,0)','2015-06-23 11:54:24.428','postgres');
INSERT INTO tbl_audit VALUES ('2985','bitacora','U','(17,1,"2015-06-19 10:13:55-05",123123,1,1,1,"",1502474,20141117_1102421653101.txt,jpg,0)','(17,1,"2015-06-19 10:13:55-05",123123,1,1,1,"",1502474,20141117_1102421653101.txt,txt,0)','2015-06-23 11:54:26.236','postgres');
INSERT INTO tbl_audit VALUES ('2986','bitacora','D','(34,26,"2015-06-19 15:43:32-05",qwe,1,1,1,"<p>qwe</p>
",308625,"24 Track Music Session15433226.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.213','postgres');
INSERT INTO tbl_audit VALUES ('2987','bitacora','D','(33,25,"2015-06-19 15:14:43-05",234,1,1,1,"",308625,"24 Track Music Session15142525.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.214','postgres');
INSERT INTO tbl_audit VALUES ('2988','bitacora','D','(32,25,"2015-06-19 15:14:25-05",234,1,1,1,"<p>234</p>
",308625,"24 Track Music Session15142525.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.214','postgres');
INSERT INTO tbl_audit VALUES ('2989','bitacora','D','(31,24,"2015-06-19 15:14:02-05",wer,1,1,1,"",308625,"24 Track Music Session15140224.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.215','postgres');
INSERT INTO tbl_audit VALUES ('2990','bitacora','D','(30,23,"2015-06-19 15:13:48-05",wer,1,1,1,"<p>werwer</p>
",308625,"24 Track Music Session15134823.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.215','postgres');
INSERT INTO tbl_audit VALUES ('2991','bitacora','D','(29,22,"2015-06-19 15:13:08-05",qweqwe,1,1,1,"",308625,"24 Track Music Session15130822.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.216','postgres');
INSERT INTO tbl_audit VALUES ('2992','bitacora','D','(28,21,"2015-06-19 15:12:35-05",345345,1,1,1,"",308625,"24 Track Music Session15123521.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.216','postgres');
INSERT INTO tbl_audit VALUES ('2993','bitacora','D','(27,20,"2015-06-19 15:12:17-05",234,1,1,1,"<p>234234</p>
",308625,"24 Track Music Session15121720.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.217','postgres');
INSERT INTO tbl_audit VALUES ('2994','bitacora','D','(26,19,"2015-06-19 15:12:00-05",234,1,1,1,"<p>2</p>
",308625,"24 Track Music Session15120019.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.217','postgres');
INSERT INTO tbl_audit VALUES ('2995','bitacora','D','(25,18,"2015-06-19 15:11:34-05",234,1,1,1,"",308625,"24 Track Music Session15113418.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.218','postgres');
INSERT INTO tbl_audit VALUES ('3130','metas','D','(2,tipo,txt,1)',NULL,'2015-06-23 12:54:39.887','postgres');
INSERT INTO tbl_audit VALUES ('2996','bitacora','D','(24,17,"2015-06-19 15:10:41-05",wer,1,1,1,"",308625,"24 Track Music Session15104117.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.218','postgres');
INSERT INTO tbl_audit VALUES ('2997','bitacora','D','(23,16,"2015-06-19 15:09:09-05",123,1,1,1,"",308625,"24 Track Music Session15090916.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.233','postgres');
INSERT INTO tbl_audit VALUES ('2998','bitacora','D','(22,15,"2015-06-19 15:07:40-05",wer,1,1,1,"<p>werwer</p>
",308625,"24 Track Music Session15074015.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.233','postgres');
INSERT INTO tbl_audit VALUES ('2999','bitacora','D','(20,13,"2015-06-19 15:06:22-05",werwer,1,1,1,"<p>qweqwe</p>
",136277,"Vocal and Guitar with Metronome15062213.sesx",sesx,0)',NULL,'2015-06-23 11:54:38.234','postgres');
INSERT INTO tbl_audit VALUES ('3000','bitacora','D','(18,11,"2015-06-19 10:16:48-05",23123,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.234','postgres');
INSERT INTO tbl_audit VALUES ('3001','bitacora','D','(17,1,"2015-06-19 10:13:55-05",123123,1,1,1,"",1502474,20141117_1102421653101.txt,txt,0)',NULL,'2015-06-23 11:54:38.235','postgres');
INSERT INTO tbl_audit VALUES ('3002','bitacora','D','(16,7,"2015-06-19 10:10:32-05",4234234234,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.235','postgres');
INSERT INTO tbl_audit VALUES ('3003','bitacora','D','(15,7,"2015-06-19 10:07:46-05",4234234234,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.235','postgres');
INSERT INTO tbl_audit VALUES ('3004','bitacora','D','(14,7,"2015-06-19 10:03:02-05",4234234234,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.235','postgres');
INSERT INTO tbl_audit VALUES ('3005','bitacora','D','(13,7,"2015-06-19 10:02:04-05",4234234234,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.236','postgres');
INSERT INTO tbl_audit VALUES ('3006','bitacora','D','(12,7,"2015-06-18 18:24:59-05",4234234234,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.236','postgres');
INSERT INTO tbl_audit VALUES ('3007','bitacora','D','(11,7,"2015-06-18 18:22:08-05",4234234234,1,1,1,"<p>234</p>
","","","",0)',NULL,'2015-06-23 11:54:38.237','postgres');
INSERT INTO tbl_audit VALUES ('3008','bitacora','D','(10,10,"2015-06-18 17:17:15-05",WEQE,2,1,1,"<p>QWE</p>
","","","",0)',NULL,'2015-06-23 11:54:38.237','postgres');
INSERT INTO tbl_audit VALUES ('3009','bitacora','D','(9,9,"2015-06-18 17:17:06-05",123123,2,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.238','postgres');
INSERT INTO tbl_audit VALUES ('3010','bitacora','D','(8,8,"2015-06-18 17:16:59-05",3QWEQWEQWE,2,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.238','postgres');
INSERT INTO tbl_audit VALUES ('3011','bitacora','D','(7,7,"2015-06-18 17:04:33-05",4234234234,1,1,1,"<p>234234</p>
","","","",0)',NULL,'2015-06-23 11:54:38.239','postgres');
INSERT INTO tbl_audit VALUES ('3012','bitacora','D','(6,6,"2015-06-18 17:04:07-05",1123weqwe,1,1,1,"<p>eqweqwe</p>
","","","",0)',NULL,'2015-06-23 11:54:38.239','postgres');
INSERT INTO tbl_audit VALUES ('3013','bitacora','D','(5,5,"2015-06-18 17:03:58-05",123123,1,1,1,"<p>213123123</p>
","","","",0)',NULL,'2015-06-23 11:54:38.239','postgres');
INSERT INTO tbl_audit VALUES ('3014','bitacora','D','(4,4,"2015-06-18 16:54:33-05",2222222222222,1,1,1,"<p>2222222222222</p>
","","","",0)',NULL,'2015-06-23 11:54:38.241','postgres');
INSERT INTO tbl_audit VALUES ('3015','bitacora','D','(3,3,"2015-06-18 16:54:04-05",htyhtyhtyh,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.241','postgres');
INSERT INTO tbl_audit VALUES ('3016','bitacora','D','(2,2,"2015-06-18 16:53:44-05",qweqweqwe,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:38.241','postgres');
INSERT INTO tbl_audit VALUES ('3017','bitacora','D','(38,25,"2015-06-22 13:23:46-05",234,1,1,1,"",308625,"24 Track Music Session15142525.sesx",sesx,1)',NULL,'2015-06-23 11:54:40.508','postgres');
INSERT INTO tbl_audit VALUES ('3018','bitacora','D','(37,25,"2015-06-22 13:18:25-05",234,1,1,1,"",308625,"24 Track Music Session15142525.sesx",sesx,0)',NULL,'2015-06-23 11:54:40.509','postgres');
INSERT INTO tbl_audit VALUES ('3019','bitacora','D','(36,25,"2015-06-22 13:16:47-05",234,1,1,1,"",308625,"24 Track Music Session15142525.sesx",sesx,0)',NULL,'2015-06-23 11:54:40.509','postgres');
INSERT INTO tbl_audit VALUES ('3020','bitacora','D','(35,26,"2015-06-22 13:10:21-05",qwe,1,1,1,"<p>asdasd</p>
",308625,"24 Track Music Session15433226.sesx",sesx,0)',NULL,'2015-06-23 11:54:40.51','postgres');
INSERT INTO tbl_audit VALUES ('3021','bitacora','D','(21,14,"2015-06-19 15:06:58-05",234,1,1,1,"",308625,"24 Track Music Session15065814.sesx",sesx,0)',NULL,'2015-06-23 11:54:40.51','postgres');
INSERT INTO tbl_audit VALUES ('3022','bitacora','D','(19,12,"2015-06-19 10:17:21-05",123,1,1,1,"","","","",0)',NULL,'2015-06-23 11:54:40.511','postgres');
INSERT INTO tbl_audit VALUES ('3023','archivo','D','(26,qwe,2-2015-06-19-sesx-26-34,1,1,"2015-06-19 15:43:32-05",1)',NULL,'2015-06-23 11:56:02.795','postgres');
INSERT INTO tbl_audit VALUES ('3024','metas','D','(43,nombre,"24 Track Music Session.sesx",26)',NULL,'2015-06-23 11:56:02.795','postgres');
INSERT INTO tbl_audit VALUES ('3025','metas','D','(44,tipo,sesx,26)',NULL,'2015-06-23 11:56:02.795','postgres');
INSERT INTO tbl_audit VALUES ('3026','metas','D','(45,tamaño,308625,26)',NULL,'2015-06-23 11:56:02.795','postgres');
INSERT INTO tbl_audit VALUES ('3027','recibidos','D','(34,26,34,"2015-06-19 15:43:32-05",1,{1})',NULL,'2015-06-23 11:56:02.795','postgres');
INSERT INTO tbl_audit VALUES ('3028','recibidos','D','(35,26,35,"2015-06-22 13:10:21-05",1,{1})',NULL,'2015-06-23 11:56:02.795','postgres');
INSERT INTO tbl_audit VALUES ('3029','archivo','D','(25,234,2-2015-06-19-sesx-25-32,1,1,"2015-06-19 15:14:25-05",1)',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3030','metas','D','(40,nombre,"24 Track Music Session.sesx",25)',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3031','metas','D','(41,tipo,sesx,25)',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3032','metas','D','(42,tamaño,308625,25)',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3033','recibidos','D','(38,25,38,"2015-06-22 13:23:46-05",1,"{""1,4""}")',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3034','recibidos','D','(32,25,32,"2015-06-19 15:14:25-05",1,"{""1,4""}")',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3035','recibidos','D','(33,25,33,"2015-06-19 15:14:43-05",1,"{""4,1""}")',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3036','recibidos','D','(36,25,36,"2015-06-22 13:16:47-05",1,"{""1,4""}")',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3037','recibidos','D','(37,25,37,"2015-06-22 13:18:25-05",1,"{""1,4""}")',NULL,'2015-06-23 11:56:02.852','postgres');
INSERT INTO tbl_audit VALUES ('3038','archivo','D','(24,wer,2-2015-06-19-sesx-24-31,1,1,"2015-06-19 15:14:02-05",0)',NULL,'2015-06-23 11:56:02.854','postgres');
INSERT INTO tbl_audit VALUES ('3039','metas','D','(37,nombre,"24 Track Music Session.sesx",24)',NULL,'2015-06-23 11:56:02.854','postgres');
INSERT INTO tbl_audit VALUES ('3040','metas','D','(38,tipo,sesx,24)',NULL,'2015-06-23 11:56:02.854','postgres');
INSERT INTO tbl_audit VALUES ('3041','metas','D','(39,tamaño,308625,24)',NULL,'2015-06-23 11:56:02.854','postgres');
INSERT INTO tbl_audit VALUES ('3042','recibidos','D','(31,24,31,"2015-06-19 15:14:02-05",1,{2})',NULL,'2015-06-23 11:56:02.854','postgres');
INSERT INTO tbl_audit VALUES ('3043','archivo','D','(23,wrer,2-2015-06-19-sesx-23-30,1,1,"2015-06-19 15:13:48-05",0)',NULL,'2015-06-23 11:56:02.855','postgres');
INSERT INTO tbl_audit VALUES ('3044','metas','D','(34,nombre,"24 Track Music Session.sesx",23)',NULL,'2015-06-23 11:56:02.855','postgres');
INSERT INTO tbl_audit VALUES ('3045','metas','D','(35,tipo,sesx,23)',NULL,'2015-06-23 11:56:02.855','postgres');
INSERT INTO tbl_audit VALUES ('3046','metas','D','(36,tamaño,308625,23)',NULL,'2015-06-23 11:56:02.855','postgres');
INSERT INTO tbl_audit VALUES ('3047','recibidos','D','(30,23,30,"2015-06-19 15:13:48-05",1,"{""2,3""}")',NULL,'2015-06-23 11:56:02.855','postgres');
INSERT INTO tbl_audit VALUES ('3048','archivo','D','(22,asdqwe,2-2015-06-19-sesx-22-29,1,1,"2015-06-19 15:13:08-05",0)',NULL,'2015-06-23 11:56:02.856','postgres');
INSERT INTO tbl_audit VALUES ('3049','metas','D','(31,nombre,"24 Track Music Session.sesx",22)',NULL,'2015-06-23 11:56:02.856','postgres');
INSERT INTO tbl_audit VALUES ('3050','metas','D','(32,tipo,sesx,22)',NULL,'2015-06-23 11:56:02.856','postgres');
INSERT INTO tbl_audit VALUES ('3051','metas','D','(33,tamaño,308625,22)',NULL,'2015-06-23 11:56:02.856','postgres');
INSERT INTO tbl_audit VALUES ('3052','recibidos','D','(29,22,29,"2015-06-19 15:13:08-05",1,{1})',NULL,'2015-06-23 11:56:02.856','postgres');
INSERT INTO tbl_audit VALUES ('3053','archivo','D','(21,345,2-2015-06-19-sesx-21-28,1,1,"2015-06-19 15:12:35-05",0)',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3054','metas','D','(28,nombre,"24 Track Music Session.sesx",21)',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3055','metas','D','(29,tipo,sesx,21)',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3056','metas','D','(30,tamaño,308625,21)',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3057','recibidos','D','(28,21,28,"2015-06-19 15:12:35-05",1,"{""1,2,3,4""}")',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3058','archivo','D','(20,234,2-2015-06-19-sesx-20-27,1,1,"2015-06-19 15:12:17-05",0)',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3059','metas','D','(25,nombre,"24 Track Music Session.sesx",20)',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3060','metas','D','(26,tipo,sesx,20)',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3061','metas','D','(27,tamaño,308625,20)',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3062','recibidos','D','(27,20,27,"2015-06-19 15:12:17-05",1,"{""1,2,3,4""}")',NULL,'2015-06-23 11:56:02.857','postgres');
INSERT INTO tbl_audit VALUES ('3063','archivo','D','(19,234,2-2015-06-19-sesx-19-26,1,1,"2015-06-19 15:12:00-05",0)',NULL,'2015-06-23 11:56:02.858','postgres');
INSERT INTO tbl_audit VALUES ('3064','metas','D','(22,nombre,"24 Track Music Session.sesx",19)',NULL,'2015-06-23 11:56:02.858','postgres');
INSERT INTO tbl_audit VALUES ('3065','metas','D','(23,tipo,sesx,19)',NULL,'2015-06-23 11:56:02.858','postgres');
INSERT INTO tbl_audit VALUES ('3066','metas','D','(24,tamaño,308625,19)',NULL,'2015-06-23 11:56:02.858','postgres');
INSERT INTO tbl_audit VALUES ('3067','recibidos','D','(26,19,26,"2015-06-19 15:12:00-05",1,"{""1,3""}")',NULL,'2015-06-23 11:56:02.858','postgres');
INSERT INTO tbl_audit VALUES ('3068','archivo','D','(18,234,2-2015-06-19-sesx-18-25,1,1,"2015-06-19 15:11:34-05",0)',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3069','metas','D','(19,nombre,"24 Track Music Session.sesx",18)',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3070','metas','D','(20,tipo,sesx,18)',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3071','metas','D','(21,tamaño,308625,18)',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3072','recibidos','D','(25,18,25,"2015-06-19 15:11:34-05",1,{1})',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3073','archivo','D','(17,wer,2-2015-06-19-sesx-17-24,1,1,"2015-06-19 15:10:41-05",0)',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3074','metas','D','(16,nombre,"24 Track Music Session.sesx",17)',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3075','metas','D','(17,tipo,sesx,17)',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3076','metas','D','(18,tamaño,308625,17)',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3077','recibidos','D','(24,17,24,"2015-06-19 15:10:41-05",1,{1})',NULL,'2015-06-23 11:56:02.859','postgres');
INSERT INTO tbl_audit VALUES ('3078','archivo','D','(16,123,2-2015-06-19-sesx-16-23,1,1,"2015-06-19 15:09:09-05",0)',NULL,'2015-06-23 11:56:02.86','postgres');
INSERT INTO tbl_audit VALUES ('3079','metas','D','(13,nombre,"24 Track Music Session.sesx",16)',NULL,'2015-06-23 11:56:02.86','postgres');
INSERT INTO tbl_audit VALUES ('3080','metas','D','(14,tipo,sesx,16)',NULL,'2015-06-23 11:56:02.86','postgres');
INSERT INTO tbl_audit VALUES ('3081','metas','D','(15,tamaño,308625,16)',NULL,'2015-06-23 11:56:02.86','postgres');
INSERT INTO tbl_audit VALUES ('3082','recibidos','D','(23,16,23,"2015-06-19 15:09:09-05",1,"{""1,2,3,4""}")',NULL,'2015-06-23 11:56:02.86','postgres');
INSERT INTO tbl_audit VALUES ('3083','archivo','D','(15,wer,2-2015-06-19-sesx-15-22,1,1,"2015-06-19 15:07:40-05",0)',NULL,'2015-06-23 11:56:02.861','postgres');
INSERT INTO tbl_audit VALUES ('3084','metas','D','(10,nombre,"24 Track Music Session.sesx",15)',NULL,'2015-06-23 11:56:02.861','postgres');
INSERT INTO tbl_audit VALUES ('3085','metas','D','(11,tipo,sesx,15)',NULL,'2015-06-23 11:56:02.861','postgres');
INSERT INTO tbl_audit VALUES ('3086','metas','D','(12,tamaño,308625,15)',NULL,'2015-06-23 11:56:02.861','postgres');
INSERT INTO tbl_audit VALUES ('3087','recibidos','D','(22,15,22,"2015-06-19 15:07:40-05",1,"{""1,2,3,4""}")',NULL,'2015-06-23 11:56:02.861','postgres');
INSERT INTO tbl_audit VALUES ('3088','archivo','D','(14,234,2-2015-06-19-sesx-14-21,1,1,"2015-06-19 15:06:58-05",0)',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3089','metas','D','(7,nombre,"24 Track Music Session.sesx",14)',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3090','metas','D','(8,tipo,sesx,14)',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3091','metas','D','(9,tamaño,308625,14)',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3092','recibidos','D','(21,14,21,"2015-06-19 15:06:58-05",1,"{""1,3""}")',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3093','archivo','D','(13,werw,V-2015-06-19-sesx-13-20,1,1,"2015-06-19 15:06:22-05",0)',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3094','metas','D','(4,nombre,"Vocal and Guitar with Metronome.sesx",13)',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3095','metas','D','(5,tipo,sesx,13)',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3096','metas','D','(6,tamaño,136277,13)',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3097','recibidos','D','(20,13,20,"2015-06-19 15:06:22-05",1,"{""1,2,3,4""}")',NULL,'2015-06-23 11:56:02.862','postgres');
INSERT INTO tbl_audit VALUES ('3098','archivo','D','(12,2312,2-2015-06-19-SD-12-19,1,1,"2015-06-19 10:17:21-05",0)',NULL,'2015-06-23 11:56:02.863','postgres');
INSERT INTO tbl_audit VALUES ('3099','recibidos','D','(19,12,19,"2015-06-19 10:17:21-05",1,{1})',NULL,'2015-06-23 11:56:02.863','postgres');
INSERT INTO tbl_audit VALUES ('3100','archivo','D','(11,123,1-2015-06-19-SD-11-18,1,1,"2015-06-19 10:16:48-05",0)',NULL,'2015-06-23 11:56:02.863','postgres');
INSERT INTO tbl_audit VALUES ('3101','recibidos','D','(18,11,18,"2015-06-19 10:16:48-05",1,{1})',NULL,'2015-06-23 11:56:02.863','postgres');
INSERT INTO tbl_audit VALUES ('3102','archivo','D','(10,123123,1-2015-06-18-SD-10-10,1,2,"2015-06-18 17:17:15-05",0)',NULL,'2015-06-23 11:56:02.864','postgres');
INSERT INTO tbl_audit VALUES ('3103','recibidos','D','(10,10,10,"2015-06-18 17:17:15-05",2,"{""1,2""}")',NULL,'2015-06-23 11:56:02.864','postgres');
INSERT INTO tbl_audit VALUES ('3104','archivo','D','(9,23123,2-2015-06-18-SD-9-9,1,2,"2015-06-18 17:17:06-05",0)',NULL,'2015-06-23 11:56:02.864','postgres');
INSERT INTO tbl_audit VALUES ('3105','recibidos','D','(9,9,9,"2015-06-18 17:17:06-05",2,{1})',NULL,'2015-06-23 11:56:02.864','postgres');
INSERT INTO tbl_audit VALUES ('3106','archivo','D','(8,12312,1-2015-06-18-SD-8-8,1,2,"2015-06-18 17:16:59-05",0)',NULL,'2015-06-23 11:56:02.865','postgres');
INSERT INTO tbl_audit VALUES ('3107','recibidos','D','(8,8,8,"2015-06-18 17:16:59-05",2,{2})',NULL,'2015-06-23 11:56:02.865','postgres');
INSERT INTO tbl_audit VALUES ('3108','archivo','D','(7,423423,4-2015-06-18-SD-7-7,1,1,"2015-06-18 17:04:33-05",1)',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3109','recibidos','D','(7,7,7,"2015-06-18 17:04:33-05",1,{1})',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3110','recibidos','D','(11,7,11,"2015-06-18 18:22:08-05",1,{1})',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3111','recibidos','D','(12,7,12,"2015-06-18 18:24:59-05",1,{1})',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3112','recibidos','D','(13,7,13,"2015-06-19 10:02:04-05",1,{1})',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3113','recibidos','D','(14,7,14,"2015-06-19 10:03:02-05",1,{1})',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3114','recibidos','D','(15,7,15,"2015-06-19 10:07:46-05",1,{1})',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3115','recibidos','D','(16,7,16,"2015-06-19 10:10:32-05",1,{1})',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3116','archivo','D','(6,123123,1-2015-06-18-SD-6-6,1,1,"2015-06-18 17:04:07-05",0)',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3117','recibidos','D','(6,6,6,"2015-06-18 17:04:07-05",1,"{""1,2""}")',NULL,'2015-06-23 11:56:02.866','postgres');
INSERT INTO tbl_audit VALUES ('3118','archivo','D','(5,werwerwe,w-2015-06-18-SD-5-5,1,1,"2015-06-18 17:03:58-05",0)',NULL,'2015-06-23 11:56:02.867','postgres');
INSERT INTO tbl_audit VALUES ('3119','recibidos','D','(5,5,5,"2015-06-18 17:03:58-05",1,{2})',NULL,'2015-06-23 11:56:02.867','postgres');
INSERT INTO tbl_audit VALUES ('3120','archivo','D','(4,123123123,1-2015-06-18-SD-4-4,1,1,"2015-06-18 16:54:33-05",0)',NULL,'2015-06-23 11:56:02.868','postgres');
INSERT INTO tbl_audit VALUES ('3121','recibidos','D','(4,4,4,"2015-06-18 16:54:33-05",1,{1})',NULL,'2015-06-23 11:56:02.868','postgres');
INSERT INTO tbl_audit VALUES ('3122','archivo','D','(3,htyhty,h-2015-06-18-SD-3-3,1,1,"2015-06-18 16:54:04-05",0)',NULL,'2015-06-23 11:56:02.868','postgres');
INSERT INTO tbl_audit VALUES ('3123','recibidos','D','(3,3,3,"2015-06-18 16:54:04-05",1,"{""1,2""}")',NULL,'2015-06-23 11:56:02.868','postgres');
INSERT INTO tbl_audit VALUES ('3124','archivo','D','(2,234234,2-2015-06-18-SD-2-2,1,1,"2015-06-18 16:53:44-05",0)',NULL,'2015-06-23 11:56:02.869','postgres');
INSERT INTO tbl_audit VALUES ('3125','recibidos','D','(2,2,2,"2015-06-18 16:53:44-05",1,{2})',NULL,'2015-06-23 11:56:02.869','postgres');
INSERT INTO tbl_audit VALUES ('3126','metas','U','(2,tipo,jpg,1)','(2,tipo,txt,1)','2015-06-23 12:52:23.879','postgres');
INSERT INTO tbl_audit VALUES ('3127','metas','U','(1,nombre,20141117_110242.jpg,1)','(1,nombre,20141117_110242.tt,1)','2015-06-23 12:52:26.719','postgres');
INSERT INTO tbl_audit VALUES ('3128','archivo','D','(1,qqqqweqw,2-2015-06-18-jpg-1-1,1,1,"2015-06-18 16:53:10-05",0)',NULL,'2015-06-23 12:54:39.887','postgres');
INSERT INTO tbl_audit VALUES ('3129','bitacora','D','(1,1,"2015-06-18 16:53:10-05",123123,1,1,1,"<p>werwerwerwer</p>
",1502474,20141117_1102421653101.txt,txt,0)',NULL,'2015-06-23 12:54:39.887','postgres');
INSERT INTO tbl_audit VALUES ('3131','metas','D','(1,nombre,20141117_110242.tt,1)',NULL,'2015-06-23 12:54:39.887','postgres');
INSERT INTO tbl_audit VALUES ('3132','metas','D','(3,tamaño,1502474,1)',NULL,'2015-06-23 12:54:39.887','postgres');
INSERT INTO tbl_audit VALUES ('3133','recibidos','D','(1,1,1,"2015-06-18 16:53:10-05",1,"{""1,2""}")',NULL,'2015-06-23 12:54:39.887','postgres');
INSERT INTO tbl_audit VALUES ('3134','recibidos','D','(17,1,17,"2015-06-19 10:13:55-05",1,"{""1,2""}")',NULL,'2015-06-23 12:54:39.887','postgres');
INSERT INTO tbl_audit VALUES ('3135','archivo','I',NULL,'(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-06-23 12:55:10-05",0)','2015-06-23 12:55:11.012','postgres');
INSERT INTO tbl_audit VALUES ('3136','bitacora','I',NULL,'(1,1,"2015-06-23 12:55:10-05",wer,1,1,1,"<p>qweq</p>
",18369,reservacion1255101.backup,backup,0)','2015-06-23 12:55:11.024','postgres');
INSERT INTO tbl_audit VALUES ('3137','metas','I',NULL,'(1,nombre,reservacion.backup,1)','2015-06-23 12:55:11.03','postgres');
INSERT INTO tbl_audit VALUES ('3138','metas','I',NULL,'(2,tipo,backup,1)','2015-06-23 12:55:11.033','postgres');
INSERT INTO tbl_audit VALUES ('3139','metas','I',NULL,'(3,tamaño,18369,1)','2015-06-23 12:55:11.034','postgres');
INSERT INTO tbl_audit VALUES ('3140','recibidos','I',NULL,'(1,1,1,"2015-06-23 12:55:10-05",1,{1})','2015-06-23 12:55:11.071','postgres');
INSERT INTO tbl_audit VALUES ('3141','bitacora','U','(1,1,"2015-06-23 12:55:10-05",wer,1,1,1,"<p>qweq</p>
",18369,reservacion1255101.backup,backup,0)','(1,1,"2015-06-23 12:55:10-05",gtgerget,1,1,1,"<p>qweq</p>
",18369,reservacion1255101.backup,backup,0)','2015-06-23 13:14:56.325','postgres');
INSERT INTO tbl_audit VALUES ('3142','archivo','I',NULL,'(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-06-24 10:36:07-05",0)','2015-06-24 10:36:07.849','postgres');
INSERT INTO tbl_audit VALUES ('3143','bitacora','I',NULL,'(2,2,"2015-06-24 10:36:07-05",qweqwe,1,1,1,"<p>qweqwe</p>
","","","",0)','2015-06-24 10:36:07.968','postgres');
INSERT INTO tbl_audit VALUES ('3144','recibidos','I',NULL,'(2,2,2,"2015-06-24 10:36:07-05",1,"{""1,2""}")','2015-06-24 10:36:08.099','postgres');
INSERT INTO tbl_audit VALUES ('3145','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-06-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-05-24 10:36:07-05",0)','2015-06-24 10:37:37.112','postgres');
INSERT INTO tbl_audit VALUES ('3146','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-05-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-06-24 10:36:07-05",0)','2015-06-24 10:38:05.383','postgres');
INSERT INTO tbl_audit VALUES ('3147','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-06-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,2,"2015-06-24 10:36:07-05",0)','2015-06-24 10:39:28.534','postgres');
INSERT INTO tbl_audit VALUES ('3148','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,2,"2015-06-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,2,"2015-05-24 10:36:07-05",0)','2015-06-24 10:39:34.686','postgres');
INSERT INTO tbl_audit VALUES ('3149','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,2,"2015-05-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-05-24 10:36:07-05",0)','2015-06-24 10:40:01.326','postgres');
INSERT INTO tbl_audit VALUES ('3150','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-05-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-02-24 10:36:07-05",0)','2015-06-24 10:45:45.97','postgres');
INSERT INTO tbl_audit VALUES ('3151','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-02-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-06-24 10:36:07-05",0)','2015-06-24 10:55:04.362','postgres');
INSERT INTO tbl_audit VALUES ('3152','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-06-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-05-24 10:36:07-05",0)','2015-06-24 10:55:15.466','postgres');
INSERT INTO tbl_audit VALUES ('3153','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-05-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-02-24 10:36:07-05",0)','2015-06-24 10:55:42.649','postgres');
INSERT INTO tbl_audit VALUES ('3154','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-02-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",0)','2015-06-24 10:55:50.649','postgres');
INSERT INTO tbl_audit VALUES ('3155','bitacora','U','(2,2,"2015-06-24 10:36:07-05",qweqwe,1,1,1,"<p>qweqwe</p>
","","","",0)','(2,2,"2015-06-24 10:36:07-05",qweqwe,1,1,1,"<p>qweqwe</p>
",0,"","",0)','2015-06-24 11:18:29.079','postgres');
INSERT INTO tbl_audit VALUES ('3156','archivo','I',NULL,'(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",0)','2015-06-24 11:21:33.977','postgres');
INSERT INTO tbl_audit VALUES ('3157','bitacora','I',NULL,'(3,3,"2015-06-24 11:21:33-05",qwe,1,1,1,"<p>wewe</p>
",0,"","",0)','2015-06-24 11:21:33.992','postgres');
INSERT INTO tbl_audit VALUES ('3158','recibidos','I',NULL,'(3,3,3,"2015-06-24 11:21:33-05",1,{1})','2015-06-24 11:21:34.001','postgres');
INSERT INTO tbl_audit VALUES ('3159','archivo','U','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-06-23 12:55:10-05",0)','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",0)','2015-06-24 11:33:33.563','postgres');
INSERT INTO tbl_audit VALUES ('3160','bitacora','U','(2,2,"2015-06-24 10:36:07-05",qweqwe,1,1,1,"<p>qweqwe</p>
",0,"","",0)','(2,2,"2015-06-24 10:36:07-05",qweqwe,1,1,1,"<p>qweqwe</p>
",25000,"","",0)','2015-06-24 11:36:46.785','postgres');
INSERT INTO tbl_audit VALUES ('3161','bitacora','U','(3,3,"2015-06-24 11:21:33-05",qwe,1,1,1,"<p>wewe</p>
",0,"","",0)','(3,3,"2015-06-24 11:21:33-05",qwe,1,1,1,"<p>wewe</p>
",35000,"","",0)','2015-06-24 11:36:48.697','postgres');
INSERT INTO tbl_audit VALUES ('3162','bitacora','U','(2,2,"2015-06-24 10:36:07-05",qweqwe,1,1,1,"<p>qweqwe</p>
",25000,"","",0)','(2,2,"2015-06-24 10:36:07-05",qweqwe,1,2,1,"<p>qweqwe</p>
",25000,"","",0)','2015-06-24 13:30:19.584','postgres');
INSERT INTO tbl_audit VALUES ('3163','archivo','U','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",0)','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",1)','2015-06-24 14:37:53.601','postgres');
INSERT INTO tbl_audit VALUES ('3164','archivo','U','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",1)','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",0)','2015-06-24 14:44:43.876','postgres');
INSERT INTO tbl_audit VALUES ('3165','archivo','U','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",0)','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",1)','2015-06-24 14:45:18.867','postgres');
INSERT INTO tbl_audit VALUES ('3166','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",1)','2015-06-24 14:45:21.459','postgres');
INSERT INTO tbl_audit VALUES ('3167','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",1)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",0)','2015-06-24 14:45:34.515','postgres');
INSERT INTO tbl_audit VALUES ('3168','archivo','U','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",1)','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",0)','2015-06-24 14:45:44.635','postgres');
INSERT INTO tbl_audit VALUES ('3169','archivo','U','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",0)','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",1)','2015-06-24 14:45:46.658','postgres');
INSERT INTO tbl_audit VALUES ('3170','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",1)','2015-06-24 14:45:53.819','postgres');
INSERT INTO tbl_audit VALUES ('3171','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",1)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",0)','2015-06-24 14:46:59.53','postgres');
INSERT INTO tbl_audit VALUES ('3172','archivo','U','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",1)','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",0)','2015-06-24 14:47:22.77','postgres');
INSERT INTO tbl_audit VALUES ('3173','archivo','U','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",0)','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",1)','2015-06-24 14:47:26.618','postgres');
INSERT INTO tbl_audit VALUES ('3174','archivo','U','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",0)','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",1)','2015-06-24 14:47:29.834','postgres');
INSERT INTO tbl_audit VALUES ('3175','archivo','U','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",1)','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",0)','2015-06-24 14:47:39.713','postgres');
INSERT INTO tbl_audit VALUES ('3176','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",1)','2015-06-24 14:48:29.873','postgres');
INSERT INTO tbl_audit VALUES ('3177','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",1)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",0)','2015-06-24 14:48:49.856','postgres');
INSERT INTO tbl_audit VALUES ('3178','archivo','U','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",1)','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",0)','2015-06-24 14:48:58.225','postgres');
INSERT INTO tbl_audit VALUES ('3179','archivo','U','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",0)','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",1)','2015-06-24 14:56:32.731','postgres');
INSERT INTO tbl_audit VALUES ('3180','archivo','D','(3,qwe,q-2015-06-24-SD-3-3,1,1,"2015-06-24 11:21:33-05",0)',NULL,'2015-07-06 15:08:51.024','postgres');
INSERT INTO tbl_audit VALUES ('3181','bitacora','D','(3,3,"2015-06-24 11:21:33-05",qwe,1,1,1,"<p>wewe</p>
",35000,"","",0)',NULL,'2015-07-06 15:08:51.024','postgres');
INSERT INTO tbl_audit VALUES ('3182','recibidos','D','(3,3,3,"2015-06-24 11:21:33-05",1,{1})',NULL,'2015-07-06 15:08:51.024','postgres');
INSERT INTO tbl_audit VALUES ('3183','archivo','D','(2,wqe,w-2015-06-24-SD-2-2,1,1,"2015-12-24 10:36:07-05",1)',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3184','bitacora','D','(2,2,"2015-06-24 10:36:07-05",qweqwe,1,2,1,"<p>qweqwe</p>
",25000,"","",0)',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3185','recibidos','D','(2,2,2,"2015-06-24 10:36:07-05",1,"{""1,2""}")',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3186','archivo','D','(1,wer,r-2015-06-23-backup-1-1,1,1,"2015-12-23 12:55:10-05",0)',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3187','bitacora','D','(1,1,"2015-06-23 12:55:10-05",gtgerget,1,1,1,"<p>qweq</p>
",18369,reservacion1255101.backup,backup,0)',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3188','metas','D','(1,nombre,reservacion.backup,1)',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3189','metas','D','(2,tipo,backup,1)',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3190','metas','D','(3,tamaño,18369,1)',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3191','recibidos','D','(1,1,1,"2015-06-23 12:55:10-05",1,{1})',NULL,'2015-07-06 15:08:51.133','postgres');
INSERT INTO tbl_audit VALUES ('3192','archivo','I',NULL,'(1,qwe,d-2015-07-06-txt-1-1,1,1,"2015-07-06 15:09:30-05",0)','2015-07-06 15:09:30.874','postgres');
INSERT INTO tbl_audit VALUES ('3193','bitacora','I',NULL,'(1,1,"2015-07-06 15:09:30-05",qwe,1,1,1,"<p>qweqwe</p>
",0,"descarga (11)1509301.txt",txt,0)','2015-07-06 15:09:30.904','postgres');
INSERT INTO tbl_audit VALUES ('3194','metas','I',NULL,'(1,nombre,"descarga (11).txt",1)','2015-07-06 15:09:30.92','postgres');
INSERT INTO tbl_audit VALUES ('3195','metas','I',NULL,'(2,tipo,txt,1)','2015-07-06 15:09:30.946','postgres');
INSERT INTO tbl_audit VALUES ('3196','metas','I',NULL,'(3,tamaño,0,1)','2015-07-06 15:09:30.947','postgres');
INSERT INTO tbl_audit VALUES ('3197','recibidos','I',NULL,'(1,1,1,"2015-07-06 15:09:30-05",1,{1})','2015-07-06 15:09:30.965','postgres');
INSERT INTO tbl_audit VALUES ('3198','archivo','D','(1,qwe,d-2015-07-06-txt-1-1,1,1,"2015-07-06 15:09:30-05",0)',NULL,'2015-07-06 15:09:57.589','postgres');
INSERT INTO tbl_audit VALUES ('3199','bitacora','D','(1,1,"2015-07-06 15:09:30-05",qwe,1,1,1,"<p>qweqwe</p>
",0,"descarga (11)1509301.txt",txt,0)',NULL,'2015-07-06 15:09:57.589','postgres');
INSERT INTO tbl_audit VALUES ('3200','metas','D','(1,nombre,"descarga (11).txt",1)',NULL,'2015-07-06 15:09:57.589','postgres');
INSERT INTO tbl_audit VALUES ('3201','metas','D','(2,tipo,txt,1)',NULL,'2015-07-06 15:09:57.589','postgres');
INSERT INTO tbl_audit VALUES ('3202','metas','D','(3,tamaño,0,1)',NULL,'2015-07-06 15:09:57.589','postgres');
INSERT INTO tbl_audit VALUES ('3203','recibidos','D','(1,1,1,"2015-07-06 15:09:30-05",1,{1})',NULL,'2015-07-06 15:09:57.589','postgres');
INSERT INTO tbl_audit VALUES ('3204','archivo','I',NULL,'(1,eqw,I-2015-07-06-pdf-1-1,1,1,"2015-07-06 15:10:14-05",0)','2015-07-06 15:10:14.167','postgres');
INSERT INTO tbl_audit VALUES ('3205','bitacora','I',NULL,'(1,1,"2015-07-06 15:10:14-05",qweq,1,1,1,"<p>qweqwe</p>
",4006,"Inicio - TOTORA SISA1510141.pdf",pdf,0)','2015-07-06 15:10:14.175','postgres');
INSERT INTO tbl_audit VALUES ('3206','metas','I',NULL,'(1,nombre,"Inicio - TOTORA SISA.pdf",1)','2015-07-06 15:10:14.18','postgres');
INSERT INTO tbl_audit VALUES ('3207','metas','I',NULL,'(2,tipo,pdf,1)','2015-07-06 15:10:14.183','postgres');
INSERT INTO tbl_audit VALUES ('3208','metas','I',NULL,'(3,tamaño,4006,1)','2015-07-06 15:10:14.185','postgres');
INSERT INTO tbl_audit VALUES ('3209','recibidos','I',NULL,'(1,1,1,"2015-07-06 15:10:14-05",1,{1})','2015-07-06 15:10:14.193','postgres');
INSERT INTO tbl_audit VALUES ('3210','archivo','I',NULL,'(2,qw,q-2015-07-06-SD-2-2,1,1,"2015-07-06 15:10:36-05",0)','2015-07-06 15:10:36.211','postgres');
INSERT INTO tbl_audit VALUES ('3211','bitacora','I',NULL,'(2,2,"2015-07-06 15:10:36-05",qwe,1,1,1,"<p>qweqw</p>
",0,"","",0)','2015-07-06 15:10:36.218','postgres');
INSERT INTO tbl_audit VALUES ('3212','recibidos','I',NULL,'(2,2,2,"2015-07-06 15:10:36-05",1,{2})','2015-07-06 15:10:36.228','postgres');
INSERT INTO tbl_audit VALUES ('3213','bitacora','U','(2,2,"2015-07-06 15:10:36-05",qwe,1,1,1,"<p>qweqw</p>
",0,"","",0)','(2,2,"2015-07-06 15:10:36-05",qwe,1,1,1,"<p>qweqw</p>
",100,"","",0)','2015-07-06 15:11:07.776','postgres');
INSERT INTO tbl_audit VALUES ('3214','bitacora','U','(2,2,"2015-07-06 15:10:36-05",qwe,1,1,1,"<p>qweqw</p>
",100,"","",0)','(2,2,"2016-07-06 15:10:36-05",qwe,1,1,1,"<p>qweqw</p>
",100,"","",0)','2015-07-06 15:11:12.263','postgres');
INSERT INTO tbl_audit VALUES ('3215','bitacora','U','(2,2,"2016-07-06 15:10:36-05",qwe,1,1,1,"<p>qweqw</p>
",100,"","",0)','(2,2,"2015-07-06 15:10:36-05",qwe,1,1,1,"<p>qweqw</p>
",100,"","",0)','2015-07-06 15:11:21.151','postgres');
INSERT INTO tbl_audit VALUES ('3216','archivo','U','(2,qw,q-2015-07-06-SD-2-2,1,1,"2015-07-06 15:10:36-05",0)','(2,qw,q-2015-07-06-SD-2-2,1,1,"2016-07-06 15:10:36-05",0)','2015-07-06 15:11:33.611','postgres');
INSERT INTO tbl_audit VALUES ('3217','tipo_documento','U','(1,DOC,"Documento de texto",Activo)','(1,DOC,Txt,Activo)','2015-07-06 15:58:09.096','postgres');
INSERT INTO tbl_audit VALUES ('3218','tipo_documento','U','(1,DOC,Txt,Activo)','(1,DOC,"Documento de texto",Activo)','2015-07-06 15:58:26.838','postgres');
INSERT INTO tbl_audit VALUES ('3219','tipo_documento','U','(3,HOC,"Hoja de Cálculo",Activo)','(3,HOC,"Hoja de Cálculo",0)','2015-07-06 15:58:31.031','postgres');
INSERT INTO tbl_audit VALUES ('3220','tipo_documento','U','(2,CAR,Carta,Activo)','(2,CAR,Carta,0)','2015-07-06 15:58:32.601','postgres');
INSERT INTO tbl_audit VALUES ('3221','tipo_documento','U','(1,DOC,"Documento de texto",Activo)','(1,DOC,"Documento de texto",0)','2015-07-06 15:58:33.452','postgres');
INSERT INTO tbl_audit VALUES ('3222','archivo','U','(2,qw,q-2015-07-06-SD-2-2,1,1,"2016-07-06 15:10:36-05",0)','(2,qw,q-2015-07-06-SD-2-2,2,1,"2016-07-06 15:10:36-05",0)','2015-07-06 16:15:48.196','postgres');
INSERT INTO tbl_audit VALUES ('3223','archivo','U','(2,qw,q-2015-07-06-SD-2-2,2,1,"2016-07-06 15:10:36-05",0)','(2,qw,q-2015-07-06-SD-2-2,1,1,"2016-07-06 15:10:36-05",0)','2015-07-06 16:15:58.331','postgres');
INSERT INTO tbl_audit VALUES ('3224','bitacora','U','(2,2,"2015-07-06 15:10:36-05",qwe,1,1,1,"<p>qweqw</p>
",100,"","",0)','(2,2,"2015-07-06 15:10:36-05",qwe,1,2,1,"<p>qweqw</p>
",100,"","",0)','2015-07-06 16:16:14.026','postgres');
INSERT INTO tbl_audit VALUES ('3225','archivo','U','(2,qw,q-2015-07-06-SD-2-2,1,1,"2016-07-06 15:10:36-05",0)','(2,qw,q-2015-07-06-SD-2-2,1,1,"2015-07-06 15:10:36-05",0)','2015-07-06 16:18:57.097','postgres');
INSERT INTO tbl_audit VALUES ('3226','archivo','U','(2,qw,q-2015-07-06-SD-2-2,1,1,"2015-07-06 15:10:36-05",0)','(2,qw,q-2015-07-06-SD-2-2,1,1,"2016-07-06 15:10:36-05",0)','2015-07-06 16:26:28.384','postgres');
INSERT INTO tbl_audit VALUES ('3227','archivo','U','(1,eqw,I-2015-07-06-pdf-1-1,1,1,"2015-07-06 15:10:14-05",0)','(1,"ENVIOS DE LOS DATOS PERSONALES PARA SU RESPECTIVOA RECEPCIONE LA OFICNA",I-2015-07-06-pdf-1-1,1,1,"2015-07-06 15:10:14-05",0)','2015-07-15 11:13:54.186','postgres');
INSERT INTO tbl_audit VALUES ('3228','bitacora','U','(1,1,"2015-07-06 15:10:14-05",qweq,1,1,1,"<p>qweqwe</p>
",4006,"Inicio - TOTORA SISA1510141.pdf",pdf,0)','(1,1,"2015-07-06 15:10:14-05","qweqDFLJS ÑK JKJ SKÑ ÑKJQOROE WÑIWJEROPU  UWRUW PI",1,1,1,"<p>qweqwe</p>
",4006,"Inicio - TOTORA SISA1510141.pdf",pdf,0)','2015-07-20 12:03:27.89','postgres');
INSERT INTO tbl_audit VALUES ('3229','archivo','I',NULL,'(3,GHGJ,F-2015-07-20-doc-3-3,1,1,"2015-07-20 12:51:14-05",0)','2015-07-20 12:51:14.203','postgres');
INSERT INTO tbl_audit VALUES ('3230','bitacora','I',NULL,'(3,3,"2015-07-20 12:51:14-05",JHGHJGHJ,1,1,1,"",195584,FICHA_TECNICA_DEVIVA1251143.doc,doc,0)','2015-07-20 12:51:14.229','postgres');
INSERT INTO tbl_audit VALUES ('3231','metas','I',NULL,'(4,nombre,FICHA_TECNICA_DEVIVA.doc,3)','2015-07-20 12:51:14.256','postgres');
INSERT INTO tbl_audit VALUES ('3232','metas','I',NULL,'(5,tipo,doc,3)','2015-07-20 12:51:14.273','postgres');
INSERT INTO tbl_audit VALUES ('3233','metas','I',NULL,'(6,tamaño,195584,3)','2015-07-20 12:51:14.274','postgres');
INSERT INTO tbl_audit VALUES ('3234','recibidos','I',NULL,'(3,3,3,"2015-07-20 12:51:14-05",1,"{""1,2""}")','2015-07-20 12:51:14.301','postgres');
INSERT INTO tbl_audit VALUES ('3235','archivo','I',NULL,'(4,fhfgh,I-2015-07-20-xlsx-4-4,1,1,"2015-07-20 12:52:46-05",0)','2015-07-20 12:52:46.328','postgres');
INSERT INTO tbl_audit VALUES ('3236','bitacora','I',NULL,'(4,4,"2015-07-20 12:52:46-05",ghfgh,1,1,1,"",14996,INFORMATICA1504241252464.xlsx,xlsx,0)','2015-07-20 12:52:46.336','postgres');
INSERT INTO tbl_audit VALUES ('3237','metas','I',NULL,'(7,nombre,INFORMATICA150424.xlsx,4)','2015-07-20 12:52:46.343','postgres');
INSERT INTO tbl_audit VALUES ('3238','metas','I',NULL,'(8,tipo,xlsx,4)','2015-07-20 12:52:46.345','postgres');
INSERT INTO tbl_audit VALUES ('3239','metas','I',NULL,'(9,tamaño,14996,4)','2015-07-20 12:52:46.347','postgres');
INSERT INTO tbl_audit VALUES ('3240','recibidos','I',NULL,'(4,4,4,"2015-07-20 12:52:46-05",1,{1})','2015-07-20 12:52:46.352','postgres');
INSERT INTO tbl_audit VALUES ('3241','archivo','I',NULL,'(5,qwe,P-2015-07-20-pptx-5-5,1,1,"2015-07-20 12:53:51-05",0)','2015-07-20 12:53:51.789','postgres');
INSERT INTO tbl_audit VALUES ('3242','bitacora','I',NULL,'(5,5,"2015-07-20 12:53:51-05",qweqwe,1,1,1,"<p>qwe</p>
",29795,Presentación11253515.pptx,pptx,0)','2015-07-20 12:53:51.801','postgres');
INSERT INTO tbl_audit VALUES ('3243','metas','I',NULL,'(10,nombre,Presentación1.pptx,5)','2015-07-20 12:53:51.807','postgres');
INSERT INTO tbl_audit VALUES ('3244','metas','I',NULL,'(11,tipo,pptx,5)','2015-07-20 12:53:51.809','postgres');
INSERT INTO tbl_audit VALUES ('3245','metas','I',NULL,'(12,tamaño,29795,5)','2015-07-20 12:53:51.812','postgres');
INSERT INTO tbl_audit VALUES ('3246','recibidos','I',NULL,'(5,5,5,"2015-07-20 12:53:51-05",1,{1})','2015-07-20 12:53:51.818','postgres');
INSERT INTO tbl_audit VALUES ('3247','archivo','I',NULL,'(6,rer,S-2015-07-20-jpg-6-6,1,1,"2015-07-20 12:54:29-05",0)','2015-07-20 12:54:29.887','postgres');
INSERT INTO tbl_audit VALUES ('3248','bitacora','I',NULL,'(6,6,"2015-07-20 12:54:29-05",erwer,1,1,1,"",119726,"Sin título-11254296.jpg",jpg,0)','2015-07-20 12:54:29.895','postgres');
INSERT INTO tbl_audit VALUES ('3249','metas','I',NULL,'(13,nombre,"Sin título-1.jpg",6)','2015-07-20 12:54:29.902','postgres');
INSERT INTO tbl_audit VALUES ('3250','metas','I',NULL,'(14,tipo,jpg,6)','2015-07-20 12:54:29.904','postgres');
INSERT INTO tbl_audit VALUES ('3251','metas','I',NULL,'(15,tamaño,119726,6)','2015-07-20 12:54:29.906','postgres');
INSERT INTO tbl_audit VALUES ('3252','recibidos','I',NULL,'(6,6,6,"2015-07-20 12:54:29-05",1,{1})','2015-07-20 12:54:29.911','postgres');
INSERT INTO tbl_audit VALUES ('3253','aplicaciones','I',NULL,'(1,"Gestion Documental",)','2015-07-20 16:02:30.119','postgres');
INSERT INTO tbl_audit VALUES ('3254','aplicaciones','U','(1,"Gestion Documental",)','(1,Envio,envio)','2015-07-20 16:02:42.934','postgres');
INSERT INTO tbl_audit VALUES ('3255','aplicaciones','I',NULL,'(2,Recibidos,inbox)','2015-07-20 16:03:00.678','postgres');
INSERT INTO tbl_audit VALUES ('3256','aplicaciones','I',NULL,'(3,Enviados,enviados)','2015-07-20 16:03:11.854','postgres');
INSERT INTO tbl_audit VALUES ('3257','aplicaciones','I',NULL,'(4,"Buscar Archivos",inbox/)','2015-07-20 16:03:32.799','postgres');
INSERT INTO tbl_audit VALUES ('3258','aplicaciones','U','(4,"Buscar Archivos",inbox/)','(4,"Buscar Archivos",inbox/buscar_archivos.php)','2015-07-20 16:03:46.55','postgres');
INSERT INTO tbl_audit VALUES ('3259','aplicaciones','I',NULL,'(5,Categorias,categorias)','2015-07-20 16:04:14.045','postgres');
INSERT INTO tbl_audit VALUES ('3260','aplicaciones','I',NULL,'(6,Departamentos,departamentos)','2015-07-20 16:04:33.157','postgres');
INSERT INTO tbl_audit VALUES ('3261','aplicaciones','I',NULL,'(7,"Medios Recepcion",medios_recepcion)','2015-07-20 16:04:48.693','postgres');
INSERT INTO tbl_audit VALUES ('3262','aplicaciones','U','(7,"Medios Recepcion",medios_recepcion)','(7,"Medios Recepcion",medio_recepcion)','2015-07-20 16:04:56.5','postgres');
INSERT INTO tbl_audit VALUES ('3263','aplicaciones','I',NULL,'(8,"Tipo Documento",tipo_documento)','2015-07-20 16:05:12.324','postgres');
INSERT INTO tbl_audit VALUES ('3264','aplicaciones','I',NULL,'(9,"Tipos de usuarios",tipo_usaurio)','2015-07-20 16:05:25.788','postgres');
INSERT INTO tbl_audit VALUES ('3265','aplicaciones','I',NULL,'(10,Pais,pais)','2015-07-20 16:05:35.156','postgres');
INSERT INTO tbl_audit VALUES ('3266','aplicaciones','I',NULL,'(11,provincia,provincia)','2015-07-20 16:05:47.068','postgres');
INSERT INTO tbl_audit VALUES ('3267','aplicaciones','U','(11,provincia,provincia)','(11,Provincia,provincia)','2015-07-20 16:05:49.211','postgres');
INSERT INTO tbl_audit VALUES ('3268','aplicaciones','I',NULL,'(12,Ciudad,ciudad)','2015-07-20 16:05:57.34','postgres');
INSERT INTO tbl_audit VALUES ('3269','aplicaciones','I',NULL,'(13,"Dashboard Usuario",reportes_usuario/usuario.php)','2015-07-20 16:06:22.371','postgres');
INSERT INTO tbl_audit VALUES ('3270','aplicaciones','I',NULL,'(14,"Dashboard usuario",)','2015-07-20 16:06:42.179','postgres');
INSERT INTO tbl_audit VALUES ('3271','aplicaciones','U','(14,"Dashboard usuario",)','(14,"Dashboard usuario",reportes_usuario/usuario.php)','2015-07-20 16:06:46.235','postgres');
INSERT INTO tbl_audit VALUES ('3272','aplicaciones','U','(13,"Dashboard Usuario",reportes_usuario/usuario.php)','(13,"Reportes Usuario",reportes_usuario/usuario.php)','2015-07-20 16:06:52.827','postgres');
INSERT INTO tbl_audit VALUES ('3273','aplicaciones','U','(14,"Dashboard usuario",reportes_usuario/usuario.php)','(14,"Dashboard usuario",reportes_usuario/dashboard.php)','2015-07-20 16:07:06.755','postgres');
INSERT INTO tbl_audit VALUES ('3274','aplicaciones','I',NULL,'(15,"Nuevos Usuarios",usuarios)','2015-07-20 16:07:19.459','postgres');
INSERT INTO tbl_audit VALUES ('3275','aplicaciones','I',NULL,'(16,"Permisos usuarios",)','2015-07-20 16:07:26.523','postgres');
INSERT INTO tbl_audit VALUES ('3276','aplicaciones','U','(16,"Permisos usuarios",)','(16,"Permisos usuarios",permisos)','2015-07-20 16:07:28.259','postgres');
INSERT INTO tbl_audit VALUES ('3277','aplicaciones','I',NULL,'(17,"Buscar Archivos",)','2015-07-20 16:07:41.226','postgres');
INSERT INTO tbl_audit VALUES ('3278','aplicaciones','U','(17,"Buscar Archivos",)','(17,"Buscar Archivos",buscar_archivos)','2015-07-20 16:07:45.035','postgres');
INSERT INTO tbl_audit VALUES ('3279','aplicaciones','I',NULL,'(18,Backup,backup)','2015-07-20 16:07:54.739','postgres');
INSERT INTO tbl_audit VALUES ('3280','aplicaciones','I',NULL,'(19,"Bashboard General",reportes_generales/dashboard.php)','2015-07-20 16:08:12.65','postgres');
INSERT INTO tbl_audit VALUES ('3281','aplicaciones','I',NULL,'(20,,reportes_generales/dashboard.php)','2015-07-20 16:08:16.138','postgres');
INSERT INTO tbl_audit VALUES ('3282','aplicaciones','U','(20,,reportes_generales/dashboard.php)','(20,,reportes_generales/generales.php)','2015-07-20 16:08:24.898','postgres');
INSERT INTO tbl_audit VALUES ('3283','aplicaciones','U','(19,"Bashboard General",reportes_generales/dashboard.php)','(19,"Dashboard General",reportes_generales/dashboard.php)','2015-07-20 16:08:27.858','postgres');
INSERT INTO tbl_audit VALUES ('3284','aplicaciones','U','(20,,reportes_generales/generales.php)','(20,"Reportes Generales",reportes_generales/generales.php)','2015-07-20 16:08:35.85','postgres');
INSERT INTO tbl_audit VALUES ('3285','aplicaciones','U','(16,"Permisos usuarios",permisos)','(16,"Permisos Usuarios",permisos)','2015-07-20 16:08:42.489','postgres');
INSERT INTO tbl_audit VALUES ('3286','aplicaciones','U','(14,"Dashboard usuario",reportes_usuario/dashboard.php)','(14,"Dashboard Usuario",reportes_usuario/dashboard.php)','2015-07-20 16:08:46.906','postgres');
INSERT INTO tbl_audit VALUES ('3287','aplicaciones','U','(9,"Tipos de usuarios",tipo_usaurio)','(9,"Tipos de Usuarios",tipo_usaurio)','2015-07-20 16:08:52.369','postgres');
INSERT INTO tbl_audit VALUES ('3288','aplicaciones','U','(8,"Tipo Documento",tipo_documento)','(8,"Tipo de  Documento",tipo_documento)','2015-07-20 16:08:56.378','postgres');
INSERT INTO tbl_audit VALUES ('3289','aplicaciones','U','(7,"Medios Recepcion",medio_recepcion)','(7,"Medios de Recepcion",medio_recepcion)','2015-07-20 16:09:01.401','postgres');
INSERT INTO tbl_audit VALUES ('3290','accesos','I',NULL,'(1,1,1,0)','2015-07-20 16:09:28.321','postgres');
INSERT INTO tbl_audit VALUES ('3291','accesos','I',NULL,'(2,1,1,0)','2015-07-20 16:09:31.953','postgres');
INSERT INTO tbl_audit VALUES ('3292','accesos','I',NULL,'(3,1,1,0)','2015-07-20 16:09:34.881','postgres');
INSERT INTO tbl_audit VALUES ('3293','accesos','I',NULL,'(4,1,1,0)','2015-07-20 16:09:37.553','postgres');
INSERT INTO tbl_audit VALUES ('3294','accesos','I',NULL,'(5,1,1,0)','2015-07-20 16:09:40.729','postgres');
INSERT INTO tbl_audit VALUES ('3295','accesos','I',NULL,'(6,,,)','2015-07-20 16:09:41.673','postgres');
INSERT INTO tbl_audit VALUES ('3296','accesos','U','(6,,,)','(6,1,,)','2015-07-20 16:09:42.425','postgres');
INSERT INTO tbl_audit VALUES ('3297','accesos','U','(6,1,,)','(6,1,1,)','2015-07-20 16:09:43.953','postgres');
INSERT INTO tbl_audit VALUES ('3298','accesos','U','(6,1,1,)','(6,1,1,0)','2015-07-20 16:09:45.057','postgres');
INSERT INTO tbl_audit VALUES ('3299','accesos','I',NULL,'(7,1,1,0)','2015-07-20 16:09:52.857','postgres');
INSERT INTO tbl_audit VALUES ('3300','accesos','I',NULL,'(8,1,1,0)','2015-07-20 16:09:57.049','postgres');
INSERT INTO tbl_audit VALUES ('3301','accesos','I',NULL,'(9,1,1,0)','2015-07-20 16:10:01.688','postgres');
INSERT INTO tbl_audit VALUES ('3302','accesos','I',NULL,'(10,1,1,0)','2015-07-20 16:10:05.232','postgres');
INSERT INTO tbl_audit VALUES ('3303','accesos','I',NULL,'(11,1,1,0)','2015-07-20 16:10:08.304','postgres');
INSERT INTO tbl_audit VALUES ('3304','accesos','I',NULL,'(12,1,1,0)','2015-07-20 16:10:11.185','postgres');
INSERT INTO tbl_audit VALUES ('3305','accesos','I',NULL,'(13,1,1,0)','2015-07-20 16:10:14.625','postgres');
INSERT INTO tbl_audit VALUES ('3306','accesos','I',NULL,'(14,1,1,0)','2015-07-20 16:10:18.841','postgres');
INSERT INTO tbl_audit VALUES ('3307','accesos','I',NULL,'(15,1,1,0)','2015-07-20 16:10:23.752','postgres');
INSERT INTO tbl_audit VALUES ('3308','accesos','I',NULL,'(16,1,1,0)','2015-07-20 16:10:28.92','postgres');
INSERT INTO tbl_audit VALUES ('3309','accesos','I',NULL,'(17,1,1,0)','2015-07-20 16:10:35.537','postgres');
INSERT INTO tbl_audit VALUES ('3310','accesos','I',NULL,'(18,1,1,0)','2015-07-20 16:10:41.752','postgres');
INSERT INTO tbl_audit VALUES ('3311','accesos','I',NULL,'(19,,,)','2015-07-20 16:10:45.376','postgres');
INSERT INTO tbl_audit VALUES ('3312','accesos','I',NULL,'(20,,,)','2015-07-20 16:10:46.585','postgres');
INSERT INTO tbl_audit VALUES ('3313','accesos','U','(19,,,)','(19,1,,)','2015-07-20 16:10:47.776','postgres');
INSERT INTO tbl_audit VALUES ('3314','accesos','U','(19,1,,)','(19,1,1,)','2015-07-20 16:10:48.56','postgres');
INSERT INTO tbl_audit VALUES ('3315','accesos','U','(19,1,1,)','(19,1,1,0)','2015-07-20 16:10:49.136','postgres');
INSERT INTO tbl_audit VALUES ('3316','accesos','U','(20,,,)','(20,1,,)','2015-07-20 16:10:50.464','postgres');
INSERT INTO tbl_audit VALUES ('3317','accesos','U','(20,1,,)','(20,1,1,)','2015-07-20 16:10:51.024','postgres');
INSERT INTO tbl_audit VALUES ('3318','accesos','U','(20,1,1,)','(20,1,1,0)','2015-07-20 16:10:53.056','postgres');
INSERT INTO tbl_audit VALUES ('3319','accesos','U','(2,1,1,0)','(2,1,2,0)','2015-07-20 17:02:03.19','postgres');
INSERT INTO tbl_audit VALUES ('3320','accesos','U','(3,1,1,0)','(3,1,3,0)','2015-07-20 17:02:04.082','postgres');
INSERT INTO tbl_audit VALUES ('3321','accesos','U','(4,1,1,0)','(4,1,4,0)','2015-07-20 17:02:04.802','postgres');
INSERT INTO tbl_audit VALUES ('3322','accesos','U','(5,1,1,0)','(5,1,5,0)','2015-07-20 17:02:06.815','postgres');
INSERT INTO tbl_audit VALUES ('3323','accesos','U','(6,1,1,0)','(6,1,6,0)','2015-07-20 17:02:07.486','postgres');
INSERT INTO tbl_audit VALUES ('3324','accesos','U','(7,1,1,0)','(7,1,7,0)','2015-07-20 17:02:09.388','postgres');
INSERT INTO tbl_audit VALUES ('3325','accesos','U','(8,1,1,0)','(8,1,8,0)','2015-07-20 17:02:10.803','postgres');
INSERT INTO tbl_audit VALUES ('3326','accesos','U','(9,1,1,0)','(9,1,9,0)','2015-07-20 17:02:11.54','postgres');
INSERT INTO tbl_audit VALUES ('3327','accesos','U','(10,1,1,0)','(10,1,10,0)','2015-07-20 17:02:13.39','postgres');
INSERT INTO tbl_audit VALUES ('3328','accesos','U','(12,1,1,0)','(12,1,12,0)','2015-07-20 17:02:14.926','postgres');
INSERT INTO tbl_audit VALUES ('3329','accesos','U','(11,1,1,0)','(11,1,11,0)','2015-07-20 17:02:16.247','postgres');
INSERT INTO tbl_audit VALUES ('3330','accesos','U','(13,1,1,0)','(13,1,13,0)','2015-07-20 17:02:17.354','postgres');
INSERT INTO tbl_audit VALUES ('3331','accesos','U','(14,1,1,0)','(14,1,14,0)','2015-07-20 17:02:18.502','postgres');
INSERT INTO tbl_audit VALUES ('3332','accesos','U','(15,1,1,0)','(15,1,15,0)','2015-07-20 17:02:20.759','postgres');
INSERT INTO tbl_audit VALUES ('3333','accesos','U','(16,1,1,0)','(16,1,16,0)','2015-07-20 17:02:22.95','postgres');
INSERT INTO tbl_audit VALUES ('3334','accesos','U','(17,1,1,0)','(17,1,17,0)','2015-07-20 17:02:25.009','postgres');
INSERT INTO tbl_audit VALUES ('3335','accesos','U','(18,1,1,0)','(18,1,18,0)','2015-07-20 17:02:26.429','postgres');
INSERT INTO tbl_audit VALUES ('3336','accesos','U','(19,1,1,0)','(19,1,189,0)','2015-07-20 17:02:27.626','postgres');
INSERT INTO tbl_audit VALUES ('3337','accesos','U','(20,1,1,0)','(20,1,20,0)','2015-07-20 17:02:28.974','postgres');
INSERT INTO tbl_audit VALUES ('3338','accesos','U','(19,1,189,0)','(19,1,19,0)','2015-07-20 17:02:30.265','postgres');
INSERT INTO tbl_audit VALUES ('3339','usuario','I',NULL,'(5,E115,Eqweqw,qweqwe,1,"","","",1,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:14:00-05",Cédula,1002910345)','2015-07-23 16:14:00.33','postgres');
INSERT INTO tbl_audit VALUES ('3340','clave','I',NULL,'(5,MTIzMTIz,5)','2015-07-23 16:14:00.473','postgres');
INSERT INTO tbl_audit VALUES ('3341','usuario','D','(5,E115,Eqweqw,qweqwe,1,"","","",1,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:14:00-05",Cédula,1002910345)',NULL,'2015-07-23 16:14:19.68','postgres');
INSERT INTO tbl_audit VALUES ('3342','usuario','D','(4,1114,123qweqw,123we,1,"","","",1,wewewe,"Uniandes Ibarra",1,1,"2015-06-19 10:22:14-05",Cédula,1002910345)',NULL,'2015-07-23 16:14:19.686','postgres');
INSERT INTO tbl_audit VALUES ('3343','usuario','D','(3,1113,123123,qweq,1,"","","",1,qweqwe,"Uniandes Ibarra",1,1,"2015-06-19 10:18:29-05",Cédula,1002910345)',NULL,'2015-07-23 16:14:19.687','postgres');
INSERT INTO tbl_audit VALUES ('3344','usuario','I',NULL,'(3,E113,Eqweqwe,qweqwe,1,"","","",1,qweqwe,"Uniandes Ibarra",1,1,"2015-07-23 16:14:32-05",Cédula,1002910345)','2015-07-23 16:14:32.923','postgres');
INSERT INTO tbl_audit VALUES ('3345','usuario','D','(3,E113,Eqweqwe,qweqwe,1,"","","",1,qweqwe,"Uniandes Ibarra",1,1,"2015-07-23 16:14:32-05",Cédula,1002910345)',NULL,'2015-07-23 16:15:24.96','postgres');
INSERT INTO tbl_audit VALUES ('3346','usuario','I',NULL,'(3,Q113,Qweqwe,qwe,1,"","","",1,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:20:00-05",Cédula,1002910345)','2015-07-23 16:20:00.664','postgres');
INSERT INTO tbl_audit VALUES ('3347','usuario','D','(3,Q113,Qweqwe,qwe,1,"","","",1,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:20:00-05",Cédula,1002910345)',NULL,'2015-07-23 16:20:31.884','postgres');
INSERT INTO tbl_audit VALUES ('3348','usuario','I',NULL,'(3,Q113,Qwe,123123,1,"","","",1,123123,qweqwe,1,1,"2015-07-23 16:20:58-05",Cédula,1002910345)','2015-07-23 16:20:58.405','postgres');
INSERT INTO tbl_audit VALUES ('3349','usuario','D','(3,Q113,Qwe,123123,1,"","","",1,123123,qweqwe,1,1,"2015-07-23 16:20:58-05",Cédula,1002910345)',NULL,'2015-07-23 16:21:12.475','postgres');
INSERT INTO tbl_audit VALUES ('3350','usuario','I',NULL,'(3,Q113,Qweqwe,qweqw,1,"","","",1,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:21:34-05",Cédula,1002910345)','2015-07-23 16:21:34.387','postgres');
INSERT INTO tbl_audit VALUES ('3351','usuario','D','(3,Q113,Qweqwe,qweqw,1,"","","",1,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:21:34-05",Cédula,1002910345)',NULL,'2015-07-23 16:22:16.714','postgres');
INSERT INTO tbl_audit VALUES ('3352','usuario','I',NULL,'(3,Q113,Qweqwe,qweqwe,1,"","","",1,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:22:25-05",Cédula,1002910345)','2015-07-23 16:22:25.782','postgres');
INSERT INTO tbl_audit VALUES ('3353','accesos','I',NULL,'(21,3,1,0)','2015-07-23 16:22:25.805','postgres');
INSERT INTO tbl_audit VALUES ('3354','accesos','I',NULL,'(22,3,2,0)','2015-07-23 16:22:25.807','postgres');
INSERT INTO tbl_audit VALUES ('3355','accesos','I',NULL,'(23,3,3,0)','2015-07-23 16:22:25.809','postgres');
INSERT INTO tbl_audit VALUES ('3356','accesos','I',NULL,'(24,3,4,0)','2015-07-23 16:22:25.81','postgres');
INSERT INTO tbl_audit VALUES ('3357','accesos','I',NULL,'(25,3,5,0)','2015-07-23 16:22:25.812','postgres');
INSERT INTO tbl_audit VALUES ('3358','accesos','I',NULL,'(26,3,6,0)','2015-07-23 16:22:25.814','postgres');
INSERT INTO tbl_audit VALUES ('3359','accesos','I',NULL,'(27,3,7,0)','2015-07-23 16:22:25.816','postgres');
INSERT INTO tbl_audit VALUES ('3360','accesos','I',NULL,'(28,3,8,0)','2015-07-23 16:22:25.818','postgres');
INSERT INTO tbl_audit VALUES ('3361','accesos','I',NULL,'(29,3,9,0)','2015-07-23 16:22:25.82','postgres');
INSERT INTO tbl_audit VALUES ('3362','accesos','I',NULL,'(30,3,10,0)','2015-07-23 16:22:25.821','postgres');
INSERT INTO tbl_audit VALUES ('3363','accesos','I',NULL,'(31,3,11,0)','2015-07-23 16:22:25.823','postgres');
INSERT INTO tbl_audit VALUES ('3364','accesos','I',NULL,'(32,3,12,0)','2015-07-23 16:22:25.824','postgres');
INSERT INTO tbl_audit VALUES ('3365','accesos','I',NULL,'(33,3,13,0)','2015-07-23 16:22:25.825','postgres');
INSERT INTO tbl_audit VALUES ('3366','accesos','I',NULL,'(34,3,14,0)','2015-07-23 16:22:25.827','postgres');
INSERT INTO tbl_audit VALUES ('3367','accesos','I',NULL,'(35,3,15,0)','2015-07-23 16:22:25.828','postgres');
INSERT INTO tbl_audit VALUES ('3368','accesos','I',NULL,'(36,3,16,0)','2015-07-23 16:22:25.83','postgres');
INSERT INTO tbl_audit VALUES ('3369','accesos','I',NULL,'(37,3,17,0)','2015-07-23 16:22:25.832','postgres');
INSERT INTO tbl_audit VALUES ('3370','accesos','I',NULL,'(38,3,18,0)','2015-07-23 16:22:25.834','postgres');
INSERT INTO tbl_audit VALUES ('3371','accesos','I',NULL,'(39,3,19,0)','2015-07-23 16:22:25.836','postgres');
INSERT INTO tbl_audit VALUES ('3372','accesos','I',NULL,'(40,3,20,0)','2015-07-23 16:22:25.837','postgres');
INSERT INTO tbl_audit VALUES ('3373','accesos','D','(40,3,20,0)',NULL,'2015-07-23 16:22:42.002','postgres');
INSERT INTO tbl_audit VALUES ('3374','accesos','D','(39,3,19,0)',NULL,'2015-07-23 16:22:42.008','postgres');
INSERT INTO tbl_audit VALUES ('3375','accesos','D','(38,3,18,0)',NULL,'2015-07-23 16:22:42.008','postgres');
INSERT INTO tbl_audit VALUES ('3376','accesos','D','(37,3,17,0)',NULL,'2015-07-23 16:22:42.009','postgres');
INSERT INTO tbl_audit VALUES ('3377','accesos','D','(36,3,16,0)',NULL,'2015-07-23 16:22:42.009','postgres');
INSERT INTO tbl_audit VALUES ('3378','accesos','D','(35,3,15,0)',NULL,'2015-07-23 16:22:42.01','postgres');
INSERT INTO tbl_audit VALUES ('3379','accesos','D','(34,3,14,0)',NULL,'2015-07-23 16:22:42.01','postgres');
INSERT INTO tbl_audit VALUES ('3380','accesos','D','(33,3,13,0)',NULL,'2015-07-23 16:22:42.011','postgres');
INSERT INTO tbl_audit VALUES ('3381','accesos','D','(32,3,12,0)',NULL,'2015-07-23 16:22:42.011','postgres');
INSERT INTO tbl_audit VALUES ('3382','accesos','D','(31,3,11,0)',NULL,'2015-07-23 16:22:42.011','postgres');
INSERT INTO tbl_audit VALUES ('3383','accesos','D','(30,3,10,0)',NULL,'2015-07-23 16:22:42.012','postgres');
INSERT INTO tbl_audit VALUES ('3384','accesos','D','(29,3,9,0)',NULL,'2015-07-23 16:22:42.012','postgres');
INSERT INTO tbl_audit VALUES ('3385','accesos','D','(28,3,8,0)',NULL,'2015-07-23 16:22:42.013','postgres');
INSERT INTO tbl_audit VALUES ('3386','accesos','D','(27,3,7,0)',NULL,'2015-07-23 16:22:42.013','postgres');
INSERT INTO tbl_audit VALUES ('3387','accesos','D','(26,3,6,0)',NULL,'2015-07-23 16:22:42.013','postgres');
INSERT INTO tbl_audit VALUES ('3388','accesos','D','(25,3,5,0)',NULL,'2015-07-23 16:22:42.014','postgres');
INSERT INTO tbl_audit VALUES ('3389','accesos','D','(24,3,4,0)',NULL,'2015-07-23 16:22:42.014','postgres');
INSERT INTO tbl_audit VALUES ('3390','accesos','D','(23,3,3,0)',NULL,'2015-07-23 16:22:42.014','postgres');
INSERT INTO tbl_audit VALUES ('3391','accesos','D','(22,3,2,0)',NULL,'2015-07-23 16:22:42.015','postgres');
INSERT INTO tbl_audit VALUES ('3392','accesos','D','(21,3,1,0)',NULL,'2015-07-23 16:22:42.015','postgres');
INSERT INTO tbl_audit VALUES ('3393','usuario','D','(3,Q113,Qweqwe,qweqwe,1,"","","",1,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:22:25-05",Cédula,1002910345)',NULL,'2015-07-23 16:25:02.248','postgres');
INSERT INTO tbl_audit VALUES ('3394','usuario','I',NULL,'(3,Q113,Qweqw,qweqw,1,"","","",2,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:25:09-05","",1002910345)','2015-07-23 16:25:09.292','postgres');
INSERT INTO tbl_audit VALUES ('3395','accesos','I',NULL,'(21,3,1,0)','2015-07-23 16:25:09.317','postgres');
INSERT INTO tbl_audit VALUES ('3396','accesos','I',NULL,'(22,3,2,0)','2015-07-23 16:25:09.319','postgres');
INSERT INTO tbl_audit VALUES ('3397','accesos','I',NULL,'(23,3,3,0)','2015-07-23 16:25:09.321','postgres');
INSERT INTO tbl_audit VALUES ('3398','accesos','I',NULL,'(24,3,4,0)','2015-07-23 16:25:09.322','postgres');
INSERT INTO tbl_audit VALUES ('3399','accesos','I',NULL,'(25,3,5,1)','2015-07-23 16:25:09.324','postgres');
INSERT INTO tbl_audit VALUES ('3400','accesos','I',NULL,'(26,3,6,1)','2015-07-23 16:25:09.325','postgres');
INSERT INTO tbl_audit VALUES ('3401','accesos','I',NULL,'(27,3,7,1)','2015-07-23 16:25:09.327','postgres');
INSERT INTO tbl_audit VALUES ('3402','accesos','I',NULL,'(28,3,8,1)','2015-07-23 16:25:09.328','postgres');
INSERT INTO tbl_audit VALUES ('3403','accesos','I',NULL,'(29,3,9,1)','2015-07-23 16:25:09.329','postgres');
INSERT INTO tbl_audit VALUES ('3404','accesos','I',NULL,'(30,3,10,1)','2015-07-23 16:25:09.331','postgres');
INSERT INTO tbl_audit VALUES ('3405','accesos','I',NULL,'(31,3,11,1)','2015-07-23 16:25:09.332','postgres');
INSERT INTO tbl_audit VALUES ('3406','accesos','I',NULL,'(32,3,12,1)','2015-07-23 16:25:09.333','postgres');
INSERT INTO tbl_audit VALUES ('3407','accesos','I',NULL,'(33,3,13,0)','2015-07-23 16:25:09.335','postgres');
INSERT INTO tbl_audit VALUES ('3408','accesos','I',NULL,'(34,3,14,0)','2015-07-23 16:25:09.336','postgres');
INSERT INTO tbl_audit VALUES ('3409','accesos','I',NULL,'(35,3,15,1)','2015-07-23 16:25:09.337','postgres');
INSERT INTO tbl_audit VALUES ('3410','accesos','I',NULL,'(36,3,16,1)','2015-07-23 16:25:09.338','postgres');
INSERT INTO tbl_audit VALUES ('3411','accesos','I',NULL,'(37,3,17,1)','2015-07-23 16:25:09.34','postgres');
INSERT INTO tbl_audit VALUES ('3412','accesos','I',NULL,'(38,3,18,1)','2015-07-23 16:25:09.341','postgres');
INSERT INTO tbl_audit VALUES ('3413','accesos','I',NULL,'(39,3,19,1)','2015-07-23 16:25:09.343','postgres');
INSERT INTO tbl_audit VALUES ('3414','accesos','I',NULL,'(40,3,20,1)','2015-07-23 16:25:09.344','postgres');
INSERT INTO tbl_audit VALUES ('3415','pais','I',NULL,'(237,"","")','2015-07-23 16:29:41.606','postgres');
INSERT INTO tbl_audit VALUES ('3416','usuario','D','(3,Q113,Qweqw,qweqw,1,"","","",2,123123,"Uniandes Ibarra",1,1,"2015-07-23 16:25:09-05","",1002910345)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3417','accesos','D','(21,3,1,0)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3418','accesos','D','(22,3,2,0)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3419','accesos','D','(23,3,3,0)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3420','accesos','D','(24,3,4,0)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3421','accesos','D','(25,3,5,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3422','accesos','D','(26,3,6,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3423','accesos','D','(27,3,7,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3424','accesos','D','(28,3,8,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3425','accesos','D','(29,3,9,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3426','accesos','D','(30,3,10,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3427','accesos','D','(31,3,11,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3428','accesos','D','(32,3,12,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3429','accesos','D','(33,3,13,0)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3430','accesos','D','(34,3,14,0)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3431','accesos','D','(35,3,15,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3432','accesos','D','(36,3,16,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3433','accesos','D','(37,3,17,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3434','accesos','D','(38,3,18,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3435','accesos','D','(39,3,19,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3436','accesos','D','(40,3,20,1)',NULL,'2015-07-23 16:55:00.282','postgres');
INSERT INTO tbl_audit VALUES ('3437','usuario','D','(2,NK02,Naty,Huera,1,"","","",1,natyk,"Uniandes Ibarra",1,1,"2015-04-27 15:36:52-05",Cédula,1234567890)',NULL,'2015-07-23 16:56:48.104','postgres');
INSERT INTO tbl_audit VALUES ('3438','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:56:56.943','postgres');
INSERT INTO tbl_audit VALUES ('3439','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:57:22.569','postgres');
INSERT INTO tbl_audit VALUES ('3440','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:57:40.159','postgres');
INSERT INTO tbl_audit VALUES ('3441','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:57:55.612','postgres');
INSERT INTO tbl_audit VALUES ('3442','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:58:16.893','postgres');
INSERT INTO tbl_audit VALUES ('3443','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:59:07.451','postgres');
INSERT INTO tbl_audit VALUES ('3444','accesos','U','(2,1,2,0)','(2,1,2,0)','2015-07-23 16:59:07.46','postgres');
INSERT INTO tbl_audit VALUES ('3445','accesos','U','(3,1,3,0)','(3,1,3,0)','2015-07-23 16:59:07.461','postgres');
INSERT INTO tbl_audit VALUES ('3446','accesos','U','(4,1,4,0)','(4,1,4,0)','2015-07-23 16:59:07.463','postgres');
INSERT INTO tbl_audit VALUES ('3447','accesos','U','(5,1,5,0)','(5,1,5,0)','2015-07-23 16:59:07.464','postgres');
INSERT INTO tbl_audit VALUES ('3448','accesos','U','(6,1,6,0)','(6,1,6,0)','2015-07-23 16:59:07.465','postgres');
INSERT INTO tbl_audit VALUES ('3449','accesos','U','(7,1,7,0)','(7,1,7,1)','2015-07-23 16:59:07.466','postgres');
INSERT INTO tbl_audit VALUES ('3450','accesos','U','(8,1,8,0)','(8,1,8,1)','2015-07-23 16:59:07.467','postgres');
INSERT INTO tbl_audit VALUES ('3451','accesos','U','(9,1,9,0)','(9,1,9,1)','2015-07-23 16:59:07.468','postgres');
INSERT INTO tbl_audit VALUES ('3452','accesos','U','(10,1,10,0)','(10,1,10,0)','2015-07-23 16:59:07.469','postgres');
INSERT INTO tbl_audit VALUES ('3453','accesos','U','(11,1,11,0)','(11,1,11,0)','2015-07-23 16:59:07.47','postgres');
INSERT INTO tbl_audit VALUES ('3454','accesos','U','(12,1,12,0)','(12,1,12,0)','2015-07-23 16:59:07.471','postgres');
INSERT INTO tbl_audit VALUES ('3455','accesos','U','(13,1,13,0)','(13,1,13,0)','2015-07-23 16:59:07.471','postgres');
INSERT INTO tbl_audit VALUES ('3456','accesos','U','(14,1,14,0)','(14,1,14,0)','2015-07-23 16:59:07.472','postgres');
INSERT INTO tbl_audit VALUES ('3457','accesos','U','(15,1,15,0)','(15,1,15,0)','2015-07-23 16:59:07.473','postgres');
INSERT INTO tbl_audit VALUES ('3458','accesos','U','(16,1,16,0)','(16,1,16,0)','2015-07-23 16:59:07.474','postgres');
INSERT INTO tbl_audit VALUES ('3459','accesos','U','(17,1,17,0)','(17,1,17,0)','2015-07-23 16:59:07.475','postgres');
INSERT INTO tbl_audit VALUES ('3460','accesos','U','(18,1,18,0)','(18,1,18,0)','2015-07-23 16:59:07.476','postgres');
INSERT INTO tbl_audit VALUES ('3461','accesos','U','(19,1,19,0)','(19,1,19,0)','2015-07-23 16:59:07.477','postgres');
INSERT INTO tbl_audit VALUES ('3462','accesos','U','(20,1,20,0)','(20,1,20,0)','2015-07-23 16:59:07.478','postgres');
INSERT INTO tbl_audit VALUES ('3463','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:59:17.489','postgres');
INSERT INTO tbl_audit VALUES ('3464','accesos','U','(2,1,2,0)','(2,1,2,0)','2015-07-23 16:59:17.496','postgres');
INSERT INTO tbl_audit VALUES ('3465','accesos','U','(3,1,3,0)','(3,1,3,0)','2015-07-23 16:59:17.498','postgres');
INSERT INTO tbl_audit VALUES ('3466','accesos','U','(4,1,4,0)','(4,1,4,0)','2015-07-23 16:59:17.499','postgres');
INSERT INTO tbl_audit VALUES ('3467','accesos','U','(5,1,5,0)','(5,1,5,0)','2015-07-23 16:59:17.5','postgres');
INSERT INTO tbl_audit VALUES ('3468','accesos','U','(6,1,6,0)','(6,1,6,0)','2015-07-23 16:59:17.5','postgres');
INSERT INTO tbl_audit VALUES ('3469','accesos','U','(7,1,7,1)','(7,1,7,1)','2015-07-23 16:59:17.501','postgres');
INSERT INTO tbl_audit VALUES ('3470','accesos','U','(8,1,8,1)','(8,1,8,1)','2015-07-23 16:59:17.502','postgres');
INSERT INTO tbl_audit VALUES ('3471','accesos','U','(9,1,9,1)','(9,1,9,1)','2015-07-23 16:59:17.503','postgres');
INSERT INTO tbl_audit VALUES ('3472','accesos','U','(10,1,10,0)','(10,1,10,0)','2015-07-23 16:59:17.504','postgres');
INSERT INTO tbl_audit VALUES ('3473','accesos','U','(11,1,11,0)','(11,1,11,0)','2015-07-23 16:59:17.505','postgres');
INSERT INTO tbl_audit VALUES ('3474','accesos','U','(12,1,12,0)','(12,1,12,0)','2015-07-23 16:59:17.506','postgres');
INSERT INTO tbl_audit VALUES ('3475','accesos','U','(13,1,13,0)','(13,1,13,0)','2015-07-23 16:59:17.507','postgres');
INSERT INTO tbl_audit VALUES ('3476','accesos','U','(14,1,14,0)','(14,1,14,0)','2015-07-23 16:59:17.508','postgres');
INSERT INTO tbl_audit VALUES ('3477','accesos','U','(15,1,15,0)','(15,1,15,0)','2015-07-23 16:59:17.509','postgres');
INSERT INTO tbl_audit VALUES ('3478','accesos','U','(16,1,16,0)','(16,1,16,0)','2015-07-23 16:59:17.51','postgres');
INSERT INTO tbl_audit VALUES ('3479','accesos','U','(17,1,17,0)','(17,1,17,0)','2015-07-23 16:59:17.511','postgres');
INSERT INTO tbl_audit VALUES ('3480','accesos','U','(18,1,18,0)','(18,1,18,0)','2015-07-23 16:59:17.512','postgres');
INSERT INTO tbl_audit VALUES ('3481','accesos','U','(19,1,19,0)','(19,1,19,0)','2015-07-23 16:59:17.513','postgres');
INSERT INTO tbl_audit VALUES ('3482','accesos','U','(20,1,20,0)','(20,1,20,0)','2015-07-23 16:59:17.514','postgres');
INSERT INTO tbl_audit VALUES ('3483','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:59:29.182','postgres');
INSERT INTO tbl_audit VALUES ('3484','accesos','U','(2,1,2,0)','(2,1,2,0)','2015-07-23 16:59:29.19','postgres');
INSERT INTO tbl_audit VALUES ('3485','accesos','U','(3,1,3,0)','(3,1,3,0)','2015-07-23 16:59:29.191','postgres');
INSERT INTO tbl_audit VALUES ('3486','accesos','U','(4,1,4,0)','(4,1,4,0)','2015-07-23 16:59:29.193','postgres');
INSERT INTO tbl_audit VALUES ('3487','accesos','U','(5,1,5,0)','(5,1,5,0)','2015-07-23 16:59:29.194','postgres');
INSERT INTO tbl_audit VALUES ('3488','accesos','U','(6,1,6,0)','(6,1,6,0)','2015-07-23 16:59:29.195','postgres');
INSERT INTO tbl_audit VALUES ('3489','accesos','U','(7,1,7,1)','(7,1,7,0)','2015-07-23 16:59:29.196','postgres');
INSERT INTO tbl_audit VALUES ('3490','accesos','U','(8,1,8,1)','(8,1,8,0)','2015-07-23 16:59:29.197','postgres');
INSERT INTO tbl_audit VALUES ('3491','accesos','U','(9,1,9,1)','(9,1,9,0)','2015-07-23 16:59:29.198','postgres');
INSERT INTO tbl_audit VALUES ('3492','accesos','U','(10,1,10,0)','(10,1,10,0)','2015-07-23 16:59:29.199','postgres');
INSERT INTO tbl_audit VALUES ('3493','accesos','U','(11,1,11,0)','(11,1,11,0)','2015-07-23 16:59:29.2','postgres');
INSERT INTO tbl_audit VALUES ('3494','accesos','U','(12,1,12,0)','(12,1,12,0)','2015-07-23 16:59:29.201','postgres');
INSERT INTO tbl_audit VALUES ('3495','accesos','U','(13,1,13,0)','(13,1,13,0)','2015-07-23 16:59:29.202','postgres');
INSERT INTO tbl_audit VALUES ('3496','accesos','U','(14,1,14,0)','(14,1,14,0)','2015-07-23 16:59:29.203','postgres');
INSERT INTO tbl_audit VALUES ('3497','accesos','U','(15,1,15,0)','(15,1,15,0)','2015-07-23 16:59:29.204','postgres');
INSERT INTO tbl_audit VALUES ('3498','accesos','U','(16,1,16,0)','(16,1,16,0)','2015-07-23 16:59:29.206','postgres');
INSERT INTO tbl_audit VALUES ('3499','accesos','U','(17,1,17,0)','(17,1,17,0)','2015-07-23 16:59:29.207','postgres');
INSERT INTO tbl_audit VALUES ('3500','accesos','U','(18,1,18,0)','(18,1,18,0)','2015-07-23 16:59:29.207','postgres');
INSERT INTO tbl_audit VALUES ('3501','accesos','U','(19,1,19,0)','(19,1,19,0)','2015-07-23 16:59:29.208','postgres');
INSERT INTO tbl_audit VALUES ('3502','accesos','U','(20,1,20,0)','(20,1,20,0)','2015-07-23 16:59:29.209','postgres');
INSERT INTO tbl_audit VALUES ('3503','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:59:39.671','postgres');
INSERT INTO tbl_audit VALUES ('3504','accesos','U','(2,1,2,0)','(2,1,2,0)','2015-07-23 16:59:39.679','postgres');
INSERT INTO tbl_audit VALUES ('3505','accesos','U','(3,1,3,0)','(3,1,3,0)','2015-07-23 16:59:39.68','postgres');
INSERT INTO tbl_audit VALUES ('3506','accesos','U','(4,1,4,0)','(4,1,4,0)','2015-07-23 16:59:39.681','postgres');
INSERT INTO tbl_audit VALUES ('3507','accesos','U','(5,1,5,0)','(5,1,5,1)','2015-07-23 16:59:39.682','postgres');
INSERT INTO tbl_audit VALUES ('3508','accesos','U','(6,1,6,0)','(6,1,6,1)','2015-07-23 16:59:39.683','postgres');
INSERT INTO tbl_audit VALUES ('3509','accesos','U','(7,1,7,0)','(7,1,7,1)','2015-07-23 16:59:39.684','postgres');
INSERT INTO tbl_audit VALUES ('3510','accesos','U','(8,1,8,0)','(8,1,8,1)','2015-07-23 16:59:39.685','postgres');
INSERT INTO tbl_audit VALUES ('3511','accesos','U','(9,1,9,0)','(9,1,9,1)','2015-07-23 16:59:39.686','postgres');
INSERT INTO tbl_audit VALUES ('3512','accesos','U','(10,1,10,0)','(10,1,10,1)','2015-07-23 16:59:39.687','postgres');
INSERT INTO tbl_audit VALUES ('3513','accesos','U','(11,1,11,0)','(11,1,11,1)','2015-07-23 16:59:39.688','postgres');
INSERT INTO tbl_audit VALUES ('3514','accesos','U','(12,1,12,0)','(12,1,12,1)','2015-07-23 16:59:39.689','postgres');
INSERT INTO tbl_audit VALUES ('3515','accesos','U','(13,1,13,0)','(13,1,13,0)','2015-07-23 16:59:39.69','postgres');
INSERT INTO tbl_audit VALUES ('3516','accesos','U','(14,1,14,0)','(14,1,14,0)','2015-07-23 16:59:39.691','postgres');
INSERT INTO tbl_audit VALUES ('3517','accesos','U','(15,1,15,0)','(15,1,15,0)','2015-07-23 16:59:39.691','postgres');
INSERT INTO tbl_audit VALUES ('3518','accesos','U','(16,1,16,0)','(16,1,16,0)','2015-07-23 16:59:39.692','postgres');
INSERT INTO tbl_audit VALUES ('3519','accesos','U','(17,1,17,0)','(17,1,17,0)','2015-07-23 16:59:39.693','postgres');
INSERT INTO tbl_audit VALUES ('3520','accesos','U','(18,1,18,0)','(18,1,18,0)','2015-07-23 16:59:39.694','postgres');
INSERT INTO tbl_audit VALUES ('3521','accesos','U','(19,1,19,0)','(19,1,19,0)','2015-07-23 16:59:39.695','postgres');
INSERT INTO tbl_audit VALUES ('3522','accesos','U','(20,1,20,0)','(20,1,20,0)','2015-07-23 16:59:39.696','postgres');
INSERT INTO tbl_audit VALUES ('3523','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 16:59:53.855','postgres');
INSERT INTO tbl_audit VALUES ('3524','accesos','U','(2,1,2,0)','(2,1,2,0)','2015-07-23 16:59:53.862','postgres');
INSERT INTO tbl_audit VALUES ('3525','accesos','U','(3,1,3,0)','(3,1,3,0)','2015-07-23 16:59:53.864','postgres');
INSERT INTO tbl_audit VALUES ('3526','accesos','U','(4,1,4,0)','(4,1,4,0)','2015-07-23 16:59:53.865','postgres');
INSERT INTO tbl_audit VALUES ('3527','accesos','U','(5,1,5,1)','(5,1,5,0)','2015-07-23 16:59:53.866','postgres');
INSERT INTO tbl_audit VALUES ('3528','accesos','U','(6,1,6,1)','(6,1,6,0)','2015-07-23 16:59:53.867','postgres');
INSERT INTO tbl_audit VALUES ('3529','accesos','U','(7,1,7,1)','(7,1,7,0)','2015-07-23 16:59:53.868','postgres');
INSERT INTO tbl_audit VALUES ('3530','accesos','U','(8,1,8,1)','(8,1,8,0)','2015-07-23 16:59:53.869','postgres');
INSERT INTO tbl_audit VALUES ('3531','accesos','U','(9,1,9,1)','(9,1,9,0)','2015-07-23 16:59:53.87','postgres');
INSERT INTO tbl_audit VALUES ('3532','accesos','U','(10,1,10,1)','(10,1,10,0)','2015-07-23 16:59:53.871','postgres');
INSERT INTO tbl_audit VALUES ('3533','accesos','U','(11,1,11,1)','(11,1,11,0)','2015-07-23 16:59:53.872','postgres');
INSERT INTO tbl_audit VALUES ('3534','accesos','U','(12,1,12,1)','(12,1,12,0)','2015-07-23 16:59:53.873','postgres');
INSERT INTO tbl_audit VALUES ('3535','accesos','U','(13,1,13,0)','(13,1,13,0)','2015-07-23 16:59:53.874','postgres');
INSERT INTO tbl_audit VALUES ('3536','accesos','U','(14,1,14,0)','(14,1,14,0)','2015-07-23 16:59:53.875','postgres');
INSERT INTO tbl_audit VALUES ('3537','accesos','U','(15,1,15,0)','(15,1,15,0)','2015-07-23 16:59:53.875','postgres');
INSERT INTO tbl_audit VALUES ('3538','accesos','U','(16,1,16,0)','(16,1,16,0)','2015-07-23 16:59:53.876','postgres');
INSERT INTO tbl_audit VALUES ('3539','accesos','U','(17,1,17,0)','(17,1,17,0)','2015-07-23 16:59:53.877','postgres');
INSERT INTO tbl_audit VALUES ('3540','accesos','U','(18,1,18,0)','(18,1,18,0)','2015-07-23 16:59:53.878','postgres');
INSERT INTO tbl_audit VALUES ('3541','accesos','U','(19,1,19,0)','(19,1,19,0)','2015-07-23 16:59:53.879','postgres');
INSERT INTO tbl_audit VALUES ('3542','accesos','U','(20,1,20,0)','(20,1,20,0)','2015-07-23 16:59:53.88','postgres');
INSERT INTO tbl_audit VALUES ('3543','accesos','U','(1,1,1,0)','(1,1,1,0)','2015-07-23 17:00:28.763','postgres');
INSERT INTO tbl_audit VALUES ('3544','accesos','U','(2,1,2,0)','(2,1,2,0)','2015-07-23 17:00:28.771','postgres');
INSERT INTO tbl_audit VALUES ('3545','accesos','U','(3,1,3,0)','(3,1,3,0)','2015-07-23 17:00:28.772','postgres');
INSERT INTO tbl_audit VALUES ('3546','accesos','U','(4,1,4,0)','(4,1,4,0)','2015-07-23 17:00:28.774','postgres');
INSERT INTO tbl_audit VALUES ('3547','accesos','U','(5,1,5,0)','(5,1,5,0)','2015-07-23 17:00:28.775','postgres');
INSERT INTO tbl_audit VALUES ('3548','accesos','U','(6,1,6,0)','(6,1,6,0)','2015-07-23 17:00:28.776','postgres');
INSERT INTO tbl_audit VALUES ('3549','accesos','U','(7,1,7,0)','(7,1,7,0)','2015-07-23 17:00:28.777','postgres');
INSERT INTO tbl_audit VALUES ('3550','accesos','U','(8,1,8,0)','(8,1,8,0)','2015-07-23 17:00:28.778','postgres');
INSERT INTO tbl_audit VALUES ('3551','accesos','U','(9,1,9,0)','(9,1,9,0)','2015-07-23 17:00:28.779','postgres');
INSERT INTO tbl_audit VALUES ('3552','accesos','U','(10,1,10,0)','(10,1,10,0)','2015-07-23 17:00:28.78','postgres');
INSERT INTO tbl_audit VALUES ('3553','accesos','U','(11,1,11,0)','(11,1,11,0)','2015-07-23 17:00:28.781','postgres');
INSERT INTO tbl_audit VALUES ('3554','accesos','U','(12,1,12,0)','(12,1,12,0)','2015-07-23 17:00:28.782','postgres');
INSERT INTO tbl_audit VALUES ('3555','accesos','U','(13,1,13,0)','(13,1,13,0)','2015-07-23 17:00:28.783','postgres');
INSERT INTO tbl_audit VALUES ('3556','accesos','U','(14,1,14,0)','(14,1,14,0)','2015-07-23 17:00:28.784','postgres');
INSERT INTO tbl_audit VALUES ('3557','accesos','U','(15,1,15,0)','(15,1,15,0)','2015-07-23 17:00:28.785','postgres');
INSERT INTO tbl_audit VALUES ('3558','accesos','U','(16,1,16,0)','(16,1,16,0)','2015-07-23 17:00:28.785','postgres');
INSERT INTO tbl_audit VALUES ('3559','accesos','U','(17,1,17,0)','(17,1,17,0)','2015-07-23 17:00:28.786','postgres');
INSERT INTO tbl_audit VALUES ('3560','accesos','U','(18,1,18,0)','(18,1,18,0)','2015-07-23 17:00:28.787','postgres');
INSERT INTO tbl_audit VALUES ('3561','accesos','U','(19,1,19,0)','(19,1,19,0)','2015-07-23 17:00:28.788','postgres');
INSERT INTO tbl_audit VALUES ('3562','accesos','U','(20,1,20,0)','(20,1,20,0)','2015-07-23 17:00:28.789','postgres');
INSERT INTO tbl_audit VALUES ('3563','usuario','I',NULL,'(2,Q112,Qweqwe,123,1,"","","",1,123,"Uniandes Ibarra",1,1,"2015-07-23 17:01:52-05",Cédula,1002910345)','2015-07-23 17:01:52.858','postgres');
INSERT INTO tbl_audit VALUES ('3564','accesos','I',NULL,'(21,2,1,0)','2015-07-23 17:01:52.881','postgres');
INSERT INTO tbl_audit VALUES ('3565','accesos','I',NULL,'(22,2,2,0)','2015-07-23 17:01:52.884','postgres');
INSERT INTO tbl_audit VALUES ('3566','accesos','I',NULL,'(23,2,3,0)','2015-07-23 17:01:52.885','postgres');
INSERT INTO tbl_audit VALUES ('3567','accesos','I',NULL,'(24,2,4,0)','2015-07-23 17:01:52.887','postgres');
INSERT INTO tbl_audit VALUES ('3568','accesos','I',NULL,'(25,2,5,0)','2015-07-23 17:01:52.888','postgres');
INSERT INTO tbl_audit VALUES ('3569','accesos','I',NULL,'(26,2,6,0)','2015-07-23 17:01:52.89','postgres');
INSERT INTO tbl_audit VALUES ('3570','accesos','I',NULL,'(27,2,7,0)','2015-07-23 17:01:52.892','postgres');
INSERT INTO tbl_audit VALUES ('3571','accesos','I',NULL,'(28,2,8,0)','2015-07-23 17:01:52.894','postgres');
INSERT INTO tbl_audit VALUES ('3572','accesos','I',NULL,'(29,2,9,0)','2015-07-23 17:01:52.896','postgres');
INSERT INTO tbl_audit VALUES ('3573','accesos','I',NULL,'(30,2,10,0)','2015-07-23 17:01:52.897','postgres');
INSERT INTO tbl_audit VALUES ('3574','accesos','I',NULL,'(31,2,11,0)','2015-07-23 17:01:52.899','postgres');
INSERT INTO tbl_audit VALUES ('3575','accesos','I',NULL,'(32,2,12,0)','2015-07-23 17:01:52.9','postgres');
INSERT INTO tbl_audit VALUES ('3576','accesos','I',NULL,'(33,2,13,0)','2015-07-23 17:01:52.901','postgres');
INSERT INTO tbl_audit VALUES ('3577','accesos','I',NULL,'(34,2,14,0)','2015-07-23 17:01:52.903','postgres');
INSERT INTO tbl_audit VALUES ('3578','accesos','I',NULL,'(35,2,15,0)','2015-07-23 17:01:52.904','postgres');
INSERT INTO tbl_audit VALUES ('3579','accesos','I',NULL,'(36,2,16,0)','2015-07-23 17:01:52.906','postgres');
INSERT INTO tbl_audit VALUES ('3580','accesos','I',NULL,'(37,2,17,0)','2015-07-23 17:01:52.908','postgres');
INSERT INTO tbl_audit VALUES ('3581','accesos','I',NULL,'(38,2,18,0)','2015-07-23 17:01:52.91','postgres');
INSERT INTO tbl_audit VALUES ('3582','accesos','I',NULL,'(39,2,19,0)','2015-07-23 17:01:52.911','postgres');
INSERT INTO tbl_audit VALUES ('3583','accesos','I',NULL,'(40,2,20,0)','2015-07-23 17:01:52.913','postgres');
INSERT INTO tbl_audit VALUES ('3584','accesos','U','(21,2,1,0)','(21,2,1,0)','2015-07-23 17:02:06.676','postgres');
INSERT INTO tbl_audit VALUES ('3585','accesos','U','(22,2,2,0)','(22,2,2,0)','2015-07-23 17:02:06.684','postgres');
INSERT INTO tbl_audit VALUES ('3586','accesos','U','(23,2,3,0)','(23,2,3,0)','2015-07-23 17:02:06.686','postgres');
INSERT INTO tbl_audit VALUES ('3587','accesos','U','(24,2,4,0)','(24,2,4,0)','2015-07-23 17:02:06.687','postgres');
INSERT INTO tbl_audit VALUES ('3588','accesos','U','(25,2,5,0)','(25,2,5,1)','2015-07-23 17:02:06.688','postgres');
INSERT INTO tbl_audit VALUES ('3589','accesos','U','(26,2,6,0)','(26,2,6,0)','2015-07-23 17:02:06.689','postgres');
INSERT INTO tbl_audit VALUES ('3590','accesos','U','(27,2,7,0)','(27,2,7,1)','2015-07-23 17:02:06.69','postgres');
INSERT INTO tbl_audit VALUES ('3591','accesos','U','(28,2,8,0)','(28,2,8,1)','2015-07-23 17:02:06.691','postgres');
INSERT INTO tbl_audit VALUES ('3592','accesos','U','(29,2,9,0)','(29,2,9,1)','2015-07-23 17:02:06.692','postgres');
INSERT INTO tbl_audit VALUES ('3593','accesos','U','(30,2,10,0)','(30,2,10,0)','2015-07-23 17:02:06.694','postgres');
INSERT INTO tbl_audit VALUES ('3594','accesos','U','(31,2,11,0)','(31,2,11,1)','2015-07-23 17:02:06.695','postgres');
INSERT INTO tbl_audit VALUES ('3595','accesos','U','(32,2,12,0)','(32,2,12,0)','2015-07-23 17:02:06.696','postgres');
INSERT INTO tbl_audit VALUES ('3596','accesos','U','(33,2,13,0)','(33,2,13,0)','2015-07-23 17:02:06.697','postgres');
INSERT INTO tbl_audit VALUES ('3597','accesos','U','(34,2,14,0)','(34,2,14,0)','2015-07-23 17:02:06.698','postgres');
INSERT INTO tbl_audit VALUES ('3598','accesos','U','(35,2,15,0)','(35,2,15,0)','2015-07-23 17:02:06.699','postgres');
INSERT INTO tbl_audit VALUES ('3599','accesos','U','(36,2,16,0)','(36,2,16,0)','2015-07-23 17:02:06.699','postgres');
INSERT INTO tbl_audit VALUES ('3600','accesos','U','(37,2,17,0)','(37,2,17,0)','2015-07-23 17:02:06.701','postgres');
INSERT INTO tbl_audit VALUES ('3601','accesos','U','(38,2,18,0)','(38,2,18,0)','2015-07-23 17:02:06.702','postgres');
INSERT INTO tbl_audit VALUES ('3602','accesos','U','(39,2,19,0)','(39,2,19,0)','2015-07-23 17:02:06.703','postgres');
INSERT INTO tbl_audit VALUES ('3603','accesos','U','(40,2,20,0)','(40,2,20,0)','2015-07-23 17:02:06.704','postgres');


--
-- Creating index for 'tbl_audit'
--

ALTER TABLE ONLY  tbl_audit  ADD CONSTRAINT  pk_audit  PRIMARY KEY  (pk_audit);

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

INSERT INTO tipo_documento VALUES ('4','PDF','Pdf','0');
INSERT INTO tipo_documento VALUES ('3','HOC','Hoja de Cálculo','0');
INSERT INTO tipo_documento VALUES ('2','CAR','Carta','0');
INSERT INTO tipo_documento VALUES ('1','DOC','Documento de texto','0');


--
-- Creating index for 'tipo_documento'
--

ALTER TABLE ONLY  tipo_documento  ADD CONSTRAINT  tipo_documento_pkey  PRIMARY KEY  (id_tipo_documento);

--
-- Estrutura de la tabla 'tipo_usuario'
--

DROP TABLE tipo_usuario CASCADE;
CREATE TABLE tipo_usuario (
id_tipo_usuario int4 NOT NULL,
nombre_tipo text,
estado text
);

--
-- Creating data for 'tipo_usuario'
--

INSERT INTO tipo_usuario VALUES ('1','Administrador','0');
INSERT INTO tipo_usuario VALUES ('2','Usuario','1');


--
-- Creating index for 'tipo_usuario'
--

ALTER TABLE ONLY  tipo_usuario  ADD CONSTRAINT  tipo_usuario_pkey  PRIMARY KEY  (id_tipo_usuario);

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
usuario text,
institucion text,
id_categoria int4,
id_departamento int4,
fecha timestamp with time zone,
tipo_documento text,
nro_documento text
);

--
-- Creating data for 'usuario'
--

INSERT INTO usuario VALUES ('1','AAW01','Willi Alfonso Narvaez Iñahuazo','Otavalo Lass','2',NULL,NULL,NULL,'1','admin','Uniandes Ibarra','1','1','2015-04-27 15:36:52-05','Cédula','1002910345');
INSERT INTO usuario VALUES ('2','Q112','Qweqwe','123','1','','','','1','123','Uniandes Ibarra','1','1','2015-07-23 17:01:52-05','Cédula','1002910345');


--
-- Creating index for 'usuario'
--

ALTER TABLE ONLY  usuario  ADD CONSTRAINT  usuario_pkey  PRIMARY KEY  (id_usuario);


--
-- Creating relacionships for 'accesos'
--

ALTER TABLE ONLY accesos ADD CONSTRAINT r_usuario_acceso FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'bitacora'
--

ALTER TABLE ONLY bitacora ADD CONSTRAINT fk_bitacora_archivo FOREIGN KEY (id_archivo) REFERENCES archivo(id_archivo) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'bitacora'
--

ALTER TABLE ONLY bitacora ADD CONSTRAINT fk_medio_recepcion_bitacora FOREIGN KEY (id_medio_recepcion) REFERENCES medio_recepcion(id_medio) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'bitacora'
--

ALTER TABLE ONLY bitacora ADD CONSTRAINT fk_tipo_documento_bitacora FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento(id_tipo_documento) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'ciudad'
--

ALTER TABLE ONLY ciudad ADD CONSTRAINT r_provincia_ciudad FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'enviados'
--

ALTER TABLE ONLY enviados ADD CONSTRAINT fk_archivo_envio FOREIGN KEY (id_archivo) REFERENCES archivo(id_archivo) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'metas'
--

ALTER TABLE ONLY metas ADD CONSTRAINT r_meta_archivo FOREIGN KEY (id_archivo) REFERENCES archivo(id_archivo) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'recibidos'
--

ALTER TABLE ONLY recibidos ADD CONSTRAINT fk_recibidos_archivo FOREIGN KEY (id_archivo) REFERENCES archivo(id_archivo) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'usuario'
--

ALTER TABLE ONLY usuario ADD CONSTRAINT r_categoria_usuario FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'usuario'
--

ALTER TABLE ONLY usuario ADD CONSTRAINT r_usuario_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'usuario'
--

ALTER TABLE ONLY usuario ADD CONSTRAINT r_usuario_tipo_usuario FOREIGN KEY (id_tipo_user) REFERENCES tipo_usuario(id_tipo_usuario) ON UPDATE CASCADE ON DELETE CASCADE;
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
CREATE TRIGGER tbl_enviados_tg_audit AFTER INSERT OR UPDATE OR DELETE ON enviados FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();