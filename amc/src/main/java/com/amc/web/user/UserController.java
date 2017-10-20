package com.amc.web.user;

import java.util.Date;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.amc.service.domain.User;
import com.amc.service.user.UserService;
import com.amc.common.Page;
import com.amc.common.Search;

//==> 회원관리 Controller
@Controller
@RequestMapping("/user/*")
public class UserController {

	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public UserController(){
		System.out.println(this.getClass());
	}

	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
		System.out.println("/user/addUser : GET");
		return "redirect:/user/addUser.jsp";
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {
		System.out.println("/user/addUser : POST");
		System.out.println("유저 무슨값이 들어오길래 년 값이 0이래 :" + user);
		
		String birth2 = user.getBirth();
		user.setBirth(birth2.replaceAll("-",""));	
		System.out.println(user.getBirth());
		
		userService.addUser(user);
		return "forward:/index.jsp";
	}
	
	@RequestMapping( value="loginUser", method=RequestMethod.GET )
	public String loginUser() throws Exception{
		
		System.out.println("/user/logonUser : GET");
		return "redirect:/user/loginUser.jsp";
	}
	
	@RequestMapping( value="loginUser", method=RequestMethod.POST )
	public String loginUser(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/loginUser : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if(dbUser==null){
			System.out.println("널 값이다");
		}else{
			if(user.getPassword().equals(dbUser.getPassword())){
				session.setAttribute("user", dbUser);
			}
		}
		return "redirect:/index.jsp";
	}
	
	@RequestMapping( value="logoutUser", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		session.invalidate();
		return "redirect:/index.jsp";
	}

	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}

	
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		System.out.println(search.getCurrentPage());
		System.out.println(((Integer)map.get("totalCount")).intValue());
		System.out.println(pageUnit);
		System.out.println(pageSize);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	// 이메일 본인 인증
    @RequestMapping(value = "auth", method = RequestMethod.POST, produces = "application/json")
    public String sendMailAuth(HttpSession session, @RequestParam String email) throws Exception  {
    	
    	String subject = "회원가입 인증 발급 안내 입니다. ";
    	
    	System.out.println(subject);
        
    	StringBuilder sb = new StringBuilder();        
        String img = "http://127.0.0.1:8080/images/uploadFiles/1.jpg";
        
        System.out.println(img);
        sb.append("밑에 이미지를 클릭 하시면 회원가입 화면으로 이동합니다. <br/>" );
        sb.append("<a href=http://127.0.0.1:8080/user/addUser>");
        sb.append("<img src='"+img+"'/></a>");
        
        System.out.println(sb);
        
        userService.send(subject, sb.toString(), "bitcampamc@gmail.com", email, null);
        
        System.out.println("메일 보내기 성공");
        
        return "redirect:/user/authForm.jsp";
    }
    
    // 비밀번호 찾기    
    @RequestMapping(value = "sendPassword", method = RequestMethod.POST)
    public String sendPassword(HttpSession session, 
    									RedirectAttributes ra,
    									@RequestParam String userId, 		
    									@RequestParam String userName ) throws Exception {
    	
    	System.out.println("sendPassword Controller : POST ");
    	User user = userService.getUser(userId);
        if (user != null) {
            if (!user.getUserId().equals(userId)) {
                ra.addFlashAttribute("resultMsg", "입력하신 이메일의 회원정보와 가입된 아이디가 일치하지 않습니다.");
                return "redirect:/find/password";
            }
            int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
            String password = String.valueOf(ran);            
            user.setPassword(password);
            userService.updateUser(user);
            String subject = "임시 비밀번호 발급 안내 입니다.";
            StringBuilder sb = new StringBuilder();
            sb.append("귀하의 임시 비밀번호는 " + password + " 입니다.");
            userService.send(subject, sb.toString(), "bitcampamc@gmail.com", userId, null);
            ra.addFlashAttribute("resultMsg", "귀하의 이메일 주소로 새로운 임시 비밀번호를 발송 하였습니다.");
            
        } else {
            ra.addFlashAttribute("resultMsg", "귀하의 이메일로 가입된 아이디가 존재하지 않습니다.");
        }
        return "redirect:/index.jsp";
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
		return "redirect:/user/addUser";
		/*return map.get("access_token");*/
	}
	
/*	@RequestMapping(value="/getConn", method=RequestMethod.GET)
	public String getConn(@RequestParam("access_token") String accesstoken) throws Exception{
		
		System.out.println("accesstoken : "+accesstoken);
		System.out.println("앱연결 해보자~!");
		
		String user = (String)userService.getConn(userService.getAccessToken(accesstoken));
		//사용자 토큰 받기 메서드 불러오기 성공
		
		System.out.println(user);
		
		return "redirect:/user/addUser";
	}
*/	
}
