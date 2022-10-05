package com.iyoons.world.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.service.AttachService;
import com.iyoons.world.vo.BoardAttachVO;

@Service(value="AttachService")
public class AttachServiceImpl implements AttachService{
	
	@Autowired
	AttachDAO dao;

	@Override
	public List<BoardAttachVO> getAttachList(int postSeq) {
		List<BoardAttachVO> anlist = dao.getAttachList(postSeq);
		for(BoardAttachVO avo : anlist) {
			String path = avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
			avo.setFullPath(path);
		}
		return anlist;
	}
	
}
