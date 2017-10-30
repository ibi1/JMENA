package kr.co.jmena.www.web.sample.Ctr;

import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.sample.Biz.EnaSampleBiz;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EnaSampleCtr {
	
	@Resource(name = "enaSampleBiz")
	private EnaSampleBiz enaSampleBiz;
	
	public EnaSampleCtr() {}
	
	@RequestMapping("/sample/selectEnaSample.do")
	public ModelAndView selectEnaSample(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView view = new ModelAndView();
		
		view.addObject("DATA", enaSampleBiz.selectEnaSample());
		
		JSONObject obj = new JSONObject();
		PrintWriter out = response.getWriter();
		
		for(int i = 0; i < enaSampleBiz.selectEnaSample().size(); i++) {
			obj.put("no", enaSampleBiz.selectEnaSample().get(i).getNo());
			obj.put("data", enaSampleBiz.selectEnaSample().get(i).getData());
			
			out.print(obj);
		}
		
		
		out.flush();
		out.close();
		
		return null;
	}
	
	@RequestMapping("/sample/insertEnaSample.do")
	public ModelAndView insertEnaSample(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView view = new ModelAndView();
		
		return view;
	}
	
	@RequestMapping("/sample/updateEnaSample.do")
	public ModelAndView updateEnaSample(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView view = new ModelAndView();
		
		return view;
	}
	
	@RequestMapping("/sample/deleteEnaSample.do")
	public ModelAndView deleteEnaSample(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView view = new ModelAndView();
		
		return view;
	}
	
}
