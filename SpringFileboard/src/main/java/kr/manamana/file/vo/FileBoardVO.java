package kr.manamana.file.vo;

import java.util.Date;
import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;



@XmlRootElement
public class FileBoardVO {
	private int idx;
	private String name;
	private String password;
	private String subject;
	private String content;
	private Date   regDate;
	private String ip;
	
	//필드두개 추가
	private int fileCount; //첨부파일개수
	private List<FileBoardFilesVO> fileList; //첨부파일목록

	private int commentCount; // 리스트에서 댓글의 개수 저장
	
	private List<CommentVO> commentList; // 내용보기에서 댓글들 저장

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getFileCount() {
		return fileCount;
	}

	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	public List<FileBoardFilesVO> getFileList() {
		return fileList;
	}

	public void setFileList(List<FileBoardFilesVO> fileList) {
		this.fileList = fileList;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public List<CommentVO> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<CommentVO> commentList) {
		this.commentList = commentList;
	}

	@Override
	public String toString() {
		return "FileBoardVO [idx=" + idx + ", name=" + name + ", password=" + password + ", subject=" + subject
				+ ", content=" + content + ", regDate=" + regDate + ", ip=" + ip + ", fileCount=" + fileCount
				+ ", fileList=" + fileList + ", commentCount=" + commentCount + ", commentList=" + commentList + "]";
	}
	
	
	
	
	
}
