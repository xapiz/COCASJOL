﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Net;
using System.Net.Mail;
using System.Data;
using System.Data.Objects;

using COCASJOL.LOGIC;
using COCASJOL.LOGIC.Seguridad;

namespace COCASJOL.LOGIC.Utiles
{
    public class EmailLogic
    {
        public static void EnviarCorreoUsuarioNuevo(string USR_USERNAME, string USR_PASSWORD)
        {
            try
            {
                UsuarioLogic usuariologica = new UsuarioLogic();
                usuario user = usuariologica.GetUsuario(USR_USERNAME);

                string mailto = user.USR_CORREO;
                string nombre = user.USR_NOMBRE + user.USR_APELLIDO;

                string subject = "";
                string message = "";

                using (var db = new colinasEntities())
                {
                    EntityKey k = new EntityKey("colinasEntities.plantillas_notificaciones", "PLANTILLAS_LLAVE", "USUARIONUEVO");
                    var pl = db.GetObjectByKey(k);
                    plantilla_notificacion plantilla = (plantilla_notificacion)pl;

                    subject = plantilla.PLANTILLAS_ASUNTO;
                    message = plantilla.PLANTILLAS_MENSAJE;
                }

                message = message.Replace("{NOMBRE}", nombre);
                message = message.Replace("{USUARIO}", USR_USERNAME);
                message = message.Replace("{CONTRASEÑA}", USR_PASSWORD);

                EnviarCorreo(mailto, subject, message);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static void EnviarCorreoRolNuevo(string USR_USERNAME, int ROL_ID)
        {
            try
            {
                UsuarioLogic usuariologica = new UsuarioLogic();
                usuario user = usuariologica.GetUsuario(USR_USERNAME);

                string mailto = user.USR_CORREO;
                string nombre = user.USR_NOMBRE + user.USR_APELLIDO;

                string rol = "";
                string privs = "";

                string subject = "";
                string message = ""; 

                using (var db = new colinasEntities())
                {
                    EntityKey k = new EntityKey("colinasEntities.roles", "ROL_ID", ROL_ID);
                    var r = db.GetObjectByKey(k);
                    rol role = (rol)r;

                    rol = role.ROL_NOMBRE + " - " + role.ROL_DESCRIPCION;

                    foreach (privilegio p in role.privilegios)
                        privs += p.PRIV_NOMBRE + ", ";


                    EntityKey k2 = new EntityKey("colinasEntities.plantillas_notificaciones", "PLANTILLAS_LLAVE", "ROLNUEVO");
                    var pl = db.GetObjectByKey(k2);
                    plantilla_notificacion plantilla = (plantilla_notificacion)pl;

                    subject = plantilla.PLANTILLAS_ASUNTO;
                    message = plantilla.PLANTILLAS_MENSAJE;
                }

                message = message.Replace("{NOMBRE}", nombre);
                message = message.Replace("{USUARIO}", USR_USERNAME);
                message = message.Replace("{ROL}", rol);
                message = message.Replace("{PRIVILEGIOS}", privs);

                EnviarCorreo(mailto, subject, message);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public static void EnviarCorreoPrivilegioNuevo(string USR_USERNAME, int PRIV_ID)
        {
            try
            {
                UsuarioLogic usuariologica = new UsuarioLogic();
                usuario user = usuariologica.GetUsuario(USR_USERNAME);

                string mailto = user.USR_CORREO;
                string nombre = user.USR_NOMBRE + user.USR_APELLIDO;

                string priv = "";

                string subject = "";
                string message = "";

                using (var db = new colinasEntities())
                {
                    EntityKey k = new EntityKey("colinasEntities.privilegios", "PRIV_ID", PRIV_ID);

                    var p = db.GetObjectByKey(k);

                    privilegio priv2 = (privilegio)p;

                    priv = priv2.PRIV_NOMBRE;

                    EntityKey k2 = new EntityKey("colinasEntities.plantillas_notificaciones", "PLANTILLAS_LLAVE", "PRIVILEGIONUEVO");
                    var pl = db.GetObjectByKey(k2);
                    plantilla_notificacion plantilla = (plantilla_notificacion)pl;

                    subject = plantilla.PLANTILLAS_ASUNTO;
                    message = plantilla.PLANTILLAS_MENSAJE;
                }

                message = message.Replace("{NOMBRE}", nombre);
                message = message.Replace("{USUARIO}", USR_USERNAME);
                message = message.Replace("{PRIVILEGIO}", priv);

                EnviarCorreo(mailto, subject, message);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        private static void EnviarCorreo(string mailto, string subject, string message)
        {
            try
            {
                string strUsePassword = System.Configuration.ConfigurationManager.AppSettings.Get("CorreoUsarPassword");
                string mailfrom = System.Configuration.ConfigurationManager.AppSettings.Get("CorreoLocal");
                string host = System.Configuration.ConfigurationManager.AppSettings.Get("SMTP_SERVER");

                bool usePassword = Convert.ToBoolean(strUsePassword);

                if (usePassword)
                {
                    string fromPassword = System.Configuration.ConfigurationManager.AppSettings.Get("CorreoLocalPassword");
                    sendMail(mailto, mailfrom, fromPassword, message, subject, host);
                }
                else
                    sendMail(mailto, mailfrom, message, subject, host);
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        private static void sendMail(string to, string from, string message, string subject, string server)
        {
            try
            {
                MailMessage correo = new MailMessage(from, to, subject, message);
                correo.IsBodyHtml = true;
                SmtpClient smtpcliente = new SmtpClient(server);
                smtpcliente.Send(correo);
                correo.Dispose();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private static void sendMail(string to, string from, string fromPassword, string message, string subject, string server)
        {
            try
            {
                MailMessage correo = new MailMessage(from, to, subject, message);
                correo.IsBodyHtml = true;
                SmtpClient smtpcliente = new SmtpClient 
                {
                    Host = server,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(from, fromPassword)
                };
                smtpcliente.Send(correo);
                correo.Dispose();
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}