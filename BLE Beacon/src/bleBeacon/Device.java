package bleBeacon;

import java.io.Serializable;
import java.lang.String;
import java.util.Collection;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;
import static javax.persistence.CascadeType.ALL;

/**
 * Entity implementation class for Entity: Device
 *
 */
@Entity

public class Device implements Serializable {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	private int id_;
	
	private String uuid_;
	private String address_;
	private String major_;
	private String minor_;
	@OneToOne(cascade = ALL)
	@JoinColumn(name = "object__id_", referencedColumnName = "id_")
	private Object object_;
	private static final long serialVersionUID = 1L;

	public Device() {
		super();
	}   
	public int getId_() {
		return this.id_;
	}

	public void setId_(int id_) {
		this.id_ = id_;
	}   

	public String getAddress_() {
		return this.address_;
	}

	public void setAddress_(String address_) {
		this.address_ = address_;
	}
	public Object getObject_() {
		return object_;
	}
	public void setObject_(Object object_) {
		this.object_ = object_;
	}
	public String getUuid_() {
		return uuid_;
	}
	public void setUuid_(String uuid_) {
		this.uuid_ = uuid_;
	}
	public String getMajor_() {
		return major_;
	}
	public void setMajor_(String major_) {
		this.major_ = major_;
	}
	public String getMinor_() {
		return minor_;
	}
	public void setMinor_(String minor_) {
		this.minor_ = minor_;
	}
	
}
