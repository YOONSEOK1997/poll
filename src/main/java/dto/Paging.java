package dto;

public class Paging {
	private int curretPage;
	private int rowPerPage;
	
	public int getCurretPage() {
		return curretPage;
	}
	public void setCurrentPage(int curretPage) {
		this.curretPage = curretPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	public int getBeginRow () {
		return (this.curretPage-1) * this.rowPerPage;
	}
	public int getLastPage(int totalRow) {
		int lastPage = totalRow / this.rowPerPage;
		if(totalRow % this.rowPerPage !=0) {
			lastPage = lastPage+1;
		}
		return lastPage;
	}
}
