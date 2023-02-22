package mvc.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.BCommand;
import mvc.command.BDeleteCommand;
import mvc.command.BListCommand;
import mvc.command.BUpdateCommand;
import mvc.command.BViewCommand;
import mvc.command.BWriteCommand;
import mvc.command.BWriteFormCommand;

@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("actionDo");
		
		BCommand com = null;
		String viewPage = null;
		
		// getRequestURI()는 요청된 전체 URI를 가져온다.
		String uri = request.getRequestURI();
		System.out.println("URI : " + uri);
		
		// getContextPath()는 프로젝트명이 반환된다.
		String contextPath = request.getContextPath();
		System.out.println("contextPath : " + contextPath);
		
		// 실행되는 파일의 이름을 반환한다.
		String command = uri.substring(contextPath.length());
		System.out.println("command : " + command);
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		// command패턴에 따라 분기
		if(command.equals("/BoardListAction.do")) {  
			System.out.println("------------------------------");
			System.out.println("/BoardListAction.do페이지 호출");
			System.out.println("------------------------------");
			com = new BListCommand();
			com.execute(request, response);
			System.out.println("BoardListAction의 execute() 실행 완료");
			viewPage = "./board/list.jsp";
		} else if(command.equals("/BoardWriteForm.do")) { // 회원의 로그인 정보를 가져온다.
			System.out.println("------------------------------");
			System.out.println("/BoardWriteForm.do페이지 호출");
			System.out.println("------------------------------");
			com = new BWriteFormCommand();
			com.execute(request, response);
			System.out.println("BoardWriteForm의 execute() 실행 완료");
			viewPage = "./board/writeForm.jsp";
		} else if(command.equals("/BoardWriteAction.do")) { // 게시글을 작성하고 DB에 저장
			System.out.println("------------------------------");
			System.out.println("/BoardWriteAction.do페이지 호출");
			System.out.println("------------------------------");
			com = new BWriteCommand();
			com.execute(request, response);
			System.out.println("BoardWriteAction의 execute() 실행 완료");
			viewPage = "/BoardListAction.do";
		} else if(command.equals("/BoardViewAction.do")) { // 게시글을 작성하고 DB에 저장
			System.out.println("------------------------------");
			System.out.println("/BoardViewAction.do페이지 호출");
			System.out.println("------------------------------");
			com = new BViewCommand();
			com.execute(request, response);
			System.out.println("BoardViewAction의 execute() 실행 완료");
			viewPage = "./board/view.jsp";
		} else if(command.equals("/BoardUpdateAction.do")) { // 게시글을 수정
			System.out.println("------------------------------");
			System.out.println("/BoardUpdateAction.do페이지 호출");
			System.out.println("------------------------------");
			com = new BUpdateCommand();
			com.execute(request, response);
			System.out.println("BoardUpdateAction의 execute() 실행 완료");
			viewPage = "/BoardListAction.do";
		} else if(command.equals("/BoardDeleteAction.do")) { // 게시글을 수정
			System.out.println("------------------------------");
			System.out.println("/BoardDeleteAction.do페이지 호출");
			System.out.println("------------------------------");
			com = new BDeleteCommand();
			com.execute(request, response);
			System.out.println("BoardDeleteAction의 execute() 실행 완료");
			viewPage = "/BoardListAction.do";
		}
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher(viewPage);
		rd.forward(request, response);
	}

}
