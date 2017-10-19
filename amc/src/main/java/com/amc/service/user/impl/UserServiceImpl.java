package com.amc.service.user.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.domain.User;
import com.amc.service.user.UserService;



import com.amc.service.user.UserDAO;

//==> ȸ������ ���� ����
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
		System.out.println("����� serviceImpl : "+userDAO.getId(user));
		return userDAO.getId(user);
	}

	@Override
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
	}

    @Override
    public boolean send(String subject, String text, String from, String to, String filePath) {
        // javax.mail.internet.MimeMessage    	
    	System.out.println("���� ������ ���� ����");
    	MimeMessage message = javaMailSender.createMimeMessage();
 
        try {
            // org.springframework.mail.javamail.MimeMessageHelper
        	// ��Ƽ��Ʈ �޽����� �ʿ��ϴٴ� �ǹ̷� true �÷��׸� ����Ѵ�
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setSubject(subject);
            
            // ���Ե� �ؽ�Ʈ�� HTML�̶�� �ǹ̷� true �÷��׸� ����Ѵ�
            
            helper.setText(text, true);
            helper.setFrom(from);
            helper.setTo(to);

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
	private static final String Redirect_URL= "http://127.0.0.1:8080/user/kakaologin";
	//Host
	private static final String keyHost = "https://kauth.kakao.com";
	
	//TODO : CODE �ޱ�.
	/*GET /oauth/authorize?client_id={app_key}&redirect_uri={redirect_uri}&response_type=code HTTP/1.1
	Host:kauth.kakao.com
	* */

	@Override
	public String getCode() throws Exception {
		// TODO  : �ڵ�ޱ�
		System.out.println("UserServiceImpl �� kakao get Code �޼ҵ�");
		String getcode = keyHost;
		getcode += "/oauth/authorize?client_id="+RestApiKey;
		getcode += "&redirect_uri="+Redirect_URL;
		getcode += "&response_type=code";
		
		return getcode;

	}

	@Override
	public String getAccessToken(String authorize_code) throws Exception {
		// TODO : ����� ��ū �ޱ�
		/*
		curl -v -X POST https://kauth.kakao.com/oauth/token \
			 -d 'grant_type=authorization_code' \
			 -d 'client_id={app_key}' \
			 -d 'redirect_uri={redirect_uri}' \
			 -d 'code={authorize_code}'
			 */
		String 	getAccessToken = keyHost;
				getAccessToken += "/oauth/token?grant_type=authorization_code";
				getAccessToken += "&client_id="+RestApiKey;
				getAccessToken += "&redirect_uri="+Redirect_URL;
				getAccessToken += "&code="+authorize_code;
		return getAccessToken;

	}

	@Override
	public String getHtml(String accesstoken) throws Exception {
		// TODO : ��û�� �� �о����!!
		HttpURLConnection urlconn = null;
		String returnresult = null;
		try {
			URL url = new URL(accesstoken);
			//1.URL ��ü ����.
			urlconn = (HttpURLConnection)url.openConnection();
			//2.�ش� url�� url.openConnection() �޼��带 ���ؼ�.
			// HttpURLConnection ���Ӱ�ü�� �����Ͽ� url�� �����մϴ�.
			urlconn.setRequestProperty("Content-Type","application/json;charset=UTF-8");
			//3.url ������ http ������� ��û�ϱ����ؼ��� īī������ ������ ������� ��û�Ѵ�.
			//īī����(Response) : Content-Type: application/json;charset=UTF-8
			urlconn.setRequestMethod("POST");
			//4.POST������� ��û�ϱ�.
			urlconn.setDoOutput(true);
			//5.��û�� ���� �о�ð��̴�. true �� ����.
			urlconn.connect();
			//6.�����ϰڴ�.
			BufferedReader in = new BufferedReader(new InputStreamReader(urlconn.getInputStream(),"UTF-8"));
			//7.
			
			//*BufferdeReader : ���ڸ� �о���̰ų� ���� ��½�Ʈ������ ���ڸ� �������� ���۸� �����ν� ���ڸ� ȿ�������� ó������ �մϴ�.
			//*InputStreamReader : �� ���ھ� ������ ���۸��� �ϰԵǸ� ����� ��Ʈ�����κ��� �̸� ���ۿ� �����͸� ���� ���� ������ ���� ȿ�������� ������� �� �ֽ��ϴ�.
			
			//8.urlconn.getInputStream(), "UTF-8"
			//������ url ���� ���� UTF-8�� ���ڵ� �Ǿ �о�´�.
			//�׸��� ���ڿ� BufferedReader,InputStreamReader  �� ���ؼ� ���ڸ� �о���� in�� �����մϴ�. 
			StringBuffer sb = new StringBuffer();
			//9. StringBuffer ��ü ����
			
			//*StringBuffer : StringBuffer�� ���ڿ��� �߰��ϰų� ���� �Ҷ� �ַ� ����ϴ� �ڷ����̴�.
			
			String result = null;
			//10. ������ ������ ����
			while ((result = in.readLine()) != null){
				//11.while ���� ���ؼ� ��� ������ ������ö����� �о���� ���ؼ� ���
				//BufferedReader�� readLine() �޼��带 �̿��ؼ� null �� �ƴ� ��쿡 �ϳ��� �о�� result�� �������ش�.
				sb.append(result);
				sb.append("\n");
			}
			returnresult = sb.toString();
			
		}catch(MalformedURLException e){
			/*	
			 * URL ��ü�� ������ �� �ش� URL �ڿ��� �������� �ʰų� �ùٸ��� ���� ���������� ��쿡 
			MalformedURLException ���ܰ� �߻��մϴ�.
			�� ���ܴ� catched exception�̱� ������ try-catch������ URL �����ڵ带 ��������մϴ�.
			*/
			e.printStackTrace();
		}catch(IOException e){
			/*
			urlconn = (HttpURLConnection) url.openConnection();
			������ ���� �Ұ�찡 �ֱ⶧���� IOException ó���� ���־����ϴ�. 
			*/
			e.printStackTrace();
		}
		
		return returnresult;
	}
	

	@Override
	public Map<String, String> JsonStringMap(String data) throws Exception {
		// TODO JSON �����;� ���Է� ���ʶ�
		Map<String, String> map = new HashMap<String, String>();
		//1. map�� ��Ƽ� �������ֱ����ؼ� map �� ����
		ObjectMapper mapper = new ObjectMapper();
		//2. ObjectMapper ��ü ���� ObjectMapper�� readValue() �� ���ؼ� Json �����͸� ��ȯ�����ٰ��̴�. 
		
		try{
			map = mapper.readValue(data, new TypeReference<HashMap<String, String>>() {
			//3. �޾ƿ� data�� TypeReference�� ���ؼ� map���� ��ȯ�����صڿ� mapper.readValue�� ���ؼ� map�� �������ش�.
			});
		}catch(JsonParseException e){
			//TODO Auto-generated catch block
			e.printStackTrace();
		}catch(JsonMappingException e){
			//TODO Auto-generated catch block
			e.printStackTrace();
		}catch(IOException e){
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		//4.����ó�� ���� ���ش�.
		
		return map;
		//5. ���������� �޾ƿ� data�� map �� ������ �Ϸ�Ǿ����Ƿ� map�� ���Ͻ����ش�.
	}
	
/*	@Override
	public String getAllList(String access_token) throws Exception {
		// TODO : ��û�� �� �о����!!
		HttpURLConnection urlconn = null;
		String returnresult = null;
		
		try {
			URL url = new URL("https://kapi.kakao.com/v1/api/talk/profile?access_token="+access_token);			
			urlconn = (HttpURLConnection) url.openConnection();				
			urlconn.setRequestProperty("Content-Type", "application/json;charset=UTF-8");				
			urlconn.setDoOutput(true);				
			urlconn.connect();
			
			BufferedReader in = new BufferedReader(new InputStreamReader(urlconn.getInputStream(), "UTF-8"));			
			StringBuffer sb = new StringBuffer();				
			String result = null;
		
			while ((result = in.readLine()) != null){
				sb.append(result);
				sb.append("\n");
			}
			returnresult = sb.toString();
			
		}catch(MalformedURLException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}
		
		return returnresult;
	}
*/
	
	
	@Override
	public String getAllList(String access_token) throws Exception {
		// TODO : ��û�� �� �о����!!
		HttpURLConnection urlconn = null;
		String returnresult = null;
		
		try {
			URL url = new URL("https://kapi.kakao.com/v1/user/me");			
			urlconn = (HttpURLConnection) url.openConnection();				
			urlconn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");				
			urlconn.setRequestProperty("Authorization", "Bearer " + access_token);
			urlconn.setRequestMethod("GET");
			urlconn.setDoOutput(true);				
			
			int responseCode = urlconn.getResponseCode();

			BufferedReader in = null;
			
			if(responseCode == 200){
				in = new BufferedReader(new InputStreamReader(urlconn.getInputStream(),"utf-8"));
			}else{
				in = new BufferedReader(new InputStreamReader(urlconn.getErrorStream(),"utf-8"));
			}
			
			String result = "";
			StringBuffer sb = new StringBuffer();				
			
		
			while ((result = in.readLine()) != null){
				sb.append(result);
			}
			returnresult = sb.toString();
			in.close();
			
		}catch(MalformedURLException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}
		
		System.out.println(returnresult);

		JSONObject jsonObj = (JSONObject)JSONValue.parse(returnresult);
		System.out.println("JSON OBJECT Ȯ�� : "+ returnresult);
		
		System.out.println(jsonObj.get("kaccount_email"));
		

		return returnresult;
	}


/*	@Override
	public String getConn(String accesstoken) throws Exception {
		// TODO �ۿ����̶�µ� �̰� ���� �����̾�
		System.out.println("UserServiceImpl �� getConn �޼ҵ�");
		HttpURLConnection urlconn = null;
		String returnresult = null;
	
		try {
			URL url = new URL("https://kapi.kakao.com/v1/user/signup/profile?access_token="+accesstoken);			
			urlconn = (HttpURLConnection) url.openConnection();				
			urlconn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");				
			urlconn.setDoOutput(true);				
			urlconn.connect();
			
			BufferedReader in = new BufferedReader(new InputStreamReader(urlconn.getInputStream(), "UTF-8"));			
			StringBuffer sb = new StringBuffer();				
			String result = null;
		
			while ((result = in.readLine()) != null){
				sb.append(result);
				sb.append("\n");
			}
			returnresult = sb.toString();
			
		}catch(MalformedURLException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}
		
		return returnresult;
		
	}
*/
	
	
}
