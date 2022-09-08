package com.iyoons.world.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iyoons.world.dao.DemoDAO;
import com.iyoons.world.service.DemoService;
import com.iyoons.world.vo.DemoVO;

@Service(value="demoService")
public class DemoServiceImpl implements DemoService{
	
	@Resource
	DemoDAO demoDao;
	

	public List<DemoVO> getDemoList() {
		return demoDao.getDemoList();
	}
	
}
