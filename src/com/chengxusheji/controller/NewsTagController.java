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
import com.chengxusheji.service.NewsTagService;
import com.chengxusheji.po.NewsTag;
import com.chengxusheji.service.NewsService;
import com.chengxusheji.po.News;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//NewsTag管理控制层
@Controller
@RequestMapping("/NewsTag")
public class NewsTagController extends BaseController {

    /*业务层对象*/
    @Resource NewsTagService newsTagService;

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
	@InitBinder("newsTag")
	public void initBinderNewsTag(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("newsTag.");
	}
	/*跳转到添加NewsTag视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new NewsTag());
		/*查询所有的News信息*/
		List<News> newsList = newsService.queryAllNews();
		request.setAttribute("newsList", newsList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "NewsTag_add";
	}

	/*客户端ajax方式提交添加新闻标记信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated NewsTag newsTag, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        newsTagService.addNewsTag(newsTag);
        message = "新闻标记添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询新闻标记信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)newsTagService.setRows(rows);
		List<NewsTag> newsTagList = newsTagService.queryNewsTag(newsObj, userObj, page);
	    /*计算总的页数和总的记录数*/
	    newsTagService.queryTotalPageAndRecordNumber(newsObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = newsTagService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = newsTagService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(NewsTag newsTag:newsTagList) {
			JSONObject jsonNewsTag = newsTag.getJsonObject();
			jsonArray.put(jsonNewsTag);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询新闻标记信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<NewsTag> newsTagList = newsTagService.queryAllNewsTag();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(NewsTag newsTag:newsTagList) {
			JSONObject jsonNewsTag = new JSONObject();
			jsonNewsTag.accumulate("tagId", newsTag.getTagId());
			jsonArray.put(jsonNewsTag);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询新闻标记信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<NewsTag> newsTagList = newsTagService.queryNewsTag(newsObj, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    newsTagService.queryTotalPageAndRecordNumber(newsObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = newsTagService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = newsTagService.getRecordNumber();
	    request.setAttribute("newsTagList",  newsTagList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("newsObj", newsObj);
	    request.setAttribute("userObj", userObj);
	    List<News> newsList = newsService.queryAllNews();
	    request.setAttribute("newsList", newsList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "NewsTag/newsTag_frontquery_result"; 
	}

     /*前台查询NewsTag信息*/
	@RequestMapping(value="/{tagId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer tagId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键tagId获取NewsTag对象*/
        NewsTag newsTag = newsTagService.getNewsTag(tagId);

        List<News> newsList = newsService.queryAllNews();
        request.setAttribute("newsList", newsList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("newsTag",  newsTag);
        return "NewsTag/newsTag_frontshow";
	}

	/*ajax方式显示新闻标记修改jsp视图页*/
	@RequestMapping(value="/{tagId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer tagId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键tagId获取NewsTag对象*/
        NewsTag newsTag = newsTagService.getNewsTag(tagId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonNewsTag = newsTag.getJsonObject();
		out.println(jsonNewsTag.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新新闻标记信息*/
	@RequestMapping(value = "/{tagId}/update", method = RequestMethod.POST)
	public void update(@Validated NewsTag newsTag, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			newsTagService.updateNewsTag(newsTag);
			message = "新闻标记更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "新闻标记更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除新闻标记信息*/
	@RequestMapping(value="/{tagId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer tagId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  newsTagService.deleteNewsTag(tagId);
	            request.setAttribute("message", "新闻标记删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "新闻标记删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条新闻标记记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String tagIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = newsTagService.deleteNewsTags(tagIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出新闻标记信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<NewsTag> newsTagList = newsTagService.queryNewsTag(newsObj,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "NewsTag信息记录"; 
        String[] headers = { "标记id","被标记新闻","标记的用户","新闻状态","标记时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<newsTagList.size();i++) {
        	NewsTag newsTag = newsTagList.get(i); 
        	dataset.add(new String[]{newsTag.getTagId() + "",newsTag.getNewsObj().getNewsTitle(),newsTag.getUserObj().getName(),newsTag.getNewsState() + "",newsTag.getTagTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"NewsTag.xls");//filename是下载的xls的名，建议最好用英文 
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
