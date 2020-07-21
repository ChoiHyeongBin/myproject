package vo;

// 주문내 상품들의 정보를 저장하는 클래스
public class OrdDetailInfo {
	private int od_num, od_price, od_amount;
	private String ol_id, pl_id, od_optsize, od_optcolor, pl_name, pl_img1, cs_id;
	
	public int getOd_num() {
		return od_num;
	}
	public void setOd_num(int od_num) {
		this.od_num = od_num;
	}
	public int getOd_price() {
		return od_price;
	}
	public void setOd_price(int od_price) {
		this.od_price = od_price;
	}
	public int getOd_amount() {
		return od_amount;
	}
	public void setOd_amount(int od_amount) {
		this.od_amount = od_amount;
	}
	public String getOl_id() {
		return ol_id;
	}
	public void setOl_id(String ol_id) {
		this.ol_id = ol_id;
	}
	public String getPl_id() {
		return pl_id;
	}
	public void setPl_id(String pl_id) {
		this.pl_id = pl_id;
	}
	public String getOd_optsize() {
		return od_optsize;
	}
	public void setOd_optsize(String od_optsize) {
		this.od_optsize = od_optsize;
	}
	public String getOd_optcolor() {
		return od_optcolor;
	}
	public void setOd_optcolor(String od_optcolor) {
		this.od_optcolor = od_optcolor;
	}
	public String getPl_name() {
		return pl_name;
	}
	public void setPl_name(String pl_name) {
		this.pl_name = pl_name;
	}
	public String getPl_img1() {
		return pl_img1;
	}
	public void setPl_img1(String pl_img1) {
		this.pl_img1 = pl_img1;
	}
	public String getCs_id() {
		return cs_id;
	}
	public void setCs_id(String cs_id) {
		this.cs_id = cs_id;
	}
	
}