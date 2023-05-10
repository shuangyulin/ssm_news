package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class NewsTag {
    /*标记id*/
    private Integer tagId;
    public Integer getTagId(){
        return tagId;
    }
    public void setTagId(Integer tagId){
        this.tagId = tagId;
    }

    /*被标记新闻*/
    private News newsObj;
    public News getNewsObj() {
        return newsObj;
    }
    public void setNewsObj(News newsObj) {
        this.newsObj = newsObj;
    }

    /*标记的用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*新闻状态*/
    @NotNull(message="必须输入新闻状态")
    private Integer newsState;
    public Integer getNewsState() {
        return newsState;
    }
    public void setNewsState(Integer newsState) {
        this.newsState = newsState;
    }

    /*标记时间*/
    @NotEmpty(message="标记时间不能为空")
    private String tagTime;
    public String getTagTime() {
        return tagTime;
    }
    public void setTagTime(String tagTime) {
        this.tagTime = tagTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNewsTag=new JSONObject(); 
		jsonNewsTag.accumulate("tagId", this.getTagId());
		jsonNewsTag.accumulate("newsObj", this.getNewsObj().getNewsTitle());
		jsonNewsTag.accumulate("newsObjPri", this.getNewsObj().getNewsId());
		jsonNewsTag.accumulate("userObj", this.getUserObj().getName());
		jsonNewsTag.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonNewsTag.accumulate("newsState", this.getNewsState());
		jsonNewsTag.accumulate("tagTime", this.getTagTime());
		return jsonNewsTag;
    }}