package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA011004Dao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011004Biz {
	
	@Resource(name = "SA011004Dao")
	private SA011004Dao SA011004Dao;
	
	public SA011004Biz() {}

	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<Map<String, Object>> selectListIpgumMst(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = null;
		
		try {
			lst = SA011004Dao.selectListIpgumMst(param);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}

	public List<Map<String, Object>> selectPopListIpgumMst(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = null;
		
		try {
			lst = SA011004Dao.selectPopListIpgumMst(param);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
	
	public List<Map<String, Object>> selectOneInsamst(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = null;
		
		try {
			lst = SA011004Dao.selectOneInsamst(param);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
	
	public int insertIpgumMst(Map<String, Object> param) throws Exception {
		int cnt = 0;
		String sKey = "";
		
		try {
			sKey = SA011004Dao.insertIpgumMst(param);
			
			if(sKey.length() > 0) {
				if (param.get("IPGUMGUBUN").equals("005")) {	// 입금구분이 "환불금"일 경우
					param.put("IPGUMID", sKey);
					cnt = SA011004Dao.updateRefundIpgumMst(param);
				} else {
					cnt = 1;
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}
	
	public int updateIpgumMst(Map<String, Object> param) throws Exception {
		int cnt = 0;
		
		try {
			cnt = SA011004Dao.updateIpgumMst(param);
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}
	
	public int deleteIpgumMst(Map<String, Object> param) throws Exception {
		int cnt = 0;
		
		try {
			cnt = SA011004Dao.deleteIpgumMst(param);
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}
}
