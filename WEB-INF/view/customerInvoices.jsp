<%-- 
    Document   : customerInvoices
    Created on : Jun 10, 2021, 8:44:48 PM
    Author     : hari-work
--%>

<%@page import="java.util.List" import="cqb.data.*" import="cqb.db.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/buyerHeader.jspf" %>
<% List infoList = (List) request.getAttribute("InvoiceInfo");
    Buyer buyerObj = (Buyer) request.getAttribute("BuyerObj");%>
<p>
    Buyer - <%=buyerObj.getCompanyName()%>
</p>


<body>
    <table align="center" style="width:60%">
        <tr>
            <th colspan="2" style="width:100%">Invoice No.</th>
            <th>Invoice Id</th>
            <th>Amount</th>
            <th>Due date</th>
            <th>Past Due</th>
            <th>Balance</th>
          
        </tr>

        <% for (int i = 0; i < infoList.size(); i++) {
                InvoiceInfo info = (InvoiceInfo) infoList.get(i);%>
        <tr>
            <td colspan="2" style="width:100%"><%= info.InvoiceNumber%></td>
            <td><a href="invoiceItemsCustomer?InvoiceId=<%=info.InvoiceId%>&time=<%=java.time.Instant.now().getEpochSecond()%>">
                    <%= info.InvoiceId%></a></td>
            <td><%= info.Amount%></td>
            <td><%= info.DueDate%></td>
            <td><%= info.DaysPastDue%></td>
            <td><%= info.Balance%></td>
            
        </tr>
        <% }%>


    </table>

    <br><br>

    <%@include  file="../jspf/footer.jspf" %>
