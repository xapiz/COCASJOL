﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.Objects;
using Ext.Net;

using COCASJOL.LOGIC.Productos;
using COCASJOL.LOGIC.Web;
 
namespace COCASJOL.WEBSITE.Source.Productos
{
    public partial class Productos : COCASJOLBASE
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!X.IsAjaxRequest)
                {
                    string loggedUsr = Session["username"] as string;
                    this.LoggedUserHdn.Text = loggedUsr;
                    this.ValidarCredenciales(typeof(Productos).Name);
                }
            }
            catch (Exception)
            {
                //log
                throw;
            }
        }

        protected void ProductosDS_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!this.IsPostBack)
                e.Cancel = true;
        }

        protected void AddNombreTxt_Validate(object sender, RemoteValidationEventArgs e)
        {
            try
            {
                string nombreDeProducto = this.AddNombreTxt.Text;

                ProductoLogic productologic = new ProductoLogic();

                if (productologic.NombreDeProductoExiste(nombreDeProducto))
                {
                    e.Success = false;
                    e.ErrorMessage = "El nombre de producto ingresado ya existe.";
                }
                else
                    e.Success = true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void EditNombreTxt_Validate(object sender, RemoteValidationEventArgs e)
        {
            try
            {
                string nombreDeProducto = this.EditNombreTxt.Text;

                ProductoLogic productologic = new ProductoLogic();

                if (productologic.NombreDeProductoExiste(nombreDeProducto))
                {
                    e.Success = false;
                    e.ErrorMessage = "El nombre de producto ingresado ya existe.";
                }
                else
                    e.Success = true;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}