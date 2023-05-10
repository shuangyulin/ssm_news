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
import com.chengxusheji.service.NewsCommentService;
import com.chengxusheji.po.NewsComment;
import com.chengxusheji.service.NewsService;
import com.chengxusheji.po.News;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//NewsComment管理控制层
@Controller
@RequestMapping("/NewsComment")
public class NewsCommentController extends BaseController {

    /*业务层对象*/
    @Resource NewsCommentService newsCommentService;

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
	@InitBinder("newsComment")
	public void initBinderNewsComment(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("newsComment.");
	}
	/*跳转到添加NewsComment视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new NewsComment());
		/*查询所有的News信息*/
		List<News> newsList = newsService.queryAllNews();
		request.setAttribute("newsList", newsList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "NewsComment_add";
	}

	/*客户端ajax方式提交添加新闻评论信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated NewsComment newsComment, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        newsCommentService.addNewsComment(newsComment);
        message = "新闻评论添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询新闻评论信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)newsCommentService.setRows(rows);
		List<NewsComment> newsCommentList = newsCommentService.queryNewsComment(newsObj, userObj, page);
	    /*计算总的页数和总的记录数*/
	    newsCommentService.queryTotalPageAndRecordNumber(newsObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = newsCommentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = newsCommentService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(NewsComment newsComment:newsCommentList) {
			JSONObject jsonNewsComment = newsComment.getJsonObject();
			jsonArray.put(jsonNewsComment);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询新闻评论信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<NewsComment> newsCommentList = newsCommentService.queryAllNewsComment();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(NewsComment newsComment:newsCommentList) {
			JSONObject jsonNewsComment = new JSONObject();
			jsonNewsComment.accumulate("commentId", newsComment.getCommentId());
			jsonArray.put(jsonNewsComment);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询新闻评论信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<NewsComment> newsCommentList = newsCommentService.queryNewsComment(newsObj, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    newsCommentService.queryTotalPageAndRecordNumber(newsObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = newsCommentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = newsCommentService.getRecordNumber();
	    request.setAttribute("newsCommentList",  newsCommentList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("newsObj", newsObj);
	    request.setAttribute("userObj", userObj);
	    List<News> newsList = newsService.queryAllNews();
	    request.setAttribute("newsList", newsList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "NewsComment/newsComment_frontquery_result"; 
	}

     /*前台查询NewsComment信息*/
	@RequestMapping(value="/{commentId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer commentId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键commentId获取NewsComment对象*/
        NewsComment newsComment = newsCommentService.getNewsComment(commentId);

        List<News> newsList = newsService.queryAllNews();
        request.setAttribute("newsList", newsList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("newsComment",  newsComment);
        return "NewsComment/newsComment_frontshow";
	}

	/*ajax方式显示新闻评论修改jsp视图页*/
	@RequestMapping(value="/{commentId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer commentId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键commentId获取NewsComment对象*/
        NewsComment newsComment = newsCommentService.getNewsComment(commentId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonNewsComment = newsComment.getJsonObject();
		out.println(jsonNewsComment.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新新闻评论信息*/
	@RequestMapping(value = "/{commentId}/update", method = RequestMethod.POST)
	public void update(@Validated NewsComment newsComment, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			newsCommentService.updateNewsComment(newsComment);
			message = "新闻评论更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "新闻评论更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除新闻评论信息*/
	@RequestMapping(value="/{commentId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer commentId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  newsCommentService.deleteNewsComment(commentId);
	            request.setAttribute("message", "新闻评论删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "新闻评论删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条新闻评论记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String commentIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = newsCommentService.deleteNewsComments(commentIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出新闻评论信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("newsObj") News newsObj,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<NewsComment> newsCommentList = newsCommentService.queryNewsComment(newsObj,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "NewsComment信息记录"; 
        String[] headers = { "评论id","被评新闻","评论人","评论内容","评论时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<newsCommentList.size();i++) {
        	NewsComment newsComment = newsCommentList.get(i); 
        	dataset.add(new String[]{newsComment.getCommentId() + "",newsComment.getNewsObj().getNewsTitle(),newsComment.getUserObj().getName(),newsComment.getContent(),newsComment.getCommentTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"NewsComment.xls");//filename是下载的xls的名，建议最好用英文 
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
