<%-- 
    Document   : showCustomerInvoice
    Created on : Jun 10, 2021, 8:44:48 PM
    Author     : hari-work
--%>

<%@page import="java.util.*" import="cqb.data.*" import="cqb.db.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/cqb.css?<%=Calendar.getInstance().get(Calendar.MINUTE)%>">
        <style>
            table, tr, td{
                border:none;
                width:30%;
            }
            .paymentForm{
                display: inline-block;
                padding-right:100px;
                padding-left:20px;
            }
            .amount{
                text-align: left;
                padding-right:0px;
            }
        </style>
        <script src="scripts/jquery-3.6.0.js""></script>
    </head>
    <body style="width: 80%;">

        <% List itemsList = (List) request.getAttribute("ItemsList");
            Buyer buyerObj = (Buyer) request.getAttribute("BuyerObj");
            Invoice invoiceObj = (Invoice) request.getAttribute("InvoiceObj");
            Supplier supplierObj = (Supplier) request.getAttribute("SupplierObj");
        %>

        <h3 class="SecondaryHeader" style="text-align:left"> <%=supplierObj.getCompanyName()%> </h3>
        <p style="text-align:left" align="left"> 
            <%=supplierObj.getCompanyStreet()%><br>
            <%=supplierObj.getCompanyCity()%>,&nbsp;<%=supplierObj.getCompanyState()%>&nbsp;<%=supplierObj.getCompanyZip()%>&nbsp;US<br>
            <%=supplierObj.getPhone()%><br>
            <%=supplierObj.getEmail()%><br><br>

        <h3> INVOICE </h3>
    </p>

    <table style="float:right;">
        <tr>
            <td><h3> INVOICE </h3></td>               
        </tr>
        <tr>
            <td>INVOICE</td>
            <td><%=invoiceObj.getInvoiceId()%></td>            
        </tr>
        <tr>
            <td>DATE</td>
            <td><%=invoiceObj.getTxnDate()%></td>
        </tr>
        <tr>
            <td>TERMS</td>
            <td>DUE ON RECEIPT</td>
        </tr>
        <tr>
            <td>DUE DATE</td>
            <td><%=invoiceObj.getDueDate()%></td>
        </tr>
    </table>
</p>
<br><br>
<p style="text-align:left" align="left">BILL TO<br>
    <%=buyerObj.getCompanyName()%><br>
    <%=buyerObj.getBillStreet()%><br>
    <%=buyerObj.getBillCity()%>,&nbsp;<%=buyerObj.getBillState()%>&nbsp;<%=buyerObj.getBillZip()%>&nbsp;US<br>
    <%=buyerObj.getPhone()%><br>
    <%=buyerObj.getEmailAddress()%><br><br>
</p>

<br><br><br>

<table align="center" style="border:1px solid; border-collapse: collapse; text-align:left; padding: 8px;; width: 80%;">
    <tr>
        <th style="border:1px solid; text-align:left;"></th>
        <th style="border:1px solid; text-align:left;">Item#</th>
        <th style="border:1px solid; text-align:left;">Description</th>           
        <th style="border:1px solid; text-align:left;">QTY</th>
        <th style="border:1px solid; text-align:left;">RATE</th>
        <th style="border:1px solid; text-align:left;">Amount</th>
        <th style="border:1px solid; text-align:left;">Tax</th>
    </tr>

    <% for (int i = 0; i < itemsList.size(); i++) {
            LineItem lineItem = (LineItem) itemsList.get(i);%>
    <tr>

        <td style="border:1px solid; text-align:left;"><%=i + 1%></td>
        <td style="border:1px solid; text-align:left;"><%= lineItem.getDescription()%></td>
        <td style="border:1px solid; text-align:left;"><%= lineItem.getQuantity()%></td>
        <td style="border:1px solid; text-align:left;"><%= lineItem.getUnitPrice()%></td>           
        <td style="border:1px solid; text-align:left;"><%= lineItem.getTotalAmount()%></td>
        <td style="border:1px solid; text-align:left;"><%= lineItem.getTaxAmount()%></td>            
    </tr>
    <% }%>

</table>

<script>
    function updateAmounts(itemTotal, itemTax, cboxId) {
        function updateAmounts(itemTotal, itemTax, cboxId) {
            if (document.getElementById(cboxId).checked) {
                var Total = Number(1 * $("#Total").val() + itemTotal + itemTax).toFixed(2);
                $("#Total").val(Total);
                var SubTotal = Number(1 * $("#SubTotal").val() + itemTotal).toFixed(2);
                $("#SubTotal").val(SubTotal);
                var Tax = Number(1 * $("#Tax").val() + itemTax).toFixed(2);
                $("#Tax").val(Tax);
                var Balance = Number(1 * $("#Balance").val() - itemTotal - itemTax).toFixed(2);
                $("#Balance").val(Balance);
            } else {
                var Total = Number(1 * $("#Total").val() - itemTotal - itemTax).toFixed(2);
                $("#Total").val(Total);
                var SubTotal = Number(1 * $("#SubTotal").val() - itemTotal).toFixed(2);
                $("#SubTotal").val(SubTotal);
                var Tax = Number(1 * $("#Tax").val() - itemTax).toFixed(2);
                $("#Tax").val(Tax);
                var Balance = Number(1 * $("#Balance").val() + itemTotal + itemTax).toFixed(2);
                $("#Balance").val(Balance);
            }

        }
        function update(total, cboxId) {
            if (document.getElementById(cboxId).checked) {
                return Number(total) + Number(document.getElementById(cboxId).value);
            } else {
                return Number(total) - Number(document.getElementById(cboxId).value);
            }
        }
</script>
<br><br>
<div style="float:right">
    <form method="POST" class="paymentForm" action="receiveCustomerPayment?InvoiceId=<%=invoiceObj.getInvoiceId()%>&SupplierId=<%=invoiceObj.getSupplierId()%>">
        <label for="SubTotal" style="padding-left: 100px;">SubTotal:&nbsp;&nbsp;&nbsp;&nbsp;</label>
        <input type="text" id="SubTotal" class="amount disable"  name="SubTotal" value="<%=invoiceObj.getSubTotal()%>"> <br>
        <label for="Tax" style="padding-left: 100px;">Tax:&nbsp;&nbsp;&nbsp;&nbsp;</label>
        <input type="text" id="Tax" class="amount disable"  name="Tax" value="<%=invoiceObj.getTax()%>"> <br>
        <label for="Total" style="padding-left: 100px;">Total:&nbsp;&nbsp;&nbsp;&nbsp;</label>
        <input type="text" id="Total" class="amount disable"   name="Amount" value="<%=invoiceObj.getTotalAmt()%>"> <br>
        <hr style="width:75%;height:2px;border-width:0;color:gray;background-color:gray;text-align:right;margin-right:0">
        <label for="Balance" style="padding-left: 100px;">Balance Due:&nbsp;&nbsp;&nbsp;&nbsp;</label>
        <input type="text" id="Balance" class="amount disable"  name="Balance" value="<%=invoiceObj.getTotalAmt()%>"> <br><br>
        <button type="submit" align="left" style="margin-left:0px;margin-right:0px; text-align: left" onclick="Disabled = true" >Receive Payment</button>

    </form>

</div>
<br><br>

</body>
</html>

