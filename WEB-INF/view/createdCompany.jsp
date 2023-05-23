

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/backOffice.jspf" %>

<h3 align="center" style="color:DodgerBlue;">Created User Account for <%=(String) session.getAttribute("SupplierName")%> on Bill360.</h3>
<h4 align="center" >User Id : <%=(String) session.getAttribute("UserId")%> </h4>
<h3 align="center" >Password   : <%=(String) session.getAttribute("Password")%> </h3>

<hr style="width:50%;height:5px;border-width:0;background-color:black;text-align:center;">

<h3 align="center" style="color:DodgerBlue;">Created <%=(String) session.getAttribute("SupplierName")%> company on Codat. </h3>
<h3 align="center" >Company Name : <%=(String) session.getAttribute("SupplierName")%> </h3>
<h3 align="center" >Company Id   : <%=(String) session.getAttribute("CompanyId")%> </h3>

<nav>
    <button type="button" onclick="location.assign('topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>')">Back</button>
</nav>

<%@include  file="../jspf/footer.jspf" %>
