package model;

import java.sql.Timestamp;
import java.util.Date;

public class User {

    private int accountId;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String gender;
    private String roles;
    private String avatarPics;
    private int otp;
    private Timestamp otpExpireTime;

    public User() {
    }

    public User(String fullName, String email, String phoneNumber, String gender, String avatarPics) {
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.avatarPics = avatarPics;
    }

    public User(int accountId, String fullName, String email, String phoneNumber, String gender, String avatarPics) {
        this.accountId = accountId;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.avatarPics = avatarPics;
    }
    
    

    public User(int accountId, String username, String password, String fullName, String email, String phoneNumber, String gender, String roles, String avatarPics, int otp) {
        this.accountId = accountId;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.roles = roles;
        this.avatarPics = avatarPics;
        this.otp = otp;
        long currentTimeMillis = System.currentTimeMillis();
        this.otpExpireTime = new Timestamp(currentTimeMillis + 600000);
    }

    public User(String username, String password, String fullName, String email, String phoneNumber, String gender, String roles, String avatarPics, int otp) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.roles = roles;
        this.avatarPics = avatarPics;
        this.otp = otp;
        long currentTimeMillis = System.currentTimeMillis();
        this.otpExpireTime = new Timestamp(currentTimeMillis + 600000);
    }

    public User(String username, String password, String fullName, String email, String phoneNumber, String gender, String roles, String avatarPics) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.roles = roles;
        this.avatarPics = avatarPics;
    }

    public User(int accountId, String username, String password, String fullName, String email, String phoneNumber, String gender, String roles, String avatarPics) {
        this.accountId = accountId;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.roles = roles;
        this.avatarPics = avatarPics;
    }
    
    

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getRoles() {
        return roles;
    }

    public void setRoles(String roles) {
        this.roles = roles;
    }

    public String getAvatarPics() {
        return avatarPics;
    }

    public void setAvatarPics(String avatarPics) {
        this.avatarPics = avatarPics;
    }

    public int getOtp() {
        return otp;
    }

    public void setOtp(int otp) {
        this.otp = otp;
    }

    public Timestamp getOtpExpireTime() {
        return otpExpireTime;
    }

    public void setOtpExpireTime(Timestamp otpExpireTime) {
        this.otpExpireTime = otpExpireTime;
    }

    @Override
    public String toString() {
        return "User{" + "accountId=" + accountId + ", username=" + username + ", password=" + password + ", fullName=" + fullName + ", email=" + email + ", phoneNumber=" + phoneNumber + ", gender=" + gender + ", roles=" + roles + ", avatarPics=" + avatarPics + '}';
    }

        
}
