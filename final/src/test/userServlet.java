package test;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;


/**
 * james
 */

@WebServlet("/register")
public class userServlet extends HttpServlet {
    private static final long serialVersionUID = 1;
    private static EntityManagerFactory factory;
    private static final String PERSISTENCE_UNIT_NAME = "User";


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email =  request.getParameter("email");
        String department =  request.getParameter("department");
        int year = Integer.parseInt(request.getParameter("year"));

        factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        EntityManager em = factory.createEntityManager();
        
        //Check if entry exists
        Query q = em.createQuery("SELECT u FROM User u");
        List<User> userList = q.getResultList();
        int i = 1;
        for (User user : userList) {
        	i++;
             if (username.equals(user.username))	{
            	 response.sendRedirect("userdetails2.jsp");
            	 return;
             }
        }
      
        
	   // Register new user
        em.getTransaction().begin();
	    User user = new User();
	    user.setUsername(username);
	    user.setPassword(password);
	    user.setName(name);
	    user.setSurname(surname);
	    user.setEmail(email);
	    user.setDepartment(department);
	    user.set_year(year);
	    em.persist(user);
	    em.getTransaction().commit();
	        
	   	response.sendRedirect("userdetails.jsp");
    }
}
