﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CambiarClave.ascx.cs" Inherits="COCASJOL.Website.Source.Seguridad.CambiarClave" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

    <script type="text/javascript" src="../../resources/js/md5.js"></script>
    <script type="text/javascript">
        PageX = {
            updatePassword: function () {
                var encryptedChallenge = faultylabs.MD5(CambiarClaveActualConfirmarTxt.getValue());

                if (CambiarClaveActualTxt.getValue() == encryptedChallenge) {
                    Ext.Msg.confirm('Cambiar Contraseña', 'Seguro desea cambiar su contraseña?', function (btn, text) {
                        if (btn == 'yes') {
                            CambiarClaveActualTxt.setValue(encryptedChallenge);

                            var encrypted = faultylabs.MD5(CambiarClaveNuevaConfirmarTxt.getValue());
                            CambiarClaveNuevaTxt.setValue(encrypted);
                            CambiarClaveNuevaConfirmarTxt.setValue(encrypted);
                            Ext.net.DirectMethods.CambiarClaveGuardarBtn_Click({ success: function () { Ext.Msg.alert('Cambiar Contraseña', 'Contraseña actualizada exitosamente.'); FormPanel2.getForm().reset(); } }, { eventMask: { showMask: true, target: 'customtarget', customTarget: FormPanel2} });
                        }
                    });
                } else {
                    Ext.Msg.alert('Cambiar Contraseña', 'Contraseña actual ingresada es incorrecta.');
                }
            }
        }
    </script>


        <ext:Hidden ID="LoggedUserHdn" runat="server" >
        </ext:Hidden>

                <ext:FormPanel ID="FormPanel2" AutoHeight="true"  MonitorResize="true" runat="server" Title="Form Panel" Header="false" ButtonAlign="Right" MonitorValid="true">
                    <Items>
                        <ext:Panel ID="Panel4" runat="server" Frame="false" Padding="5" Layout="AnchorLayout" Border="false">
                            <Items>
                                <ext:TextField runat="server" ID="CambiarClaveUsernameTxt"        LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Nombre de Usuario" AllowBlank="false" Hidden="true" ReadOnly="true"></ext:TextField>
                                <ext:TextField runat="server" ID="CambiarClaveActualTxt"          LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Contraseña Actual"           InputType="Password" AllowBlank="false" Hidden="true" ReadOnly="true"></ext:TextField>
                                <ext:TextField runat="server" ID="CambiarClaveActualConfirmarTxt" LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Confirmar Contraseña Actual" InputType="Password" AllowBlank="false" MsgTarget="Side" ></ext:TextField>
                                <ext:TextField runat="server" ID="CambiarClaveNuevaTxt"           LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Nueva Contraseña"            InputType="Password" AllowBlank="false" MsgTarget="Side" ></ext:TextField>
                                <ext:TextField runat="server" ID="CambiarClaveNuevaConfirmarTxt"  LabelAlign="Right" AnchorHorizontal="90%" FieldLabel="Confirmar Contraseña"        InputType="Password" AllowBlank="false" Vtype="password" MsgTarget="Side" >
                                    <CustomConfig>
                                        <ext:ConfigItem Name="initialPassField" Value="#{CambiarClaveNuevaTxt}" Mode="Value" />
                                    </CustomConfig>
                                </ext:TextField>
                            </Items>
                        </ext:Panel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="CambiarClaveGuardarBtn" runat="server" Text="Guardar" Icon="Disk" FormBind="true">
                            <Listeners>
                                <Click Handler="PageX.updatePassword();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:FormPanel>