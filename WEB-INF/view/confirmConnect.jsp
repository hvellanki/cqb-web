<%-- 
    Document   : confirmConnect
    Created on : Jun 7, 2021, 11:46:36 AM
    Author     : hari-work
--%>
<%@page import="java.util.List" import="cqb.db.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>

<p align="center" style="color:Green">Connect to Quick Books Online to authorize our access your account! Once we are authorized we will download your info.
    <br><br>
    <button type="button" align="center" onclick="window.location.href = 'connectToQBO'">Connect to QBO</button>
</p>
<%@include  file="../jspf/footer.jspf" %>
