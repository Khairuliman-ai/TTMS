<%-- 
    Document   : logout
    Created on : 10 May 2025, 7:19:32 am
    Author     : wanmu
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the user session
    session.invalidate();

    // Redirect to login page
    response.sendRedirect("login.jsp");
%>
