package com.reportManager.utils;

import java.util.List;

public class PageHelper extends Page {

	private Integer total;	// ������
	private List<?> list;	// ����
	
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public List<?> getList() {
		return list;
	}
	public void setList(List<?> list) {
		this.list = list;
	}
	public PageHelper(Integer total, List<?> list) {
		super();
		this.total = total;
		this.list = list;
	}
}
