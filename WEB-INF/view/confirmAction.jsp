<%-- 
    Document   : confirmAction
    Created on : Jul 9, 2021, 2:06:30 PM
    Author     : hari-work
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>

<p align="center" style="color:Green"><%=request.getAttribute("DisplayMsg")%>

</p>
<p align="center">
    <button type="button" align="center" onclick="window.location.href = 'topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>'">Continue</button>
</p>
<%@include  file="../jspf/footer.jspf" %>