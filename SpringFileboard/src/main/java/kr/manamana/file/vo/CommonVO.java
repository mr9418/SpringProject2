package kr.manamana.file.vo;

public class CommonVO {
	private int p=1;
	private int s=10;
	private int b=10;
	private int idx=-1;
	private int m=0;
	
	private int currentPage=1;
	private int pageSize=10;
	private int blockSize=10;
	private int mode=0;
	
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
		currentPage = this.p;
	}
	public int getS() {
		return s;
	}
	public void setS(int s) {
		this.s = s;
		pageSize = this.s;
	}
	public int getB() {
		return b;
	}
	public void setB(int b) {
		this.b = b;
		blockSize = this.b;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getM() {
		return m;
	}
	public void setM(int m) {
		this.m = m;
		mode = this.m;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getMode() {
		return mode;
	}
	public void setMode(int mode) {
		this.mode = mode;
	}
	@Override
	public String toString() {
		return "CommonVO [p=" + p + ", s=" + s + ", b=" + b + ", idx=" + idx + ", m=" + m + ", currentPage=" + currentPage
				+ ", pageSize=" + pageSize + ", blockSize=" + blockSize + ", mode=" + mode + "]";
	}
}
