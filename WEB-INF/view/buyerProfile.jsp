<%-- 
    Document   : buyerProfile
    Created on : Jun 7, 2021, 11:46:36 AM
    Author     : hari-work
--%>
<%@page import="java.util.*" import="cqb.data.*" import="cqb.db.*" import="cqb.svc.*" import="cc.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/cqb.css"> 
        <script src="scripts/jquery-3.6.0.js"></script>
        <style>
            tr.buyerData, th.buyerData, td.buyerData{
                border:none;
            }
            table.buyerData{
                width:60%;
            }
            form.buyerData, input.buyerData{
                padding:0px;
            }
            input.buyerData{
                text-align: left;
            }
            label {
                display: inline-block;
                width: 180px;
                text-align: right;
            }​
        </style>
    </head>
    <div style="text-align:right;"><a href="logout" style="padding: 16px" >logout</a></div>
    <h1 align="center"><span style="background-color: #d5f4e6;">Bill360 Seller Portal</span></h1>
    <h2 class="SecondaryHeader" align="center"> <%= session.getAttribute("SupplierName")%> </h2>


    <% Buyer buyer = (Buyer) session.getAttribute("BuyerObj");
        Props PropsObj = Props.getReference("cqb");
        String HostName = PropsObj.getProperty("B360Host");
        int execTime = 0;
        if (request.getParameter("ExecTime") != null) {
            execTime = Integer.parseInt(request.getParameter("ExecTime"));
        }
    %>

    <% if (execTime > 0) {%>
    <script>
        //alert("Time to refresh Taxes : " + <%=execTime%> + " sec");
    </script>        
    <%}%>
    <script>
        $(document).ready(function () {
            $("input").prop("disabled", true);
        });

    </script>
    <p>
        <a href="topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>">Menu</a> ><a href="buyerAccounts?time=<%=java.time.Instant.now().getEpochSecond()%>">Buyers Accounts</a> > <%= buyer.getCustomerName()%>
    </p>
    <form method="POST" class="buyerData" action="<%=HostName%>/saveInvoice"  style="text-align:left"> 
        <table class="buyerData" align="center" >
            <tr><td class="buyerData"><label for="CustomerName">CustomerName:</label><input class="buyerData" type="text" id="CustomerName" name="CustomerName" value="<%=buyer.getCustomerName()%>"> </td>
                <td class="buyerData"><label for="Email">Email:</label>
                    <input class="buyerData" type="Email" id="Email" name="Email" value="<%=buyer.getEmailAddress()%>" required></td>
            </tr>
            <tr>
                <td class="buyerData"><label for="Primary">Primary Phone:</label>
                    <input class="buyerData" type="text" id="Primary" name="PrimaryPhone" value="<%=buyer.getPhone()%>" required></td>
            </tr>
            <tr style="border-bottom: 2px solid black;"><td  class="buyerData"><label for="Company">Company:</label><input class="buyerData" type="text" id="Company" name="Company" value="<%=buyer.getCustomerName()%>"> </td>

            </tr>

            <tr style="height: 15px;"></tr>

            <tr> <th class="buyerData"> Billing Address: </th> <th class="buyerData"> Shipping Address: </th>
            <tr>
                <td class="buyerData"><label for="BillStreet">BillStreet:</label><input class="buyerData" type="text" id="BillStreet" name="BillStreet" value="<%=buyer.getBillStreet()%>" ></td>
                <td class="buyerData"><label for="ShipStreet">ShipStreet:</label><input class="buyerData" type="text" id="ShipStreet" name="ShipStreet" value="<%=buyer.getShipStreet()%>" ></td>
            </tr>
            <tr>
                <td class="buyerData"><label for="BillCity">BillCity:</label><input class="buyerData" type="text" id="BillCity" name="BillCity" value="<%=buyer.getBillCity()%>" ></td>
                <td class="buyerData"><label for="ShipCity">ShipCity:</label><input class="buyerData" type="text" id="ShipCity" name="ShipCity" value="<%=buyer.getShipCity()%>" ></td>
            </tr>
            <tr>
                <td class="buyerData"><label for="BillState">BillState:</label><input class="buyerData" type="text" id="BillState" name="BillState" value="<%=buyer.getBillState()%>" ></td>
                <td class="buyerData"><label for="ShipState">ShipState:</label><input class="buyerData" type="text" id="ShipState" name="ShipState" value="<%=buyer.getShipState()%>" ></td>

            </tr>
            <tr>
                <td class="buyerData"><label for="BillZip">BillZip:</label><input class="buyerData" type="text" id="BillZip" name="BillZip" value="<%=buyer.getBillZip()%>" ></td>
                <td class="buyerData"><label for="ShipZip">ShipZip:</label><input class="buyerData" type="text" id="ShipZip" name="ShipZip" value="<%=buyer.getShipZip()%>" ></td>
            </tr>
            <tr  style="border-bottom: 2px solid black;">
                <td class="buyerData"><label for="BillCountry">BillCountry:</label><input class="buyerData" type="text" id="BillCountry" name="BillCountry" value="US" ></td>
                <td class="buyerData"><label for="ShipCountry">ShipCountry:</label><input class="buyerData" type="text" id="ShipCountry" name="ShipCountry" value="US" ></td>
            </tr>           

            <!--tr style="border-bottom:2px solid black">
                <td colspan="100%"></td>
            </tr-->

        </table>
    </form>

    <table class="buyerData" align="center" style="text-align: center; border:none">
        <tr class="amounts" style="text-align: center; border:none">
            <td class="amounts" style="text-align: center; border:none">
                <button type="button" onclick="location.assign('displayJson?EntityName=Buyer&EntityId=<%= buyer.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Display Json</button>  
            </td>
            <!--td class="amounts" style="text-align: center; border:none">
                <button align="right" onclick="location.assign('refreshBuyer?BuyerId=<%=buyer.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Refresh Buyer Data</button>
            </td>
            <td class="amounts" style="text-align: center; border:none">
                <button align="right" onclick="location.assign('refreshTaxData?BuyerId=<%=buyer.getBuyerId()%>&time=<%=java.time.Instant.now().getEpochSecond()%>')">Refresh Tax Data</button>
            </td-->
        </tr>
    </table>

    <br><br>
    <button type="button" onclick="window.location.href = 'buyerAccounts?time=<%=java.time.Instant.now().getEpochSecond()%>'">Back</button>
    <%@include  file="../jspf/footer.jspf" %>