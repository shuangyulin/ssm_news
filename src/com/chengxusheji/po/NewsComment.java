package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class NewsComment {
    /*评论id*/
    private Integer commentId;
    public Integer getCommentId(){
        return commentId;
    }
    public void setCommentId(Integer commentId){
        this.commentId = commentId;
    }

    /*被评新闻*/
    private News newsObj;
    public News getNewsObj() {
        return newsObj;
    }
    public void setNewsObj(News newsObj) {
        this.newsObj = newsObj;
    }

    /*评论人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*评论内容*/
    @NotEmpty(message="评论内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*评论时间*/
    @NotEmpty(message="评论时间不能为空")
    private String commentTime;
    public String getCommentTime() {
        return commentTime;
    }
    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNewsComment=new JSONObject(); 
		jsonNewsComment.accumulate("commentId", this.getCommentId());
		jsonNewsComment.accumulate("newsObj", this.getNewsObj().getNewsTitle());
		jsonNewsComment.accumulate("newsObjPri", this.getNewsObj().getNewsId());
		jsonNewsComment.accumulate("userObj", this.getUserObj().getName());
		jsonNewsComment.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonNewsComment.accumulate("content", this.getContent());
		jsonNewsComment.accumulate("commentTime", this.getCommentTime());
		return jsonNewsComment;
    }}