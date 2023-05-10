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
import com.chengxusheji.service.NewsCollectionService;
import com.chengxusheji.po.NewsCollection;
import com.chengxusheji.service.NewsService;
import com.chengxusheji.po.News;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//NewsCollection管理控制层
@Controller
@RequestMapping("/NewsCollection")
public class NewsCollectionController extends BaseController {

    /*业务层对象*/
    @Resource NewsCollectionService newsCollectionService;

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
	@InitBinder("newsCollection")
	public void initBinderNewsCollection(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("newsCollection.");
	}
	/*跳转到添加NewsCollection视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new NewsCollection());
		/*查询所有的News信息*/
		List<News> newsList = newsService.queryAllNews();
		request.setAttribute("newsList", newsList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "NewsCollection_add";
	}

	/*客户端ajax方式提交添加新闻收藏信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated NewsCollection newsCollection, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        newsCollectionService.addNewsCollection(newsCollection);
        message = "新闻收藏添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询新闻收藏信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)newsCollectionService.setRows(rows);
		List<NewsCollection> newsCollectionList = newsCollectionService.queryNewsCollection(newsObj, userObj, page);
	    /*计算总的页数和总的记录数*/
	    newsCollectionService.queryTotalPageAndRecordNumber(newsObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = newsCollectionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = newsCollectionService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(NewsCollection newsCollection:newsCollectionList) {
			JSONObject jsonNewsCollection = newsCollection.getJsonObject();
			jsonArray.put(jsonNewsCollection);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询新闻收藏信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<NewsCollection> newsCollectionList = newsCollectionService.queryAllNewsCollection();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(NewsCollection newsCollection:newsCollectionList) {
			JSONObject jsonNewsCollection = new JSONObject();
			jsonNewsCollection.accumulate("collectionId", newsCollection.getCollectionId());
			jsonArray.put(jsonNewsCollection);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询新闻收藏信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<NewsCollection> newsCollectionList = newsCollectionService.queryNewsCollection(newsObj, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    newsCollectionService.queryTotalPageAndRecordNumber(newsObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = newsCollectionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = newsCollectionService.getRecordNumber();
	    request.setAttribute("newsCollectionList",  newsCollectionList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("newsObj", newsObj);
	    request.setAttribute("userObj", userObj);
	    List<News> newsList = newsService.queryAllNews();
	    request.setAttribute("newsList", newsList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "NewsCollection/newsCollection_frontquery_result"; 
	}

     /*前台查询NewsCollection信息*/
	@RequestMapping(value="/{collectionId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer collectionId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键collectionId获取NewsCollection对象*/
        NewsCollection newsCollection = newsCollectionService.getNewsCollection(collectionId);

        List<News> newsList = newsService.queryAllNews();
        request.setAttribute("newsList", newsList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("newsCollection",  newsCollection);
        return "NewsCollection/newsCollection_frontshow";
	}

	/*ajax方式显示新闻收藏修改jsp视图页*/
	@RequestMapping(value="/{collectionId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer collectionId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键collectionId获取NewsCollection对象*/
        NewsCollection newsCollection = newsCollectionService.getNewsCollection(collectionId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonNewsCollection = newsCollection.getJsonObject();
		out.println(jsonNewsCollection.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新新闻收藏信息*/
	@RequestMapping(value = "/{collectionId}/update", method = RequestMethod.POST)
	public void update(@Validated NewsCollection newsCollection, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			newsCollectionService.updateNewsCollection(newsCollection);
			message = "新闻收藏更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "新闻收藏更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除新闻收藏信息*/
	@RequestMapping(value="/{collectionId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer collectionId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  newsCollectionService.deleteNewsCollection(collectionId);
	            request.setAttribute("message", "新闻收藏删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "新闻收藏删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条新闻收藏记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String collectionIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = newsCollectionService.deleteNewsCollections(collectionIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出新闻收藏信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<NewsCollection> newsCollectionList = newsCollectionService.queryNewsCollection(newsObj,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "NewsCollection信息记录"; 
        String[] headers = { "收藏id","被收藏新闻","收藏人","收藏时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<newsCollectionList.size();i++) {
        	NewsCollection newsCollection = newsCollectionList.get(i); 
        	dataset.add(new String[]{newsCollection.getCollectionId() + "",newsCollection.getNewsObj().getNewsTitle(),newsCollection.getUserObj().getName(),newsCollection.getCollectTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"NewsCollection.xls");//filename是下载的xls的名，建议最好用英文 
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
