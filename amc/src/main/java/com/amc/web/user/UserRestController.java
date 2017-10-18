package com.amc.web.user;

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
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}

	@RequestMapping( value="checkDuplication/{userId}", method=RequestMethod.GET )
	public boolean checkDuplication( @PathVariable String userId ) throws Exception{

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
	
}
