package com.iyoons.world.service;

import java.util.List;

import com.iyoons.world.vo.DemoVO;

public interface DemoService {
	List<DemoVO> getDemoList();
	
	DemoVO getDemoInfo(DemoVO param);
	
	void regDemoProc(DemoVO param);

	void modDemoProc(DemoVO param);
}
