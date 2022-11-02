package com.iyoons.world.vo;

import lombok.Data;

@Data
public class PageVO {

	private int pageSize;
	private int pageNum;
	private int currentPage;
	private int startRow;
	private int endRow;
	private String search = "";
	private String keyword = "";

}
