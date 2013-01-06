﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Desktop.aspx.cs" Inherits="COCASJOL.WEBSITE.Desktop" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="~/Source/Seguridad/UsuarioActual.ascx" TagName="UsuarioActual" TagPrefix="usera" %>
<%@ Register Src="~/Source/Seguridad/CambiarClave.ascx" TagName="CambiarClave" TagPrefix="cclave" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Colinas</title>
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
    <link rel="icon" href="../favicon.ico" type="image/x-icon"/>

    <link rel="Stylesheet" type="text/css" href="../resources/css/Desktop.css" />
    <link rel="Stylesheet" type="text/css" href="../resources/css/DesktopShortcuts.css" />
    <script type="text/javascript" src="../resources/js/md5.js" ></script>
    <script type="text/javascript" src="../resources/js/desktop.js" ></script>
</head>
<body>
    <script type="text/javascript">
        function CheckNotifications() {
            Ext.net.DirectMethods.CheckForNotifications();
        }

        var DesktopintervalVariable = setInterval(CheckNotifications, 5000);
    </script>
    <form id="form1" runat="server">
    <div class="desktop_body">
        <ext:ResourceManager ID="ResourceManager1" runat="server" DisableViewState="true">
            <Listeners>
                <DocumentReady Handler="DesktopX.initialCheckForNotification();" />
            </Listeners>
        </ext:ResourceManager>

        <%--Context Menu--%>

        <ext:Menu runat="server" ID="cmenu">
            <Items>
            <ext:MenuItem Text="Configuración" Icon="Wrench">
                <Listeners>
                    <Click Handler="WindowX.settings();" />
                </Listeners>
            </ext:MenuItem>
            <ext:MenuSeparator />
            <ext:MenuItem Text="Ventanas en Cascada" Icon="ApplicationCascade">
                <Listeners>
                    <Click Handler="DesktopX.cascadeWindows(#{MyDesktop});" />
                </Listeners>
            </ext:MenuItem>
            <ext:MenuItem Text="Ventanas en grupo Horizontal" Icon="ApplicationTileHorizontal">
                <Listeners>
                    <Click Handler="DesktopX.tileFitWindows(#{MyDesktop}, true);" />
                </Listeners>
            </ext:MenuItem>
            <ext:MenuItem Text="Ventanas en grupo Vertical" Icon="ApplicationTileVertical">
                <Listeners>
                    <Click Handler="DesktopX.tileFitWindows(#{MyDesktop}, false);" />
                </Listeners>
            </ext:MenuItem>
            <ext:MenuItem Text="Ventanas en Mosaico" Icon="ApplicationTileVertical">
                <Listeners>
                    <Click Handler="DesktopX.tileWindows(#{MyDesktop});" />
                </Listeners>
            </ext:MenuItem>
            <ext:MenuItem Text="Ventanas en Tablero" Icon="ApplicationViewTile">
                <Listeners>
                    <Click Handler="DesktopX.checkerboardWindows(#{MyDesktop});" />
                </Listeners>
            </ext:MenuItem>
            <ext:MenuSeparator />
            <ext:MenuItem Text="Cerrar Ventanas" Icon="ApplicationDelete">
                <Listeners>
                    <Click Handler="DesktopX.closeAllWindows(#{MyDesktop});" />
                </Listeners>
            </ext:MenuItem>
            <ext:MenuSeparator />
            <ext:MenuItem Text="Restaurar Ventanas" Icon="ApplicationGet">
                <Listeners>
                    <Click Handler="DesktopX.showAllWindows(#{MyDesktop});" />
                </Listeners>
            </ext:MenuItem>
            <ext:MenuItem Text="Minimizar Ventanas" Icon="ApplicationPut">
                <Listeners>
                    <Click Handler="DesktopX.minimizeAllWindows(#{MyDesktop});" />
                </Listeners>
            </ext:MenuItem>
            </Items>
        </ext:Menu>
        
        <%--Context Menu--%>

        <%--Desktop--%>

        <ext:Desktop
            ID="MyDesktop" 
            runat="server" 
            BackgroundColor="White" 
            ShortcutTextColor="Black" >
            <Listeners>
                <ShortcutClick Handler="ShorcutClickHandler(#{MyDesktop}, id);" />
                <Ready Handler="Ext.get('x-desktop').on('contextmenu', function(e){e.stopEvent();e.preventDefault();cmenu.showAt(e.getPoint());});
                                Ext.get('ux-taskbar').on('contextmenu', function(e){e.stopEvent();e.preventDefault();cmenu.showAt(e.getPoint());});" />
            </Listeners>
            <StartButton Text="Inicio" IconCls="start-button" />

            <Modules>
                <%--Seguridad--%>
                <ext:DesktopModule ModuleID="UsuariosModule">
                    <Launcher ID="UsuariosLauncher" runat="server" Text="Usuarios" Icon="User" >
                        <Listeners>
                            <Click Handler="WindowX.usuarios(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="RolesModule">
                    <Launcher ID="RolesLauncher" runat="server" Text="Roles" Icon="Cog" >
                        <Listeners>
                            <Click Handler="WindowX.roles(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <%--Seguridad--%>

                <%--Socios--%>
                <ext:DesktopModule ModuleID="SociosModule">
                    <Launcher ID="SociosLauncher" runat="server" Text="Socios" Icon="Group" >
                        <Listeners>
                            <Click Handler="WindowX.socios(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <%--Socios--%>

                <%--Productos--%>
                <ext:DesktopModule ModuleID="TiposDeProductoModule">
                    <Launcher ID="TiposDeProductoLauncher" runat="server" Text="Tipos de Producto" Icon="Basket" >
                        <Listeners>
                            <Click Handler="WindowX.tiposDeProductos(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="ProductosModule">
                    <Launcher ID="ProductosLauncher" runat="server" Text="Productos" Icon="Cart" >
                        <Listeners>
                            <Click Handler="WindowX.productos(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <%--Productos--%>

                <%--Notas De Peso--%>
                <ext:DesktopModule ModuleID="EstadosNotasDePesoModule">
                    <Launcher ID="EstadosNotasDePesoLauncher" runat="server" Text="Estados de Notas De Peso" Icon="PageGo" >
                        <Listeners>
                            <Click Handler="WindowX.estadosNotasDePeso(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="NotasDePesoEnPesajeModule">
                    <Launcher ID="Launcher1" runat="server" Text="Notas De Peso en Area de Pesaje" Icon="PageWhitePut" >
                        <Listeners>
                            <Click Handler="WindowX.notasDePesoEnPesaje(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="NotasDePesoEnCatacionModule">
                    <Launcher ID="Launcher2" runat="server" Text="Notas De Peso en Area de Catación" Icon="PageWhiteCup" >
                        <Listeners>
                            <Click Handler="WindowX.notasDePesoEnCatacion(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="NotasDePesoModule">
                    <Launcher ID="NotasDePesoLauncher" runat="server" Text="Notas De Peso" Icon="PageWhiteOffice" >
                        <Listeners>
                            <Click Handler="WindowX.notasDePeso(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <%--Notas De Peso--%>

                <%--Hojas De Liquidación--%>
                <ext:DesktopModule ModuleID="HojasDeLiquidacionModule">
                    <Launcher ID="Launcher3" runat="server" Text="Hojas De Liquidación" Icon="Script" >
                        <Listeners>
                            <Click Handler="WindowX.hojasDeLiquidacion(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <%--Hojas De Liquidación--%>

                <%--Prestamos--%>
                <ext:DesktopModule ModuleID="SolicitudesDePrestamoModule">
                    <Launcher ID="SolicitudesDePrestamoLauncher" runat="server" Text="Solicitudes de Prestamo" Icon="PageWhiteText" >
                        <Listeners>
                            <Click Handler="WindowX.solicitudesDePrestamo(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="PrestamosModule">
                    <Launcher ID="PrestamosLauncher" runat="server" Text="Prestamos" IconCls="icon-prestamos16" >
                        <Listeners>
                            <Click Handler="WindowX.prestamos(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <%--Prestamos--%>

                <%--Inventario de Cafe por Socio --%>
                <ext:DesktopModule ModuleID="ClasificacionesDeCafeModule">
                    <Launcher ID="ClasificacionesDeCafeLauncher" runat="server" Text="Clasificaciones de Café" Icon="TableGo" >
                        <Listeners>
                            <Click Handler="WindowX.clasificacionesDeCafe(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="InventarioDeCafePorSocioModule">
                    <Launcher ID="InventarioDeCafePorSocioLauncher" runat="server" Text="Inventario de Café por Socio" Icon="Bricks" >
                        <Listeners>
                            <Click Handler="WindowX.inventarioDeCafePorSocio(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <%--Inventario de Cafe por Socio --%>

                <%--Configuracion--%>
                <ext:DesktopModule ModuleID="VariablesDeEntornoModule">
                    <Launcher ID="VariablesDeEntornoLauncher" runat="server" Text="Variables de Entorno" Icon="Database" >
                        <Listeners>
                            <Click Handler="WindowX.variablesDeEntorno(#{MyDesktop});" />
                        </Listeners>
                    </Launcher>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="SettingsModule" WindowID="SettingsWin" >
                    <Launcher ID="SettingsLauncher" runat="server" Text="Configuración" Icon="Wrench" />
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="NotificacioModule" WindowID="NotificationsWin" >
                    <Launcher ID="NotificacioLauncher" runat="server" Text="Notificaciones" Icon="Mail" />
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="UsuarioActualModule" WindowID="UsuarioActualWin" >
                    <Launcher ID="UsuarioActualLauncher" runat="server" Text="Editar Usuario" Icon="UserEdit" />
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="CambiarClaveModule" WindowID="CambiarClaveWin" >
                    <Launcher ID="CambiarClaveLauncher" runat="server" Text="Cambiar Clave" Icon="Key" />
                </ext:DesktopModule>
                <%--Configuracion--%>
            </Modules>  
            
            <Shortcuts>
                <ext:DesktopShortcut ShortcutID="scUsuarios"                 Text="Usuarios"                          IconCls="shortcut-icon icon-usuarios" />
                <ext:DesktopShortcut ShortcutID="scRoles"                    Text="Roles"                             IconCls="shortcut-icon icon-roles" />
                <ext:DesktopShortcut ShortcutID="scVariablesDeEntorno"       Text="Variables de Entorno"              IconCls="shortcut-icon icon-variablesEntorno" />
                <ext:DesktopShortcut ShortcutID="scSocios"                   Text="Socios"                            IconCls="shortcut-icon icon-socios" />
                <ext:DesktopShortcut ShortcutID="scTiposDeProductos"         Text="Tipos de Productos"                IconCls="shortcut-icon icon-tiposDeProducto" />
                <ext:DesktopShortcut ShortcutID="scProductos"                Text="Productos"                         IconCls="shortcut-icon icon-productos" />
                <ext:DesktopShortcut ShortcutID="scEstadosNotasDePeso"       Text="Estados de Notas de Peso"          IconCls="shortcut-icon icon-estadosNotasDePeso" />
                <ext:DesktopShortcut ShortcutID="scNotasDePesoEnPesaje"      Text="Notas De Peso en Area de Pesaje"   IconCls="shortcut-icon icon-notasDePesoEnPesaje" />
                <ext:DesktopShortcut ShortcutID="scNotasDePesoEnCatacion"    Text="Notas De Peso en Area de Catación" IconCls="shortcut-icon icon-notasDePesoEnCatacion" />
                <ext:DesktopShortcut ShortcutID="scNotasDePeso"              Text="Notas de Peso"                     IconCls="shortcut-icon icon-notasDePeso" />
                <ext:DesktopShortcut ShortcutID="scHojasDeLiquidacion"       Text="Hojas de Liquidación"              IconCls="shortcut-icon icon-hojaDeLiquidacion" />
                <ext:DesktopShortcut ShortcutID="scSolicitudesDePrestamo"    Text="Solicitudes de Prestamo"           IconCls="shortcut-icon icon-solicitudesDePrestamo" />
                <ext:DesktopShortcut ShortcutID="scPrestamos"                Text="Prestamos"                         IconCls="shortcut-icon icon-prestamos" />
                <ext:DesktopShortcut ShortcutID="scClasificacionesDeCafe"    Text="Clasificaciones de Café"           IconCls="shortcut-icon icon-clasificacionesDeCafe" />
                <ext:DesktopShortcut ShortcutID="scInventarioDeCafePorSocio" Text="Inventario de Café por Socio"      IconCls="shortcut-icon icon-inventarioDeCafePorSocio" />
            </Shortcuts>

            <StartMenu Height="550" Width="360" ToolsWidth="127" Title="Start Menu" Icon="UserSuit">
                <ToolItems>
                    <ext:MenuItem Text="Configuración" Icon="Wrench">
                        <Listeners>
                            <Click Handler="WindowX.settings();" />
                        </Listeners>
                    </ext:MenuItem>
                    <ext:MenuItem Text="Salir" Icon="Disconnect">
                        <DirectEvents>
                            <Click OnEvent="Logout_Click" After="window.clearInterval(DesktopintervalVariable)">
                                <EventMask ShowMask="true" Msg="Adios..." MinDelay="1000" />
                            </Click>
                        </DirectEvents>
                    </ext:MenuItem>
                    <ext:MenuSeparator />
                    <ext:MenuItem Text="About" Icon="Information">
                        <Listeners>
                            <Click Handler="WindowX.about();" />
                        </Listeners>
                    </ext:MenuItem>
                </ToolItems>                
                <Items>
                    <ext:MenuItem ID="SecurityMenu" runat="server" Text="Seguridad" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem ID="UsuariosMenuItem" Text="Usuarios" Icon="User">
                                        <Listeners>
                                            <Click Handler="WindowX.usuarios(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem ID="RolesMenuItem" Text="Roles" Icon="Cog">
                                        <Listeners>
                                            <Click Handler="WindowX.roles(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuItem ID="AsociatesMenu" runat="server" Text="Socios" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem ID="SociosMenuItem" Text="Socios" Icon="Group" >
                                        <Listeners>
                                            <click Handler="WindowX.socios(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuItem ID="ProductsMenu" runat="server" Text="Productos" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem ID="TiposDeProductosMenuItem" Text="Tipos de Productos" Icon="Basket" >
                                        <Listeners>
                                            <click Handler="WindowX.tiposDeProductos(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem ID="ProductosMenuItem" Text="Productos" Icon="Cart" >
                                        <Listeners>
                                            <click Handler="WindowX.productos(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuItem ID="NotasDePesoMenu" runat="server" Text="Notas de Peso" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem ID="EstadosNotasDePesoMenuItem" Text="Estados de Notas de Peso" Icon="PageGo" >
                                        <Listeners>
                                            <click Handler="WindowX.estadosNotasDePeso(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem ID="NotasDePesoEnPesajeMenuItem" Text="Notas De Peso en Area de Pesaje" Icon="PageWhitePut" >
                                        <Listeners>
                                            <click Handler="WindowX.notasDePesoEnPesaje(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem ID="NotasDePesoEnCatacionMenuItem" Text="Notas De Peso en Area de Catacion" Icon="PageWhiteCup" >
                                        <Listeners>
                                            <click Handler="WindowX.notasDePesoEnCatacion(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem ID="NotasDePesoMenuItem" Text="Notas de Peso" Icon="PageWhiteOffice" >
                                        <Listeners>
                                            <click Handler="WindowX.notasDePeso(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuItem ID="LiquidacionesMenu" runat="server" Text="Hojas de Liquidación" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem ID="LiquidacionesMenuItem" Text="Hojas de Liquidación" Icon="Script" >
                                        <Listeners>
                                            <click Handler="WindowX.hojasDeLiquidacion(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuItem ID="PrestamosMenu" runat="server" Text="Prestamos" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem ID="SolicitudesDePrestamoMenuItem" Text="Solicitudes de Prestamo" Icon="PageWhiteText" >
                                        <Listeners>
                                            <click Handler="WindowX.solicitudesDePrestamo(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem ID="PrestamosMenuItem" Text="Prestamos" IconCls="icon-prestamos16" >
                                        <Listeners>
                                            <click Handler="WindowX.prestamos(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuItem ID="InventarioDeCafePorSocioMenu" runat="server" Text="Inventario de Café por Socio" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem ID="ClasificacionesDeCafeMenuItem" Text="Clasificaciones de Café" Icon="Cup" >
                                        <Listeners>
                                            <click Handler="WindowX.clasificacionesDeCafe(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                    <ext:MenuItem ID="InventarioDeCafePorSocioMenuItem" Text="Inventario de Café por Socio" Icon="Bricks" >
                                        <Listeners>
                                            <click Handler="WindowX.inventarioDeCafePorSocio(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuItem ID="EnvironmentMenu" runat="server" Text="Entorno" Icon="Folder" HideOnClick="false">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem ID="VariablesDeEntornoMenuItem" Text="Variables de Entorno" Icon="Database" >
                                        <Listeners>
                                            <click Handler="WindowX.variablesDeEntorno(#{MyDesktop});" />
                                        </Listeners>
                                    </ext:MenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:MenuItem>
                    <ext:MenuSeparator />
                </Items>
            </StartMenu>
        </ext:Desktop>

        <%--Desktop--%>

        <ext:DesktopWindow
            ID="SettingsWin"
            runat="server"
            Title="Configuración"
            Width="300"
            Maximizable="false"
            BodyBorder="false"
            InitCenter="false"
            Icon="Wrench"
            AutoHeight="true"
            Resizable="false"
            Shadow="None"
            Layout="AccordionLayout">
            <Items>
                <ext:Panel ID="Panel2" runat="server" Height="200" Title="Notificaciones" Layout="FitLayout">
                    <Items>
                        <ext:Portal ID="portal2" runat="server" AutoHeight="true" Header="false" Layout="Column">
                            <Items>
                                <ext:PortalColumn ID="portalcolumn1" runat="server" StyleSpec="padding:10px 10px 10px 10px"
                                    ColumnWidth="1" Layout="Anchor" Height="200" >
                                    <Items>
                                        <ext:Portlet runat="server" Title="Bandeja de Notificaciones" Selectable="true" ID="Portlet12" Draggable="false" Collapsible="false" Icon="Mail">
                                            <Items>
                                                <ext:TableLayout ID="TableLayout2" runat="server" >
                                                    <Cells>
                                                        <ext:Cell>
                                                            <ext:ImageButton ID="NotificacioneBtn" runat="server" Height="32" Width="32"
                                                                ImageUrl="../resources/images/mail_box.png">
                                                                <Listeners>
                                                                    <Click Handler="#{NotificationsWin}.show();" />
                                                                </Listeners>
                                                            </ext:ImageButton>
                                                        </ext:Cell>
                                                        <ext:Cell CellCls="labelCell">
                                                            <ext:Label ID="Label111" runat="server" Text="Ver todas las notificaciones recibidas.">
                                                                <ToolTips>
                                                                    <ext:ToolTip runat="server" Html="Presione click sobre la imagen."></ext:ToolTip>
                                                                </ToolTips>
                                                            </ext:Label>
                                                        </ext:Cell>
                                                    </Cells>
                                                </ext:TableLayout>
                                            </Items>
                                        </ext:Portlet>
                                    </Items>
                                </ext:PortalColumn>
                            </Items>
                        </ext:Portal>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" AutoHeight="true" Title="Editar Usuario" Layout="FitLayout">
                    <Items>
                        <ext:Portal ID="portal1" runat="server" AutoHeight="true" Header="false" Layout="Column">
                            <Items>
                                <ext:PortalColumn ID="portalcolumn" runat="server" StyleSpec="padding:10px 10px 10px 10px"
                                    ColumnWidth="1" Layout="Anchor" Height="150">
                                    <Items>
                                        <ext:Portlet runat="server" Title="Editar Información" Selectable="true" ID="UserInfoPortlet" Draggable="false" Collapsible="false" Icon="UserEdit">
                                            <Items>
                                                <ext:TableLayout runat="server" >
                                                    <Cells>
                                                        <ext:Cell>
                                                            <ext:ImageButton ID="UsuarioActulBtn" runat="server" Height="32" Width="32"
                                                                ImageUrl="../resources/images/user_edit.png">
                                                                <Listeners>
                                                                    <Click Handler="#{UsuarioActualWin}.show();" />
                                                                </Listeners>
                                                            </ext:ImageButton>
                                                        </ext:Cell>
                                                        <ext:Cell CellCls="labelCell">
                                                            <ext:Label ID="Label11" runat="server" Text="Permite Cambiar la información del usuario actual.">
                                                                <ToolTips>
                                                                    <ext:ToolTip runat="server" Html="Presione click sobre la imagen."></ext:ToolTip>
                                                                </ToolTips>
                                                            </ext:Label>
                                                        </ext:Cell>
                                                    </Cells>
                                                </ext:TableLayout>
                                            </Items>
                                        </ext:Portlet>
                                        <ext:Portlet runat="server" Title="Cambiar Contraseña" Selectable="true" ID="PasswordPortlet" Draggable="false" Collapsible="false" Icon="Key">
                                            <Items>
                                                <ext:TableLayout runat="server" ID="TableLayout1">
                                                    <Cells>
                                                        <ext:Cell>
                                                            <ext:ImageButton ID="CambiarClaveBtn" runat="server" Height="32" Width="32"
                                                                ImageUrl="../resources/images/key.png">
                                                                <Listeners>
                                                                    <Click Handler="#{CambiarClaveWin}.show();" />
                                                                </Listeners>
                                                            </ext:ImageButton>
                                                        </ext:Cell>
                                                        <ext:Cell CellCls="labelCell">
                                                            <ext:Label ID="Label12" runat="server" Text="Permite Cambiar la contraseña del usuario actual." >
                                                                <ToolTips>
                                                                    <ext:ToolTip runat="server" Html="Presione click sobre la imagen."></ext:ToolTip>
                                                                </ToolTips>
                                                            </ext:Label>
                                                        </ext:Cell>
                                                    </Cells>
                                                </ext:TableLayout>
                                            </Items>
                                        </ext:Portlet>
                                    </Items>
                                </ext:PortalColumn>
                            </Items>
                        </ext:Portal>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:DesktopWindow>

        <ext:Store ID="dsReport" runat="server" OnRefreshData="dsReport_Refresh" AutoLoad="false">
            <Reader>
                <ext:JsonReader IDProperty="NOTIFICACION_ID">
                    <Fields>
                        <ext:RecordField Name="NOTIFICACION_ID" />
                        <ext:RecordField Name="NOTIFICACION_ESTADO" >
                            <Convert Handler="
                            switch(value)
                            {
                                case 1: return 'Notificando';
                                case 2: return 'Leido';
                               default: return 'Creado';
                            }"
                            />
                        </ext:RecordField>
                        <ext:RecordField Name="USR_USERNAME" />
                        <ext:RecordField Name="NOTIFICACION_TITLE" />
                        <ext:RecordField Name="NOTIFICACION_MENSAJE" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
            <Listeners>
                <BeforeLoad Handler="#{NotificacionesGridP}.plugins[0].collapseAll();" />
            </Listeners>
        </ext:Store>

        <ext:DesktopWindow
            ID="NotificationsWin"
            runat="server"
            Title="Notificaciones"
            Width="480"
            Maximizable="false"
            CloseAction="Hide"
            InitCenter="true"
            Icon="Mail"
            AutoHeight="true"
            Layout="FitLayout"
            Resizable="false"
            Hidden="true">
            <TopBar>
                <ext:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <ext:Button runat="server" ID="DeleteReadNotificationBtn" Text="Eliminar Leidos" Icon="Delete">
                            <Listeners>
                                <Click Handler="DesktopX.deleteReadNotifications();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Listeners>
                <Show Handler="#{dsReport}.reload();" />
                <Hide Handler="#{dsReport}.removeAll();" />
            </Listeners>
            <Items>
                <ext:FormPanel ID="FormPanel1" runat="server" Title="Form Panel" Header="false" ButtonAlign="Right" AutoScroll="true" Layout="FormLayout" AutoHeight="true">
                    <Items>
                        <ext:Panel ID="Panel3" runat="server" Frame="false" Padding="5">
                            <Items>
                                <ext:GridPanel ID="NotificacionesGridP" runat="server" AutoExpandColumn="NOTIFICACION_TITLE"
                                    Height="250" Title="Notificaciones" Header="false" Border="true" StripeRows="true"
                                    TrackMouseOver="true" SelectionMemory="Enabled" StoreID="dsReport">
                                    <Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel2">
                                        <Columns>
                                            <ext:Column DataIndex="NOTIFICACION_ID" Header="Id" Sortable="true"></ext:Column>
                                            <ext:Column DataIndex="NOTIFICACION_ESTADO" Header="Estado" Sortable="true"></ext:Column>
                                            <ext:Column DataIndex="NOTIFICACION_TITLE" Header="Título" Sortable="true"></ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <Plugins>
                                        <ext:RowExpander ID="RowExpander1" runat="server">
                                            <Template ID="Template1" runat="server">
                                                <Html>
                                                    <div style="padding:5px;">
		                            				<b>Titulo: 
                                                        <div style="margin-left: 25px;">{NOTIFICACION_TITLE}</div>
                                                    </b>
                                                    <br />
                                                    <b>Estado: 
                                                        <div style="margin-left: 25px;">{NOTIFICACION_ESTADO}</div>
                                                    </b>
                                                    <br />
		                            				<b>Mensaje:
                                                        <div style="margin-left:25px !important; ">
                                                            {NOTIFICACION_MENSAJE}
                                                        </div>
                                                    </b>
                                                    </div>
		                            			</Html>
                                            </Template>
                                        </ext:RowExpander>
                                    </Plugins>
                                    <BottomBar>
                                        <ext:PagingToolbar ID="PagingToolbar4" runat="server" PageSize="10" StoreID="dsReport" />
                                    </BottomBar>
                                    <LoadMask ShowMask="true" />
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:FormPanel>
            </Items>
        </ext:DesktopWindow>

        <ext:Window
            ID="AboutWin"
            runat="server"
            Title="About"
            Width="300"
            Maximizable="false"
            CloseAction="Hide"
            InitCenter="true"
            Icon="Information"
            Height="200"
            Resizable="false"
            Hidden="true">
            <Content>
                Proyecto de Graduación para Ingeniería en Sistemas Computacionales.
            </Content>
        </ext:Window>

        <%--shortcuts' tooltips--%>

        <ext:ToolTip runat="server" ID="scUsuariosTooltip"                  Html="Usuarios"                          Target="scUsuarios-shortcut"                 ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scRolesTooltip"                     Html="Roles"                             Target="scRoles-shortcut"                    ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scVariablesDeEntornoTooltip"        Html="Variables de Entorno"              Target="scVariablesDeEntorno-shortcut"       ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scSociosTooltip"                    Html="Socios"                            Target="scSocios-shortcut"                   ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scTiposDeProductosTooltip"          Html="Tipos de Productos"                Target="scTiposDeProductos-shortcut"         ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scProductosTooltip"                 Html="Productos"                         Target="scProductos-shortcut"                ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scEstadosNotasDePesoTooltip"        Html="Estados de Notas de Peso"          Target="scEstadosNotasDePeso-shortcut"       ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scNotasDePesoEnPesajeTooltip"       Html="Notas De Peso en Area de Pesaje"   Target="scNotasDePesoEnPesaje-shortcut"      ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scNotasDePesoEnCatacionTooltip"     Html="Notas De Peso en Area de Catación" Target="scNotasDePesoEnCatacion-shortcut"    ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scNotasDePesoTooltip"               Html="Notas de Peso"                     Target="scNotasDePeso-shortcut"              ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scHojasDeLiquidacionTooltip"        Html="Hojas de Liquidación"              Target="scHojasDeLiquidacion-shortcut"       ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scSolicitudesDePrestamoTooltip"     Html="Solicitudes de Prestamo"           Target="scSolicitudesDePrestamo-shortcut"    ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scPrestamosTooltip"                 Html="Prestamos"                         Target="scPrestamos-shortcut"                ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scClasificacionesDeCafeTooltip"     Html="Clasificaciones de Café"           Target="scClasificacionesDeCafe-shortcut"    ></ext:ToolTip>
        <ext:ToolTip runat="server" ID="scInventarioDeCafePorSocioTooltip"  Html="Inventario de Café por Socio"      Target="scInventarioDeCafePorSocio-shortcut" ></ext:ToolTip>

        <%--shortcuts' tooltips--%>

        <usera:UsuarioActual runat="server" ID="UsuarioActualCtl" />
        <cclave:CambiarClave runat="server" ID="CambiarClaveCtl" />
    </div>
    </form>
    <a href="http://www.unitec.edu" target="_blank" alt="Powered by Ext .Net"id="poweredby"> <div></div> </a>
</body>
</html>
