<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function OnBatchEditEndEditing(s, e) {
            var cPrice = s.GetColumnByField("Price");
            var cPercentage = s.GetColumnByField("Percentage");
            var cost = s.batchEditApi.GetCellValue(e.visibleIndex, "Cost");

            if (fieldName == "Price") {
                var price = e.rowValues[cPrice.index].value;
                s.batchEditApi.SetCellValue(e.visibleIndex, "Percentage", (price - cost) / (cost), null, true);
            }
            if (fieldName == "Percentage") {
                var percentage = e.rowValues[cPercentage.index].value;
                s.batchEditApi.SetCellValue(e.visibleIndex, "Price", cost + (cost * percentage), null, true);
            }
        }

        var fieldName;
        function OnBatchEditStartEditing(s, e) {
            fieldName = e.focusedColumn.fieldName;
        }
    </script>
</head>
<body>
    <form id="frmMain" runat="server">
        <dx:ASPxGridView ID="Grid" runat="server" KeyFieldName="ID" OnBatchUpdate="Grid_BatchUpdate"
            OnRowInserting="Grid_RowInserting" OnRowUpdating="Grid_RowUpdating" OnRowDeleting="Grid_RowDeleting">
            <ClientSideEvents BatchEditEndEditing="OnBatchEditEndEditing" BatchEditStartEditing="OnBatchEditStartEditing" />
            <SettingsEditing>
                <BatchEditSettings StartEditAction="FocusedCellClick" />
            </SettingsEditing>
            <Columns>
                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowDeleteButton="true" />
                <dx:GridViewDataTextColumn FieldName="Cost" ReadOnly="true">
                    <PropertiesTextEdit DisplayFormatString="N2">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataSpinEditColumn FieldName="Price">
                    <PropertiesSpinEdit DisplayFormatString="N2" MinValue="0" MaxValue="99999">
                    </PropertiesSpinEdit>
                </dx:GridViewDataSpinEditColumn>
                <dx:GridViewDataSpinEditColumn FieldName="Percentage">
                    <PropertiesSpinEdit DisplayFormatString="p">
                    </PropertiesSpinEdit>
                </dx:GridViewDataSpinEditColumn>
            </Columns>
            <SettingsEditing Mode="Batch" />
        </dx:ASPxGridView>
    </form>
</body>
</html>