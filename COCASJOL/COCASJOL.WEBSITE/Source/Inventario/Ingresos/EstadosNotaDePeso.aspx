﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EstadosNotaDePeso.aspx.cs" Inherits="COCASJOL.WEBSITE.Source.Inventario.Ingresos.EstadosNotaDePeso" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="~/Source/Auditoria/Auditoria.ascx" TagPrefix="aud" TagName="Auditoria" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Estados de Notas De Peso</title>
    <script type="text/javascript" src="../../../resources/js/inventario/ingresos/estadosNotaDePeso.js" ></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <ext:ResourceManager ID="ResourceManager1" runat="server"  DisableViewState="true" >
            <Listeners>
                <DocumentReady Handler="PageX.setReferences();" />
            </Listeners>
        </ext:ResourceManager>

        <ext:KeyNav ID="KeyNav1" runat="server" Target="={document.body}" >
            <Home Handler="PageX.navHome();" />
            <PageUp Handler="PageX.navPrev();" />
            <PageDown Handler="PageX.navNext();" />
            <End Handler="PageX.navEnd();" />
        </ext:KeyNav>

        <aud:Auditoria runat="server" ID="AudWin" />

        <asp:ObjectDataSource ID="EstadosNotaDS" runat="server"
                TypeName="COCASJOL.LOGIC.Inventario.Ingresos.EstadoNotaDePesoLogic"
                SelectMethod="GetEstadosNotaDePeso"
                UpdateMethod="ActualizarEstadoNotaDePeso"
                DeleteMethod="EliminarEstadoNotaDePeso" onselecting="EstadosNotaDS_Selecting" >
                <SelectParameters>
                    <asp:ControlParameter Name="ESTADOS_NOTA_ID"               Type="Int32"    ControlID="f_ESTADOS_NOTA_ID"          PropertyName="Text" />
                    <asp:ControlParameter Name="ESTADOS_NOTA_SIGUIENTE"        Type="Int32"    ControlID="f_ESTADOS_NOTA_SIGUIENTE"   PropertyName="Text" />
                    <asp:ControlParameter Name="ESTADOS_NOTA_SIGUIENTE_NOMBRE" Type="String"   ControlID="nullHdn"                    PropertyName="Text" />
                    <asp:ControlParameter Name="ESTADOS_NOTA_LLAVE"            Type="String"   ControlID="f_ESTADOS_NOTA_LLAVE"       PropertyName="Text" />
                    <asp:ControlParameter Name="ESTADOS_NOTA_NOMBRE"           Type="String"   ControlID="f_ESTADOS_NOTA_NOMBRE"      PropertyName="Text" />
                    <asp:ControlParameter Name="ESTADOS_NOTA_DESCRIPCION"      Type="String"   ControlID="nullHdn"                    PropertyName="Text" />
                    <asp:ControlParameter Name="CREADO_POR"                    Type="String"   ControlID="nullHdn"                    PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="FECHA_CREACION"                Type="DateTime" ControlID="nullHdn"                    PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="MODIFICADO_POR"                Type="String"   ControlID="nullHdn"                    PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="FECHA_MODIFICACION"            Type="DateTime" ControlID="nullHdn"                    PropertyName="Text" DefaultValue="" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ESTADOS_NOTA_ID"               Type="Int32" />
                    <asp:Parameter Name="ESTADOS_NOTA_SIGUIENTE"        Type="Int32" />
                    <asp:Parameter Name="ESTADOS_NOTA_SIGUIENTE_NOMBRE" Type="String" />
                    <asp:Parameter Name="ESTADOS_NOTA_LLAVE"            Type="String" />
                    <asp:Parameter Name="ESTADOS_NOTA_NOMBRE"           Type="String" />
                    <asp:Parameter Name="ESTADOS_NOTA_DESCRIPCION"      Type="String" />
                    <asp:Parameter Name="CREADO_POR"                    Type="String" />
                    <asp:Parameter Name="FECHA_CREACION"                Type="DateTime" />
                    <asp:Parameter Name="MODIFICADO_POR"                Type="String" />
                    <asp:Parameter Name="FECHA_MODIFICACION"            Type="DateTime" />
                </UpdateParameters>
        </asp:ObjectDataSource>

        <asp:ObjectDataSource ID="EstadosNotaFiltrosDS" runat="server"
                TypeName="COCASJOL.LOGIC.Inventario.Ingresos.EstadoNotaDePesoLogic"
                SelectMethod="GetEstadosNotaDePeso" >
        </asp:ObjectDataSource>

        <ext:Store ID="EstadosNotaFiltrosSt" runat="server" DataSourceID="EstadosNotaFiltrosDS">
            <Reader>
                <ext:JsonReader IDProperty="ESTADOS_NOTA_ID">
                    <Fields>
                        <ext:RecordField Name="ESTADOS_NOTA_ID" />
                        <ext:RecordField Name="ESTADOS_NOTA_NOMBRE" />
                        <ext:RecordField Name="ESTADOS_NOTA_LLAVE" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>

        <ext:Store ID="EstadosNotaPadreSt" runat="server" OnRefreshData="EstadosNotaPadreSt_Refresh">
            <Reader>
                <ext:JsonReader IDProperty="ESTADOS_NOTA_ID">
                    <Fields>
                        <ext:RecordField Name="ESTADOS_NOTA_ID" />
                        <ext:RecordField Name="ESTADOS_NOTA_NOMBRE" />
                        <ext:RecordField Name="ESTADOS_NOTA_LLAVE" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        
        <ext:Hidden ID="nullHdn" runat="server" >
        </ext:Hidden>

        <ext:Hidden ID="LoggedUserHdn" runat="server" >
        </ext:Hidden>

        <ext:Viewport ID="Viewport1" runat="server" Layout="FitLayout">
            <Items>
                <ext:Panel ID="Panel1" runat="server" Frame="false" Header="false" Title="Estados de Nota de Peso" Icon="TableGo" Layout="Fit">
                    <Items>
                        <ext:GridPanel ID="EstadosNotaGridP" runat="server" AutoExpandColumn="ESTADOS_NOTA_NOMBRE" Height="300"
                            Title="Usuarios" Header="false" Border="false" StripeRows="true" TrackMouseOver="true">
                            <Store>
                                <ext:Store ID="EstadosNotaSt" runat="server" DataSourceID="EstadosNotaDS" AutoSave="true" SkipIdForNewRecords="false" >
                                    <Reader>
                                        <ext:JsonReader IDProperty="ESTADOS_NOTA_ID">
                                            <Fields>
                                                <ext:RecordField Name="ESTADOS_NOTA_ID"           />
                                                <ext:RecordField Name="ESTADOS_NOTA_SIGUIENTE"        />
                                                <ext:RecordField Name="ESTADOS_NOTA_SIGUIENTE_NOMBRE" ServerMapping="estados_nota_de_peso_siguiente.ESTADOS_NOTA_LLAVE" />
                                                <ext:RecordField Name="ESTADOS_NOTA_LLAVE"        />
                                                <ext:RecordField Name="ESTADOS_NOTA_NOMBRE"       />
                                                <ext:RecordField Name="ESTADOS_NOTA_DESCRIPCION"  />
                                                <ext:RecordField Name="CREADO_POR"                />
                                                <ext:RecordField Name="FECHA_CREACION"            Type="Date" />
                                                <ext:RecordField Name="MODIFICADO_POR"            />
                                                <ext:RecordField Name="FECHA_MODIFICACION"        Type="Date" />
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                    <Listeners>
                                        <CommitDone Handler="Ext.Msg.alert('Guardar', 'Cambios guardados exitosamente.');" />
                                    </Listeners>
                                </ext:Store>
                            </Store>
                            <ColumnModel>
                                <Columns>
                                    <ext:Column DataIndex="ESTADOS_NOTA_ID"           Header="Id" Sortable="true"></ext:Column>
                                    <ext:Column DataIndex="ESTADOS_NOTA_LLAVE"        Header="Llave" Sortable="true" Width="150"></ext:Column>
                                    <ext:Column DataIndex="ESTADOS_NOTA_NOMBRE"       Header="Nombre" Sortable="true" Width="150"></ext:Column>
                                    <ext:Column DataIndex="ESTADOS_NOTA_SIGUIENTE_NOMBRE" Header="Estado Siguiente" Sortable="true"></ext:Column>
                                    <ext:Column DataIndex="ESTADOS_NOTA_ID" Width="28" Sortable="false" MenuDisabled="true" Header="&nbsp;" Fixed="true">
                                        <Renderer Handler="return '';" />
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
                            </SelectionModel>
                            <TopBar>
                                <ext:Toolbar ID="Toolbar1" runat="server">
                                    <Items>
                                        <ext:Button ID="EditarBtn" runat="server" Text="Editar" Icon="PageEdit">
                                            <Listeners>
                                                <Click Handler="PageX.edit();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:ToolbarFill ID="ToolbarFill1" runat="server" />
                                        <ext:Button ID="AuditoriaBtn" runat="server" Text="Auditoria" Icon="Cog">
                                            <Listeners>
                                                <Click Handler="PageX.showAudit();" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <View>
                                <ext:GridView ID="GridView1" runat="server">
                                    <HeaderRows>
                                        <ext:HeaderRow>
                                            <Columns>
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:NumberField ID="f_ESTADOS_NOTA_ID" runat="server" EnableKeyEvents="true" Icon="Find">
                                                            <Listeners>
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                            </Listeners>
                                                        </ext:NumberField>
                                                    </Component>
                                                </ext:HeaderColumn>
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:TextField ID="f_ESTADOS_NOTA_LLAVE" runat="server" EnableKeyEvents="true" Icon="Find" MaxLength="25">
                                                            <Listeners>
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                            </Listeners>
                                                        </ext:TextField>
                                                    </Component>
                                                </ext:HeaderColumn>
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:TextField ID="f_ESTADOS_NOTA_NOMBRE" runat="server" EnableKeyEvents="true" Icon="Find" MaxLength="45">
                                                            <Listeners>
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                            </Listeners>
                                                        </ext:TextField>
                                                    </Component>
                                                </ext:HeaderColumn>
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:ComboBox
                                                            ID="f_ESTADOS_NOTA_SIGUIENTE" 
                                                            runat="server"
                                                            Icon="Find"
                                                            AllowBlank="true"
                                                            ForceSelection="true"
                                                            StoreID="EstadosNotaFiltrosSt"
                                                            ValueField="ESTADOS_NOTA_ID" 
                                                            DisplayField="ESTADOS_NOTA_LLAVE" 
                                                            Mode="Local"
                                                            TypeAhead="true">
                                                            <Triggers>
                                                                <ext:FieldTrigger Icon="Clear"/>
                                                            </Triggers>
                                                            <Listeners>
                                                                <Select Handler="PageX.reloadGridStore();" />
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                                <TriggerClick Handler="this.clearValue();" />
                                                            </Listeners>
                                                        </ext:ComboBox>
                                                    </Component>
                                                </ext:HeaderColumn>
                                                               
                                                <ext:HeaderColumn AutoWidthElement="false">
                                                    <Component>
                                                        <ext:Button ID="ClearFilterButton" runat="server" Icon="Cancel">
                                                            <ToolTips>
                                                                <ext:ToolTip ID="ToolTip4" runat="server" Html="Clear filter" />
                                                            </ToolTips>
                                                            <Listeners>
                                                                <Click Handler="PageX.clearFilter();" />
                                                            </Listeners>                                            
                                                        </ext:Button>
                                                    </Component>
                                                </ext:HeaderColumn>
                                            </Columns>
                                        </ext:HeaderRow>
                                    </HeaderRows>
                                </ext:GridView>
                            </View>
                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="20" StoreID="EstadosNotaSt" />
                            </BottomBar>
                            <LoadMask ShowMask="true" />
                            <SaveMask ShowMask="true" />
                            <Listeners>
                                <RowDblClick Handler="PageX.edit();" />
                            </Listeners>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>

        <ext:Window ID="EditarEstadosNotaWin"
            runat="server"
            Hidden="true"
            Icon="PageEdit"
            Title="Editar Estado de Nota de Peso"
            Width="500"
            Layout="FormLayout"
            AutoHeight="True"
            Resizable="false"
            Shadow="None"
            Modal="true"
            X="10" Y="30">
            <Items>
                <ext:FormPanel ID="EditarEstadosNotaFormP" runat="server" Title="Form Panel" Header="false" ButtonAlign="Right" MonitorValid="true" LabelWidth="120">
                    <Listeners>
                        <Show Handler="this.getForm().reset();" />
                    </Listeners>
                    <Items>
                        <ext:Panel ID="Panel12" runat="server" Title="Información" Layout="AnchorLayout" AutoHeight="True"
                            Resizable="false">
                            <Listeners>
                                <Activate Handler="ShowButtons();" />
                            </Listeners>
                            <Items>
                                <ext:Panel ID="Panel13" runat="server" Frame="false" Padding="5" Layout="AnchorLayout" Border="false">
                                    <Items>
                                        <ext:NumberField runat="server" ID="EditIdTxt"            DataIndex="ESTADOS_NOTA_ID"          LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Id de Estado" AllowBlank="false" ReadOnly="true" Hidden="true"></ext:NumberField>
                                        <ext:TextField runat="server"   ID="EditLlaveTxt"         DataIndex="ESTADOS_NOTA_LLAVE"       LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Llave" ReadOnly="true">
                                            <ToolTips>
                                                <ext:ToolTip ID="ToolTip1" runat="server" Html="La llave de estado es de solo lectura." Title="Llave de Estado" Width="200" TrackMouse="true" />
                                            </ToolTips>
                                        </ext:TextField>
                                        <ext:TextField runat="server"   ID="EditNombreTxt"        DataIndex="ESTADOS_NOTA_NOMBRE"      LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Nombre" AllowBlank="false" MsgTarget="Side" MaxLength="45" ></ext:TextField>
                                        <ext:TextField runat="server"   ID="EditDescripcionTxt"   DataIndex="ESTADOS_NOTA_DESCRIPCION" LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Descripción" MaxLength="100"></ext:TextField>
                                        <ext:ComboBox runat="server"    ID="EditPadreIdCmb"       DataIndex="ESTADOS_NOTA_SIGUIENTE"       LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Estado Siguiente" MsgTarget="Side"
                                            StoreID="EstadosNotaPadreSt"
                                            ValueField="ESTADOS_NOTA_ID" 
                                            DisplayField="ESTADOS_NOTA_LLAVE"
                                            ForceSelection="true"
                                            Mode="Local"
                                            TypeAhead="true">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                            </Triggers>
                                            <Listeners>
                                                <BeforeQuery Handler="this.triggers[0][ this.getRawValue().toString().length == 0 ? 'hide' : 'show']();" />
                                                <TriggerClick Handler="if (index == 0) { this.focus().clearValue(); trigger.hide();}" />
                                                <Select Handler="this.triggers[0].show();" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:TextField runat="server"   ID="EditCreatedByTxt"     DataIndex="CREADO_POR"               LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Creado_por" Hidden="true" ></ext:TextField>
                                        <ext:TextField runat="server"   ID="EditCreationDateTxt"  DataIndex="FECHA_CREACION"           LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Fecha de Creacion" Hidden="true" ></ext:TextField>
                                        <ext:TextField runat="server"   ID="EditModifiedByTxt"    DataIndex="MODIFICADO_POR"           LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Modificado por" Hidden="true" ></ext:TextField>
                                        <ext:TextField runat="server"   ID="EditModificationDate" DataIndex="FECHA_MODIFICACION"       LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Fecha de Modificacion" Hidden="true" ></ext:TextField>
                                    </Items>
                                </ext:Panel>
                            </Items>
                        </ext:Panel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="EditPreviousBtn" runat="server" Text="Anterior" Icon="PreviousGreen">
                            <Listeners>
                                <Click Handler="PageX.previous();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="EditNextBtn" runat="server" Text="Siguiente" Icon="NextGreen">
                            <Listeners>
                                <Click Handler="PageX.next();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="EditGuardarBtn" runat="server" Text="Guardar" Icon="Disk" FormBind="true">
                            <Listeners>
                                <Click Handler="#{EditModifiedByTxt}.setValue(#{LoggedUserHdn}.getValue()); PageX.update();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:FormPanel>
            </Items>
        </ext:Window>
    </div>
    </form>
</body>
</html>
