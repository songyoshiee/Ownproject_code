package com.watchers.common.file.util;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

import com.watchers.common.exception.WatchersBizException;
import com.watchers.common.mstdata.util.SystemPropsUtil;

@Component
public class FileDownloadUtil {
	
	public static void download(HttpServletResponse response, String fileName){
		byte[] buffer = new byte[1024];
		int byteData = 0;
		int offset = 0;
		
		// 파일다운로드 실행 
 		try {
 		   //파일객체를 생성한다
 			String uploadPath = SystemPropsUtil.getEnvironProperty("FILE_UPLOAD_PATH").replace("\\", File.separator);
            File downloadFile = new File(uploadPath+File.separator+fileName);
            
            response.setHeader("Content-Type", "application/octet-stream;");
            response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName,"UTF-8").replace("+",  "%20") + ";");
            response.setHeader("Content-Transfer-Encoding", "binary");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "-1");
            
            //데이터스트림을 생성한다
            FileInputStream in = new FileInputStream(downloadFile);
            //Response객체를 이용하여 출력스트림을 생성
            ServletOutputStream out = response.getOutputStream();

            //모든데이터를 출력한다(버퍼길이만큼나누어서 출력한다)
            while((byteData = in.read(buffer, offset, buffer.length)) != -1){
                out.write(buffer, 0, byteData);
            }
            in.close();
            out.flush();
            out.close();
 		} catch (Exception ex) {
 			//에러메세지 출력
 			System.out.println(ex.getMessage() + " : " +  ex);
 			throw new WatchersBizException("File Download에 실패하였습니다.");
 		}
	}
}
