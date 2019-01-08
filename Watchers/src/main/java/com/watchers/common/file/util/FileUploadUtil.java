package com.watchers.common.file.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.watchers.common.exception.WatchersBizException;
import com.watchers.common.mstdata.util.SystemPropsUtil;

@Component
public class FileUploadUtil {
	
	public static String upload(HttpServletRequest request){
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest)request;
 	    Iterator<String> fileNameIterator = mpRequest.getFileNames();
 	    String fileName = "";
 	    
 	    while (fileNameIterator.hasNext()) {
     	    	//파일정보를 하나씩 취득한다
     	        MultipartFile multiFile = mpRequest.getFile((String) fileNameIterator.next());
     	        if (multiFile.getSize() > 0) { // writing file to a directory
     	        	
     	        	String uploadPath = SystemPropsUtil.getEnvironProperty("FILE_UPLOAD_PATH").replace("\\", File.separator);
     	        	fileName = multiFile.getOriginalFilename();
     	        	String pattern = Pattern.quote(File.separator);
     	        	
     	        	for(int i = 0; i < fileName.split(pattern).length-1; i++){
     	        		File f = new File(uploadPath+fileName.split(pattern)[i]);
     	        		
     	        		if(!f.exists()){
     	        			f.mkdir();
     	        		}
     	        	}
     	        	
     	        	File upLoadedfile = new File(uploadPath+File.separator+fileName);
     	        	try {
						upLoadedfile.createNewFile();
						FileOutputStream fos = new FileOutputStream(upLoadedfile); 
	     	        	fos.write(multiFile.getBytes());
	     	        	fos.close(); //setting the value of fileUploaded variable
					} catch (IOException e) {
						throw new WatchersBizException("File Upload에 실패하였습니다.");
					} 
     	        }
         }
 	     return fileName;
	}
}
