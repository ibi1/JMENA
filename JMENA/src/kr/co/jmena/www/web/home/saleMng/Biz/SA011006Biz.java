package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA011006Dao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011006Biz {
	
	@Resource(name = "SA011006Dao")
	private SA011006Dao SA011006Dao;
	
	public SA011006Biz() {}

	protected final Logger logger = Logger.getLogger(getClass());

	public List<Map<String, Object>> selectListSaleMst(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = null;
		
		try {
			lst = SA011006Dao.selectListSaleMst(param);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
	
	public int insertRefundTb(Map<String, Object> param) throws Exception {
		int cnt = 0;
		
		try {
			cnt = SA011006Dao.insertRefundTb(param);
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}
	
	public int updateRefundTb(Map<String, Object> param) throws Exception {
		int cnt = 0;
		
		try {
			cnt = SA011006Dao.updateRefundTb(param);
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}
	
	public int deleteRefundTb(Map<String, Object> param) throws Exception {
		int cnt = 0;
		
		try {
			cnt = SA011006Dao.deleteRefundTb(param);
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}	
	
	public int insertIpgumMst(Map<String, Object> param) throws Exception {
		int cnt = 0;
		String sKey = "";
		
		try {
			sKey = SA011006Dao.insertIpgumMst(param);
			
			if(sKey.length() > 0) {
				param.put("IPGUMID", sKey);
				
				if(param.get("REFUND_SALEID").equals("")) {		// 환불내역이 없으면 신규 생성 (입금 전액 대체)
					cnt = SA011006Dao.insertRefundTbExport(param);
				} else { 
					cnt = SA011006Dao.updateRefundTbExport(param);
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}

	public int deleteIpgumMst(Map<String, Object> param) throws Exception {
		int cnt = 0;
		String sKey = "";
		List<Map<String, Object>> lst = null;
		
		try {
			lst = SA011006Dao.selectOneIpgumDtl(param);
			
			if(lst.size() > 0) {
				cnt = -1;
			} else {
				cnt = SA011006Dao.deleteIpgumMst(param);
				
				if(cnt > 0) {
					param.put("IPGUMID", null);
					
					if(param.get("REFUNDAMT").equals("0")) {						
						cnt = SA011006Dao.deleteRefundTb(param);
					} else {
						cnt = SA011006Dao.updateRefundTbExport(param);
					}
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}
}
