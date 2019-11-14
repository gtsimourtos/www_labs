package www;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import www.Login;
import www.LoginDao;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	 private static final long serialVersionUID = 1;
	    private LoginDao loginDao;

	    public void init() {
	        loginDao = new LoginDao();
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {

	        String username = request.getParameter("username");
	        String password = request.getParameter("password");
	        Login login = new Login();
	        login.setUsername(username);
	        login.setPassword(password);

	        try {
	            if (loginDao.validate(login)) {
	                response.sendRedirect("loginsuccess.jsp");
	            } else {
	                response.sendRedirect("loginfail.jsp");
	            }
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	        }
	    }
}
