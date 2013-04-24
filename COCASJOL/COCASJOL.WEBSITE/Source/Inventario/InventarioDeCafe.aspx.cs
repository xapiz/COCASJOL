﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.Objects;
using Ext.Net;

using COCASJOL.LOGIC.Web;

using log4net;
using Microsoft.Reporting.WebForms;

namespace COCASJOL.WEBSITE.Source.Inventario
{
    public partial class InventarioDeCafe : COCASJOL.LOGIC.Web.COCASJOLREPORT
    {
        private static ILog log = LogManager.GetLogger(typeof(InventarioDeCafe).Name);

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!X.IsAjaxRequest)
                {
                    
                }

                string loggedUsr = Session["username"] as string;
                this.LoggedUserHdn.Text = loggedUsr;
            }
            catch (Exception ex)
            {
                log.Fatal("Error fatal al cargar pagina de inventario de cafe.", ex);
                throw;
            }
        }

        protected void InventarioCafeDS_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            try
            {
                if (!this.IsPostBack)
                {
                    COCASJOL.LOGIC.Configuracion.ConfiguracionDeSistemaLogic configLogic = new COCASJOL.LOGIC.Configuracion.ConfiguracionDeSistemaLogic(this.docConfiguracion);
                    if (configLogic.VentanasCargarDatos == true)
                        e.Cancel = false;
                    else
                        e.Cancel = true;
                }
            }
            catch (Exception ex)
            {
                log.Fatal("Error fatal al cargar inventario de cafe.", ex);
                throw;
            }
        }

        protected void Export_PDFBtn_Click(object sender, DirectEventArgs e)
        {
            string formatoSalida = "";
            try
            {
                COCASJOL.LOGIC.Inventario.InventarioDeCafeLogic reporteLogic = new COCASJOL.LOGIC.Inventario.InventarioDeCafeLogic();

                List<COCASJOL.DATAACCESS.reporte_total_inventario_de_cafe> ReporteInventarioDeCafeDeCooperativaLst = reporteLogic.GetInventarioDeCafe
                    (string.IsNullOrEmpty(this.f_CLASIFICACIONES_CAFE_ID.Text) ? 0 : Convert.ToInt32(this.f_CLASIFICACIONES_CAFE_ID.Text),
                    string.IsNullOrEmpty(this.f_INVENTARIO_ENTRADAS_CANTIDAD.Text) ? -1 : Convert.ToInt32(this.f_INVENTARIO_ENTRADAS_CANTIDAD.Text),
                    string.IsNullOrEmpty(this.f_INVENTARIO_SALIDAS_SALDO.Text) ? -1 : Convert.ToInt32(this.f_INVENTARIO_SALIDAS_SALDO.Text),
                    "",
                    default(DateTime));

                ReportDataSource datasourceInventarioCafeCooperativa = new ReportDataSource("ResumenDeInventarioDeCafeDeCooperativaDataSet", ReporteInventarioDeCafeDeCooperativaLst);

                ReportParameterCollection reportParamCollection = new ReportParameterCollection();
                reportParamCollection.Add(new ReportParameter("parMostrarQuintales", this.p_QUINTALES.Checked.ToString()));

                formatoSalida = "PDF";

                string rdlPath = "~/resources/rdlcs/ReportResumenInventarioDeCafeDeCooperativa.rdlc";

                this.CreateFileOutput("ReporteResumenInventarioDeCafeDeCooperativa", formatoSalida, rdlPath, datasourceInventarioCafeCooperativa, reportParamCollection);
            }
            catch (Exception ex)
            {
                log.Fatal(string.Format("Error fatal al generar reporte. Formato de salida: {0}", formatoSalida), ex);
                throw;
            }
        }

        protected void Export_ExcelBtn_Click(object sender, DirectEventArgs e)
        {
            string formatoSalida = "";
            try
            {
                COCASJOL.LOGIC.Inventario.InventarioDeCafeLogic reporteLogic = new COCASJOL.LOGIC.Inventario.InventarioDeCafeLogic();

                List<COCASJOL.DATAACCESS.reporte_total_inventario_de_cafe> ReporteInventarioDeCafeDeCooperativaLst = reporteLogic.GetInventarioDeCafe
                    (string.IsNullOrEmpty(this.f_CLASIFICACIONES_CAFE_ID.Text) ? 0 : Convert.ToInt32(this.f_CLASIFICACIONES_CAFE_ID.Text),
                    string.IsNullOrEmpty(this.f_INVENTARIO_ENTRADAS_CANTIDAD.Text) ? -1 : Convert.ToInt32(this.f_INVENTARIO_ENTRADAS_CANTIDAD.Text),
                    string.IsNullOrEmpty(this.f_INVENTARIO_SALIDAS_SALDO.Text) ? -1 : Convert.ToInt32(this.f_INVENTARIO_SALIDAS_SALDO.Text),
                    "",
                    default(DateTime));

                ReportDataSource datasourceInventarioCafeCooperativa = new ReportDataSource("ResumenDeInventarioDeCafeDeCooperativaDataSet", ReporteInventarioDeCafeDeCooperativaLst);

                ReportParameterCollection reportParamCollection = new ReportParameterCollection();
                reportParamCollection.Add(new ReportParameter("parMostrarQuintales", this.p_QUINTALES.Checked.ToString()));

                formatoSalida = "EXCEL";

                string rdlPath = "~/resources/rdlcs/ReportResumenInventarioDeCafeDeCooperativa.rdlc";

                this.CreateFileOutput("ReporteResumenInventarioDeCafeDeCooperativa", formatoSalida, rdlPath, datasourceInventarioCafeCooperativa, reportParamCollection);
            }
            catch (Exception ex)
            {
                log.Fatal(string.Format("Error fatal al generar reporte. Formato de salida: {0}", formatoSalida), ex);
                throw;
            }
        }
    }
}