package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Dao.SA011002Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011002Biz {
	
	@Resource(name = "SA011002Dao")
	private SA011002Dao SA011002Dao;

	public SA011002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA011002VO> selectListEanSaleMstBDtl(SA011002VO vo) throws Exception {
		List<SA011002VO> lst = null;

		try {
			lst = SA011002Dao.selectListEanSaleMstBDtl(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataSaleMstBDtl(SA011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011002Dao.insertDataSaleMstBDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataSaleMstBDtl(SA011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011002Dao.updateDataSaleMstBDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllJointnameTbBDtl(SA011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (SA011002Dao.selectAllJointnameTbBDtl(vo) > 0) {
				chkFlag = SA011002Dao.deleteAllJointnameTbBDtl(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataSalebDtl(SA011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011002Dao.deleteDataSalebDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataSaleMstBDtl(SA011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011002Dao.deleteDataSaleMstBDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<SA011001VO> selectListEnaJointNameTbBDtl(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;

		try {
			lst = SA011002Dao.selectListEnaJointNameTbBDtl(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataEnaJointNameTbBDtl(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			//공동명의 구분 및 등기여부, 등기일자 업데이트
			chkFlag = SA011002Dao.updateDataJointBDtl(vo);
			
			if (chkFlag == true) {
				if (!"".equals(vo.getJOINTNAME())) {	//그리드 추가 값이 있을 경우
				chkFlag = SA011002Dao.insertDataEnaJointNameTbBDtl(vo);
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataEnaJointNameTbBDtl(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
	
		try {
			//공동명의 구분 및 등기여부, 등기일자 업데이트
			chkFlag = SA011002Dao.updateDataJointBDtl(vo);
			
			if (chkFlag == true) {
				if (!"".equals(vo.getJOINTNAME())) {	//그리드 추가 값이 있을 경우
				chkFlag = SA011002Dao.updateDataEnaJointNameTbBDtl(vo);
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataEnaJointNameTbBDtl(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011002Dao.deleteDataEnaJointNameTbBDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<SA011002VO> selectListEanSaleMstBDtlPopup(SA011002VO vo) throws Exception {
		List<SA011002VO> lst = null;

		try {
			lst = SA011002Dao.selectListEanSaleMstBDtlPopup(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<MM011001VO> selectListEnaBuyMstBDtlPopup(MM011001VO vo) throws Exception {
		List<MM011001VO> lst = null;

		try {
			lst = SA011002Dao.selectListEnaBuyMstBDtlPopup(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
}
