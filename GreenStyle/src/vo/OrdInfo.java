package vo;

import java.util.ArrayList;

public class OrdInfo {
	private int ol_num, ol_point, ol_pay, mc_num;
	private String ol_id, ol_ismem, ol_buyer, ol_phone, ol_email, ol_rname, ol_rphone, ol_rzip, ol_raddr1, ol_raddr2, ol_comment;
	private String ol_payment, ol_status, ol_date, status, ol_call, payStatus, cs_id; // pl_id;
	private ArrayList<OrdDetailInfo> ordPdtList;
	
	public int getOl_num() {
		return ol_num;
	}
	public void setOl_num(int ol_num) {
		this.ol_num = ol_num;
	}
	public int getOl_point() {
		return ol_point;
	}
	public void setOl_point(int ol_point) {
		this.ol_point = ol_point;
	}
	public int getOl_pay() {
		return ol_pay;
	}
	public void setOl_pay(int ol_pay) {
		this.ol_pay = ol_pay;
	}
	public String getOl_id() {
		return ol_id;
	}
	public void setOl_id(String ol_id) {
		this.ol_id = ol_id;
	}
	public String getOl_ismem() {
		return ol_ismem;
	}
	public void setOl_ismem(String ol_ismem) {
		this.ol_ismem = ol_ismem;
	}
	public String getOl_buyer() {
		return ol_buyer;
	}
	public void setOl_buyer(String ol_buyer) {
		this.ol_buyer = ol_buyer;
	}
	public String getOl_phone() {
		return ol_phone;
	}
	public void setOl_phone(String ol_phone) {
		this.ol_phone = ol_phone;
	}
	public String getOl_email() {
		return ol_email;
	}
	public void setOl_email(String ol_email) {
		this.ol_email = ol_email;
	}
	public String getOl_rname() {
		return ol_rname;
	}
	public void setOl_rname(String ol_rname) {
		this.ol_rname = ol_rname;
	}
	public String getOl_rphone() {
		return ol_rphone;
	}
	public void setOl_rphone(String ol_rphone) {
		this.ol_rphone = ol_rphone;
	}
	public String getOl_rzip() {
		return ol_rzip;
	}
	public void setOl_rzip(String ol_rzip) {
		this.ol_rzip = ol_rzip;
	}
	public String getOl_raddr1() {
		return ol_raddr1;
	}
	public void setOl_raddr1(String ol_raddr1) {
		this.ol_raddr1 = ol_raddr1;
	}
	public String getOl_raddr2() {
		return ol_raddr2;
	}
	public void setOl_raddr2(String ol_raddr2) {
		this.ol_raddr2 = ol_raddr2;
	}
	public String getOl_comment() {
		return ol_comment;
	}
	public void setOl_comment(String ol_comment) {
		this.ol_comment = ol_comment;
	}
	public String getOl_payment() {
		return ol_payment;
	}
	public void setOl_payment(String ol_payment) {
		this.ol_payment = ol_payment;
	}
	public String getOl_status() {
		return ol_status;
	}
	public void setOl_status(String ol_status) {
		this.ol_status = ol_status;
	}
	public String getOl_date() {
		return ol_date;
	}
	public void setOl_date(String ol_date) {
		this.ol_date = ol_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public ArrayList<OrdDetailInfo> getOrdPdtList() {
		return ordPdtList;
	}
	public void setOrdPdtList(ArrayList<OrdDetailInfo> ordPdtList) {
		this.ordPdtList = ordPdtList;
	}
	public String getOl_call() {
		return ol_call;
	}
	public void setOl_call(String ol_call) {
		this.ol_call = ol_call;
	}
	public String getPayStatus() {
		return payStatus;
	}
	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}
	public String getCs_id() {
		return cs_id;
	}
	public void setCs_id(String cs_id) {
		this.cs_id = cs_id;
	}
	public int getMc_num() {
		return mc_num;
	}
	public void setMc_num(int mc_num) {
		this.mc_num = mc_num;
	}
}
