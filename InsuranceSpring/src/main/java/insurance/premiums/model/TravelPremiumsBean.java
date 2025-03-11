package insurance.premiums.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document(collection = "travelpremiums")
public class TravelPremiumsBean {

    @Id
    private Integer _id;

    @Field("100W")
    private Integer W100;

    @Field("300W")
    private Integer W300;

    @Field("500W")
    private Integer W500;

    @Field("700W")
    private Integer W700;

    @Field("1000W")
    private Integer W1000;

    // Getter and Setter
    public Integer get_id() {
        return _id;
    }

    public void set_id(Integer _id) {
        this._id = _id;
    }

    public Integer getW100() {
        return W100;
    }

    public void setW100(Integer w100) {
        W100 = w100;
    }

    public Integer getW300() {
        return W300;
    }

    public void setW300(Integer w300) {
        W300 = w300;
    }

    public Integer getW500() {
        return W500;
    }

    public void setW500(Integer w500) {
        W500 = w500;
    }

    public Integer getW700() {
        return W700;
    }

    public void setW700(Integer w700) {
        W700 = w700;
    }

    public Integer getW1000() {
        return W1000;
    }

    public void setW1000(Integer w1000) {
        W1000 = w1000;
    }
}
