<%-- 
    Document   : displayJson
    Created on : Nov 19, 2021, 10:55:37 PM
    Author     : hari-work
--%>

<%@page import="java.util.List" import="cqb.db.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/cqb.css">
        <style>           
            table, th, td {
                border:none;
                border-collapse: collapse;
                /*border: none;*/
                width: 50%;
                table-layout: fixed;
            }
            #copyB{
                margin-left: 360px;
                margin-top:10px;
                margin-bottom:750px;
                border-radius: 12px; 
                background-color: greenyellow;
                text-align: center; 
                width:60px; 
                height:30px; 
                font-size: 16px;
            }

        </style>
        <script src="scripts/jquery-3.6.0.js"></script>
        <script src="scripts/jquery.beautify-json.js"></script>

    </head>
    <body>
        <h1 align="center"><span style="background-color: #d5f4e6;">Bill360 QBO Prototype</span></h1>
        <h2 class="SecondaryHeader" align="center"> <%= session.getAttribute("SupplierName")%> </h2>

        <% JsonRep repObj = (JsonRep) request.getAttribute("JsonObj");%>
        <h3 align="center"><%=request.getAttribute("EntityName")%> response </h3>

        <script>
            function copyToClipboard() {
                /* Get the text field */
                var copyText = document.getElementById("JsonText");
                var textArea = document.createElement("textarea");
                textArea.value = copyText.textContent;
                document.body.appendChild(textArea);
                textArea.select();
                document.execCommand("Copy");
                textArea.remove();
                /* Alert the copied text */
                alert("Copied the text to Clipboard");
            }
            ;
            /*$('.container').beautifyJSON();
             $('.container').beautifyJSON({
             type: "plain"
             });
             $(document).ready(function () {
             let txt = JSON.stringify(<%=repObj.getJsonValue()%>, null, "<br>  ");              
             $("#JsonText").text(txt);
             });  */

        </script>


        <table> <tr>
                <td>
                    <div class="container" id="JsonText"  style="margin-left: 300px; width:375px;  height:800px;  text-align: left; border-style:solid; overflow:auto; overflow-break:normal" >
                        <%=repObj.getJsonValue()%></div>

                </td>          
                <td>
                    <button id="copyB" onclick="copyToClipboard()">
                        Copy
                    </button> 
                </td>
            </tr>
        </table>  


        <br>
        <p align="center">
            <button type="button" align="center"  onclick="window.location.href = 'topMenu?time=<%=java.time.Instant.now().getEpochSecond()%>'">Continue</button>
        </p>
        <%@include  file="../jspf/footer.jspf" %>
