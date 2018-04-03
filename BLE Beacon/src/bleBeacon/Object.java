package bleBeacon;

import java.awt.List;
import java.io.Serializable;
import java.lang.String;
import java.util.Collection;

import javax.persistence.*;
import static javax.persistence.GenerationType.IDENTITY;
import static javax.persistence.CascadeType.ALL;

/**
 * Entity implementation class for Entity: Object
 *
 */
@Entity

public class Object implements Serializable {
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	private int id_;
	private String name_;
	private String type_;
	private String city_;
	private String link_;
	private String about_;
	@OneToMany(cascade = ALL)
	@JoinTable(joinColumns = @JoinColumn(name = "Object_id_", referencedColumnName = "id_"), inverseJoinColumns = @JoinColumn(name = "informations__id_", referencedColumnName = "id_"))
	private Collection<Information> informations_;
	@OneToOne(cascade = ALL)
	@JoinColumn(name = "device__id_", referencedColumnName = "id_")
	private Device device_;
	@ManyToMany(cascade = ALL)
	@JoinTable(inverseJoinColumns = @JoinColumn(name = "members__id_", referencedColumnName = "id_"), joinColumns = @JoinColumn(name = "Object_id_", referencedColumnName = "id_"))
	private Collection<Member> members_;
	private static final long serialVersionUID = 1L;

	public Object() {
		super();
	}   
	public int getId_() {
		return this.id_;
	}

	public void setId_(int id_) {
		this.id_ = id_;
	}   
	public String getName_() {
		return this.name_;
	}

	public void setName_(String name_) {
		this.name_ = name_;
	}   
	public String getType_() {
		return this.type_;
	}

	public void setType_(String type_) {
		this.type_ = type_;
	}   
	public String getCity_() {
		return this.city_;
	}

	public void setCity_(String city_) {
		this.city_ = city_;
	}
	
	public Device getDevice_() {
		return device_;
	}
	public void setDevice_(Device device_) {
		this.device_ = device_;
	}
	public void addMemberToObject(Member member)
	{
		this.members_.add(member);
	}
	public void setMembers_(Collection<Member> members_) {
		this.members_ = members_;
	}
	public Collection<Member> getObjects_() {
		return this.members_;
	}
	public void printMembers(){
		
	}
	public String getLink_() {
		return link_;
	}
	public void setLink_(String link_) {
		this.link_ = link_;
	}
	public String getAbout_() {
		return about_;
	}
	public void setAbout_(String about_) {
		this.about_ = about_;
	}
	public Collection<Information> getInformations_() {
		return informations_;
	}
	public void setInformations_(Collection<Information> informations_) {
		this.informations_ = informations_;
	}
	public void addInformationToObject(Information information)
	{
		this.informations_.add(information);
	}
}
