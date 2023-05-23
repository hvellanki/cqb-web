<%-- 
    Document   : authURL
    Created on : Jun 7, 2021, 11:46:36 AM
    Author     : hari-work
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>

<h3 align="center" style="color:DodgerBlue;">Welcome to Bill360.</h3>
<!--h3 align="center" style="color:DodgerBlue;">Your company:<%=(String)session.getAttribute("SupplierName")%> has been created. </h3-->
<h3 align="center" style="color:DodgerBlue;">Please click below button to connect to your Accounting software: </h3>
<p align="center">
    <button type="button" align="center" style="font-size:18px;" onclick="window.open('<%=(String)session.getAttribute("AuthURL")%>', '_blank')">Connect</button>

    <!--button type="button" align="center" style="font-size:18px;" onclick="window.location.href = '<%=(String)session.getAttribute("AuthURL")%>'" target="_blank">Connect</button-->
</p>
<%@include  file="../jspf/footer.jspf" %>
