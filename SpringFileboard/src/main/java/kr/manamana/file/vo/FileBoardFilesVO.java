package kr.manamana.file.vo;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class FileBoardFilesVO {
	   private int idx;
	   private int ref;
	   private String oFile;
	   private String sFile;
	   
	   
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public String getoFile() {
		return oFile;
	}
	public void setoFile(String oFile) {
		this.oFile = oFile;
	}
	public String getsFile() {
		return sFile;
	}
	public void setsFile(String sFile) {
		this.sFile = sFile;
	}

	@Override
	public String toString() {
		return "FileBoardFilesVO [idx=" + idx + ", ref=" + ref + ", oFile=" + oFile + ", sFile=" + sFile + "]";
	}
	   

}
