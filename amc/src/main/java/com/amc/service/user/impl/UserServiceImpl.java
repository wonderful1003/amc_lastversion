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
    	System.out.println("메일 보내기 서비스 임플");
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
	
	//TODO : CODE 받기.
	/*GET /oauth/authorize?client_id={app_key}&redirect_uri={redirect_uri}&response_type=code HTTP/1.1
	Host:kauth.kakao.com
	* */

	@Override
	public String getCode() throws Exception {
		// TODO  : 코드받기
		System.out.println("UserServiceImpl 의 kakao get Code 메소드");
		String getcode = keyHost;
		getcode += "/oauth/authorize?client_id="+RestApiKey;
		getcode += "&redirect_uri="+Redirect_URL;
		getcode += "&response_type=code";
		
		return getcode;

	}

	@Override
	public String getAccessToken(String authorize_code) throws Exception {
		// TODO : 사용자 토큰 받기
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
		// TODO : 요청한 값 읽어오기!!
		HttpURLConnection urlconn = null;
		String returnresult = null;
		try {
			URL url = new URL(accesstoken);
			//1.URL 객체 생성.
			urlconn = (HttpURLConnection)url.openConnection();
			//2.해당 url에 url.openConnection() 메서드를 통해서.
			// HttpURLConnection 접속객체를 생성하여 url에 접속합니다.
			urlconn.setRequestProperty("Content-Type","application/json;charset=UTF-8");
			//3.url 접속후 http 방식으로 요청하기위해서는 카카오톡이 지정한 방식으로 요청한다.
			//카카오톡(Response) : Content-Type: application/json;charset=UTF-8
			urlconn.setRequestMethod("POST");
			//4.POST방식으로 요청하기.
			urlconn.setDoOutput(true);
			//5.요청한 값을 읽어올것이다. true 로 지정.
			urlconn.connect();
			//6.연결하겠다.
			BufferedReader in = new BufferedReader(new InputStreamReader(urlconn.getInputStream(),"UTF-8"));
			//7.
			
			//*BufferdeReader : 문자를 읽어들이거나 문자 출력스트림으로 문자를 내보낼때 버퍼링 함으로써 문자를 효율적으로 처리가능 합니다.
			//*InputStreamReader : 한 문자씩 읽지만 버퍼링을 하게되면 입출력 스트림으로부터 미리 버퍼에 데이터를 갖다 놓기 때문에 보다 효율적으로 입출력할 수 있습니다.
			
			//8.urlconn.getInputStream(), "UTF-8"
			//연결한 url 으로 부터 UTF-8로 인코딩 되어서 읽어온다.
			//그리고 난뒤에 BufferedReader,InputStreamReader  을 통해서 문자를 읽어오고 in에 저장합니다. 
			StringBuffer sb = new StringBuffer();
			//9. StringBuffer 객체 생성
			
			//*StringBuffer : StringBuffer는 문자열을 추가하거나 변경 할때 주로 사용하는 자료형이다.
			
			String result = null;
			//10. 저장할 변수명 지정
			while ((result = in.readLine()) != null){
				//11.while 문을 통해서 모든 내용을 가지고올때까지 읽어오기 위해서 사용
				//BufferedReader의 readLine() 메서드를 이용해서 null 이 아닐 경우에 하나씩 읽어와 result에 저장해준다.
				sb.append(result);
				sb.append("\n");
			}
			returnresult = sb.toString();
			
		}catch(MalformedURLException e){
			/*	
			 * URL 객체를 생성할 때 해당 URL 자원이 존재하지 않거나 올바르지 않은 프로토콜일 경우에 
			MalformedURLException 예외가 발생합니다.
			이 예외는 catched exception이기 때문에 try-catch문으로 URL 생성코드를 감싸줘야합니다.
			*/
			e.printStackTrace();
		}catch(IOException e){
			/*
			urlconn = (HttpURLConnection) url.openConnection();
			연결이 실패 할경우가 있기때문에 IOException 처리를 해주었습니다. 
			*/
			e.printStackTrace();
		}
		
		return returnresult;
	}
	

	@Override
	public Map<String, String> JsonStringMap(String data) throws Exception {
		// TODO JSON 데이터야 내게로 오너라
		Map<String, String> map = new HashMap<String, String>();
		//1. map에 담아서 리턴해주기위해서 map 을 생성
		ObjectMapper mapper = new ObjectMapper();
		//2. ObjectMapper 객체 생성 ObjectMapper의 readValue() 를 통해서 Json 데이터를 변환시켜줄것이다. 
		
		try{
			map = mapper.readValue(data, new TypeReference<HashMap<String, String>>() {
			//3. 받아온 data를 TypeReference를 통해서 map으로 변환시켜준뒤에 mapper.readValue를 통해서 map에 저장해준다.
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
		//4.예외처리 까지 해준다.
		
		return map;
		//5. 마지막으로 받아온 data를 map 에 저장이 완료되었으므로 map을 리턴시켜준다.
	}
	
/*	@Override
	public String getAllList(String access_token) throws Exception {
		// TODO : 요청한 값 읽어오기!!
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
		// TODO : 요청한 값 읽어오기!!
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
		System.out.println("JSON OBJECT 확인 : "+ returnresult);
		
		System.out.println(jsonObj.get("kaccount_email"));
		

		return returnresult;
	}


/*	@Override
	public String getConn(String accesstoken) throws Exception {
		// TODO 앱연결이라는데 이건 정말 고통이야
		System.out.println("UserServiceImpl 의 getConn 메소드");
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
