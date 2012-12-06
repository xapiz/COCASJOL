﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="COCASJOL.WEBSITE.Source.Productos.Productos" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript">
        var Grid = null;
        var GridStore = null;
        var AddWindow = null;
        var AddForm = null; 
        var EditWindow = null;
        var EditForm = null;

        var AlertSelMsgTitle = "Atención";
        var AlertSelMsg = "Debe seleccionar 1 elemento";

        var ConfirmMsgTitle = "Producto";
        var ConfirmUpdate = "Seguro desea modificar el producto?";
        var ConfirmDelete = "Seguro desea eliminar el producto?";

        var PageX = {
            _index: 0,

            setReferences: function () {
                Grid = ProductosGridP;
                GridStore = ProductosSt;
                AddWindow = AgregarProductosWin;
                AddForm = AddTipoFormP;
                EditWindow = EditarProductosWin;
                EditForm = EditarTipoFormP;
            },

            add: function () {
                AddWindow.show();
            },

            insert: function () {
                var fields = AddForm.getForm().getFieldValues(false, "dataIndex");

                Grid.insertRecord(0, fields, false);
                AddForm.getForm().reset();
            },

            getIndex: function () {
                return this._index;
            },

            setIndex: function (index) {
                if (index > -1 && index < Grid.getStore().getCount()) {
                    this._index = index;
                }
            },

            getRecord: function () {
                var rec = Grid.getStore().getAt(this.getIndex());  // Get the Record

                if (rec != null) {
                    return rec;
                }
            },

            edit: function () {
                if (Grid.getSelectionModel().hasSelection()) {
                    var record = Grid.getSelectionModel().getSelected();
                    var index = Grid.store.indexOf(record);
                    this.setIndex(index);
                    this.open();
                } else {
                    var msg = Ext.Msg;
                    Ext.Msg.alert(AlertSelMsgTitle, AlertSelMsg);
                }
            },

            edit2: function (index) {
                this.setIndex(index);
                this.open();
            },

            next: function () {
                this.edit2(this.getIndex() + 1);
            },

            previous: function () {
                this.edit2(this.getIndex() - 1);
            },

            open: function () {
                rec = this.getRecord();

                if (rec != null) {
                    EditWindow.show();
                    EditForm.getForm().loadRecord(rec);
                    EditForm.record = rec;
                }
            },

            update: function () {
                if (EditForm.record == null) {
                    return;
                }

                Ext.Msg.confirm(ConfirmMsgTitle, ConfirmUpdate, function (btn, text) {
                    if (btn == 'yes') {
                        EditForm.getForm().updateRecord(EditForm.record);
                    }
                });
            },

            remove: function () {
                if (Grid.getSelectionModel().hasSelection()) {
                    Ext.Msg.confirm(ConfirmMsgTitle, ConfirmDelete, function (btn, text) {
                        if (btn == 'yes') {
                            var record = Grid.getSelectionModel().getSelected();
                            Grid.deleteRecord(record);
                        }
                    });
                } else {
                    var msg = Ext.Msg;
                    Ext.Msg.alert(AlertSelMsgTitle, AlertSelMsg);
                }
            },

            keyUpEvent: function (sender, e) {
                if (e.getKey() == 13)
                    GridStore.reload();
            },

            reloadGridStore: function () {
                GridStore.reload();
            }
        };

        var HideButtons = function () {
            EditPreviousBtn.hide();
            EditNextBtn.hide();
            EditGuardarBtn.hide();
        }

        var ShowButtons = function () {
            EditPreviousBtn.show();
            EditNextBtn.show();
            EditGuardarBtn.show();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <ext:ResourceManager ID="ResourceManager1" runat="server">
            <Listeners>
                <DocumentReady Handler="PageX.setReferences();" />
            </Listeners>
        </ext:ResourceManager>

        <asp:ObjectDataSource ID="ProductosDS" runat="server"
                TypeName="COCASJOL.LOGIC.Productos.ProductoLogic"
                SelectMethod="GetProductos"
                InsertMethod="InsertarProducto"
                UpdateMethod="ActualizarProducto"
                DeleteMethod="EliminarProducto" onselecting="ProductosDS_Selecting" >
                <SelectParameters>
                    <asp:ControlParameter Name="PRODUCTOS_ID"           Type="Int32"    ControlID="f_PRODUCTOS_ID"           PropertyName="Text" DefaultValue="-1" />
                    <asp:ControlParameter Name="TIPOS_PROD_ID"          Type="Int32"    ControlID="f_TIPOS_PROD_ID"          PropertyName="Text" DefaultValue="-1" />
                    <asp:ControlParameter Name="TIPOS_PROD_NOMBRE"      Type="String"   ControlID="nullHdn"                  PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="PRODUCTOS_NOMBRE"       Type="String"   ControlID="f_PRODUCTOS_NOMBRE"       PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="PRODUCTOS_DESCRIPCION"  Type="String"   ControlID="f_PRODUCTOS_DESCRIPCION"  PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="PRODUCTOS_CANTIDAD_MIN" Type="Int32"    ControlID="f_PRODUCTOS_CANTIDAD_MIN" PropertyName="Text" DefaultValue="-1"/>
                    <asp:ControlParameter Name="PRODUCTOS_EXISTENCIA"   Type="Int32"    ControlID="f_PRODUCTOS_EXISTENCIA"   PropertyName="Text" DefaultValue="-1"/>
                    <asp:ControlParameter Name="CREADO_POR"             Type="String"   ControlID="nullHdn"                  PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="FECHA_CREACION"         Type="DateTime" ControlID="nullHdn"                  PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="MODIFICADO_POR"         Type="String"   ControlID="nullHdn"                  PropertyName="Text" DefaultValue="" />
                    <asp:ControlParameter Name="FECHA_MODIFICACION"     Type="DateTime" ControlID="nullHdn"                  PropertyName="Text" DefaultValue="" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="PRODUCTOS_ID"           Type="Int32" />
                    <asp:Parameter Name="TIPOS_PROD_ID"          Type="Int32" />
                    <asp:Parameter Name="TIPOS_PROD_NOMBRE"      Type="String" />
                    <asp:Parameter Name="PRODUCTOS_NOMBRE"       Type="String" />
                    <asp:Parameter Name="PRODUCTOS_DESCRIPCION"  Type="String" />
                    <asp:Parameter Name="PRODUCTOS_CANTIDAD_MIN" Type="Int32" />
                    <asp:Parameter Name="PRODUCTOS_EXISTENCIA"   Type="Int32" />
                    <asp:Parameter Name="CREADO_POR"             Type="String" />
                    <asp:Parameter Name="FECHA_CREACION"         Type="DateTime" />
                    <asp:Parameter Name="MODIFICADO_POR"         Type="String" />
                    <asp:Parameter Name="FECHA_MODIFICACION"     Type="DateTime" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PRODUCTOS_ID"           Type="Int32" />
                    <asp:Parameter Name="TIPOS_PROD_ID"          Type="Int32" />
                    <asp:Parameter Name="TIPOS_PROD_NOMBRE"      Type="String" />
                    <asp:Parameter Name="PRODUCTOS_NOMBRE"       Type="String" />
                    <asp:Parameter Name="PRODUCTOS_DESCRIPCION"  Type="String" />
                    <asp:Parameter Name="PRODUCTOS_CANTIDAD_MIN" Type="Int32" />
                    <asp:Parameter Name="PRODUCTOS_EXISTENCIA"   Type="Int32" />
                    <asp:Parameter Name="CREADO_POR"             Type="String" />
                    <asp:Parameter Name="FECHA_CREACION"         Type="DateTime" />
                    <asp:Parameter Name="MODIFICADO_POR"         Type="String" />
                    <asp:Parameter Name="FECHA_MODIFICACION"     Type="DateTime" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="PRODUCTOS_ID" Type="Int32" />
                </DeleteParameters>
        </asp:ObjectDataSource>

        <asp:ObjectDataSource ID="TiposProductoDS" runat="server"
                TypeName="COCASJOL.LOGIC.Productos.TipoDeProductoLogic"
                SelectMethod="GetTiposDeProducto">
        </asp:ObjectDataSource>

        <ext:Store ID="TiposDeProductoSt" runat="server" DataSourceID="TiposProductoDS" SkipIdForNewRecords="false">
            <Reader>
                <ext:JsonReader IDProperty="TIPOS_PROD_ID">
                    <Fields>
                        <ext:RecordField Name="TIPOS_PROD_ID" />
                        <ext:RecordField Name="TIPOS_PROD_NOMBRE" />
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
                <ext:Panel ID="Panel1" runat="server" Frame="false" Header="false" Title="Productos" Icon="Basket" Layout="Fit">
                    <Items>
                        <ext:GridPanel ID="ProductosGridP" runat="server" AutoExpandColumn="PRODUCTOS_DESCRIPCION" Height="300"
                            Title="Usuarios" Header="false" Border="false" StripeRows="true" TrackMouseOver="true">
                            <Store>
                                <ext:Store ID="ProductosSt" runat="server" DataSourceID="ProductosDS" AutoSave="true" SkipIdForNewRecords="false" >
                                    <Reader>
                                        <ext:JsonReader IDProperty="PRODUCTOS_ID">
                                            <Fields>
                                                <ext:RecordField Name="PRODUCTOS_ID"           />
                                                <ext:RecordField Name="TIPOS_PROD_ID"          />
                                                <ext:RecordField Name="TIPOS_PROD_NOMBRE"      ServerMapping="tipos_productos.TIPOS_PROD_NOMBRE" />
                                                <ext:RecordField Name="PRODUCTOS_NOMBRE"       />
                                                <ext:RecordField Name="PRODUCTOS_DESCRIPCION"  />
                                                <ext:RecordField Name="PRODUCTOS_CANTIDAD_MIN" />
                                                <ext:RecordField Name="PRODUCTOS_EXISTENCIA"   />
                                                <ext:RecordField Name="CREADO_POR"             />
                                                <ext:RecordField Name="FECHA_CREACION"         Type="Date" />
                                                <ext:RecordField Name="MODIFICADO_POR"         />
                                                <ext:RecordField Name="FECHA_MODIFICACION"     Type="Date" />
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
                                    <ext:Column DataIndex="PRODUCTOS_ID"           Header="Id" Sortable="true"></ext:Column>
                                    <ext:Column DataIndex="TIPOS_PROD_NOMBRE"      Header="Tipo de Producto" Sortable="true"></ext:Column>
                                    <ext:Column DataIndex="PRODUCTOS_NOMBRE"       Header="Nombre" Sortable="true" Width="150"></ext:Column>
                                    <ext:Column DataIndex="PRODUCTOS_DESCRIPCION"  Header="Descripción" Sortable="true"></ext:Column>
                                    <ext:Column DataIndex="PRODUCTOS_CANTIDAD_MIN" Header="Cantidad Minima" Sortable="true"></ext:Column>
                                    <ext:Column DataIndex="PRODUCTOS_EXISTENCIA"   Header="Existencia" Sortable="true"></ext:Column>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
                            </SelectionModel>
                            <TopBar>
                                <ext:Toolbar ID="Toolbar1" runat="server">
                                    <Items>
                                        <ext:Button ID="AgregarBtn" runat="server" Text="Agregar" Icon="CartAdd" >
                                            <Listeners>
                                                <Click Handler="PageX.add();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="EditarBtn" runat="server" Text="Editar" Icon="CartEdit">
                                            <Listeners>
                                                <Click Handler="PageX.edit();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="EliminarBtn" runat="server" Text="Eliminar" Icon="CartDelete">
                                            <Listeners>
                                                <Click Handler="PageX.remove();" />
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
                                                        <ext:NumberField ID="f_PRODUCTOS_ID" runat="server" EnableKeyEvents="true" Icon="Find">
                                                            <Listeners>
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                            </Listeners>
                                                        </ext:NumberField>
                                                    </Component>
                                                </ext:HeaderColumn>
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:ComboBox
                                                            ID="f_TIPOS_PROD_ID" 
                                                            runat="server"
                                                            Icon="Find"
                                                            StoreID="TiposDeProductoSt"
                                                            DataIndex="TIPOS_PROD_ID"
                                                            ValueField="TIPOS_PROD_ID" 
                                                            DisplayField="TIPOS_PROD_NOMBRE" 
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
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:TextField ID="f_PRODUCTOS_NOMBRE" runat="server" EnableKeyEvents="true" Icon="Find">
                                                            <Listeners>
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                            </Listeners>
                                                        </ext:TextField>
                                                    </Component>
                                                </ext:HeaderColumn>
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:TextField ID="f_PRODUCTOS_DESCRIPCION" runat="server" EnableKeyEvents="true" Icon="Find">
                                                            <Listeners>
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                            </Listeners>
                                                        </ext:TextField>
                                                    </Component>
                                                </ext:HeaderColumn>
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:NumberField ID="f_PRODUCTOS_CANTIDAD_MIN" runat="server" EnableKeyEvents="true" Icon="Find">
                                                            <Listeners>
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                            </Listeners>
                                                        </ext:NumberField>
                                                    </Component>
                                                </ext:HeaderColumn>
                                                <ext:HeaderColumn Cls="x-small-editor">
                                                    <Component>
                                                        <ext:NumberField ID="f_PRODUCTOS_EXISTENCIA" runat="server" EnableKeyEvents="true" Icon="Find">
                                                            <Listeners>
                                                                <KeyUp Handler="PageX.keyUpEvent(this, e);" />
                                                            </Listeners>
                                                        </ext:NumberField>
                                                    </Component>
                                                </ext:HeaderColumn>
                                            </Columns>
                                        </ext:HeaderRow>
                                    </HeaderRows>
                                </ext:GridView>
                            </View>
                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="20" StoreID="ProductosSt" />
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

        <ext:Window ID="AgregarProductosWin"
            runat="server"
            Hidden="true"
            Icon="CartAdd"
            Title="Agregar Tipo de Producto"
            Width="500"
            Layout="FormLayout"
            AutoHeight="True"
            Resizable="false"
            Shadow="None"
            Modal="true"
            X="10" Y="30">
            <Items>
                <ext:FormPanel ID="AddTipoFormP" runat="server" Title="Form Panel" Header="false" ButtonAlign="Right" MonitorValid="true" LabelWidth="120">
                    <Listeners>
                        <Show Handler="this.getForm().reset();" />
                    </Listeners>
                    <Items>
                        <ext:Panel ID="Panel2" runat="server" Title="Información" Layout="AnchorLayout" AutoHeight="True"
                            Resizable="false">
                            <Items>
                                <ext:Panel ID="Panel3" runat="server" Frame="false" Padding="5" Layout="AnchorLayout" Border="false">
                                    <Items>
                                        <ext:ComboBox runat="server"    ID="AddTipoDeProdIdCmb"     DataIndex="TIPOS_PROD_ID"          LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Tipo de Producto" AllowBlank="false" MsgTarget="Side"
                                            StoreID="TiposDeProductoSt"
                                            ValueField="TIPOS_PROD_ID" 
                                            DisplayField="TIPOS_PROD_NOMBRE" 
                                            Mode="Local"
                                            TypeAhead="true">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.clearValue();" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:NumberField runat="server" ID="AddIdTxt"               DataIndex="PRODUCTOS_ID"           LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Id de Producto" AllowBlank="false" Text="0" Hidden="true" ReadOnly="true"></ext:NumberField>
                                        <ext:TextField   runat="server" ID="AddNombreTxt"           DataIndex="PRODUCTOS_NOMBRE"       LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Nombre" AllowBlank="false" MsgTarget="Side" MaxLength="45" IsRemoteValidation="true">
                                            <RemoteValidation OnValidation="AddNombreTxt_Validate" />
                                        </ext:TextField>
                                        <ext:TextField   runat="server" ID="AddDescripcionTxt"      DataIndex="PRODUCTOS_DESCRIPCION"  LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Descripción" MaxLength="100"></ext:TextField>
                                        <ext:NumberField runat="server" ID="AddCantidadMinTxt"      DataIndex="PRODUCTOS_CANTIDAD_MIN" LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Cantidad Minima" AllowBlank="false" AllowNegative="false" ></ext:NumberField>
                                        <ext:NumberField runat="server" ID="AddExistenciaTxt"       DataIndex="PRODUCTOS_EXISTENCIA"   LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Existencia Inicial" AllowBlank="false" AllowNegative="false" ></ext:NumberField>
                                        <ext:TextField   runat="server" ID="AddCreatedByTxt"        DataIndex="CREADO_POR"             LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Creado por" Hidden="true" ></ext:TextField>
                                        <ext:TextField   runat="server" ID="AddCreatedDateTxt"      DataIndex="FECHA_CREACION"         LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Fecha de Creacion" Hidden="true" ></ext:TextField>
                                        <ext:TextField   runat="server" ID="AddModifiedByTxt"       DataIndex="MODIFICADO_POR"         LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Modificado por" Hidden="true" ></ext:TextField>
                                        <ext:TextField   runat="server" ID="AddModificationDateTxt" DataIndex="FECHA_MODIFICACION"     LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Fecha de Modificacion" Hidden="true" ></ext:TextField>
                                    </Items>
                                </ext:Panel>
                            </Items>
                        </ext:Panel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="AddGuardarBtn" runat="server" Text="Guardar" Icon="Disk" FormBind="true">
                            <Listeners>
                                <Click Handler="#{AddCreatedByTxt}.setValue(#{LoggedUserHdn}.getValue()); PageX.insert();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:FormPanel>
            </Items>
        </ext:Window>

        <ext:Window ID="EditarProductosWin"
            runat="server"
            Hidden="true"
            Icon="CartEdit"
            Title="Editar Tipo de Producto"
            Width="500"
            Layout="FormLayout"
            AutoHeight="True"
            Resizable="false"
            Shadow="None"
            Modal="true"
            X="10" Y="30">
            <Items>
                <ext:FormPanel ID="EditarTipoFormP" runat="server" Title="Form Panel" Header="false" ButtonAlign="Right" MonitorValid="true" LabelWidth="120">
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
                                        <ext:NumberField runat="server" ID="EditIdTxt"            DataIndex="PRODUCTOS_ID"          LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Id de Producto" AllowBlank="false" ReadOnly="true">
                                            <ToolTips>
                                                <ext:ToolTip ID="ToolTip1" runat="server" Title="Id de Producto" Html="El Id de Producto es de solo lectura." Width="200" TrackMouse="true" />
                                            </ToolTips>
                                        </ext:NumberField>
                                        <ext:ComboBox runat="server"    ID="EditTipoDeProdIdCmb"  DataIndex="TIPOS_PROD_ID"          LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Tipo de Producto" AllowBlank="false" MsgTarget="Side"
                                            StoreID="TiposDeProductoSt" 
                                            ValueField="TIPOS_PROD_ID" 
                                            DisplayField="TIPOS_PROD_NOMBRE" 
                                            Mode="Local"
                                            TypeAhead="true">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.clearValue();" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:TextField runat="server"   ID="EditNombreTxt"        DataIndex="PRODUCTOS_NOMBRE"       LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Nombre" AllowBlank="false" MsgTarget="Side" MaxLength="45" IsRemoteValidation="true">
                                            <RemoteValidation OnValidation="EditNombreTxt_Validate" />
                                        </ext:TextField>
                                        <ext:TextField runat="server"   ID="EditDescripcionTxt"   DataIndex="PRODUCTOS_DESCRIPCION"  LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Descripción" MaxLength="100"></ext:TextField>
                                        <ext:NumberField runat="server" ID="EditCantidadMinTxt"   DataIndex="PRODUCTOS_CANTIDAD_MIN" LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Cantidad Minima" AllowBlank="false" AllowNegative="false" ></ext:NumberField>
                                        <ext:NumberField runat="server" ID="EditExistenciaTxt"    DataIndex="PRODUCTOS_EXISTENCIA"   LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Existencia Inicial" AllowBlank="false" AllowNegative="false" ></ext:NumberField>
                                        <ext:TextField runat="server"   ID="EditCreatedByTxt"     DataIndex="CREADO_POR"             LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Creado_por" Hidden="true" ></ext:TextField>
                                        <ext:TextField runat="server"   ID="EditCreationDateTxt"  DataIndex="FECHA_CREACION"         LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Fecha de Creacion" Hidden="true" ></ext:TextField>
                                        <ext:TextField runat="server"   ID="EditModifiedByTxt"    DataIndex="MODIFICADO_POR"         LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Modificado por" Hidden="true" ></ext:TextField>
                                        <ext:TextField runat="server"   ID="EditModificationDate" DataIndex="FECHA_MODIFICACION"     LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Fecha de Modificacion" Hidden="true" ></ext:TextField>
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