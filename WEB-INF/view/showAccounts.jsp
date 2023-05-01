<%-- 
    Document   : showAccounts
    Created on : Dec 6, 2021, 10:57:26 AM
    Author     : hari-work
--%>



<%@page import="java.util.List"  import="cqb.db.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>
<% List acctList = (List) request.getAttribute("AccountList");
%>
<p>
    <a href="topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>">Menu</a> > Accounts
</p>
<table align="center" style="width:70%">
    <tr>

        <th>Account Id</th>
        <th colspan="2" style="width:100%">Account Name</th>
        <th>Account Type</th>
        <th>Balance</th>        
        <th>Updated Date</th>
    </tr>

    <% for (int i = 0; i < acctList.size(); i++) {
             Account acct = (Account) acctList.get(i);%>
    <tr>
        <td><%= acct.getAccountId()%></td> 
        <td colspan="2" style="width:100%"><%= acct.getAccountName()%></td>
    
        <td><%= acct.getAccountType()%></td>
       
        <td><%= acct.getBalance()%></td>
       
        <td><%= acct.getUpdatedDate()%></td>
        <td>
            <button type="button" onclick="location.assign('displayJson?EntityName=Account&EntityId=<%=acct.getAccountId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Display Json</button>
        </td>

    </tr>
    <% }%>


</table>

<br><br>
<nav>
    <button type="button" align="center" onclick="window.location.href = 'topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>'">Back</button>
    <!--button type="button" onclick="location.assign('createInvoice' )">New Invoice</button-->
</nav>
<%@include  file="../jspf/footer.jspf" %>