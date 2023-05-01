<%-- 
    Document   : confirmCustomerAction
    Created on : Sep 3, 2021, 10:40:13 AM
    Author     : hari-work
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/buyerHeader.jspf" %>

<p align="center" style="color:Green"><%=request.getAttribute("DisplayMsg")%>

</p>
<p align="center">
    <button type="button" align="center" onclick="window.location.href = 'customerInvoices?time=<%=java.time.Instant.now().getEpochSecond()%>'">Continue</button>
</p>
<%@include  file="../jspf/footer.jspf" %>