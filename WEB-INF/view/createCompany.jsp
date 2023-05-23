<%-- 
    Document   : createCompany
    Created on : Jun 7, 2021, 11:46:36 AM
    Author     : hari-work
--%>
<%@page import="java.util.*" import="cqb.data.*" import="cqb.db.*" import="cqb.svc.*" import="cc.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include  file="../jspf/backOffice.jspf" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="scripts/jquery-3.6.0.js"></script>
    <link rel="stylesheet" type="text/css" href="css/pb360.css">      
    <style>
        tr.companyData, th.companyData, td.companyData{
            border:none;
        }

        table.companyData{
            width:40%;
        }
        form.companyData, input.companyData{
            padding:0px;
        }
        input.companyData{
            text-align: left;              
        }
        label {
            display: inline-block;
            width: 220px;
            text-align: right;
        }​
    </style>
</head>

<%
    Props PropsObj = Props.getReference("cqb");
    String HostName = PropsObj.getProperty("B360Host");
%>

<p>
    <a href="topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>">Menu</a> >

</p>
<form method="POST" id="SaveCompany" class="companyData" action="<%=HostName%>/saveCompany"  style="text-align:left"> 
    <table class="nbTable" align="center" >
        <tr><td class="nbTable"><label for="CompanyName">New Company Name* :</label>
                <input class="nbTable" type="text" id="CompanyName" name="CompanyName" required> </td>
        </tr>
        <tr>
            <td class="nbTable"><label for="Description">New Company Description :</label>
                <input class="nbTable" type="Description" id="Description" name="Description"></td>
        </tr>
        <!--tr> <th class="nbTable"> Company Address: </th> 
        <tr>
            <td class="nbTable"><label for="Street">Street:</label><input class="nbTable" type="text" id="Street" name="Street" ></td>
        </tr>
        <tr>
            <td class="nbTable"><label for="City">City:</label><input class="nbTable" type="text" id="City" name="City"></td>
        </tr>
        <tr>
            <td class="nbTable"><label for="State">State:</label><input class="nbTable" type="text" id="State" name="State" ></td>
        </tr>
        <tr>
            <td class="nbTable"><label for="Zip">Zip:</label><input class="nbTable" type="text" id="Zip" name="Zip" ></td>
        </tr-->

        <tr><td class="nbTable"><label for="UserId">New Seller UserId* :</label>
                <input class="nbTable" type="text" id="UserId" name="UserId" required> </td>
        </tr>
        <tr>
            <td class="nbTable"><label for="Password">New Seller Password* :</label>
                <input class="nbTable" type="Password" id="Password" name="Password"></td>
        </tr>


    </table>
</form>
<br>
<!--button type="button" onclick="location.assign('saveItem().getEpochSecond()%>')">Create Item</button--> 
<button form="SaveCompany" name="Action" value="Save" type="Submit" >Create New Company</button>

<br><br>
<button type="button" onclick="window.location.href = 'topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>'">Back</button>
<%@include  file="../jspf/footer.jspf" %>

