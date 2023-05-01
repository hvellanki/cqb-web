<%-- 
    Document   : buyerAccounts
    Created on : Jun 7, 2021, 11:46:36 AM
    Author     : hari-work
--%>
<%@page import="java.util.List" import="cqb.db.*" import="java.time.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>
<p>
    <a href="topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>">Menu</a> >Buyers Accounts
</p>
<% List buyersList = (List) request.getAttribute("BuyersList"); %>

<%if (!buyersList.isEmpty()) {%>
<h3 style="font-weight: bold;" align="center">Name</h3>

<table align="center" style="width:30%">

    <% for (int i = 0; i < buyersList.size(); i++) {
            Buyer buyer = (Buyer) buyersList.get(i);%>
    <tr><td><a style="padding: 20px" href="buyerProfile?BuyerId=<%= buyer.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>"><%= buyer.getCustomerName()%></a></td></tr>
            <% }%>


</table>
<%} else {%>
<p style="bold">There are no buyers</P>
    <%}%>

<br>

<button type="button" onclick="location.assign('createBuyer')">Add New Buyer</button>

<br><br>
<nav>
    <button type="button" onclick="location.assign('topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>')">Back</button>
</nav>
<%@include  file="../jspf/footer.jspf" %>
