<%-- 
    Document   : buyerInvoices
    Created on : Jun 10, 2021, 8:44:48 PM
    Author     : hari-work
--%>

<%@page import="java.util.List" import="cqb.data.*" import="cqb.db.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>
<% List infoList = (List) request.getAttribute("InvoiceInfo");
    Buyer buyerObj = (Buyer) request.getAttribute("BuyerObj");
    request.getSession().setAttribute("BuyerObj", buyerObj);%>
<p>
    <a href="topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>">Menu</a> ><a href="buyersInvoices?time=<%=java.time.Instant.now().getEpochSecond()%>">Invoice</a> ><%=buyerObj.getCustomerName()%>
</p>
<table align="center" style="width:90%">
    <tr>
        <th>Invoice #</th>
        <th>Invoice Id</th>
        <th>Amount</th>
        <th>Due date</th>
        <th>Past Due</th>
        <th>Balance</th>
        <th>Payment Date</th>
        <th>Invoice Status</th>
       
    </tr>

    <% for (int i = 0; i < infoList.size(); i++) {
                InvoiceInfo info = (InvoiceInfo) infoList.get(i);%>
    <tr>
       
        <td><%= info.InvoiceNumber%></td>
        <td><a href="invoiceItems?InvoiceId=<%=info.InvoiceId%>&time=<%=java.time.Instant.now().getEpochSecond()%>">
                <%= info.InvoiceId%></a></td>
        <td><%= info.Amount%></td>
        <td><%= info.DueDate%></td>
        <td><%= info.DaysPastDue%></td>
        <td><%= info.Balance%></td>
        <td><%= info.PmtDate%></td>
        <td><%= info.Status%></td>
      

    </tr>
    <% }%>


</table>

<br><br>
<nav>
    <button type="button" onclick="location.assign('buyersInvoices?time=<%=java.time.Instant.now().getEpochSecond()%>')">Back</button>
    <button type="button" onclick="location.assign('createInvoice?time=<%=java.time.Instant.now().getEpochSecond()%>')">Create Invoice</button>
</nav>
<%@include  file="../jspf/footer.jspf" %>