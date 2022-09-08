package com.iyoons.world.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.iyoons.world.vo.DemoVO;

@Mapper
public interface DemoDAO {
	public List<DemoVO> getDemoList();

}
