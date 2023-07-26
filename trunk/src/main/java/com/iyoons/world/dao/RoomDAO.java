package com.iyoons.world.dao;


import org.apache.ibatis.annotations.Mapper;

import com.iyoons.world.vo.RoomVO;

@Mapper
public interface RoomDAO {
	
	public int makeReservation(RoomVO roomVO); //게시글 작성

}
