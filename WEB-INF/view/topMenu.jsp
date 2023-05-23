<%-- 
    Document   : TopMenu
    Created on : Jun 1, 2021, 8:37:39 AM
    Author     : hari-work
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>
<table class="TopMenu" align="center">

    <tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'buyersInvoices?time=<%=java.time.Instant.now().getEpochSecond()%>'">Invoices</button></td></tr>
    <tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'showItems?time=<%=java.time.Instant.now().getEpochSecond()%>'">Items</button></td></tr>
    <tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'showPmts?time=<%=java.time.Instant.now().getEpochSecond()%>'">Payments</button></td></tr>
    <tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'buyerAccounts?time=<%=java.time.Instant.now().getEpochSecond()%>'">Buyer Accounts</button></td></tr>
    <tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'showAccounts?time=<%=java.time.Instant.now().getEpochSecond()%>'">Accounts</button></td></tr>
    <!--tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'refreshData?time=<%=java.time.Instant.now().getEpochSecond()%>'">Refresh Data </button></td></tr-->
    <tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'syncAllData?time=<%=java.time.Instant.now().getEpochSecond()%>'">Sync Data</button></td></tr>
<!--tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'recordExpense?time=<%=java.time.Instant.now().getEpochSecond()%>'">Record Expense</button></td></tr-->
    <tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'tBI'">Profile</button></td></tr>
    <!--tr><td align="center"><button type="button" style="width: 100%" onclick="window.location.href = 'testOp'">TestOp</button></td></tr-->

</table>
<br> 
<hr style="width:60%;height:5px;border-width:0;background-color:black;text-align:center;">
<h1 align="center"><span style="background-color: #d5f4e6;">Bill360 Back Office</span></h1>
<br>
<button type="button" style=" background-color: greenyellow;font-size:16px;" onclick="window.location.href = 'createCompany?time=<%=java.time.Instant.now().getEpochSecond()%>'">Create New Company</button>
<%@include  file="../jspf/footer.jspf" %>
