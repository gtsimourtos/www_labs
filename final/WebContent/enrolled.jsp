<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<% String subject = request.getParameter("subject"); %>

<!DOCTYPE html>
<html>
<%
//allow access only if session exists
String user = null;
if(session.getAttribute("username") == null){
  response.sendRedirect("land.html");
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
<head>

<title>StudentsBase - Users</title>
<style> 
  body{margin:0;height:100%;font-size:150%;
    background-image: url("students.jpg");font-family:courier;<!-- -->
    background-position: center;<!-- -->
    background-repeat: no-repeat;
    background-size: cover;<!-- -->
    background-color: rgba(255,255,255,0.5);background-blend-mode: lighten;<!-- -->
  }
  div{column-count:3 ;}
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
  #link_bar a { padding:1px; font-weight:bold;  }
  #link_bar a:link { color:white; background-color:#333; }
  #link_bar a:visited { color:#c0c0c0; background-color:#333; }
  #link_bar a:hover { color:#ffffff; background-color:#000060; }
  #link_bar a:active { color:#f0f0f0; background-color:#00ff00; }
</style>
</head>
<ul>
    <li><a href= user_test.jsp >My Profile</a></li>
    <li><a class = "active" href="users_list.jsp">Users</a></li>
    <li><a href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a href="logout.jsp">Logout</a></li>
</ul>
<body>

<br><br>
<h1 style = "text-align:center;color:black"><%=subject %> - Enrolled Users</h1>
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
String QueryString = "SELECT * from users where username in (select FK1_username from belongs where FK2_name = " + '"' + subject + '"' + ")";
rs = statement.executeQuery(QueryString);

%>

<TABLE cellpadding="15" border="1" style="background-color: #ffffcc;" align="center">
<TR>
<TD><b>USERNAME</b></TD>
<TD><b>NAME</b></TD>
<TD><b>SURNAME</b></TD>
<TD><b>EMAIL</b></TD>
<TD><b>DEPARTMENT</b></TD>
<TD><b>YEAR</b></TD>
</TR>
<%
while (rs.next()) {
%>
<TR>
<TD><%=rs.getString(1)%></TD>
<TD><%=rs.getString(4)%></TD>
<TD><%=rs.getString(5)%></TD>
<TD><a href="mailto:<%=rs.getString(6)%>"><%=rs.getString(6)%></a></TD>
<TD><%=rs.getString(2)%></TD>
<TD><%=rs.getInt(7)%></TD>
</TR>
<% } %>
<%
// close all the connections.
rs.close();
statement.close();
connection.close();
} catch (Exception ex) {
%>

<font size="+3" color="red"></b>
<%
out.println("Unable to connect to database.");
}
%>
</TABLE>



</body>
</html>