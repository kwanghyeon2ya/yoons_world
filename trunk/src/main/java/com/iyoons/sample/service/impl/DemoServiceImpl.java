package com.iyoons.sample.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iyoons.sample.dao.DemoDAO;
import com.iyoons.sample.service.DemoService;
import com.iyoons.sample.vo.DemoVO;

@Service(value="demoService")
public class DemoServiceImpl implements DemoService{
	
	@Resource
	DemoDAO demoDao;
	

	public List<DemoVO> getDemoList() {
		return demoDao.getDemoList();
	}
	
}
