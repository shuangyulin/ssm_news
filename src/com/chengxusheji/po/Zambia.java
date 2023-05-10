package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Zambia {
    /*赞id*/
    private Integer zambiaId;
    public Integer getZambiaId(){
        return zambiaId;
    }
    public void setZambiaId(Integer zambiaId){
        this.zambiaId = zambiaId;
    }

    /*被赞新闻*/
    private News newsObj;
    public News getNewsObj() {
        return newsObj;
    }
    public void setNewsObj(News newsObj) {
        this.newsObj = newsObj;
    }

    /*用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*被赞时间*/
    @NotEmpty(message="被赞时间不能为空")
    private String zambiaTime;
    public String getZambiaTime() {
        return zambiaTime;
    }
    public void setZambiaTime(String zambiaTime) {
        this.zambiaTime = zambiaTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonZambia=new JSONObject(); 
		jsonZambia.accumulate("zambiaId", this.getZambiaId());
		jsonZambia.accumulate("newsObj", this.getNewsObj().getNewsTitle());
		jsonZambia.accumulate("newsObjPri", this.getNewsObj().getNewsId());
		jsonZambia.accumulate("userObj", this.getUserObj().getName());
		jsonZambia.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonZambia.accumulate("zambiaTime", this.getZambiaTime());
		return jsonZambia;
    }}