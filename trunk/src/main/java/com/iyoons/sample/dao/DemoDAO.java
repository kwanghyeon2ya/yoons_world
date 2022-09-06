package com.iyoons.sample.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.iyoons.sample.vo.DemoVO;

@Mapper
public interface DemoDAO {
	public List<DemoVO> getDemoList();

}
