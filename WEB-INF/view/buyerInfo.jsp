<%-- 
    Document   : buyerInfo
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
        <script src="scripts/jquery-3.6.0.js""></script>
    </head>
    <body>
        <h1 align="center"><span style="background-color: #d5f4e6;">Bill360</span></h1>
        <h2 class="SecondaryHeader" align="center"> <%= session.getAttribute("SupplierName")%> </h2>


        <% Buyer buyer = (Buyer) session.getAttribute("BuyerObj");
            Props PropsObj = Props.getReference("cqb");
            String HostName = PropsObj.getProperty("B360Host");
            String Action = (String) (request.getAttribute("Action"));
            String NextAction = "displayBuyer";
            if (Action.equalsIgnoreCase("Create")) {
                NextAction = "saveBuyer";
            }
        %>
        <p>
            <a href="topMenu">Menu</a> ><a href="buyerAccounts?time=<%=java.time.Instant.now().getEpochSecond()%>">Buyers Accounts</a> > <%= buyer.getCustomerName()%>
        </p>

        <script>
            function copyBilling() {
                if (document.getElementById("ShipAddress").checked) {
                    $("#ShipStreet").val($("#BillStreet").val());
                    $("#ShipCity").val($("#BillCity").val());
                    $("#ShipState").val($("#BillState").val());
                    $("#ShipZip").val($("#BillZip").val());
                    $("#ShipCountry").val($("#BillCountry").val());
                }
            }

        </script>
        <form method="POST" id="BuyerForm" class="buyerData" action="<%=HostName%>/<%=NextAction%>"  style="text-align:left"> 
            <table class="buyerData" align="center" >
                <tr><td class="buyerData"><label for="CustomerName">CustomerName:</label><input class="buyerData" type="text" id="CustomerName" name="CustomerName" value="<%=buyer.getCustomerName()%>" required> </td>
                    <td class="buyerData"><label for="Email">Email:</label><input class="buyerData" type="Email" id="Email" name="Email" value="<%=buyer.getEmailAddress()%>" required></td>
                </tr>
                <tr>
                    <td class="buyerData"><label for="Primary">Primary Phone:</label><input class="buyerData" type="Primary" id="Primary" name="PrimaryPhone" value="<%=buyer.getPhone()%>" required></td>
                </tr>
                <tr style="border-bottom: 2px solid black;"><td  class="buyerData"><label for="CompanyName">CompanyName:</label><input class="buyerData" type="text" id="CompanyName" name="CompanyName" value="<%=buyer.getCompanyName()%>" required=""> </td>
                    <td class="buyerData"><label for="Mobile">Mobile:</label><input class="buyerData" type="Mobile" id="Mobile" name="MobilePhone" value="<%=buyer.getMobilePhone()%>" ></td>
                </tr>

                <tr style="height: 15px;"/>

                <tr> <th class="buyerData"> Billing Address: </th> <th class="buyerData"> Shipping Address :  <input class="buyerData" type="checkbox" id="ShipAddress" onchange="copyBilling()" style="text-decoration:none;" name="ShipAddress" value="ShipAddress">
                        </input>
                        <label for="ShipAddress" style="font-size:10;width:auto;">Same as Billing Address</label></th>
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
                <tr>
                    <td class="buyerData"> <label for="SalesTaxRate">SalesTaxRate:</label>
                        <select id="SalesTaxRate" name="SalesTaxRate">                   
                            <option  value="Location">Based on Location </option>
                            <option  value="Custom">Custom </option>
                            <option  value="Manual">Manual </option>
                        </select>
                    </td>                    
                </tr>
                <!--tr style="border-bottom:2px solid black">
                    <td colspan="100%"></td>
                </tr-->
                <tr style="border-bottom: 2px solid black;">
                    <td class="buyerData"> <label for="PreferredPmtMethod">Preferred Payment Method:</label>
                        <select id="PreferredPmtMethod" name="PreferredPmtMethod"> 
                            <option  value="Visa">Visa </option>
                            <option  value="MC">Master Card</option>
                            <option  value="DC">Diners Club</option>
                            <option  value="Amex">American Express</option>
                            <option  value="Check">Check </option>
                            <option  value="Cash">Cash </option>
                        </select>
                    </td> 
                    <td class="buyerData"> <label for="Terms">Terms :</label>
                        <select id="Terms" name="Terms">   
                            <option  value="0" selected>Immediate </option>
                            <option  value="10">10 days </option>
                            <option  value="15">15 days </option>
                            <option  value="30">30 days </option>
                            <option  value="60">60 days </option>

                        </select>
                    </td>  
                </tr>
                <tr>
                    <td class="buyerData"> <label for="PreferredDeliveryMethod">Preferred Delivery Method:</label>
                        <select id="PreferredDeliveryMethod" name="PreferredDeliveryMethod">                   
                            <option  value="None">None </option>
                            <option  value="Print">Print </option>
                            <option  value="Email">Email </option>
                        </select>
                    </td>                    
                </tr>
            </table>           
        </form>
        <% if (Action.equalsIgnoreCase("Create")) {%>
        <br><br>
        <button class="buyerData" style="text-align:left" form="BuyerForm" name="Action" value="Save" type="Submit" onclick="Disabled = true">Save Buyer</button>
        <%}%>
        <br><br>
        <button type="button" style="text-align:left" onclick="window.location.href = 'buyerAccounts?time=<%=java.time.Instant.now().getEpochSecond()%>'">Back</button>
        <%@include  file="../jspf/footer.jspf" %>
