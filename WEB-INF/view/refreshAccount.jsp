<%-- 
    Document   : refreshAccount
    Created on : Jul 6, 2021, 7:04:29 PM
    Author     : hari-work
--%>

<%@page import="java.util.List" import="cqb.db.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>

<!--p align="center" style="color:Green">Would you like to refresh your account?
<br><br-->
<p>
    <br>
    <button type="button"  onclick="window.location.href = 'connectToQBO'">Refresh account</button>
    <br><br>
    <button type="button"  onclick="window.location.href = 'refreshConnection'">Refresh connection only</button>
    <br><br>
    <button type="button"  onclick="window.location.href = 'topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>'">Main Menu</button>
</p>
<%@include  file="../jspf/footer.jspf" %>