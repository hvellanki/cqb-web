<%-- 
    Document   : createdBuyer
    Created on : Jun 7, 2021, 11:46:36 AM
    Author     : hari-work
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>

<h3 align="center" style="color:DodgerBlue;">Buyer Id:<%=request.getAttribute("BuyerId")%> has been created. </h3>
<br> 
<p align="center">

    <button type="button" align="center" onclick="window.location.href = 'buyerProfile?BuyerId=<%=request.getAttribute("BuyerId")%>&time=<%=java.time.Instant.now().getEpochSecond()%>'">Continue</button>
</p>
<%@include  file="../jspf/footer.jspf" %>
