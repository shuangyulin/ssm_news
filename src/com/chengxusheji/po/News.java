package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class News {
    /*新闻id*/
    private Integer newsId;
    public Integer getNewsId(){
        return newsId;
    }
    public void setNewsId(Integer newsId){
        this.newsId = newsId;
    }

    /*新闻类别*/
    private NewsClass newsClassObj;
    public NewsClass getNewsClassObj() {
        return newsClassObj;
    }
    public void setNewsClassObj(NewsClass newsClassObj) {
        this.newsClassObj = newsClassObj;
    }

    /*新闻标题*/
    @NotEmpty(message="新闻标题不能为空")
    private String newsTitle;
    public String getNewsTitle() {
        return newsTitle;
    }
    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    /*新闻图片*/
    private String newsPhoto;
    public String getNewsPhoto() {
        return newsPhoto;
    }
    public void setNewsPhoto(String newsPhoto) {
        this.newsPhoto = newsPhoto;
    }

    /*新闻内容*/
    @NotEmpty(message="新闻内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*新闻来源*/
    @NotEmpty(message="新闻来源不能为空")
    private String comFrom;
    public String getComFrom() {
        return comFrom;
    }
    public void setComFrom(String comFrom) {
        this.comFrom = comFrom;
    }

    /*浏览次数*/
    @NotNull(message="必须输入浏览次数")
    private Integer hitNum;
    public Integer getHitNum() {
        return hitNum;
    }
    public void setHitNum(Integer hitNum) {
        this.hitNum = hitNum;
    }

    /*添加时间*/
    @NotEmpty(message="添加时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNews=new JSONObject(); 
		jsonNews.accumulate("newsId", this.getNewsId());
		jsonNews.accumulate("newsClassObj", this.getNewsClassObj().getNewsClassName());
		jsonNews.accumulate("newsClassObjPri", this.getNewsClassObj().getNewsClassId());
		jsonNews.accumulate("newsTitle", this.getNewsTitle());
		jsonNews.accumulate("newsPhoto", this.getNewsPhoto());
		jsonNews.accumulate("content", this.getContent());
		jsonNews.accumulate("comFrom", this.getComFrom());
		jsonNews.accumulate("hitNum", this.getHitNum());
		jsonNews.accumulate("addTime", this.getAddTime());
		return jsonNews;
    }}