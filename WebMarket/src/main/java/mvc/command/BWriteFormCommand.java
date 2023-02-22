package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;

public class BWriteFormCommand implements BCommand {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("BWriteFormCommand클래스 들어옴");
		
		BoardDAO bDao = BoardDAO.getInstance();
		String id = request.getParameter("id");
		String name = bDao.getLoginName(id);
		request.setAttribute("name", name);
		
		System.out.println("BWriteFormCommand클래스 나감");
	}
}
