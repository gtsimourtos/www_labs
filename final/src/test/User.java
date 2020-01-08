package test;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="db.users")
public class User {
	@Id
	String username;
    
     String  name, surname,email, department;
     String Password = null;
     int year;

	public String getName(){
	return name;
	}
	public void setName(String Name){
	this.name = Name;
	}
	public String getUsername(){
	return username;
	}
	public void setUsername(String Name){
	this.username = Name;
	}
	public String getSurname(){
	return surname;
	}
	public void setSurname(String Name){
	this.surname = Name;
	}
	
	public String getEmail(){
	return email;
	}
	public void setEmail(String Name){
	this.email = Name;
	}
	
	public String getPassword(){
	     return Password;
	}
	public void setPassword(String Password){
	     this.Password = Password;
	}
	
	public String getDepartment(){
	     return department;
	}
	public void setDepartment(String department){
	     this.department = department;
	}
	
	public int get_year(){
	     return year;
	}
	public void set_year(int year){
	this.year = year;
	}
	     
}
