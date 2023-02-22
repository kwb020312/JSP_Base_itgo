package mvc.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

//�Խ����� ����Ʈ�� ���������� �������� Ŀ�ǵ� ��ü�̴�.
public class BListCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		BoardDAO bDao = BoardDAO.getInstance();
		ArrayList<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		
		int pageNum = 1;
		int limit = 5;  //���������� ��Ÿ�� �Խñ� ��
		
		//������ ���� null�ƴ϶�� �ش� �������� ���ڷ� ��ȯ�Ͽ� ������.
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		
		//DB����Ǿ� �ִ� �Խñ� �� ������ ������
		int total_record = bDao.getListCount(items, text);  
		//DB�� ����Ǿ� �ִ� ���� �Խñ��� ������
		boardlist = bDao.getBoardList(pageNum, limit, items, text); 
		
		int total_page = 0;
		
		//�� ������ ���� ���ϰ� �ִ� �ڵ�
		if(total_record % limit == 0) {
			total_page = total_record / limit;
			Math.floor(total_page);
		}
		//�������� 0�� �ƴ϶��..�������� 1~4��� �Ҹ��̴�.�̰��� ǥ���ϱ� ���ؼ�
		//total_page�� 1�� ������Ű�� �ִ�.
		else {
			total_page = total_record / limit;
			Math.floor(total_page);
			total_page += 1;			
		}
		//request��ü�� ������ �ش��ϴ� ���� �����ϰ� �ִ�.
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("boardlist", boardlist);		
	}
}
