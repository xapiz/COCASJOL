﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using System.Data.Objects;

namespace COCASJOL.LOGIC.Socios
{
    public class SociosLogic
    {
        public SociosLogic() { }

        #region Select
        public List<socio> getData()
        {
            colinasEntities db = new colinasEntities();
            var query = from soc in db.socios
                        select soc;
            return query.ToList<socio>();
        }

        public List<beneficiario_x_socio> getBenefxSocio(string socioid)
        {
            try
            {
                using (var db = new colinasEntities())
                {
                    db.socios.MergeOption = MergeOption.NoTracking;

                    var query = from ben in db.beneficiario_x_socio
                                where ben.SOCIOS_ID == socioid
                                select ben;

                    return query.ToList<beneficiario_x_socio>();
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        #endregion

        #region Update
        public void ActualizarSocio(
            string SOCIOS_ID,
            string SOCIOS_PRIMER_NOMBRE,
            string SOCIOS_SEGUNDO_NOMBRE,
            string SOCIOS_PRIMER_APELLIDO,
            string SOCIOS_SEGUNDO_APELLIDO,
            string SOCIOS_RESIDENCIA,
            string SOCIOS_ESTADO_CIVIL,
            string SOCIOS_LUGAR_DE_NACIMIENTO,
            string SOCIOS_FECHA_DE_NACIMIENTO,
            string SOCIOS_NIVEL_EDUCATIVO,
            int SOCIOS_IDENTIDAD,
            string SOCIOS_PROFESION,
            int SOCIOS_RTN,
            string SOCIOS_TELEFONO,
            string SOCIOS_LUGAR_DE_EMISION,
            string SOCIOS_FECHA_DE_EMISION,
            int GENERAL_CARNET_IHCAFE,
            string GENERAL_ORGANIZACION_SECUNDARIA,
            string  GENERAL_NUMERO_CARNET,
            string GENERAL_EMPRESA_LABORA,
            string GENERAL_EMPRESA_CARGO,
            string GENERAL_EMPRESA_DIRECCION, 
            string GENERAL_EMPRESA_TELEFONO,
            string PRODUCCION_UBICACION_FINCA,
            string PRODUCCION_AREA,
            string PRODUCCION_VARIEDAD,
            string PRODUCCION_ALTURA,
            string PRODUCCION_DISTANCIA,
            int PRODUCCION_ANUAL,
            string PRODUCCION_BENEFICIO_PROPIO,
            string PRODUCCION_ANALISIS_SUELO,
            string PRODUCCION_TIPO_INSUMOS,
            int PRODUCCION_MANZANAS_CULTIVADAS,
            string MODIFICADO_POR
            )
        {
            colinasEntities db = null;
            try
            {
                db = new colinasEntities();
                var query = from soc in db.socios
                            where soc.SOCIOS_ID == SOCIOS_ID
                            select soc;

                socio socio = query.First();
                socio.SOCIOS_ID = SOCIOS_ID;
                socio.SOCIOS_PRIMER_NOMBRE = SOCIOS_PRIMER_NOMBRE;
                socio.SOCIOS_SEGUNDO_NOMBRE = SOCIOS_SEGUNDO_NOMBRE;
                socio.SOCIOS_PRIMER_APELLIDO = SOCIOS_PRIMER_APELLIDO;
                socio.SOCIOS_SEGUNDO_APELLIDO = SOCIOS_SEGUNDO_APELLIDO;
                socio.SOCIOS_RESIDENCIA = SOCIOS_RESIDENCIA;
                socio.SOCIOS_ESTADO_CIVIL = SOCIOS_ESTADO_CIVIL;
                socio.SOCIOS_LUGAR_DE_NACIMIENTO = SOCIOS_LUGAR_DE_NACIMIENTO;
                socio.SOCIOS_FECHA_DE_NACIMIENTO = DateTime.Parse(SOCIOS_FECHA_DE_NACIMIENTO);
                socio.SOCIOS_NIVEL_EDUCATIVO = SOCIOS_NIVEL_EDUCATIVO;
                socio.SOCIOS_IDENTIDAD = SOCIOS_IDENTIDAD;
                socio.SOCIOS_PROFESION = SOCIOS_PROFESION;
                socio.SOCIOS_RTN = SOCIOS_RTN;
                socio.SOCIOS_TELEFONO = SOCIOS_TELEFONO;
                socio.SOCIOS_LUGAR_DE_EMISION = SOCIOS_LUGAR_DE_EMISION;
                socio.SOCIOS_FECHA_DE_EMISION = DateTime.Parse(SOCIOS_FECHA_DE_EMISION);
                socio.MODIFICADO_POR = MODIFICADO_POR;
                socio.FECHA_MODIFICACION = DateTime.Today;
                socio.socios_generales.GENERAL_CARNET_IHCAFE = GENERAL_CARNET_IHCAFE;
                socio.socios_generales.GENERAL_ORGANIZACION_SECUNDARIA = GENERAL_ORGANIZACION_SECUNDARIA;
                socio.socios_generales.GENERAL_NUMERO_CARNET = GENERAL_NUMERO_CARNET;
                socio.socios_generales.GENERAL_EMPRESA_LABORA = GENERAL_EMPRESA_LABORA;
                socio.socios_generales.GENERAL_EMPRESA_CARGO = GENERAL_EMPRESA_CARGO;
                socio.socios_generales.GENERAL_EMPRESA_DIRECCION = GENERAL_EMPRESA_DIRECCION;
                socio.socios_generales.GENERAL_EMPRESA_TELEFONO = GENERAL_EMPRESA_TELEFONO;
                socio.socios_produccion.PRODUCCION_UBICACION_FINCA = PRODUCCION_UBICACION_FINCA;
                socio.socios_produccion.PRODUCCION_AREA = PRODUCCION_AREA;
                socio.socios_produccion.PRODUCCION_VARIEDAD = PRODUCCION_VARIEDAD;
                socio.socios_produccion.PRODUCCION_ALTURA = PRODUCCION_ALTURA;
                socio.socios_produccion.PRODUCCION_DISTANCIA = PRODUCCION_DISTANCIA;
                socio.socios_produccion.PRODUCCION_ANUAL = PRODUCCION_ANUAL;
                socio.socios_produccion.PRODUCCION_BENEFICIO_PROPIO = PRODUCCION_BENEFICIO_PROPIO;
                socio.socios_produccion.PRODUCCION_ANALISIS_SUELO = PRODUCCION_ANALISIS_SUELO;
                socio.socios_produccion.PRODUCCION_TIPO_INSUMOS = PRODUCCION_TIPO_INSUMOS;
                socio.socios_produccion.PRODUCCION_MANZANAS_CULTIVADAS = PRODUCCION_MANZANAS_CULTIVADAS;
                db.SaveChanges();
                db.Dispose();
            }
            catch (Exception ex)
            {
                if (db != null)
                {
                    db.Dispose();
                }
                throw;
            }
        }
        #endregion update

        #region insert
        public void InsertarSocio(
            string SOCIOS_ID,
            string SOCIOS_PRIMER_NOMBRE,
            string SOCIOS_SEGUNDO_NOMBRE,
            string SOCIOS_PRIMER_APELLIDO,
            string SOCIOS_SEGUNDO_APELLIDO,
            string SOCIOS_RESIDENCIA,
            string SOCIOS_ESTADO_CIVIL,
            string SOCIOS_LUGAR_DE_NACIMIENTO,
            string SOCIOS_FECHA_DE_NACIMIENTO,
            string SOCIOS_NIVEL_EDUCATIVO,
            int SOCIOS_IDENTIDAD,
            string SOCIOS_PROFESION,
            int SOCIOS_RTN,
            string SOCIOS_TELEFONO,
            string SOCIOS_LUGAR_DE_EMISION,
            string SOCIOS_FECHA_DE_EMISION,
            int GENERAL_CARNET_IHCAFE,
            string GENERAL_ORGANIZACION_SECUNDARIA,
            string GENERAL_NUMERO_CARNET,
            string GENERAL_EMPRESA_LABORA,
            string GENERAL_EMPRESA_CARGO,
            string GENERAL_EMPRESA_DIRECCION,
            string GENERAL_EMPRESA_TELEFONO,
            string PRODUCCION_UBICACION_FINCA,
            string PRODUCCION_AREA,
            string PRODUCCION_VARIEDAD,
            string PRODUCCION_ALTURA,
            string PRODUCCION_DISTANCIA,
            int PRODUCCION_ANUAL,
            string PRODUCCION_BENEFICIO_PROPIO,
            string PRODUCCION_ANALISIS_SUELO,
            string PRODUCCION_TIPO_INSUMOS,
            int PRODUCCION_MANZANAS_CULTIVADAS,
            string CREADO_POR
            )
        {
            colinasEntities db = null;
            try
            {
                db = new colinasEntities();
                string letra = SOCIOS_PRIMER_NOMBRE.Substring(0, 1);

                var query = from cod in db.codigo
                            where cod.CODIGO_LETRA == letra
                            select cod;

                codigo c = query.First();
                string NuevoCodigo = letra + c.CODIGO_NUMERO;
                c.CODIGO_NUMERO = c.CODIGO_NUMERO + 1;
                socio soc = new socio();
                soc.SOCIOS_ID = NuevoCodigo;
                soc.SOCIOS_PRIMER_NOMBRE = SOCIOS_PRIMER_NOMBRE;
                soc.SOCIOS_SEGUNDO_NOMBRE = SOCIOS_SEGUNDO_NOMBRE;
                soc.SOCIOS_PRIMER_APELLIDO = SOCIOS_PRIMER_APELLIDO;
                soc.SOCIOS_SEGUNDO_APELLIDO = SOCIOS_SEGUNDO_APELLIDO;
                soc.SOCIOS_RESIDENCIA = SOCIOS_RESIDENCIA;
                soc.SOCIOS_ESTADO_CIVIL = SOCIOS_ESTADO_CIVIL;
                soc.SOCIOS_LUGAR_DE_NACIMIENTO = SOCIOS_LUGAR_DE_NACIMIENTO;
                soc.SOCIOS_FECHA_DE_NACIMIENTO = DateTime.Parse(SOCIOS_FECHA_DE_NACIMIENTO);
                soc.SOCIOS_NIVEL_EDUCATIVO = SOCIOS_NIVEL_EDUCATIVO;
                soc.SOCIOS_IDENTIDAD = SOCIOS_IDENTIDAD;
                soc.SOCIOS_PROFESION = SOCIOS_PROFESION;
                soc.SOCIOS_RTN = SOCIOS_RTN;
                soc.SOCIOS_TELEFONO = SOCIOS_TELEFONO;
                soc.SOCIOS_LUGAR_DE_EMISION = SOCIOS_LUGAR_DE_EMISION;
                soc.SOCIOS_FECHA_DE_EMISION = DateTime.Parse(SOCIOS_FECHA_DE_EMISION);
                soc.CREADO_POR = CREADO_POR;
                soc.FECHA_CREACION = DateTime.Today;
                soc.MODIFICADO_POR = CREADO_POR;
                soc.FECHA_MODIFICACION = DateTime.Today;
                soc.SOCIOS_ESTATUS = 1;
                db.socios.AddObject(soc);
                socio_general socgen = new socio_general();
                socgen.SOCIOS_ID = NuevoCodigo;
                socgen.GENERAL_CARNET_IHCAFE = GENERAL_CARNET_IHCAFE;
                socgen.GENERAL_ORGANIZACION_SECUNDARIA = GENERAL_ORGANIZACION_SECUNDARIA;
                socgen.GENERAL_NUMERO_CARNET = GENERAL_NUMERO_CARNET;
                socgen.GENERAL_EMPRESA_LABORA = GENERAL_EMPRESA_LABORA;
                socgen.GENERAL_EMPRESA_CARGO = GENERAL_EMPRESA_CARGO;
                socgen.GENERAL_EMPRESA_DIRECCION = GENERAL_EMPRESA_DIRECCION;
                socgen.GENERAL_EMPRESA_TELEFONO = GENERAL_EMPRESA_TELEFONO;
                db.socios_generales.AddObject(socgen);
                socio_produccion socprod = new socio_produccion();
                socprod.SOCIOS_ID = NuevoCodigo;
                socprod.PRODUCCION_UBICACION_FINCA = PRODUCCION_UBICACION_FINCA;
                socprod.PRODUCCION_AREA = PRODUCCION_AREA;
                socprod.PRODUCCION_VARIEDAD = PRODUCCION_VARIEDAD;
                socprod.PRODUCCION_ALTURA = PRODUCCION_ALTURA;
                socprod.PRODUCCION_DISTANCIA = PRODUCCION_DISTANCIA;
                socprod.PRODUCCION_ANUAL = PRODUCCION_ANUAL;
                socprod.PRODUCCION_BENEFICIO_PROPIO = PRODUCCION_BENEFICIO_PROPIO;
                socprod.PRODUCCION_ANALISIS_SUELO = PRODUCCION_ANALISIS_SUELO;
                socprod.PRODUCCION_TIPO_INSUMOS = PRODUCCION_TIPO_INSUMOS;
                socprod.PRODUCCION_MANZANAS_CULTIVADAS = PRODUCCION_MANZANAS_CULTIVADAS;
                db.socios_produccion.AddObject(socprod);
                db.SaveChanges();
                db.Dispose();
            }
            catch (Exception e)
            {
                if (db != null)
                {
                    db.Dispose();
                }
                throw;
            }
        }
        #endregion insert

        #region Delete

        public void EliminarUsuario(string SOCIOS_ID)
        {
            colinasEntities db = null;
            try
            {
                db = new colinasEntities();

                var query = from soc in db.socios
                            where soc.SOCIOS_ID == SOCIOS_ID
                            select soc;

                socio socio = query.First();

                db.DeleteObject(socio);

                db.SaveChanges();
                db.Dispose();
            }
            catch (Exception ex)
            {
                if (db != null)
                    db.Dispose();
                throw;
            }
        }

        #endregion

        #region Disable
        public void DeshabilitarUsuario(string SOCIOS_ID)
        {
            colinasEntities db = null;
            try
            {
                db = new colinasEntities();

                var query = from soc in db.socios
                            where soc.SOCIOS_ID == SOCIOS_ID
                            select soc;

                socio socio = query.First();
                socio.SOCIOS_ESTATUS = 0;
                db.SaveChanges();
                db.Dispose();

            }
            catch (Exception ex)
            {
                if (db != null)
                    db.Dispose();
                throw;
            }
        }
        #endregion

        #region Enable
        public void HabilitarUsuario(string SOCIOS_ID)
        {
            colinasEntities db = null;
            try
            {
                db = new colinasEntities();

                var query = from soc in db.socios
                            where soc.SOCIOS_ID == SOCIOS_ID
                            select soc;

                socio socio = query.First();
                socio.SOCIOS_ESTATUS = 1;
                db.SaveChanges();
                db.Dispose();

            }
            catch (Exception ex)
            {
                if (db != null)
                    db.Dispose();
                throw;
            }
        }
        #endregion
    }
}