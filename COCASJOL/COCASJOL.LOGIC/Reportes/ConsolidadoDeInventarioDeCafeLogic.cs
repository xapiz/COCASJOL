﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using System.Data.Objects;

namespace COCASJOL.LOGIC.Reportes
{
    public class ReporteConsolidadoDeCafe
    {
        private decimal _TotalIngresado, _TotalComprado, _TotalDeposito;

        public decimal TotalIngresado
        {
            get { return this._TotalIngresado; }
            set { this._TotalIngresado = value; }
        }

        public decimal TotalComprado
        {
            get { return this._TotalComprado; }
            set { this._TotalComprado = value; }
        }

        public decimal TotalDeposito
        {
            get { return this._TotalDeposito; }
            set { this._TotalDeposito = value; }
        }

        public ReporteConsolidadoDeCafe(decimal Total_Ingresado, decimal Total_Comprado, decimal Total_Deposito)
        {
            this._TotalIngresado = Total_Ingresado;
            this._TotalComprado = Total_Comprado;
            this._TotalDeposito = Total_Deposito;
        }
    }

    public class ConsolidadoDeInventarioDeCafeLogic
    {
        public ConsolidadoDeInventarioDeCafeLogic() { }

        #region Select

        public ReporteConsolidadoDeCafe GetReporte()
        {
            try
            {
                using (var db = new colinasEntities())
                {
                    var queryIngresado = from n in db.notas_de_peso
                                         select n;

                    var queryComprado = from l in db.liquidaciones
                                        select l;

                    decimal TotalIngresado = queryIngresado.Sum(n => n.NOTAS_PESO_TOTAL_RECIBIDO);
                    decimal TotalComprado = Convert.ToDecimal(queryComprado.Sum(l => l.LIQUIDACIONES_D_TOTAL_DEDUCCIONES));
                    decimal TotalDeposito = TotalIngresado - TotalComprado;

                    return new ReporteConsolidadoDeCafe(TotalIngresado, TotalComprado, TotalDeposito);
                }
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        #endregion
    }
}