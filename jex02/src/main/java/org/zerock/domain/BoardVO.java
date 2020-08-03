package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	// 지시자	    클래스 내부	   동일패키지 	상속 클래스	 기타 영역
	// private			O		       X		     X		     X
}
