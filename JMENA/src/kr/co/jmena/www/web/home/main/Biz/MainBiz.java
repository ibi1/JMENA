package kr.co.jmena.www.web.home.main.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.main.Dao.MainDao;
import kr.co.jmena.www.web.home.main.Vo.MainVO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class MainBiz {
	
	@Resource(name = "mainDao")
	private MainDao mainDao;

	public MainBiz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<MainVO> selectUserInfo(MainVO vo) throws Exception {
		List<MainVO> lst = null;

		try {
			lst = mainDao.selectUserInfo(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<MainVO> selectSystemMenu() throws Exception {
		List<MainVO> lst = null;

		try {
			lst = mainDao.selectSystemMenu();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public String[] selectTreeMenu(String sysId) throws Exception {
		StringBuilder treeHtml = new StringBuilder();
		String pgmFirst = "";
		String[] strArr = new String[2];
		
		List<MainVO> menulst = null;
		List<MainVO> pgmlst = null;
		
		try {
			menulst = mainDao.selectMenuTb(sysId);	//메뉴리스트
			pgmlst = mainDao.selectPgmTb(sysId); //프로그램리스트
			
//			treeHtml.append("<div id=\"sidetree\">");
//			treeHtml.append("<div class=\"treeheader\">&nbsp;</div>");
//			treeHtml.append("<div id=\"sidetreecontrol\"><a href=\"?#\">Collapse All</a> | <a href=\"?#\">Expand All</a></div>");
//			
//			treeHtml.append("<ul id=\"tree\">");
			//tree html 생성
			JSONObject jTreeData = new JSONObject();
			JSONArray jsonArr = new JSONArray();
			int parentIdCnt = 0;
			int idCnt = 0;
			
			for (int i = 0; i < menulst.size(); i++) {
				String menuId = menulst.get(i).getMENUID();
				
				JSONObject objParent = new JSONObject();
				
				objParent.put("id", ++idCnt);
				objParent.put("parentid", -1);
				objParent.put("text", menulst.get(i).getMENUNAME());
				
				jsonArr.add(objParent);
				
				pgmFirst = pgmlst.get(0).getPGMID();	//첫번째 프로그램 목록 무조건 넘겨주기
				
				parentIdCnt = idCnt;
				for (int j = 0; j < pgmlst.size(); j++) {
					if (menuId.equals(pgmlst.get(j).getMENUID())) {
						JSONObject objId = new JSONObject();
						
						objId.put("parentid", parentIdCnt);
						objId.put("id", ++idCnt);
						objId.put("text", pgmlst.get(j).getPGMNAME());
						objId.put("value", pgmlst.get(j).getPGMID());
						
						jsonArr.add(objId);
					}
				}
			}
			
			jTreeData.put("treeData", jsonArr);
			
			strArr[0] = jTreeData.toJSONString();
			strArr[1] = pgmFirst;
			
		} catch ( Exception e ) {
			throw e;
		}
		
		return strArr;
	}
}
