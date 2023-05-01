<%-- 
    Document   : invoiceItems
    Created on : Jun 10, 2021, 8:44:48 PM
    Author     : hari-work
--%>

<%@page import="java.util.*" import="cqb.data.*" import="cqb.db.*" import="java.math.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/cqb.css">
        <style>           
            .paymentForm, .sendForm {
                display: inline-block;
                padding-right:100px;
                padding-left:20px;
            }
            .amount{
                text-align: left;
                padding-right:0px;
            }
            .MemoB{
                color:blue;
                margin:0px;
                margin-bottom: 10px;
            }

            .MemoS{
                margin:0px;
                margin-bottom: 10px;
            }

        </style>
        <script src="scripts/jquery-3.6.0.js"></script>
    </head>
    <body>
        <h1 align="center"><span style="background-color: #d5f4e6;">Bill360</span></h1>
        <h2 class="SecondaryHeader" align="center"> <%= session.getAttribute("SupplierName")%> </h2>

        <% List itemsList = (List) request.getAttribute("ItemsList");
            Buyer buyerObj = (Buyer) request.getAttribute("BuyerObj");
            Invoice invoiceObj = (Invoice) request.getAttribute("InvoiceObj");
            //BigDecimal taxableSubTotal = invoiceObj.getSubTotal().subtract(invoiceObj.getDiscountAmount());
        %>

        <p>
            <a href="topMenu">Menu</a> ><a href="buyersInvoices">Invoice</a> ><a href="buyerInvoices?BuyerId=<%=buyerObj.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>"><%= buyerObj.getCustomerName()%> </a>> 
            Invoice No.:<%=invoiceObj.getInvoiceNumber()%>
        </p>
        <table align="center" style="border:none;">
            <tr>
                <td style="border:none; text-align:left">Buyer Name :<%= buyerObj.getCustomerName()%></td>
            </tr>
            <tr>
                <td colspan="2" style="border:none; text-align:left">Bill To :<%=buyerObj.getBillAddress()%> 
                </td> 
            </tr>
            <tr>
                <td style="border:none; text-align:left">Ship To :<%=buyerObj.getShipAddress()%> 
                </td> 
                <td style="border:none; text-align:right">Invoice Date :<%= invoiceObj.getTxnDate()%></td>
            </tr>
            <tr>
                <td style="border:none; text-align:left">Email :<%= buyerObj.getEmailAddress()%></td>
                <td style="border:none; text-align:right">Due Date :<%= invoiceObj.getDueDate()%></td>
            </tr>
        </table>
        <br>


        <table align="center" style="border:1px solid;  border-collapse: collapse; text-align:left;  width: 65%;">
            <tr>
            
                <th style="border:1px solid; text-align:left;">Item#</th>
                <th style="border:1px solid; text-align:left;">Name</th>
                <th style="border:1px solid; text-align:left;">Description</th>
                <th style="border:1px solid; text-align:left;">Price</th>
                <th style="border:1px solid; text-align:left;">Quantity</th>
                <th style="border:1px solid; text-align:left;">Total</th>
                <th style="border:1px solid; text-align:left;">Tax</th>  
            </tr>

            <% for (int i = 0; i < itemsList.size(); i++) {
                    LineItem lineItem = (LineItem) itemsList.get(i);%>
            <tr>
                <td style="border:1px solid; text-align:left;"><%=i + 1%>
                    <input type="text" class="LineNumber" hidden id='<%="LN" + i%>' name="LineNumber" value="<%=i + 1%>" form="paymentForm">
                </td>
                <td style="border:1px solid; text-align:left;"><%= lineItem.getItemName()%></td>
                <td style="border:1px solid; text-align:left;"><%= lineItem.getDescription()%>
                </td>
                <td style="border:1px solid; text-align:left;"><%= lineItem.getUnitPrice()%></td>
                <td style="border:1px solid; text-align:left;"><%= lineItem.getQuantity()%></td>
                <td style="border:1px solid; text-align:left;" class="itemAmount"><%= lineItem.getTotalAmount()%></td>
                <td style="border:1px solid; text-align:left;" class="itemTax"><%= lineItem.getTaxAmount()%></td>
            </tr>
            <% }%>

        </table>

        <script>
            function updateAmounts(itemTotal, itemTax, itemDiscount, cboxId, i, LineItemId) {
                var itemTaxableTotal = itemTotal - itemDiscount;
                var TaxableSubTotal = $("#TaxableSubTotal").val();
                if (document.getElementById(cboxId).checked) {
                    var SubTotal = Number(1 * $("#SubTotal").val() + itemTotal).toFixed(2);
                    var Discount = Number(1 * $("#Discount").val() + itemDiscount).toFixed(2);
                    $("#SubTotal").val(SubTotal);
                    $("#Discount").val(Discount);

                    if (itemTax > 0) { // taxable                    
                        TaxableSubTotal = Number(1 * TaxableSubTotal + itemTaxableTotal).toFixed(2);
                        $("#TaxableSubTotal").val(TaxableSubTotal);
                    } //else do nothing as item is non taxable

                    var Balance = Number(1 * $("#Balance").val() - itemTotal - itemTax + itemDiscount).toFixed(2);
                    $("#Balance").val(Balance);
                    enableLineItemId(LineItemId, i);
                } else {
                    //var Total = Number(1 * $("#Total").val() - itemTotal - itemTax + itemDiscount).toFixed(2);
                    //$("#Total").val(Total);
                    var SubTotal = Number(1 * $("#SubTotal").val() - itemTotal).toFixed(2);
                    $("#SubTotal").val(SubTotal);
                    //var Tax = Number(1 * $("#Tax").val() - itemTax).toFixed(2);
                    //$("#Tax").val(Tax);
                    var Discount = Number(1 * $("#Discount").val() - itemDiscount).toFixed(2);
                    $("#Discount").val(Discount);
                    if (itemTax > 0) { // taxable                    
                        TaxableSubTotal = Number(1 * TaxableSubTotal - itemTaxableTotal).toFixed(2);
                        $("#TaxableSubTotal").val(TaxableSubTotal);
                    }
                    //var TaxableSubTotal = Number(1 * $("#SubTotal").val() - $("#Discount").val()).toFixed(2);
                    //$("#TaxableSubTotal").val(TaxableSubTotal);
                    var Balance = Number(1 * $("#Balance").val() + itemTotal + itemTax - itemDiscount).toFixed(2);
                    $("#Balance").val(Balance);
                    disableLineItemId(LineItemId, i);
                }

                var Tax = Number(TaxableSubTotal * $("#TaxPercent").val() / 100).toFixed(2);
                $("#Tax").val(Tax);
                var Total = Number(1 * $("#Shipping").val() + 1 * SubTotal - 1 * Discount + 1 * Tax).toFixed(2);
                $("#Total").val(Total);
            }

         

            function disableLineItemId(LineItemId, i) {
                LineItemId.disabled = true;
                $("#LN" + i).prop("disabled", true);
            }

            function enableLineItemId(LineItemId, i) {
                $("#LN" + i).prop("disabled", false);
                LineItemId.disabled = false;
            }

            function confirmSubmit()
            {
                var agree = confirm("Are you sure you want to issue a Credit?");
                if (agree)
                    return true;
                else
                    return false;
            }
            function sendMessage() {
                let msgtxt = $("#NewMsg").val();
                let formattedText = '<p class="MemoS">' + msgtxt + "</p>";
                $("#ChatHistory").append(formattedText);
                $.post("sendMsgToBuyer?InvoiceId=<%=invoiceObj.getInvoiceId()%>", "NewMsg=" + formattedText);
                alert("Message has been sent!");
                $("#NewMsg").val("");
            }
        </script>
        <br><br>
        <div style="float:right">
            <form method="POST" id="paymentForm" class="paymentForm" action="receivePayment?InvoiceId=<%=invoiceObj.getInvoiceId()%>">
                <label for="SubTotal" style="padding-left: 100px;">SubTotal(before tax and discount):&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="SubTotal" class="disable amount"  name="SubTotal" value="<%=invoiceObj.getSubTotal()%>"> <br>
                <label for="Discount" style="padding-left: 100px;">Discount (<%=invoiceObj.getDiscountAmount()%>%):&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Discount" class="disable  amount"  name="Discount" value="<%=invoiceObj.getDiscountAmount()%>"> <br>
                
                <label for="TaxableSubTotal" style="padding-left: 100px;">Taxable SubTotal:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="TaxableSubTotal" class="disable  amount"  name="TaxableSubTotal" value="<%=invoiceObj.getSubTotal()%>"> <br>
                
         
                <label for="TaxRate" style="padding-left: 100px;">Tax Rate:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Tax" class="disable  amount"  name="TaxRate" value="<%=invoiceObj.getTaxRate()%>"> <br>
                
                <label for="Tax" style="padding-left: 100px;">Tax:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Tax" class="disable  amount"  name="Tax" value="<%=invoiceObj.getTax()%>"> <br>
               
                <label for="Total" style="padding-left: 100px;">Total:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Total" class="disable  amount"   name="Amount" value="<%=invoiceObj.getTotalAmt()%>"> <br>
                <label for="AmountRcvd" style="padding-left: 100px;">Amount Received:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="AmountRcvd" class="disable  amount"   name="AmountRcvd" value="<%=invoiceObj.getAmountRcvd()%>" disabled> <br>
                <!--label for="balance" style="padding-left: 100px;">Balance Due:&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input type="text" id="balance" class="amount"  name="Balance" value="/**/"> <br-->
                <hr style="width:75%;height:2px;border-width:0;color:gray;background-color:gray;text-align:right;margin-right:0">
                <label for="Balance" style="padding-left: 100px;">Balance Due:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Balance" class="disable  amount"  name="Balance" value="<%=invoiceObj.getAmtDue()%>"> <br><br>
                
                <button type="submit" align="left" style="margin-left:0px;margin-right:0px; text-align: left" onclick="return confirmSubmit()" formaction="issueCredit?InvoiceId=<%=invoiceObj.getInvoiceId()%>">Issue Credit</button>
                <button type="submit" align="left" style="margin-left:10px;margin-right:0px; text-align: left" onclick="Disabled = true" >Receive Payment</button>

            </form>
                
                 

            <!--form style="border:none; margin-right: 0px;" class="sendForm" method="POST" action="sendInvoice?InvoiceId=<%=invoiceObj.getInvoiceId()%>">

                <button type="submit" onclick="Disabled = true">Send Invoice</button>

            </form-->
        </div>
            
            <label for="MsgOnInvoice" style="padding-left: 0px;">Message on Invoice:</label><br>
        <div id="MsgOnInvoice" style="margin-left: 300px; width:300px;  height:60px;  text-align: left; border-style:solid; overflow:auto" ><%=invoiceObj.getPrivateNote()%></div>
        <br>
        
        <br><br>
        <button type="button" onclick="location.assign('buyerInvoices?BuyerId=<%=invoiceObj.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Back</button>
        <button type="buton" onclick="location.assign('sendInvoice?BuyerId=<%=invoiceObj.getBuyerId()%>')">Send Invoice</button>
        <button type="button" onclick="location.assign('displayJson?EntityName=Invoice&EntityId=<%=invoiceObj.getInvoiceId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Display Json</button>

    </div>
    <br><br><br>
    <div style="text-align:right"><a href="logout" style="padding: 16px; margin-top:100px" >logout</a></div>
</body>

</html>
