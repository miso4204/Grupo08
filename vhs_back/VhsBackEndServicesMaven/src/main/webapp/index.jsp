<%-- 
    Document   : index
    Created on : 01-abr-2015, 18:35:17
    Author     : Andres Vargas
    Author     : Alex Chacon
--%>
<%@ page language="java" import="org.springframework.web.context.WebApplicationContext, org.springframework.web.context.support.WebApplicationContextUtils, com.vhs.aspects.test.services.TestService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
WebApplicationContext webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
TestService testService = (TestService) webApplicationContext.getBean("testService");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>F&aacute;ricas de software :: Universidad de los Andes - VHS Project ::</title>
    </head>
    <body>
        <h1>User Available services</h1>
        <ul>
            <li>http://<%=request.getLocalAddr()%>:<%=request.getLocalPort()%>/VhsBackEndServices/webresources/vhsuser</li>
        </ul>
        
        <h1>Aspects tests</h1>
        <ul>
            <li>Test service invoked with an aspect : <%=testService.sayHello()%></li>
        </ul>
    </body>
</html>
