package bleBeacon;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;

import javax.persistence.*;
import static javax.persistence.GenerationType.IDENTITY;
import static javax.persistence.CascadeType.ALL;
import static javax.persistence.FetchType.EAGER;
import org.eclipse.persistence.annotations.JoinFetch;

import static org.eclipse.persistence.annotations.JoinFetchType.INNER;

/**
 * Entity implementation class for Entity: Member
 *
 */
@Entity

public class Member implements Serializable {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	private int id_;
	private String first_name_;
	private String last_name_;
	private String username_;
	private String password_;
	private String email_;
	private String role_;
	@ManyToMany(cascade = ALL)
	@JoinTable(joinColumns = @JoinColumn(name = "Member_id_", referencedColumnName = "id_"), inverseJoinColumns = @JoinColumn(name = "objects__id_", referencedColumnName = "id_"))
	private Collection<Object> objects_; 
	private static final long serialVersionUID = 1L;

	public Member() {
		super();
	}

	public int getId_() {
		return id_;
	}

	public void setId_(int id_) {
		this.id_ = id_;
	}

	public String getFirst_name_() {
		return first_name_;
	}

	public void setFirst_name_(String first_name_) {
		this.first_name_ = first_name_;
	}

	public String getLast_name_() {
		return last_name_;
	}

	public void setLast_name_(String last_name_) {
		this.last_name_ = last_name_;
	}

	public String getUsername_() {
		return username_;
	}
	
	public void setMember(String first_name_,String last_name_,String username_,String password_,String email_,String role_){
		this.first_name_=first_name_;
		this.last_name_=last_name_;
		this.username_=username_;
		this.password_=password_;
		this.email_=email_;
		this.role_=role_;
	}

	public void setUsername_(String username_) {
		this.username_ = username_;
	}

	public String getPassword_() {
		return password_;
	}

	public void setPassword(String password_) {
		this.password_ = password_;
	}

	public String getEmail_() {
		return email_;
	}

	public void setEmail_(String email_) {
		this.email_ = email_;
	}

	public String getRole_() {
		return role_;
	}

	public void setRole_(String role_) {
		this.role_ = role_;
	}

	public Collection<Object> getObjects_() {
		return objects_;
	}

	public void setObjects_(Collection<Object> objects_) {
		this.objects_ = objects_;
	}
	
	public void addObjectToMember(Object object)
	{
		this.objects_.add(object);
	}

	public void printObjects() {
		Iterator<Object>iterator = this.objects_.iterator();
		while(iterator.hasNext())
		{
			Object a=iterator.next();
			System.out.println("Odgovor:"+" "+a.getName_()+" Tacan: "+a.getCity_());
		}
	}
}
