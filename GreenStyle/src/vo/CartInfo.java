package vo;

// 장바구니 내의 하나의 상품에 대한 정보를 저장하기 위한 클래스
public class CartInfo {
	private int oc_num, oc_amount, pl_price, ml_point, ml_coupon, ac_discount;
	private String oc_ismem, oc_memid, pl_id, oc_optsize, oc_optcolor, oc_date, pl_name, pl_img1, pl_optsize, pl_optcolor, ma_isbasic, cs_id, cb_id;
	
	public int getOc_num() {
		return oc_num;
	}
	public void setOc_num(int oc_num) {
		this.oc_num = oc_num;
	}
	public int getOc_amount() {
		return oc_amount;
	}
	public void setOc_amount(int oc_amount) {
		this.oc_amount = oc_amount;
	}
	public int getPl_price() {
		return pl_price;
	}
	public void setPl_price(int pl_price) {
		this.pl_price = pl_price;
	}
	public String getOc_ismem() {
		return oc_ismem;
	}
	public void setOc_ismem(String oc_ismem) {
		this.oc_ismem = oc_ismem;
	}
	public String getOc_memid() {
		return oc_memid;
	}
	public void setOc_memid(String oc_memid) {
		this.oc_memid = oc_memid;
	}
	public String getPl_id() {
		return pl_id;
	}
	public void setPl_id(String pl_id) {
		this.pl_id = pl_id;
	}
	public String getOc_optsize() {
		return oc_optsize;
	}
	public void setOc_optsize(String oc_optsize) {
		this.oc_optsize = oc_optsize;
	}
	public String getOc_optcolor() {
		return oc_optcolor;
	}
	public void setOc_optcolor(String oc_optcolor) {
		this.oc_optcolor = oc_optcolor;
	}
	public String getOc_date() {
		return oc_date;
	}
	public void setOc_date(String oc_date) {
		this.oc_date = oc_date;
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
	public String getPl_optsize() {
		return pl_optsize;
	}
	public void setPl_optsize(String pl_optsize) {
		this.pl_optsize = pl_optsize;
	}
	public String getPl_optcolor() {
		return pl_optcolor;
	}
	public void setPl_optcolor(String pl_optcolor) {
		this.pl_optcolor = pl_optcolor;
	}
	public int getMl_point() {
		return ml_point;
	}
	public void setMl_point(int ml_point) {
		this.ml_point = ml_point;
	}
	public int getMl_coupon() {
		return ml_coupon;
	}
	public void setMl_coupon(int ml_coupon) {
		this.ml_coupon = ml_coupon;
	}
	public String getMa_isbasic() {
		return ma_isbasic;
	}
	public void setMa_isbasic(String ma_isbasic) {
		this.ma_isbasic = ma_isbasic;
	}
	public String getCs_id() {
		return cs_id;
	}
	public void setCs_id(String cs_id) {
		this.cs_id = cs_id;
	}
	public String getCb_id() {
		return cb_id;
	}
	public void setCb_id(String cb_id) {
		this.cb_id = cb_id;
	}
	public int getAc_discount() {
		return ac_discount;
	}
	public void setAc_discount(int ac_discount) {
		this.ac_discount = ac_discount;
	}
	
}
