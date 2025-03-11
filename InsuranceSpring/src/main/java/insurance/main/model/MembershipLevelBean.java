package insurance.main.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "membershipLevel")
public class MembershipLevelBean implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "level", nullable = false)
	private Integer level;

	@Column(name = "level_name", nullable = false, length = 255)
	private String levelName;

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getLevelName() {
		return levelName;
	}

	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}

}
