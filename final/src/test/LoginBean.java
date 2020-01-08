package test;


import java.io.Serializable;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class LoginBean implements Serializable{
     
	private static final long serialVersionUID = 1 ;
      private static final String PERSISTENCE_UNIT_NAME = "User";
      private static EntityManagerFactory factory;
     
     private String userName;
     private String password;
     public LoginBean() { }
     public String getUserName() { return userName; }
     public void setUserName(String userName) { this.userName=userName; }
     public String getPassword() { return password; }
     public void setPassword(String password) { this.password=password; }
     public String validate() {
          String flag="failure";
              factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
            EntityManager em = factory.createEntityManager();
            Query q = em.createQuery("SELECT u FROM User u WHERE u.username = :username AND u.Password = :password");
           q.setParameter("username", userName);
           q.setParameter("password", password);
           try{
               User user = (User) q.getSingleResult();
             if (userName.equalsIgnoreCase(user.username)&&password.equals(user.Password)) {
                flag="success";
             }
           }catch(Exception e){      
               return null;
           }

          return flag;
     }
}

/*import java.io.Serializable;

public class LoginBean implements Serializable{
	private static final long serialVersionUID = 1 ;
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}*/
