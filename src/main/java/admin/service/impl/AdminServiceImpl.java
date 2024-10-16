package admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.bean.AdminPaging;
import admin.bean.QnaDTO;
import admin.dao.AdminDAO;
import admin.service.AdminService;


@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDAO adminDAO;
	
	@Autowired
	private AdminPaging adminPaging; // 페이징
	
	
	
	@Override
	public Map<String, Object> list(String pg) {
		int startNum = (Integer.parseInt(pg)-1) * 5; //시작 위치
		int endNum = 5; // 개수
		Map<String,Integer> map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		//목록 데이터 출력
		List<QnaDTO> list = adminDAO.list(map);
		
		//페이징 처리
		int totalA = adminDAO.getTotalA(); // 총 글 수
		int noCheck = adminDAO.noCheck(); // 답글 안 쓴 글 수
		
		adminPaging.setCurrentPage(Integer.parseInt(pg));
		adminPaging.setPageBlock(3);
		adminPaging.setPageSize(5);
		adminPaging.setTotalA(totalA);
		adminPaging.makePagingHTML();
		
		
		Map<String,Object> map2 = new HashMap<>();
		map2.put("list", list);
		map2.put("pagingHTML", adminPaging.getPagingHTML().toString());
		map2.put("totalA", totalA);
		map2.put("noCheck", noCheck);
		
		return map2;
		
		
	}



	@Override
	public void qnaWrite(QnaDTO qnaDTO) {
		adminDAO.qnaWrite(qnaDTO);
	}



	@Override
	public void qnaReplyWrite(int seq, String replyContent) {
		System.out.println("service > seq " + seq);
		System.out.println("service > replyContent " + replyContent);
		adminDAO.qnaReplyWrite(seq, replyContent);
	}

}
