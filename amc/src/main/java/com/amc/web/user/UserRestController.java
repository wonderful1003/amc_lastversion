package com.amc.web.user;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.amc.service.user.UserService;
import com.amc.service.domain.User;

//==> 회원관리 RestController
@RestController
@RequestMapping("/user/json/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	@RequestMapping( value="getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="loginUser", method=RequestMethod.POST )
	public User loginUser(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if(dbUser==null){
			System.out.println("널 값이다");
		}else{
			if(user.getPassword().equals(dbUser.getPassword())){
				session.setAttribute("user", dbUser);
			}
		}
		
		System.out.println("dbUser : " + dbUser);
		
		return dbUser;
	}

	@RequestMapping( value="checkDuplication/{userId}", method=RequestMethod.GET )
	public boolean checkDuplication( @PathVariable String userId ) throws Exception{
		System.out.println("중복확인 체크");
		return userService.checkDuplication(userId);
	}
	
	@RequestMapping( value="checkUserId/{tempId}", method=RequestMethod.POST)
   public String checkUserId(  @PathVariable String tempId, Model model , HttpSession session) throws Exception {
      
      System.out.println("/user/checkUserId : GET");
      tempId=tempId.replace(",", ".");
      System.out.println("userId :: " + tempId);
      User user = userService.checkUserId(tempId);
      
      model.addAttribute("user", user);
      System.out.println("checkUserId 11111111111111");
      session.setAttribute("user", user);
      System.out.println("checkUserId 2222222222222");
         
      return "forward:/user/addUserView.jsp";
   }
	
	@RequestMapping( value="getId", method=RequestMethod.POST)
	public String getId(  @RequestBody User user,
							 HttpSession session) throws Exception {

	  System.out.println(user);
	  
	  /*userService.getId(user);*/
	  
      /*return "forward:/user/main.jsp";*/
	  System.out.println("여기는 controller : "+userService.getId(user));
	  
	  return userService.getId(user);
   }
	
	@RequestMapping(value="/kakaoGetCode", method=RequestMethod.GET)
	public String kakaoGetCode() throws Exception{
		
		System.out.println("kakao.getCode() : "+userService.getCode());
	
		return "redirect:"+userService.getCode();
	}

	@RequestMapping(value="/kakaologin", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam("code") String code) throws Exception{
		
		System.out.println("code : "+code);
		
		userService.getAccessToken(code);
		//사용자 토큰 받기 메서드 불러오기 성공
		
		String data = (String)userService.getHtml((userService.getAccessToken(code)));
		System.out.println("data :"+data);
		
		Map<String, String> map = userService.JsonStringMap(data);
		System.out.println("map : "+map);
		System.out.println("access_token :"+map.get("access_token"));
		System.out.println("refresh_token :"+map.get("refresh_token"));
		System.out.println("scope :"+map.get("scope"));
		System.out.println("token_type :"+map.get("token_type"));
		System.out.println("expires_in :"+map.get("expires_in"));
		
		//사용자 전체 정보받아오기를 시작합니다.
		String list = userService.getAllList((String)map.get("access_token"));
		System.out.println("list :"+list);
		//JSON데이터 변환!
		/*Map<String, String> getAllListMap = userService.JsonStringMap(list);*/
		
		System.out.println(list.substring(4,20));
		
/*		System.out.println("getAllListMap :"+getAllListMap);
		System.out.println("id :"+(String)getAllListMap.get("kaccount_email"));
		System.out.println("nickName :"+(String)getAllListMap.get("nickName"));
		System.out.println("profileImageURL :"+(String)getAllListMap.get("profileImageURL"));
		System.out.println("thumbnailURL :"+(String)getAllListMap.get("thumbnailURL"));
		System.out.println("countryISO"+(String)getAllListMap.get("countryISO"));
*/		
		/*return "redirect:/user/getConn";*/
		return "forward:/user/jason/loginUser";
		/*return map.get("access_token");*/
	}
	
	@RequestMapping( value="kakaoLogin", method=RequestMethod.POST )
	public User kakaoJsLogin(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/kakaoLogin : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if(dbUser==null){
			System.out.println("널 값이다");
		}else{
			
				session.setAttribute("user", dbUser);
			
		}
		
		System.out.println("dbUser : " + dbUser);
		
		return dbUser;
	}

	
}
