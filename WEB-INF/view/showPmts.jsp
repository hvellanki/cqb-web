<%-- 
    Document   : showPmts
    Created on : Dec 6, 2021, 10:57:26 AM
    Author     : hari-work
--%>



<%@page import="java.util.List"  import="cqb.db.*" import="cqb.svc.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>
<% List pmtList = (List) request.getAttribute("PmtList");
%>
<p>
    <a href="topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>">Menu</a> > Payments
</p>
<table align="center" style="width:80%">
    <tr>

        <th>Payment Id</th>
        <th>Ref Number</th>
        <th>Buyer Name</th>
        <th>Linked Tx Id</th>
        <th>Linked Tx Type</th>
        <th>Payment Date</th>

        <th>Payment Status</th>
        <th>Invoice Status</th>
        <th>Total Amount</th>
       
    </tr>

    <% for (int i = 0; i < pmtList.size(); i++) {
                Pmt pmt = (Pmt) pmtList.get(i);%>
    <tr>
        <td><%= pmt.getPmtId()%></td> 
        <td><%= pmt.getPmtRefNum()%></td>
        <td><%= pmt.getBuyerName()%></td>
     
        <td><%= pmt.getLinkedTxId()%></td>
        <td><%= pmt.getLinkedTxType()%></td>
        <td><%= pmt.getPmtDate()%></td>
        
        <td>APPROVED</td>
           <td><%= BuyerSvc.getInvoiceStatus(pmt.getSupplierId(), pmt.getLinkedTxId())%></td>
        <td><%= pmt.getTotalAmount()%></td>
       
        <td>
            <button type="button" onclick="location.assign('displayJson?EntityName=Payment&EntityId=<%=pmt.getPmtId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Display Json</button>
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