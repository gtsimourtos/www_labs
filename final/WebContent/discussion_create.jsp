<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="test.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 

<!DOCTYPE html>
<html>
<head>

<title>StudentsBase - Create a Discussion</title>
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
String subject = request.getParameter("subject");
String counter = request.getParameter("counter");
%>
<ul>
    <li><a href= user_test.jsp >My Profile</a></li>
    <li><a href="users_list.jsp">Users</a></li>
    <li><a class = "active" href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a href="logout.jsp">Logout</a></li>
</ul>
<br><br><br>
<h1 style = "text-align:center;color:black">Create a discussion</h1>

    
<div align="center">
  <form action="discussion_create.jsp?counter=<%=counter%>&subject=<%=subject%>" method="post">
   <table style="with: 100%">
    <tr>
     <td>Title</td>
     <td><input type="text" name="title" /></td>
    </tr>
    <tr>
     <td>Text</td>
     <td><div class="tweet-body">
        <textarea class="status" name="status" placeholder="Insert text" rows="5" cols="60"></textarea><br>
        <input type="submit" value="Submit" />
      </div></td>
    </tr>
    </table>
    <%
String title = request.getParameter("title");
String status = request.getParameter("status");
String connectionURL = "jdbc:mysql://localhost:3306/db?serverTimezone=UTC";
Connection connection = null;
PreparedStatement pstatement = null;
int updateQuery = 0;
if(title!=null && status!=null)
{
if(title!="" && status!="")
{
try {
Class.forName("com.mysql.cj.jdbc.Driver").getConstructor().newInstance();
connection = DriverManager.getConnection(connectionURL,"root","rootgt3655^^");
String queryString = "insert into discussions(title,is_question,question,FK1_name,FK2_username) values(?,?,?,?,?)";
pstatement = connection.prepareStatement(queryString);
pstatement.setString(1, title);
pstatement.setString(2, "1");
pstatement.setString(3, status);
pstatement.setString(4, subject);
pstatement.setString(5, userName);
updateQuery = pstatement.executeUpdate();
if (updateQuery != 0) {%>
<br>
<TABLE style="background-color: #E3E4FA;" border="1">
<tr><th>Data is inserted successfully in database.</th></tr>
<%
response.sendRedirect("discussions.jsp?subject="+subject);
%>
</table>

<%
}
} 
catch (Exception ex){
out.println("\nUnable to connect to database. " + ex);
ex.printStackTrace();
}finally {
// close all the connections.
pstatement.close();
connection.close();
}
}
}
%>
</FORM>
    
</div>



</body>
</html>