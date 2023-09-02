package com.acadmi.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.AbstractView;

import com.acadmi.chat.ChatFilesVO;
import com.acadmi.report.ReportFilesVO;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class FileManager extends AbstractView {
	
	@Value("${app.upload}")
	private String path;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ChatFilesVO chatFilesVO = (ChatFilesVO)model.get("chatFilesVO");
		if(chatFilesVO != null) {
			File file = new File(path+"chat",chatFilesVO.getFileName());
			//한글 처리
			response.setCharacterEncoding("UTF-8");
			
			//총 파일 크기
			response.setContentLengthLong(file.length());
			
			//다운로드시 파일의 이름을 인코딩
			String oriName = URLEncoder.encode(chatFilesVO.getOriName(), "UTF-8");
			
			//header 설정
			response.setHeader("Content-Disposition", "attachment;filename=\""+oriName+"\"");
			response.setHeader("Content-Transfer-Encoding", "binary");
			
			//HDD에서 파일을 읽고
			FileInputStream fi = new FileInputStream(file);
			//Client로 전송 준비
			OutputStream os = response.getOutputStream();
			
			//전송
			FileCopyUtils.copy(fi, os);
			
			//자원 해제
			os.close();
			fi.close();
			return;
		}
		FileVO fileVO = (FileVO)model.get("fileVO");
		
		if(fileVO !=null) {
			String board = (String)model.get("board");
			
			File file = new File(path+board, fileVO.getFileName());
			
			//한글 처리
			response.setCharacterEncoding("UTF-8");
			
			//총 파일 크기
			response.setContentLengthLong(file.length());
			
			//다운로드시 파일의 이름을 인코딩
			String oriName = URLEncoder.encode(fileVO.getOriName(), "UTF-8");
			
			//header 설정
			response.setHeader("Content-Disposition", "attachment;filename=\""+oriName+"\"");
			response.setHeader("Content-Transfer-Encoding", "binary");
			
			//HDD에서 파일을 읽고
			FileInputStream fi = new FileInputStream(file);
			//Client로 전송 준비
			OutputStream os = response.getOutputStream();
			
			//전송
			FileCopyUtils.copy(fi, os);
			
			//자원 해제
			os.close();
			fi.close();
			
			return;
		}

	
		
		ReportFilesVO reportFilesVO = (ReportFilesVO)model.get("reportFilesVO");
		
		if(reportFilesVO !=null) {
			File file = new File(path+"report",reportFilesVO.getFileName());
			//한글 처리
			response.setCharacterEncoding("UTF-8");
			
			//총 파일 크기
			response.setContentLengthLong(file.length());
			
			//다운로드시 파일의 이름을 인코딩
			String oriName = URLEncoder.encode(reportFilesVO.getOriName(), "UTF-8");
			
			//header 설정
			response.setHeader("Content-Disposition", "attachment;filename=\""+oriName+"\"");
			response.setHeader("Content-Transfer-Encoding", "binary");
			
			//HDD에서 파일을 읽고
			FileInputStream fi = new FileInputStream(file);
			//Client로 전송 준비
			OutputStream os = response.getOutputStream();
			
			//전송
			FileCopyUtils.copy(fi, os);
			
			//자원 해제
			os.close();
			fi.close();
			return;
		}
		
		
		
		
	}
	
	//1. HDD에 파일을 저장하고 저장된 파일명을 리턴
	public String saveFile(String path, MultipartFile multipartFile) throws Exception {
		
		//1. file 객체 생성
		File file = new File(path);//저장할 폴더
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		//2. 저장할 파일명 생성
		String fileName = UUID.randomUUID().toString();
		fileName = fileName+"_"+multipartFile.getOriginalFilename();
		
		//3. 경로명과 파일명의 정보를 가진 File 객체 생성
		file = new File(file, fileName);
		
		//4. 파일 저장
		multipartFile.transferTo(file);
		
		return fileName;
		
	}
	
	public String saveFile(String path, byte[] payLoad, String oriName) throws Exception {
		//1. 파일 객체 생성
		File file = new File(path);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		//2. 저장할 파일명 생성
		String fileName = UUID.randomUUID().toString();
		fileName = fileName+"_"+oriName;
		
		//3. 경로명과 파일명의 정보를 가진 File 객체 생성
		file = new File(file, fileName);
		
		//4. 파일 저장
		FileCopyUtils.copy(payLoad, file);
		
		return fileName;
	}
	
	//파일 HDD삭제
	public boolean fileDelete(String path, String fileName) throws Exception {
		
		File file = new File(path + "\\" + fileName);
	
		
		return file.delete();
	}

}
