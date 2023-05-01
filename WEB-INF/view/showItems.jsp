<%-- 
    Document   : showItems
    Created on : Dec 6, 2021, 10:57:26 AM
    Author     : hari-work
--%>



<%@page import="java.util.List"  import="cqb.db.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/header.jspf" %>
<% List itemList = (List) request.getAttribute("ItemList");
%>
<p>
    <a href="topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>">Menu</a> > Items
</p>
<table align="center" style="width:80%">
    <tr>
        <th>Item Id</th>
        <th>Item Name</th>
        <th>Description</th>

        <th>Item Type</th>
   
        <th>Income Account</th>
   
        <th>Unit Price</th>
        <th>Taxable</th>
    </tr>

    <% for (int i = 0; i < itemList.size(); i++) {
            Item item = (Item) itemList.get(i);%>
    <tr>
        <td><%= item.getItemId()%></td> 
        <td><%= item.getName()%></td>
        <td><%= item.getDescription()%></td>
     
        <td><%= item.getType()%></td>
      
        <td><%= item.getIncomeAccount()%></td>
      
        <td><%= item.getUnitPrice()%></td>
        <td><%= item.getTaxable()%></td>
        <td>
            <button type="button" onclick="location.assign('displayJson?EntityName=Item&EntityId=<%=item.getItemId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Display Json</button>
        </td>

    </tr>
    <% }%>


</table>

<br><br>
<nav>
    <button type="button" onclick="location.assign('createItem')">Add New Item</button>
    <button type="button" align="center" onclick="window.location.href = 'topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>'">Back</button>
    <!--button type="button" onclick="location.assign('createInvoice' )">New Invoice</button-->
</nav>
<%@include  file="../jspf/footer.jspf" %>
