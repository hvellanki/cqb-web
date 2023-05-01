<%-- 
    Document   : authURL
    Created on : Jun 7, 2021, 11:46:36 AM
    Author     : hari-work
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>

<h3 align="center" style="color:DodgerBlue;">Welcome to Bill360.</h3>
<h3 align="center" style="color:DodgerBlue;">Your company:<%=(String)session.getAttribute("SupplierName")%> has been created. </h3>
<h3 align="center" style="color:DodgerBlue;">Please click on below URL to authorize us to connect to your Accounting software: </h3>
<br> 
<p align="center">
    <button type="button" align="center" onclick="window.location.href = '<%=(String)session.getAttribute("AuthURL")%>'">Authorize</button>
</p>
<%@include  file="../jspf/footer.jspf" %>
