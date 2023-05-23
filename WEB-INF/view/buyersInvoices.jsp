<%-- 
    Document   : buyersInvoices
    Created on : Jun 10, 2021, 8:44:48 PM
    Author     : hari-work
--%>

<%@page import="java.util.List" import="cqb.data.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>
<p>
    <a href="topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>">Menu</a> >Invoice &nbsp;&nbsp;&nbsp;

    <button type="button" onclick="window.location.href = 'syncData?dataType=invoices&time=<%=java.time.Instant.now().getEpochSecond()%>'">Sync Data</button>
</p>


<% List infoList = (List) request.getAttribute("BuyersInvoicesInfo");
%>

<body>
    <table align="center">
        <tr>
            <th>Buyers</th>
            <th>Invoices</th>
            <th>Past Due Invoices</th>
            <th>Paid</th>
        </tr>

        <% for (int i = 0; i < infoList.size(); i++) {
                BuyerInvoiceInfo info = (BuyerInvoiceInfo) infoList.get(i);%>
        <tr>
            <td>
                <a href="buyerInvoices?BuyerId=<%= info.buyerId%>&time=<%=java.time.Instant.now().getEpochSecond()%>&BuyerName=<%= info.buyerName%>"><%= info.buyerName%></a></td>
            <td><%= info.numInvoices%></td>
            <td><%= info.numPastDue%></td>
            <td><%= info.numPaid%></td>
        </tr>
        <% }%>


    </table>

    <br><br>
    <nav>
        <button type="button" onclick="location.assign('topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>')">Back</button>
    </nav>
    <%@include  file="../jspf/footer.jspf" %>
