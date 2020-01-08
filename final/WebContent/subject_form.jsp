<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="test.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<% String subject = request.getParameter("subject"); %>

<!DOCTYPE html>
<html>
<head>

<title>StudentsBase - Subjects</title>
<style> body{margin:0;height:100%;font-size:150%;
background-image: url("books.jpg");font-family:courier;<!-- -->
background-position: center; <!-- -->
  background-repeat: no-repeat; 
  background-size: cover; <!-- -->
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
#link_bar a { padding:15px; font-weight:bold;  }
#link_bar a:link { color:white; background-color:#333; }
#link_bar a:visited { color:#c0c0c0; background-color:#333; }
#link_bar a:hover { color:#ffffff; background-color:#000060; }
#link_bar a:active { color:#f0f0f0; background-color:#00ff00; }
</style>
</head>
<body>

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
    <li><a class = "active" href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a href="logout.jsp">Logout</a></li>
</ul>


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
Statement statement = null, statement2 = null, statement3 = null;
// declare a resultset that uses as a table for output data from tha table.
ResultSet rs = null, rs2 = null;
// Load JBBC driver "com.mysql.jdbc.Driver"
Class.forName("com.mysql.cj.jdbc.Driver").getConstructor().newInstance();
/* Create a connection by using getConnection() method that takes parameters 
of string type connection url, user name and password to connect to database.*/
connection = DriverManager.getConnection(connectionURL, "root", "rootgt3655^^");
/* createStatement() is used for create statement object that is used for 
sending sql statements to the specified database. */
statement = connection.createStatement();
statement2 = connection.createStatement();
// sql query to retrieve values from the secified table.
String QueryString = "SELECT description from subjects where name = " + '"' + subject + '"';
String QueryString2 = "SELECT * from belongs where FK1_username = " + '"' + userName + '"' + "and FK2_name =" + '"' + subject + '"';
rs = statement.executeQuery(QueryString);
rs2 = statement2.executeQuery(QueryString2);
rs.next();

%>

<br><br><br>

<h1 style = "text-align:center;color:black"><%=subject%></h1>

<h3 style = "text-align:center;color:black"> 
<br><%=rs.getString(1) %><br><br><br><br>
</h3>

<%if (rs2.next() == false) 
{


if (request.getParameter("enroll") != null) {
	statement3 = connection.createStatement();
	String QueryString3 = "insert into belongs values (" + '"' + userName + '"' + "," + '"' + subject + '"' + ")";
	int i = statement3.executeUpdate(QueryString3);
}
else	{
	%>
	<div id = "link_bar" align = "center">
	<a href="subject_form.jsp?subject=<%=subject%>&enroll=sth">+Enroll</a>
	</div>
	<br><br>
	<%
}
}%>

<%
// close all the connections.
rs.close();
rs2.close();
statement.close();
connection.close();
} catch (Exception ex) {
  out.println("Unable to connect to database.");
  }
%>

<div id = "link_bar" align = "center">
<a href="discussions.jsp?subject=<%=subject%>">Discussions</a>
<a href="enrolled.jsp?subject=<%=subject%>">Enrolled</a>
<a href="find_team.jsp?subject=<%=subject%>">Find Team</a>
</div>

</body>
</html>