<%-- 
    Document   : invoiceItemsCustomer
    Created on : Sep 1, 2021, 9:06:21 PM
    Author     : hari-work
--%>


<%@page import="java.util.*" import="cqb.data.*" import="cqb.db.*" import="java.math.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/buyerPages.css">
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
        <script src="scripts/jquery-3.6.0.js""></script>
    </head>
    <h1 align="center"><span style="background-color: #d5f4e6;">Bill360</span></h1>
    <h2 class="SecondaryHeader" align="center"> <%= session.getAttribute("SupplierName")%> </h2>

    <% List itemsList = (List) request.getAttribute("ItemsList");
        Buyer buyerObj = (Buyer) request.getAttribute("BuyerObj");
        Invoice invoiceObj = (Invoice) request.getAttribute("InvoiceObj");
    %>

    <p>
        Buyer - <a href="customerInvoices?BuyerId=<%=buyerObj.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>"><%= buyerObj.getCompanyName()%> </a>> 
        Invoice No.:<%=invoiceObj.getInvoiceNumber()%>
    </p>

    <body>
        <table align="center" style="border:none;">
            <tr>
                <td style="border:none; text-align:left">Buyer Name :<%= buyerObj.getCompanyName()%></td>
            </tr>
            <tr>
                <td colspan="2" style="border:none; text-align:left">Bill To :<%=invoiceObj.getBillAddress()%> 
                </td> 
            </tr>
            <tr>
                <td style="border:none; text-align:left">Ship To :<%=invoiceObj.getShipAddress()%> 
                </td> 
                <td style="border:none; text-align:right">Invoice Date :<%= invoiceObj.getTxnDate()%></td>
            </tr>
            <tr>
                <td style="border:none; text-align:left">Email :<%= buyerObj.getPrimaryEmailAddress()%></td>
                <td style="border:none; text-align:right">Due Date :<%= invoiceObj.getDueDate()%></td>
            </tr>
        </table>
        <br>


        <table align="center" style="border:1px solid;  border-collapse: collapse; text-align:left;  width: 80%;">
            <tr>
                <th style="border:1px solid; text-align:left;"></th>
                <th style="border:1px solid; text-align:left;">Item#</th>
                <th colspan="2" style="border:1px solid; text-align:left; width:100%">Name</th>
                <th colspan="2" style="border:1px solid; text-align:left; width:100%">Description</th>
                <th style="border:1px solid; text-align:left;">Price</th>
                <th style="border:1px solid; text-align:left;">Quantity</th>
                <th style="border:1px solid; text-align:left;">Total</th>
                <th style="border:1px solid; text-align:left;">Tax</th>  
                <th style="border:1px solid; text-align:left;">Discount</th>
                <th colspan="3" style="border:1px solid; text-align:left; width:100%">Reason Code</th>
            </tr>

            <% for (int i = 0; i < itemsList.size(); i++) {
                    InvoiceLineItem lineItem = (InvoiceLineItem) itemsList.get(i);%>
            <tr id='<%="RN" + i%>'>
                <td style="border:1px solid; text-align:left;">
                    <input type="checkbox" class="cbox" id='<%="cbox" + i%>' value=""    
                           onchange="updateAmounts(<%= lineItem.getAmount()%>, <%= lineItem.getTax(invoiceObj.getTaxPercent(), invoiceObj.getDiscountPercent())%>, <%= lineItem.getDiscount(invoiceObj.getDiscountPercent())%>, id, <%="" + i%>, <%="LId" + i%>);" checked> 
                    <!--img  src="images/caution.png" width="20" height="20"-->
                </td>
                <td class="LineNumber" style="border:1px solid; text-align:left;"><%=i + 1%>
                    <input type="text" class="LineNumber" hidden id='<%="LN" + i%>' name="LineNumber" value="<%=i + 1%>" form="paymentForm">
                </td>
                <td colspan="2"  style="border:1px solid; text-align:left; width:100%"><%= lineItem.getItemName()%></td>
                <td colspan="2" style="border:1px solid; text-align:left; width:100%"><%= lineItem.getDescription()%>
                    <input type="text" id='<%="LId" + i%>' name="LineItemId" value="<%=lineItem.getInvoiceLineId()%>" form="paymentForm" hidden>
                </td>
                <td style="border:1px solid; text-align:left;"><%= lineItem.getUnitPrice()%></td>
                <td style="border:1px solid; text-align:left;"><%= lineItem.getQuantity()%></td>
                <td style="border:1px solid; text-align:left;" class="itemAmount"><%= lineItem.getAmount()%></td>
                <td style="border:1px solid; text-align:left;" class="itemTax"><%= lineItem.getTax(invoiceObj.getTaxPercent(), invoiceObj.getDiscountPercent())%></td>
                <td style="border:1px solid; text-align:left;" class="itemDiscount"><%= lineItem.getDiscount(invoiceObj.getDiscountPercent())%></td>
                <td colspan="3" class="RCData" style="border:1px solid; text-align:left; width:100%"><select id='<%="RC" + i%>' class="ReasonCode" form="paymentForm" onchange="highlightRow(this, <%=i%>);" name="ReasonCode">                   
                        <option  value="None"> </option>
                        <option  value="Shortage">Shortage</option>
                        <option  value="Defective">Defective</option>
                        <option  value="Misboxed">Misboxed</option>
                        <option  value="PriceDiscrepancy">Price Discrepancy</option>
                        <option  value="Damaged">Damaged in Transit</option>
                        <option  value="Unsatistactory">Unsatisfactory Service </option>
                    </select>
                </td>
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

                $("#RC" + i).prop('selectedIndex', 0);
                $("#RC" + i).prop("disabled", true);
                $("#LN" + i).prop("disabled", true);
                $("#RN" + i).css("background-color", "lightgreen");
                $("#RN" + i).children("img").remove();
                $("#RN" + i).find("img").remove();

                LineItemId.disabled = true;
            }

            function enableLineItemId(LineItemId, i) {

                $("#RC" + i).prop("disabled", false);
                $("#LN" + i).prop("disabled", false);

                LineItemId.disabled = false;
            }
            function confirmSubmit()
            {
                var agree = confirm("Are you sure you want to request a Credit?");
                if (agree)
                    return true;
                else
                    return false;
            }
            function highlightRow(reasonCode, i)
            {
                let Row = reasonCode.parentElement.parentElement;

                //for (let i = 0; i < reasonCode.options.length; i++) {
                if (reasonCode.options[0].selected) {
                    Row.style.backgroundColor = "lightgreen";
                    $("#RN" + i).find("img").remove();
                } else {
                    Row.style.backgroundColor = "red";
                    var cautionFlag = '<img  src="images/caution.png" width="20" height="20">';
                    $("#RN" + i).find("img").remove(); // if exists so that we don't insert it multiple times.
                    $("#RN" + i).find(".cbox").after(cautionFlag);
                }
                //}
            }
            function sendMessage() {
                let msgtxt = $("#NewMsg").val();
                let formattedText = '<p class="MemoB">' + msgtxt + "</p>";
                $("#ChatHistory").append(formattedText);
                $.post("sendMsgToSupplier?InvoiceId=<%=invoiceObj.getInvoiceId()%>", "NewMsg=" + formattedText);
                alert("Message has been sent!");
                $("#NewMsg").val("");
            }

        </script>
        <br><br>
        <div style="float:right">
            <form method="POST" id="paymentForm" class="paymentForm" action="receiveCustomerPayment?InvoiceId=<%=invoiceObj.getInvoiceId()%>&SupplierId=<%=invoiceObj.getSupplierId()%>">
                <label for="SubTotal" style="padding-left: 100px;">SubTotal(before tax and discount):&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="SubTotal" class="amount"  name="SubTotal" value="<%=invoiceObj.getSubTotal()%>"> <br>
                <label for="Discount" style="padding-left: 100px;">Discount (<%=invoiceObj.getDiscountPercent()%>%):&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Discount" class="amount"  name="Discount" value="<%=invoiceObj.getDiscountAmount()%>"> <br>
                <input type="Number" id="DiscountPercent" class="amount"  name="DiscountPercent" value="<%=invoiceObj.getDiscountPercent()%>" hidden>
                <label for="TaxableSubTotal" style="padding-left: 100px;">Taxable SubTotal:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="TaxableSubTotal" class="amount"  name="TaxableSubTotal" value="<%=invoiceObj.getTaxableAmount()%>"> <br>
                <input type="text" id="TaxPercent" class="amount"  name="TaxPercent" value="<%=invoiceObj.getTaxPercent()%>" hidden> <br>
                <label for="Tax" style="padding-left: 100px;">Tax (<%=invoiceObj.getTaxPercent()%>%):&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Tax" class="amount"  name="Tax" value="<%=invoiceObj.getTax()%>"> <br>
                <label for="Shipping" style="padding-left: 100px;">Shipping Charges:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Shipping" class="amount"  name="Shipping" value="<%=invoiceObj.getShippingCharges()%>"> <br>
                <label for="Total" style="padding-left: 100px;">Total:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Total" class="amount"   name="Amount" value="<%=invoiceObj.getTotalAmt()%>"> <br>
                <label for="AmountRcvd" style="padding-left: 100px;">Amount Received:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="AmountRcvd" class="amount"   name="AmountRcvd" value="<%=invoiceObj.getAmountRcvd()%>" disabled> <br>
                <!--label for="balance" style="padding-left: 100px;">Balance Due:&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input type="text" id="balance" class="amount"  name="Balance" value="/**/"> <br-->
                <hr style="width:75%;height:2px;border-width:0;color:gray;background-color:gray;text-align:right;margin-right:0">
                <label for="Balance" style="padding-left: 100px;">Balance Due:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" id="Balance" class="amount"  name="Balance" value="<%=invoiceObj.getBalanceDue()%>"> <br><br>

                <button type="submit" align="left" style="margin-left:20px;margin-right:0px; text-align: left" onclick="return confirmSubmit()" formaction="requestCredit?InvoiceId=<%=invoiceObj.getInvoiceId()%>">Request Credit</button>
                <button type="submit" align="left" style="margin-left:20px;margin-right:0px; text-align: left" onclick="Disabled = true" >PAY</button>

            </form>

        </div>
        <label for="MsgOnInvoice" style="padding-left: 0px;">Message on Invoice:</label><br>
        <div id="MsgOnInvoice" style="margin-left: 300px; width:300px;  height:60px;  text-align: left; border-style:solid; overflow:auto" ><%=invoiceObj.getInitialMemo()%></div>
        <br>
        <label id="LChatHistory" for="ChatHistory" style="padding-left: 0px;">Let's Chat:</label><br>
        <div id="ChatHistory" style="margin-left: 300px; width:300px;  height:150px;  text-align: left; border-style:solid; overflow:auto" ><%=invoiceObj.getAllMessagesForB()%></div>
        <!--button type="submit" align="left" style="margin-left:200px;margin-right:250px;margin-top:10px;  text-align: left" onclick="location.assign('invoiceItemsCustomer?InvoiceId=<%=invoiceObj.getInvoiceId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')"
                >Refresh</button-->
        <a href="invoiceItemsCustomer?InvoiceId=<%=invoiceObj.getInvoiceId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>#LChatHistory">
            <img  src="images/refresh-button-png-th.png"  style="margin-left:200px;margin-right:250px;margin-top:10px;">
        </a>
        <br><br>
        <label for="NewMsg"  style="padding-left: 0px;margin-right: 700px;">New Message to Merchant:</label><br>
        <textarea id="NewMsg"   form="paymentForm" style="margin-left: 0px; margin-right: 600px;"  name="NewMsg" rows="5" cols="40"></textarea>
        <button type="submit" align="left" style="margin-left:0px;margin-right:700px; text-align: left" onclick="sendMessage()" >Send Message</button>


        <div style="margin-top: 165px; margin-left: 450px; margin-right:0px" >
            <button type="button" onclick="location.assign('customerInvoices?BuyerId=<%=invoiceObj.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Back</button>
        </div>
        <br><br><br>
        <div style="text-align:right"><a href="logout" style="padding: 16px; margin-top:100px" >logout</a></div>
    </body>

</html>
