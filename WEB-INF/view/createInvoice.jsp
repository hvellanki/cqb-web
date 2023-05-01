h<%-- 
    Document   : createInvoice
    Created on : Jul 6, 2021, 8:11:29 PM
    Author     : hari-work
--%>
<%@page import="java.util.*" import="cqb.data.*" import="cqb.db.*" import="cqb.svc.*" import="cc.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/cqb.css?<%=Calendar.getInstance().get(Calendar.MINUTE)%>">

        <style>
            table.amounts{
                width:60%;
                padding-right:0px;
                padding-right:0px;
                table-layout: auto;
            }
            form.amounts, input.amounts{
                padding:0px;
            }
            input.amounts{
                text-align: left;
            }
            label {
                display: inline-block;
                width: 160px;
                text-align: right;
            }​
        </style>
        <script src="scripts/jquery-3.6.0.js""></script>
    </head>
    <body style="width: 80%;">
        <h1 align="center"><span style="background-color: #d5f4e6;">Bill360</span></h1>
        <h2 class="SecondaryHeader" align="center"> <%= session.getAttribute("SupplierName")%> </h2>

        <% List itemsList = (List) request.getAttribute("ItemsList");
            List buyersList = (List) request.getAttribute("BuyersList");
            Props PropsObj = Props.getReference("cqb");
            String HostName = PropsObj.getProperty("B360Host");
            //Supplier supplierObj = (Supplier) request.getAttribute("SupplierObj");
        %>
        <p align="left"> 
        <h2>NEW INVOICE </h2>
    </p>


    <script>
        var jBuyers = [];
        <% for (int i = 0; i < buyersList.size(); i++) {
                Buyer buyer = (Buyer) buyersList.get(i);%>
        jBuyers[<%=i%>] = {Id: "<%=buyer.getBuyerId()%>", Name: "<%=buyer.getCustomerName()%>", Email: "<%=buyer.getEmailAddress()%>",
            Address: "<%=buyer.getBillAddress()%>"};
        <%}%>
        var jItems = [];
        <% for (int i = 0; i < itemsList.size(); i++) {
                Item item = (Item) itemsList.get(i);%>
        jItems[<%=i%>] = {Id: "<%=item.getItemId()%>", Name: "<%=item.getName()%>", Description: "<%=item.getDescription()%>",
            Rate: "<%=item.getUnitPrice()%>"};
        <%}%>
        var DetailMsg = jBuyers[0].RateDetail;
    </script>

    <script>
        function getDueDate(Days) {
            var ms = new Date().getTime() + Days * 86400000;
            var D = new Date(ms);
            var DueD = "" + (D.getMonth() + 1) + "/" // 10 (PS: +1 since Month is 0-based)
                    + D.getDate() + "/"    // 30
                    + D.getFullYear();  // 2021
            return DueD;
        }
        $(document).ready(function () {
            $("#Email").val(jBuyers[0].Email);
            $("#Address").val(jBuyers[0].Address);
            $("#TaxRate").val(jBuyers[0].TaxRate);
            $("#DueDate").val(getDueDate($("#Terms").val()));

            $("#Buyers").change(function () {
                var index = $("#Buyers option:selected").index();

                $("#Email").val(jBuyers[index].Email);
                $("#Address").val(jBuyers[index].Address);
                $("#TaxRate").val(jBuyers[index].TaxRate);
                DetailMsg = jBuyers[index].RateDetail;
                setTaxedAmounts();

            });

            $("#Terms").change(function () {
                var DueD = getDueDate($("#Terms").val());
                $("#DueDate").val(DueD);
            });

            var LineNum = 1;

            $("select.SelectItem").change(function () {
                var index = $(this).prop('selectedIndex');
                var CurrentRow = $(this).parent();
                CurrentRow.siblings(".Description").text(jItems[index].Description);
                var RateElem = CurrentRow.siblings(".Rate").children();
                var QtyElem = CurrentRow.siblings("td.Qty").children();
                $(RateElem).val(jItems[index].Rate);
                $(QtyElem).val(1);
                var AmountElem = CurrentRow.siblings(".Amount").children();
                $(AmountElem).val($(QtyElem).val() * $(RateElem).val());
                setAmounts();
            });
            $("input.Qty").change(function () {

                var QtyVal = $(this).val();
                var CurrentRow = $(this).parent();
                var RateElement = CurrentRow.siblings("td.Rate").children();
                var RateVal = RateElement.val();
                var AmountElem = CurrentRow.siblings("td.Amount").children();
                $(AmountElem).val(QtyVal * RateVal);
                setAmounts();
            });
            $("input.Rate").change(function () {
             var CurrentRow = $(this).parent();
             var QtyVal = CurrentRow.siblings("td.Qty").children().val();
             var RateVal = $(this).val();
             var AmountElem = CurrentRow.siblings("td.Amount").children();
             $(AmountElem).val(QtyVal * RateVal);
             setAmounts();
             });
            $(".add").click(function () {
                var rows = $(".iData");
                var newRow = rows.first().clone(true, true);
                LineNum++;
                newRow.find('input').val('');
                newRow.children(".LineNum").children().val(LineNum);
                rows.last().after(newRow);
            });


            /*$("#TaxRate").change(function () {
             setTaxedAmounts();
             });*/

            $("#DiscountPercent").change(function () {
                setTaxedAmounts();
            });

            
            $("form").submit(function () {

                var this_master = $(this);

                this_master.find('input[type="checkbox"]').each(function () {
                    var checkbox_this = $(this);

                    if (checkbox_this.is(":checked") === true) {
                        checkbox_this.attr('value', 'TAX');
                    } else {
                        checkbox_this.prop('checked', true);
                        //DONT' ITS JUST CHECK THE CHECKBOX TO SUBMIT FORM DATA    
                        checkbox_this.attr('value', 'NON');
                    }
                });
            });


        });

        function showTaxRates() {
            alert(DetailMsg);
        }
        function setAmounts() {
            $("#SubTotal").val(getSubTotal());
            setTaxedAmounts();
        }

        function getSubTotal() {
            var SubTotal = 0.0;
            $("input.Amount").each(function () {
                SubTotal += Number($(this).val());
            });
            return SubTotal;
        }

        function getTaxableSubTotal() {
            var TaxableSubTotal = 0.0;
            $("input.Amount").each(function () {
                var CurrentRow = $(this).parent();
                var TaxableElement = CurrentRow.siblings("td.Taxable").children();
                if (TaxableElement.prop("checked")) {
                    TaxableSubTotal += Number($(this).val());
                }
            });
            return TaxableSubTotal;
        }
        function setTaxedAmounts() {
            var TaxableSubTotal = getTaxableSubTotal();
           /* var Discount = $("#SubTotal").val() * ($("#DiscountPercent").val() / 100); //).toFixed(2);;
            Discount = Number(Discount).toFixed(2);
            $("#Discount").val(Discount);

            var TaxableItemsDiscount = TaxableSubTotal * ($("#DiscountPercent").val() / 100);
            var TaxableAmount = TaxableSubTotal - TaxableItemsDiscount;*/
        
        var TaxableAmount = TaxableSubTotal;

            var Tax = 0.00;
            if (TaxableAmount > 0) {
                Tax = TaxableAmount * ($("#TaxRate").val() / 100); //).toFixed(2);;
                Tax = Number(Tax).toFixed(2);
            }
            $("#Tax").val(Tax);
            TaxableAmount = Number(TaxableAmount).toFixed(2);
            $("#TaxableAmount").val(TaxableAmount);

            //var Total = +1 * $("#SubTotal").val() - 1 * $("#Discount").val() + 1 * Tax ;
            var Total = +1 * $("#SubTotal").val()  + 1 * Tax ;
            Total = Number(Total).toFixed(2);
            $("#Total").val(Total);
            $("#Balance").val($("#Total").val());


        }


    </script>

    <form method="POST" id="SaveInvoice" action="<%=HostName%>/saveInvoice"  style="text-align:left; border:none"> 
        <table class="nbTable">
            <tr class="nbTable">
                <td class="nbTable"> <label for="Buyers">Buyer:</label>
                    <select id="Buyers" name="BuyerId">
                        <% for (int i = 0; i < buyersList.size(); i++) {
                                Buyer buyer = (Buyer) buyersList.get(i);%>

                        <option  value="<%=buyer.getBuyerId()%>"><%=buyer.getContactName()%> </option>
                        <%}%>
                    </select>
                </td>
                <td class="nbTable"><label for="Email">Buyer Email:</label>
                    <input class="buyerForm disable" type="Email" id="Email" name="Email" required>
                </td>
            </tr>
            <tr class="nbTable"><td class="nbTable"><label for="Address">Buyer Address:</label><br>
                    <textarea id="Address" class="disable" name="address" rows="4" cols="20" align="left"></textarea>
                </td>
                <td class="nbTable"><label for="Terms">Terms:</label><br>               
                    <select class="buyerForm" id="Terms" type="text" name="Terms" >
                        <option value="30">Net 30</option>
                        <option value="15">Net 15</option>
                    </select>
                </td>
                <td class="nbTable"><label for="InvoiceDate">Invoice Date:</label><br>
                    <input class="buyerForm disable" type="text" id="InvoiceDate" name="InvoiceDate" align="left" value="<%=SvcUtil.getCurrentDate()%>">                
                </td>
                <td class="nbTable"><label for="DueDate">Due Date:</label><br>
                    <input class="buyerForm disable" type="text" id="DueDate" name="DueDate" align="left"  required>
                </td>
            </tr>
        </table>
        <br><br>
        <!--form id="Items"-->
        <table class="bTable" style="width:90%; table-layout: auto;">
            <tr class="bRow">
                <th class="bData"></th>
                <th class="bData">Item No.</th>
                <th class="bData">Product/Service</th>
                <th class="bData">Description</th>
                <th class="bData">QTY</th>
                <th class="bData">RATE</th>
                <th class="bData">Amount</th>
                <th class="bData">Taxable</th>
            </tr>  
            <tr class="iData bRow" >
                <td  class="bData" ><a href="#" class="add" >+</a></td>
                <td  class="LineNum bData"><input class="itemForm disable" type="number" style="text-align: center" name="LineNumber" value="1" ></td>
                <td  class="bData" >              
                    <select class="SelectItem" name="ItemId" > 
                        <% for (int i = 0; i < itemsList.size(); i++) {
                                Item item = (Item) itemsList.get(i);%>

                        <option value="<%=item.getItemId()%>"><%=item.getName()%></option>
                        <%}%>
                </td>
                <td  class="Description bData" ></td>
                <td  class="Qty bData"><input class="itemForm Qty" type="number"   name="Qty" size="5" required></td>
                <td  class="Rate bData"><input class="itemForm Rate" type="number"  name="Rate" size="5" required></td>
                <td  class="Amount bData"><input class="itemForm Amount disable" type="number" name="Amount" size="10" required></td>
                <td  class="Taxable bData"><input class="itemForm Taxable" checked type="checkbox" name="Taxable" onchange="setAmounts()" value="Tax"></td>
            </tr>  
        </table>

        <br>


        <table class="amounts" style="text-align: right;  border:none; padding-right: 0px; float:right">
            <tr class="amounts" style="text-align: right; border:none">
                <td colspan="2" class="amounts" style="text-align: right; border:none"><label for="SubTotal">SubTotal&nbsp;&nbsp;&nbsp;&nbsp;  :</label>
                    <input  class="disable amounts" style="text-align: left; border:none; padding-right: 20px;" size="10" type="text" id="SubTotal" value="0.0" name="SubTotal">
            </tr>
            <!--tr class="amounts" style="text-align: right; border:none">
                <td colspan="2" class="amounts" style="text-align: right; border:none"><label for="DiscountPercent">DiscountPercent&nbsp;&nbsp;&nbsp;&nbsp;  :</label>
                    <input   style="text-align: left; border:none; padding-right: 20px;" size="10" type="text" id="DiscountPercent" value="0.0" name="DiscountPercent">
            </tr> 
            <tr class="amounts" style="text-align: right; border:none">
                <td colspan="2"class="amounts" style="text-align: right; border:none"><label for="Discount">Discount&nbsp;&nbsp;&nbsp;&nbsp;  :</label>
                    <input  class="disable amounts" style="text-align: left; border:none; padding-right: 20px;" size="10" type="text" id="Discount" value="0.00" name="Discount" >
            </tr-->
            <tr class="amounts" style="text-align: right; border:none">
                <td colspan="2" style="text-align: right; border:none"><label for="TaxableAmount">TaxableAmount&nbsp;&nbsp;&nbsp;&nbsp;  :</label>
                    <input  class="disable amounts" style="text-align: left; border:none; padding-right: 20px;" size="10" type="text" id="TaxableAmount" value="0.00" name="TaxableAmount" >
            </tr>
            <tr class="amounts" style="text-align: right; border:none">
                <td colspan="2" class="amounts" style="text-align: right; border:none"><label for="TaxRate">Tax Rate(Percent)&nbsp;&nbsp;&nbsp;&nbsp;  :</label>
                    <input id="TaxRate" class="disable amounts" style="text-align: left; border:none; padding-right: 20px;" size="10" type="text" id="TaxRate" name="TaxRate" value="0.00">
                    <br><span  style="font-weight: bold; color:blue; font-size: 12px; border:none" onclick="showTaxRates()">See the Math</span></td>
            </tr>
            <tr class="amounts" style="text-align: right; border:none">
                <td colspan="2" class="amounts" style="text-align: right; border:none"><label for="Tax">Tax&nbsp;&nbsp;&nbsp;&nbsp;  :</label>
                    <input class="disable amounts" style="text-align: left; border:none; padding-right: 20px;" size="10" type="text" id="Tax" name="Tax" value="0.00">
            </tr>
          
            <tr>
                <td colspan="2" class="amounts" style="text-align: right; border:none"><label for="Total">Total&nbsp;&nbsp;&nbsp;&nbsp;  :</label>
                    <input class="disable amounts" style="text-align: left; border:none; padding-right: 20px;" size="10" type="text" id="Total" value="0.00" name="Total" required> 
                </td>
            </tr>
            <tr style="height: 15px;"/>
            <tr class="amounts" style="text-align: right; border:none">
                <td class="amounts" style="text-align: right; border:none">
                    <button align="right" name="Action" value="Save" type="Submit" onclick="Disabled = true">Save</button>
                </td>
                <!--td class="amounts" style="text-align: right; border:none">
                    <button align="right" name="Action" value="SaveSend" type="Submit" onclick="Disabled = true">Save and Send</button>
                </td-->
            </tr>

        </table>


        <br>


        <!--table style="text-align: right; table-layout: auto; border:none; padding-top: 600px; padding-right: 10px;">
            <tr style="text-align: right; border:none">
                <td style="text-align: right; border:none">
                    <button align="right" name="Action" value="Save" type="Submit" onclick="Disabled = true">Save</button>
                </td>
                <td style="text-align: right; border:none">
                    <button align="right" name="Action" value="SaveSend" type="Submit" onclick="Disabled = true">Save and Send</button>
                </td>
            </tr>
        </table-->
    </form>


    <label for="Memo" style="text-align:left; margin-right: 200px;">Memo:</label><br>
    <textarea id="NewMsg"   form="SaveInvoice" style="margin-left: 0px; margin-right: 100px;"  name="Memo" rows="5" cols="40"></textarea> <br>
    <br>
    <br>
    <br>
    <br>

</body>

</html>

