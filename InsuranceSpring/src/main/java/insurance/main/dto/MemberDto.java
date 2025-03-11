package insurance.main.dto;

import insurance.main.model.MembersBean;

public class MemberDto {

	private String status;
	private String message;
	private MembersBean data;
	private Integer code;

	private MembersBean member;

	// Getter 和 Setter
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public MembersBean getData() {
		return data;
	}

	public void setData(MembersBean data) {
		this.data = data;
	}



	public MembersBean getMember() {
		return member;
	}

	public void setMember(MembersBean member) {
		this.member = member;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "MemberDto [status=" + status + ", message=" + message + ", data=" + data + ", code=" + code
				+ ", member=" + member + "]";
	}
	// 靜態便利方法
    public static MemberDto success(MembersBean data) {
        MemberDto dto = new MemberDto();
        dto.setStatus("success");
        dto.setData(data);
        return dto;
    }

    public static MemberDto successWithMember(MembersBean member) {
        MemberDto dto = new MemberDto();
        dto.setStatus("success");
        dto.setMember(member);
        return dto;
    }

    public static MemberDto error(String message) {
        MemberDto dto = new MemberDto();
        dto.setStatus("error");
        dto.setMessage(message);
        return dto;
    }
}
