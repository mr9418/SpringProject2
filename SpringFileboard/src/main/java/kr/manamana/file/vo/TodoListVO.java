package kr.manamana.file.vo;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@XmlRootElement
@NoArgsConstructor
@AllArgsConstructor
@Data

public class TodoListVO {  
	private int idx;
	private String title;
	private String name;
	private String status;
	private String contents;
	private Date regDate;
	
	

}
