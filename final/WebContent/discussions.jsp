<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="test.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 

<% String subject = request.getParameter("subject"); 
int counter = 1;%>

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

<title>StudentsBase - Discussions</title>
<style> body {margin:0;height:100%;font-size:120%;
background-image: url("discussions.jpg");font-family:courier;
background-position: center; 
  background-repeat: no-repeat;
  background-size: cover;
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
</style>
</head>
<body>
<ul>
    <li><a href= user_test.jsp >My Profile</a></li>
    <li><a href="users_list.jsp">Users</a></li>
    <li><a class = "active" href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a href="logout.jsp">Logout</a></li>
</ul>

<br><br>
<h1 style = "text-align:center;color:black"><%=subject %> - Discussions</h1>

<br><br>
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
String QueryString = "SELECT * from discussions WHERE is_question = 1 AND FK1_name = '"+subject+"'";
rs = statement.executeQuery(QueryString);

%>

<TABLE cellpadding="15" border="1" style="background-color: #ffffcc;" align="center">
<TR>
<TD><b>USERNAME</b></TD>
<TD><b>TITLE</b></TD>
</TR>
<%
while (rs.next()) {
	
%>
<TR>
<TD><a href="user_test.jsp?username=<%=rs.getString(6)%>"><%=rs.getString(6)%></a></TD>
<TD><a href="discussions_form.jsp?discussion=<%=rs.getInt(1)%>"><%=rs.getString(2)%></a></TD>
<%if(userName.equals(rs.getString(6))) {
	%><TD><a href="del_entry.jsp?username=<%=rs.getString(6)%>&subject=<%=rs.getString(5)%>&title=<%=rs.getString(2)%>&is_question=<%=rs.getString(3)%>">DELETE</a></TD>
<%	
}
%>
</TR>
<% } %>


<%
// close all the connections.
rs.close();
statement.close();
connection.close();
} catch (Exception ex) {
  out.println("Unable to connect to database.");
  }
%>
</TABLE>
<br><br><br>
<div id = "link_bar" align="center">
<a href="discussion_create.jsp?counter=<%=counter%>&subject=<%=subject%>">+Create new discussion</a>
</div>


</body>
</html>
