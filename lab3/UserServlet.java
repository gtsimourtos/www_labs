package www;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import www.User;
import www.UserDao;

@WebServlet("/register")
public class UserServlet extends HttpServlet{
	 private static final long serialVersionUID = 1;
	    private UserDao userDao;

	    public void init() {
	    	userDao = new UserDao();
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
	        String username = request.getParameter("username");
	        String password = request.getParameter("password");

	        User user = new User();
	        user.setUsername(username);
	        user.setPassword(password);

	        try {
	        	if(userDao.registerUser(user) != 0)
	        		response.sendRedirect("userdetails.jsp");
	        	else
	        		response.sendRedirect("conflict.jsp");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
}
