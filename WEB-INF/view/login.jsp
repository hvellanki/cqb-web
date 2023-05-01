<%-- 
    Document   : Login
    Created on : May 26, 2021, 8:55:17 PM
    Author     : hari-work
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cc.util.*" import="cc.db.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/cqb.css">
        <title>Bill360</title>
    </head>

    <body>
        <h1 align="center"><span style="background-color: #d5f4e6;">Bill360 QB DeskTop Prototype</span></h1>
        <h2 id="SecondaryHeader" align="center"> Login </h2>
        <% Entity.setAppSpace("cqb");
            Props PropsObj = Props.getReference("cqb");
            String HostName = PropsObj.getProperty("B360Host");
            String ErrorMsg = (String) session.getAttribute("ErrorMsg");
            if (ErrorMsg != null) {
                out.println(ErrorMsg);
            }%>
        <br><br>
        <form class="Login" method="POST" action="<%=HostName%>/verifyLogin" style="text-align:center;  margin:50px 450px 100px 450px;" >                
            <b>UserId</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input class="Login" type="text" name="UserId"  
                                                                     style="text-align: left; padding:5px;"><br><br>
            <b>Password</b> <input class="Login" type="password" name="Password"  style="text-align: left; padding:5px;"><br><br>
            <button type="submit" onclick="Disabled = true" style="text-align:center; padding:5px 30px 5px 30px ; ">Login</button>
        </form>
    </body>

</html>
