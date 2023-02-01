package com.iyoons.world.service.impl;

import org.springframework.stereotype.Service;


import com.iyoons.world.vo.PageVO;

@Service(value = "PagingSerive")
public class PagingService{

//	@Autowired PageVO page;
	
		
	public PageVO getPaging(int pageSize,int pageNum) {
		PageVO page = new PageVO();
		page.setPageSize(pageSize);
		
		if(pageNum == 0) {
			pageNum = 1;
		};
		
		page.setCurrentPage(pageNum);
		int startRow = (pageNum - 1) * pageSize + 1;	
		int endRow = pageSize * pageNum;
		
		page.setStartRow(startRow);
		page.setEndRow(endRow);
			
		
		return page;
	}
	
}
