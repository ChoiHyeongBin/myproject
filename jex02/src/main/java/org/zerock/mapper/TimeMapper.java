package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

public class TimeMapper {

	@Select("SELECT sysdate FROM dual")
	public String getTime() {
		return null;
	}
	
	public String getTime2() {
		return null;
	}
}
