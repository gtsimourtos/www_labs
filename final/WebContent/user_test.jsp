<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="test.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 

<!DOCTYPE html>
<html>

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
if(request.getParameter("username") != null)
	userName = request.getParameter("username");
%>

<head>

<title>StudentsBase - User <%=userName %></title>
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


<body>

<ul>
<%
String link = null;
String title = null;
if (userName != null) {link = "user_test.jsp";title="My Profile";}
else {link = "land.html";title="Home";}%>

    <li><a <%if(request.getParameter("username") == null){ %>class = "active"<%} %> href= <%=link%> ><%=title%></a></li>
    <li><a href="users_list.jsp">Users</a></li>
  <li><a href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a href="logout.jsp">Logout</a></li>
  </ul><h1 style = "text-align:center;color:black">User Full Name</h1>

<%
try {
/* Create string of connection url within specified format with machine
name, port number and database name. Here machine name id localhost and 
database name is student. */
String connectionURL = "jdbc:mysql://localhost:3306/db?serverTimezone=UTC";
// declare a connection by using Connection interface
Connection connection = null;
/* declare object of Statement interface that is used for executing sql 
statements. */
Statement statement = null;
// declare a resultset that uses as a table for output data from tha table.
ResultSet rs = null;
// Load JBBC driver "com.mysql.jdbc.Driver"
Class.forName("com.mysql.cj.jdbc.Driver").getConstructor().newInstance();
/* Create a connection by using getConnection() method that takes parameters 
of string type connection url, user name and password to connect to database.*/
connection = DriverManager.getConnection(connectionURL, "root", "rootgt3655^^");
/* createStatement() is used for create statement object that is used for 
sending sql statements to the specified database. */
statement = connection.createStatement();
// sql query to retrieve values from the secified table.
String QueryString = "SELECT * from users where username = "+'"' + userName+'"';
rs = statement.executeQuery(QueryString);
rs.next();
%>

<div class="card">
  <img src="profile-icon.png" alt="Profile-icon" style="width:100%">
  <h1><%=rs.getString(4)%> <%=rs.getString(5)%></h1>
  <p>Year: <%=rs.getInt(7)%></p>
  <p><%=rs.getString(2)%></p>
  <p><a href="mailto:<%=rs.getString(6)%>"><%=rs.getString(6)%></a></p>
  <a href=" "><i class="fa fa-envelope"></i></a>
</div> 

<%
// close all the connections.
rs.close();
statement.close();
connection.close();
} catch (Exception ex) {
%>
<font size="+3" color="red">
<%
out.println("Unable to connect to database.\n" + ex);
ex.printStackTrace();
}
%>
</font>
</body>
</html>