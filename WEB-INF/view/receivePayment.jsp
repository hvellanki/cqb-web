<%-- 
    Document   : receivePayment
    Created on : Jun 20, 2021, 10:18:53 PM
    Author     : hari-work
--%>
<%@page import="java.util.*" import="cqb.data.*" import="cqb.db.*" import="cc.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/cqb.css">
        <style>
            table, tr, td{
                border:none;
                width:60%;
                text-align:left;
            }
            input {
                padding-right: 20px;
                text-align:left;
            }
        </style>
    </head>
    <body style="width: 80%;">

        <%
            Buyer buyerObj = (Buyer) request.getAttribute("BuyerObj");
            Invoice invoiceObj = (Invoice) request.getAttribute("InvoiceObj");
            Props PropsObj = Props.getReference("cqb");
            String HostName = PropsObj.getProperty("B360Host");
        %>

        <p>
            <a href="topMenu">Menu</a> ><a href="buyersInvoices">Invoice</a> ><a href="buyerInvoices?BuyerId=<%=buyerObj.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>"><%= buyerObj.getCustomerName()%></a>
            > <a href="invoiceItems?InvoiceId=<%=invoiceObj.getInvoiceId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>">Invoice No.:<%= request.getParameter("InvoiceId")%></a>
        </p>
        <% session.setAttribute("InvoiceId", invoiceObj.getInvoiceId());%>
        <form method="POST" action="<%=HostName%>/processPayment?InvoiceId=<%=invoiceObj.getInvoiceId()%>"
              style="text-align:left; padding-right: 200px; width:60%"> 
            <table>
                <tr><td>Please enter your Credit Card  information:</td></tr>
                <tr>
                    <td><b>Card Number</b></td><td> 
                        <input type="text" name="CardNumber" value="4446661234567892" required></td></tr>
                <tr><td ><b>Exp Date</b> </td><td >
                        <input type="text" name="ExpDate" value="09/25" required></td></tr>
                <tr><td ><b>CVV Number</b> </td><td >
                        <input type="text" name="CVV" value="123" required></td></tr>

                <br>
                <tr><td>Please enter the Cardholder information:</td></tr>
                <tr ><td ><b>First Name</b></td><td > 
                        <input type="text" name="FirstName" value="John" required></td></tr>
                <tr ><td  ><b>Last Name</b> </td><td >
                        <input type="text" name="LastName" value="Doe" required></td></tr>

                <tr ><td ><b>Street</b></td><td > 
                        <input type="text" name="StreetAddress"  value="123 Main street" required></td></tr>
                <tr><td   value><b>City</b> </td><td >
                        <input type="text" name="City" value="Tampa" required></td></tr>
                <tr ><td ><b>State</b> </td><td >
                        <input type="text" name="State" value="FL" required></td></tr>
                <tr ><td ><b>Zip</b> </td><td >
                        <input type="text" name="Zip" value="33601" required></td></tr>
                <tr ><td ><b>Amount to be charged</b></td><td > 
                        <input type="text" name="Amount" value="<%=request.getParameter("Amount")%>" required></td></tr>
            </table>

            <br><br>
            <tr>
                <td><button type="button" style="margin-left: 20px" onclick="location.assign('invoiceItems?InvoiceId=<%=invoiceObj.getInvoiceId()%>')">Back</button></td>
                <td>&nbsp;<input type="submit" value="Submit" onclick="Disabled = true" style="margin-left: 200px"></td>
            </tr>
        </table>
    </form>

    <br><br>

    <%@include  file="../jspf/footer.jspf" %>