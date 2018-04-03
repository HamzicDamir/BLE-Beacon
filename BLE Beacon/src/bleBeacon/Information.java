package bleBeacon;

import java.io.Serializable;
import java.lang.String;
import javax.persistence.*;
import static javax.persistence.GenerationType.IDENTITY;
import static javax.persistence.CascadeType.ALL;
@Entity
public class Information implements Serializable {
	   
	@Id
	@GeneratedValue(strategy = IDENTITY)
	private int id_;
	private String text_;
	private String date_;
	private String link_;
	private String type_;
	private static final long serialVersionUID = 1L;
	@ManyToOne(cascade = ALL)
	@JoinColumn(name = "object__id_", referencedColumnName = "id_")
	private Object object_;
	public Information() {
		super();
	}   
	public int getId_() {
		return this.id_;
	}

	public void setId_(int id_) {
		this.id_ = id_;
	}   
	public String getLink_() {
		return this.link_;
	}

	public void setLink_(String link_) {
		this.link_ = link_;
	}   

	public Object getObject_() {
		return object_;
	}
	public void setObject_(Object object_) {
		this.object_ = object_;
	}
	public String getText_() {
		return text_;
	}
	public void setText_(String text_) {
		this.text_ = text_;
	}
	public String getDate_() {
		return date_;
	}
	public void setDate_(String date_) {
		this.date_ = date_;
	}
	public String getType_() {
		return type_;
	}
	public void setType_(String type_) {
		this.type_ = type_;
	}
   
}
