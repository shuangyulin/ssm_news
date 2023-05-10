package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ZambiaService;
import com.chengxusheji.po.Zambia;
import com.chengxusheji.service.NewsService;
import com.chengxusheji.po.News;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Zambia管理控制层
@Controller
@RequestMapping("/Zambia")
public class ZambiaController extends BaseController {

    /*业务层对象*/
    @Resource ZambiaService zambiaService;

    @Resource NewsService newsService;
    @Resource UserInfoService userInfoService;
	@InitBinder("newsObj")
	public void initBindernewsObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("newsObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("zambia")
	public void initBinderZambia(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("zambia.");
	}
	/*跳转到添加Zambia视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Zambia());
		/*查询所有的News信息*/
		List<News> newsList = newsService.queryAllNews();
		request.setAttribute("newsList", newsList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Zambia_add";
	}

	/*客户端ajax方式提交添加新闻赞信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Zambia zambia, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        zambiaService.addZambia(zambia);
        message = "新闻赞添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询新闻赞信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)zambiaService.setRows(rows);
		List<Zambia> zambiaList = zambiaService.queryZambia(newsObj, userObj, page);
	    /*计算总的页数和总的记录数*/
	    zambiaService.queryTotalPageAndRecordNumber(newsObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = zambiaService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = zambiaService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Zambia zambia:zambiaList) {
			JSONObject jsonZambia = zambia.getJsonObject();
			jsonArray.put(jsonZambia);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询新闻赞信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Zambia> zambiaList = zambiaService.queryAllZambia();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Zambia zambia:zambiaList) {
			JSONObject jsonZambia = new JSONObject();
			jsonZambia.accumulate("zambiaId", zambia.getZambiaId());
			jsonArray.put(jsonZambia);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询新闻赞信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<Zambia> zambiaList = zambiaService.queryZambia(newsObj, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    zambiaService.queryTotalPageAndRecordNumber(newsObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = zambiaService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = zambiaService.getRecordNumber();
	    request.setAttribute("zambiaList",  zambiaList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("newsObj", newsObj);
	    request.setAttribute("userObj", userObj);
	    List<News> newsList = newsService.queryAllNews();
	    request.setAttribute("newsList", newsList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Zambia/zambia_frontquery_result"; 
	}

     /*前台查询Zambia信息*/
	@RequestMapping(value="/{zambiaId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer zambiaId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键zambiaId获取Zambia对象*/
        Zambia zambia = zambiaService.getZambia(zambiaId);

        List<News> newsList = newsService.queryAllNews();
        request.setAttribute("newsList", newsList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("zambia",  zambia);
        return "Zambia/zambia_frontshow";
	}

	/*ajax方式显示新闻赞修改jsp视图页*/
	@RequestMapping(value="/{zambiaId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer zambiaId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键zambiaId获取Zambia对象*/
        Zambia zambia = zambiaService.getZambia(zambiaId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonZambia = zambia.getJsonObject();
		out.println(jsonZambia.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新新闻赞信息*/
	@RequestMapping(value = "/{zambiaId}/update", method = RequestMethod.POST)
	public void update(@Validated Zambia zambia, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			zambiaService.updateZambia(zambia);
			message = "新闻赞更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "新闻赞更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除新闻赞信息*/
	@RequestMapping(value="/{zambiaId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer zambiaId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  zambiaService.deleteZambia(zambiaId);
	            request.setAttribute("message", "新闻赞删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "新闻赞删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条新闻赞记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String zambiaIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = zambiaService.deleteZambias(zambiaIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出新闻赞信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<Zambia> zambiaList = zambiaService.queryZambia(newsObj,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Zambia信息记录"; 
        String[] headers = { "赞id","被赞新闻","用户","被赞时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<zambiaList.size();i++) {
        	Zambia zambia = zambiaList.get(i); 
        	dataset.add(new String[]{zambia.getZambiaId() + "",zambia.getNewsObj().getNewsTitle(),zambia.getUserObj().getName(),zambia.getZambiaTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Zambia.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
