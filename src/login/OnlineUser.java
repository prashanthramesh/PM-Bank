package login;

public class OnlineUser {
	
	private String firstName;
	private String lastName;
	private String phoneNumber;
	private String password;
	private String securityAnswer;
	private String cardNumber;
	private String email;
	private String dob;
	private String gender;
	private String cust;
	private String add;
	private String chkNO;
	private String savNO;
	private String mnyCard;
	
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getPassword() {
		return password;
	}
	public String getCustomerID() {
		return cust;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSecurityAnswer() {
		return securityAnswer;
	}
	public void setSecurityAnswer(String securityAnswer) {
		this.securityAnswer = securityAnswer;
	}
	public String getCardNumber() {
		return cardNumber;
	}
	public String getEmail() {
		return email;
	}
	public String getAddress() {
		return add;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	public void setCustomerID(String cust) {
		this.cust = cust;		
	}
	public void setAddress(String add) {
		this.add = add;		
	}
	public void setCheckAccNo(String chkNO) {		
		this.chkNO = chkNO;
	}
	public String getCheckAccNo() {
		return chkNO;
	}
	public void setSavAccNo(String savNO) {		
		this.savNO = savNO;
	}
	public String getSavAccNo() {
		return savNO;
	}
	public void setMnyCard(String mnyCard) {		
		this.mnyCard = mnyCard;
	}
	public String getMnyCard() {
		return mnyCard;
	}
	
	
	
}
