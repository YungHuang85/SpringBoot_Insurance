package insurance.main.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "points")
public class BonusPointsBean {

    @Id
    @Column(name = "email")
    private String email;

    @Column(name = "username")
    private String username;

    @Column(name = "points")
    private int points;

    
    public BonusPointsBean() {
    }

    public BonusPointsBean(String username, String email, int points) {
        this.username = username;
        this.email = email;
        this.points = points;
    }

    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }
}