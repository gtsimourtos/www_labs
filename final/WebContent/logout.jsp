<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="test.*"%>

<!DOCTYPE html>
<html>
<head>
<title>StudentsBase - Welcome</title>
<style> body{margin:0;height:100%;font-size:120%;
background-image: url("sea1.jpg");font-family:courier;<!-- -->
background-position: center; <!-- Center the image -->
  background-repeat: no-repeat;
  background-size: cover; <!-- Resize the background image to cover the entire container -->
  background-color: rgba(255,255,255,0.5);background-blend-mode: lighten;}
li {
  border-right: 1px solid #bbb;
  float:left;
}


li:last-child {
  border-right: none;
}
ul {
display:block;
  list-style-type: none;
  margin: 0;
  padding: 20px;
  overflow: hidden;
  background-color: #333;
  position: fixed;
  position:sticky;
  top: 0;
  width: 100%;
}

li a {
  color: white;
  text-align: center;
  padding:  40px 56px;
  text-decoration: none;
}
.active {
  background-color: #4CAF50;
}

.tweet-body {
  width: 100%;
  text-align: center;
}

.tweet-body textarea {
  overflow: hidden;
  resize: none;
  font-size: 14px;
}
#link_bar a { padding:15px; font-weight:bold;  }
#link_bar a:link { color:white; background-color:#333; }
#link_bar a:visited { color:#c0c0c0; background-color:#333; }
#link_bar a:hover { color:#ffffff; background-color:#000060; }
#link_bar a:active { color:#f0f0f0; background-color:#00ff00; }

.tweet-body {
  width: 100%;
  text-align: center;
}

.tweet-body textarea {
  overflow: hidden;
  resize: none;
  font-size: 14px;
}

.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  margin: auto;
  text-align: center;
}

.title {
  color: grey;
  font-size: 18px;
}

button {
  border: none;
  outline: 0;
  display: inline-block;
  padding: 8px;
  color: white;
  background-color: #000;
  text-align: center;
  cursor: pointer;
  width: 100%;
  font-size: 18px;
}

a {
  text-decoration: none;
  color: black;
}

button:hover, a:hover {
  opacity: 0.7;

</style>
</head>


<body style="background-image: url(sea1.jpg)">
<%
//allow access only if session exists
String user = null;
if(session.getAttribute("username") == null){
	response.sendRedirect("login.jsp");
}else user = (String) session.getAttribute("username");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
	if(cookie.getValue().equals(user)) userName = cookie.getValue();
	if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}
%>
<ul>
    <li><a href= user_test.jsp >My Profile</a></li>
    <li><a href="users_list.jsp">Users</a></li>
    <li><a href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a class = "active" href="logout.jsp">Logout</a></li>
</ul>
<br><br><br>
  <h1 style = "text-align:center;color:black">Hi <%=userName %>, you want to log out?</h1>
  
  <br>
  <center>
<form action="<%=response.encodeURL("logout") %>" method="post">
<input type="submit" value="Logout" >

</form>
</center>
</body>
</html>