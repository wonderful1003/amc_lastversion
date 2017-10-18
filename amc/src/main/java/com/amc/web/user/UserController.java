package com.amc.web.user;

import java.util.Date;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
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
    	
    	String joinCode  = "<a href=//192.168.0.6:8080/user/addUser>";
        session.setAttribute("joinCode", joinCode);
        String subject = "회원가입 인증 발급 안내 입니다. ";
        StringBuilder sb = new StringBuilder();        
        String img = "http://192.168.0.17:8080/images/uploadFiles/1.jpg";
        sb.append("<a href=http://192.168.0.17:8080/user/addUser>");
        sb.append("<img src='"+img+"'/></a>");
        userService.send(subject, sb.toString(), "bitcampamc@gmail.com", email, null);
        return "redirect:/user/authForm.jsp";
    }
    
    // 비밀번호 찾기    
    @RequestMapping(value = "sendPassword", method = RequestMethod.POST)
    public String sendMailPassword(HttpSession session, 
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
	
}
