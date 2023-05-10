package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class NewsCollection {
    /*收藏id*/
    private Integer collectionId;
    public Integer getCollectionId(){
        return collectionId;
    }
    public void setCollectionId(Integer collectionId){
        this.collectionId = collectionId;
    }

    /*被收藏新闻*/
    private News newsObj;
    public News getNewsObj() {
        return newsObj;
    }
    public void setNewsObj(News newsObj) {
        this.newsObj = newsObj;
    }

    /*收藏人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*收藏时间*/
    @NotEmpty(message="收藏时间不能为空")
    private String collectTime;
    public String getCollectTime() {
        return collectTime;
    }
    public void setCollectTime(String collectTime) {
        this.collectTime = collectTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNewsCollection=new JSONObject(); 
		jsonNewsCollection.accumulate("collectionId", this.getCollectionId());
		jsonNewsCollection.accumulate("newsObj", this.getNewsObj().getNewsTitle());
		jsonNewsCollection.accumulate("newsObjPri", this.getNewsObj().getNewsId());
		jsonNewsCollection.accumulate("userObj", this.getUserObj().getName());
		jsonNewsCollection.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonNewsCollection.accumulate("collectTime", this.getCollectTime());
		return jsonNewsCollection;
    }}