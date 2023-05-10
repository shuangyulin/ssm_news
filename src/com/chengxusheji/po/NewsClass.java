package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class NewsClass {
    /*分类id*/
    private Integer newsClassId;
    public Integer getNewsClassId(){
        return newsClassId;
    }
    public void setNewsClassId(Integer newsClassId){
        this.newsClassId = newsClassId;
    }

    /*分类名称*/
    @NotEmpty(message="分类名称不能为空")
    private String newsClassName;
    public String getNewsClassName() {
        return newsClassName;
    }
    public void setNewsClassName(String newsClassName) {
        this.newsClassName = newsClassName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNewsClass=new JSONObject(); 
		jsonNewsClass.accumulate("newsClassId", this.getNewsClassId());
		jsonNewsClass.accumulate("newsClassName", this.getNewsClassName());
		return jsonNewsClass;
    }}