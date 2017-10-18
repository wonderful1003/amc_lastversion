package com.amc.service.user.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.domain.User;
import com.amc.service.user.UserService;
import com.amc.service.user.UserDAO;

//==> 회원관리 서비스 구현
@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	
	///Field
	@Autowired
	@Qualifier("userDAOImpl")
	private UserDAO userDAO;
	
	// org.springframework.mail.javamail.JavaMailSender
    private JavaMailSender javaMailSender;
    
	///Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	
    public void setJavaMailSender(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.addUser(user);
	}

	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUser(userId);
	}

	@Override
	public Map<String , Object > getUserList(Search search) throws Exception {
		List<User> list= userDAO.getUserList(search);
		int totalCount = userDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.updateUser(user);
	}

	@Override
	public boolean checkDuplication(String userId) throws Exception {
		// TODO Auto-generated method stub
		boolean result=true;
		User user=userDAO.getUser(userId);
		if(user != null) {
			result=false;
		}
		return result;
	}
	
	@Override
	public User checkUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean checkId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String getId(User user) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("여기는 serviceImpl : "+userDAO.getId(user));
		return userDAO.getId(user);
	}

	@Override
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
	}

    @Override
    public boolean send(String subject, String text, String from, String to, String filePath) {
        // javax.mail.internet.MimeMessage    	
        MimeMessage message = javaMailSender.createMimeMessage();
 
        try {
            // org.springframework.mail.javamail.MimeMessageHelper
        	// 멀티파트 메시지가 필요하다는 의미로 true 플래그를 사용한다
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setSubject(subject);
            
            // 포함된 텍스트가 HTML이라는 의미로 true 플래그를 사용한다
            
            helper.setText(text, true);
            helper.setFrom(from);
            helper.setTo(to);

            FileSystemResource fileR = new FileSystemResource(new File("C:/Users/bang/Pictures/1.jpg"));
            
            helper.addInline("identifier1234", fileR);
            
            // 첨부 파일 처리
            if (filePath != null) {
                File file = new File(filePath);
                if (file.exists()) {
                    helper.addAttachment(file.getName(), new File(filePath));
                }
            }
 
            javaMailSender.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return false;
    }
    
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	//Rest Api KEY
	private static final String RestApiKey = "23cb6e93a0ebb38a3ee3f59ebebe33a7";
	//redirect_uri
	private static final String Redirect_URL= "http://127.0.0.1:8080/kakaologin";
	//Host
	private static final String keyHost = "https://kauth.kakao.com";
	
	//TODO : CODE 받기.
	/*GET /oauth/authorize?client_id={app_key}&redirect_uri={redirect_uri}&response_type=code HTTP/1.1
	Host:kauth.kakao.com
	* */

	@Override
	public String getCode() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getAccessToken(String authorize_code) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getHtml(String accesstoken) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> JsonStringMap(String data) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getAllList(String access_token) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
