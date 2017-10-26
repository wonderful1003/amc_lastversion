package com.amc.web.product;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.amc.common.Page;
import com.amc.common.Search;
import com.amc.service.domain.Product;
import com.amc.service.product.ProductService;


//==> 회원관리 RestController
@RestController
@RequestMapping("product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	//setter Method 구현 않음
			
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 3}")
	int pageSize;

	@Autowired
	@Qualifier("uploadFilePath")
	private FileSystemResource fsr;
	
	/*Constructor*/
	public ProductRestController(){
		System.out.println(this.getClass());
	}

	

	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct( @RequestParam("product") String json,
									@RequestParam("file") MultipartFile file ) throws Exception{
				
		Product product = new ObjectMapper().readValue(json.toString(), Product.class);
		
		product.setProdImage("");
		if(!file.isEmpty()){
			FileOutputStream fos = new FileOutputStream(new File(fsr.getPath(), file.getOriginalFilename()));
			fos.write(file.getBytes());
			fos.flush();
			fos.close();
			product.setProdImage(file.getOriginalFilename());
		}
		
		productService.addProduct(product);
		
		return product;
	}
	
	@RequestMapping( value="json/getGoodsProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception{
		System.out.println("여기는 product rest controller :"+prodNo);
		System.out.println("이건 productService.getProduct(prodNo)");
		System.out.println(productService.getProduct(prodNo));
		System.out.println("/product/json/getProduct : GET");
		
		//Business Logic
		return productService.getProduct(prodNo);
	}

	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
	public Product updateProduct(	@RequestBody Product product ) throws Exception{
	
		System.out.println("/product/json/updateProduct : POST");
		//Business Logic
		System.out.println("::"+product);
		
		productService.updateProduct(product);
						
		return product;
	}
	
	@RequestMapping( value="json/uploadFile", method=RequestMethod.POST )
	public boolean uploadFile( @RequestParam("file") MultipartFile file ) throws Exception{
		System.out.println("productRestController의 uploadfile");
		boolean result = false;
		
		if(!file.isEmpty()){
			try{
				file.transferTo(new File(fsr.getPath(),file.getOriginalFilename()));
				result = true;
			}catch(Exception e){
				System.out.println(file.getOriginalFilename()+" upload fail;");
			}
		}
		
		return result;
	}

	
	@RequestMapping( value="json/getProductList", method=RequestMethod.GET )
	public Map getProductList(	@RequestBody Search search ) throws Exception{
	
		System.out.println("/product/json/getProductList : POST");
		//Business Logic
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map=productService.getGoodsList(search, null);
		System.out.println("map ::"+map);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage ::" + resultPage);
		System.out.println("map tostring ::" + map.toString());
		
		return map;
	}
	
	@RequestMapping( value="json/getGoodsList/{menu}")
	public Map<String, Object> getGoodsList(@RequestBody Search search, 											
											@PathVariable String menu) throws Exception{
		Product product = new Product();
		System.out.println("######################################### json/getGoodsList 여기 오냐?");
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		if(menu.equals("manage")){
			search.setStockView(true);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		product.setProdType("G");
		
		if(search.getSearchCondition() != null && search.getSearchCondition().equals("2")){
			try{
				Integer.parseInt(search.getSearchKeyword());
			}catch(NumberFormatException e){
				search.setSearchKeyword("");
			}
			try{
				Integer.parseInt(search.getSearchKeyword2());
			}catch(NumberFormatException e){
				search.setSearchKeyword2("");
			}
		}
		
		Map<String, Object> map = productService.getGoodsList(search, product);
		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP:"+map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		
		return map;
	}
	
	@RequestMapping( value="json/getSnackList/{menu}")
	public Map<String, Object> getSnackList(@RequestBody Search search, 										
											@PathVariable String menu) throws Exception{
		System.out.println("######################################### json/getSnackList 여기 오냐?");
		Product product = new Product();
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		if(menu.equals("manage")){
			search.setStockView(true);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		product.setProdType("S");
		
		if(search.getSearchCondition() != null && search.getSearchCondition().equals("2")){
			try{
				Integer.parseInt(search.getSearchKeyword());
			}catch(NumberFormatException e){
				search.setSearchKeyword("");
			}
			try{
				Integer.parseInt(search.getSearchKeyword2());
			}catch(NumberFormatException e){
				search.setSearchKeyword2("");
			}
		}
		
		Map<String, Object> map = productService.getSnackList(search, product);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		
		return map;
	}


	
}
