package com.amc.web.product;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.amc.service.product.ProductService;
import com.amc.common.Page;
import com.amc.common.Search;
import com.amc.service.domain.Product;
import com.amc.service.domain.User;

@Controller


@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productService")
	private ProductService productService;

	public ProductController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@Autowired
	@Qualifier("uploadFilePath")
	private FileSystemResource fsr;
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {
		return "redirect:addProduct.jsp";
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product,
									@RequestParam(value="file", required=false) MultipartFile file) throws Exception {

		product.setProdImage("");
		if(file != null && !file.isEmpty()){
			product.setProdImage(file.getOriginalFilename());
		}
		
		product.setStock(product.getTotalStock());
		productService.addProduct(product);
		
		return "forward:addProductConfirm.jsp";
	}
	
	@RequestMapping( value="deleteProduct", method=RequestMethod.GET )
	public String deleteProduct( @RequestParam("prodNo") int prodNo,									
									Model model ) throws Exception{
		System.out.println("/product/deleteProduct : GET");
		productService.deleteProduct(prodNo);
		
		model.addAttribute("menu", "manage");
		
		return "forward:/product/getGoodsList";
	}
	
/*	@RequestMapping( value="deleteProduct", method=RequestMethod.POST )
	public String deleteProduct( @ModelAttribute("product") Product product, Model model , HttpSession session) throws Exception{
		System.out.println("/product/deleteProduct : POST");
		productService.deleteProduct(product);
		return "forward:/product/index.jsp";
	}
*/	
	@RequestMapping( value="getGoodsProduct", method=RequestMethod.GET)
	public String getGoodsProduct( @RequestParam("prodNo") int prodNo,
								@RequestParam(value="menu",defaultValue="") String menu ,
								Model model ) throws Exception {
		
		System.out.println("/getProduct");				
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		System.out.println(product);
		System.out.println(menu);
		
		if(menu!=""){
			if(menu.equals("manage")){
				return "forward:updateProduct";
			}
		}
		return "forward:getGoodsProduct.jsp";
	}
	
	@RequestMapping( value="getSnackProduct", method=RequestMethod.GET)
	public String getSnackProduct( @RequestParam("prodNo") int prodNo,
								@RequestParam(value="menu",defaultValue="") String menu ,
								Model model ) throws Exception {
		
		System.out.println("/getProduct");				
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		System.out.println(product);
		System.out.println(menu);
		
		if(menu!=""){
			if(menu.equals("manage")){
				return "forward:updateProduct";
			}
		}
		return "forward:getSnackProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{
		System.out.println("/updateProduct");
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		return "forward:updateProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product, 
								 @RequestParam(value="file", required=false) MultipartFile file, 
								 Model model) throws Exception{
		product.setProdImage("");
		if(file != null && !file.isEmpty()){
			product.setProdImage(file.getOriginalFilename());
		}
		
		productService.updateProduct(product);
		product=productService.getProduct(product.getProdNo());		
		model.addAttribute("product", product);
		
		if(product.getProdType()!="G"){
				return "forward:getGoodsProduct.jsp?menu=manage&prodNo="+product.getProdNo();
		}
		return "forward:getSnackProduct.jsp?menu=manage&prodNo="+product.getProdNo();
	}
			
	@RequestMapping(value="getGoodsList")
	public String getGoodsList( @ModelAttribute("search") Search search , Model model , 
								@ModelAttribute("product") Product product ,
								@RequestParam("menu") String menu) throws Exception{
		
		System.out.println("%%%%%%%%%%%%%%%%%ProductController의 /getGoodsList 메소드");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getSearchCondition() == null){
			search.setSearchCondition("1");
		}
		if(menu.equals("manage")){
			search.setStockView(true);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		product.setProdType("G");
		
		// Business logic 수행
		Map<String , Object> map=productService.getGoodsList(search, product);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("$$$$$$$$$$$$$$$$$$$$ result Page : "+resultPage);
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("product", product);
		System.out.println("ProductController의 /getGoodsList 메소드2222222222");
	
		return "forward:/product/listGoodsProduct.jsp";
	}
	
	@RequestMapping(value="getSnackList")
	public String getSnackList( @ModelAttribute("search") Search search , Model model ,
								@ModelAttribute("product") Product product ,
								@RequestParam("menu") String menu) throws Exception{
		
		System.out.println("ProductController의 /getSnackList 메소드");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getSearchCondition() == null){
			search.setSearchCondition("1");
		}
		if(menu.equals("manage")){
			search.setStockView(true);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		product.setProdType("S");
		// Business logic 수행
		Map<String , Object> map=productService.getSnackList(search, product);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("product", product);
	
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+resultPage+search+product+map.get("list"));
		
		return "forward:/product/listSnackProduct.jsp";
	}

}
