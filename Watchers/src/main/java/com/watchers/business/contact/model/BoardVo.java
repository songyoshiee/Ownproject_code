package com.watchers.business.contact.model;

public class BoardVo {

	private String idx;
	private String id;
	private String title;
	private String contents;
	private String first_date;
	private String renewal_date;

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getFirst_date() {
		return first_date;
	}

	public void setFirst_date(String first_date) {
		this.first_date = first_date;
	}

	public String getRenewal_date() {
		return renewal_date;
	}

	public void setRenewal_date(String renewal_date) {
		this.renewal_date = renewal_date;
	}
}
