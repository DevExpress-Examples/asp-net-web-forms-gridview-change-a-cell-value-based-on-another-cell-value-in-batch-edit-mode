<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128532837/17.1.6%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/T558750)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->
<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/Default.aspx.vb))
<!-- default file list end -->
# ASPxGridView - Batch Edit - How to change a cell value based on another cell value


<p>The sample illustrates how to change the Price column value when the Percentage column is changed and vice versa. <br><br>ASPxClientGridView provides the <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridView_batchEditApitopic">ASPxClientGridView.batchEditApi</a> property to work with grid in batch mode on the client side. In the <a href="https://documentation.devexpress.com/#AspNet/clsDevExpressWebScriptsASPxClientGridViewBatchEditApitopic">ASPxClientGridViewBatchEditApi</a> class, there are two methods to get and set a cell value respectfully: <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridViewBatchEditApi_GetCellValuetopic">ASPxClientGridViewBatchEditApi.GetCellValue</a>, <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridViewBatchEditApi_SetCellValuetopic(U0XPfw)">ASPxClientGridViewBatchEditApi.SetCellValue(Int32,String,Object)</a>.<br><br>In the <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridView_BatchEditEndEditingtopic">ASPxClientGridView.BatchEditEndEditing</a> event handler, the GetCellValue method returns a correct cell value when a cell is not in <strong>editing mode</strong>. If a cell is in <strong>editing mode</strong> and a value is changed, the GetCellValue method returns the previous value, not a new entered value. To get a new entered value that is still in <strong>editing mode</strong>, it's necessary to use the <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridViewBatchEditEndEditingEventArgs_rowValuestopic">ASPxClientGridViewBatchEditEndEditingEventArgs.rowValues</a> property. <br><br>In the attached sample, a focused column is saved in the <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridView_BatchEditStartEditingtopic">ASPxClientGridView.BatchEditStartEditing</a> event handler:</p>


```js
var fieldName;
function OnBatchEditStartEditing(s, e) {
    fieldName = e.focusedColumn.fieldName;
}
 

```


<p>When column editing is over, the <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridView_BatchEditEndEditingtopic">ASPxClientGridView.BatchEditEndEditing</a> event is raised. To get a new entered value, the rowValues property is used. To update the next column, the SetCellValue is used as a new column is not yet in <strong>editing mode</strong>: </p>


```js
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
 

```



<br/>


