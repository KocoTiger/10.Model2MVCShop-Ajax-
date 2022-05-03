package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;






	@RestController
	//jason data를 요구하는 애들만 처리할 용도
	@RequestMapping("/product/*")
	public class ProductRestController {
	
		
	///////////////////////2022.04.22 (금)//////////////////////////////////
	//@RequestMapping("/addProduct.do")
	//1.1 json이 붙어 있으면 Data만 요청을 하는 것 => restController에 진입을 하겠다는 말
	//밑에 String은 model& View전략과 String 전략을 쓴것 중 String 전략을 쓴것이다
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct( @RequestBody Product product) throws Exception {
	
	//어차피 실려온다				  @RequestParam("manuDate") String manuDate ) throws Exception {
	//replace("-", "")
	product.setManuDate(product.getManuDate().replace("-", ""));
	
	//원래 sql 에 날짜 받아올때 했었던 것을 이렇게 바꿔야함
	//Data가 들어온지 혹인 하기 위해 json 넣어주기
	System.out.println("/product/json/addProduct : POST");
	//Business Logic
	productService.addProduct(product);
	
	//////////////////////////////////////////
	//return "redirect:/product/addProductView.jsp";
	
	return product;
	//이게 어디로 가면 좋을까 forward를 쓰는게 맞는듯
	/////////////////////////////////////////
	}
	
	////////////////////////2022.04.22 (금)/////////////////////////
	//2.1 해동 센세와 함께만들어본 getProductTest_Codehaus()
	///////////////////////////////////////////////////////
	
	//F
	@Autowired
	@Qualifier("productServiceImpl") //package com.model2.mvc.service.product.impl;를 wiring
	ProductService productService;
	
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception {
		
//		System.out.println("/getProduct.do");
		System.out.println("/product/getProduct : GET");
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
	
		
		//밑에것은 UI를 보여줄 필요가 없다 그래서
		//return "forward:/product/getProduct.jsp"; 이것은 Navigation => 할 필요 없음
		
		//Data만 보내줌면 된다
		return product;
	}

///////////////////////2022.04.27//////////////////////////////////
////////////////GEt방식이 안돼/////////////////////////////////////////	
	
	//	@RequestMapping("/updateProductView.do")
	//	public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{
		@RequestMapping( value="json/updateProduct/{prodNo}", method=RequestMethod.GET )
		public Product updateProduct( @PathVariable int prodNo ) throws Exception{	
	
	//		System.out.println("/updateProductView.do");
			System.out.println("/product/json/updateProduct : GET");
			
			//Business Logic
			Product product = productService.getProduct(prodNo);
			// Model 과 View 연결
//			model.addAttribute("product", product);
			
//			return "forward:/product/updateProductView.jsp";
	//		return "redirect:/product/updateProduct.jsp"; 
			//이렇게 하니 상품수정 버튼이 안눌러짐 => 경로가 updateProduct여기로 갔다가 거기에 있는 fncupdate를 받게 됨
			return product;
			
		}

////////////////GEt방식이 안돼/////////////////////////////////////////	
	
///////////////////////2022.04.27//////////////////////////////////	
//	@RequestMapping("/updateProduct.do")
//	public String updateProduct( @ModelAttribute("product") Product product , Model model , HttpSession session) throws Exception{
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
	public Product updateProduct( @RequestBody Product product, HttpSession session) throws Exception{

	
//		System.out.println("/updateProduct.do");
		System.out.println("/product/json/updateProduct : POST");
		
		//Business Logic
		productService.updateProduct(product);
		
		if(session.getAttribute("product") != null) {
		
		int sessionId=((Product)session.getAttribute("product")).getProdNo();
		if(sessionId == (product.getProdNo())){
			session.setAttribute("product", product);
			}
		}
		
//		return "redirect:/getProduct.do?prodNo=" + product.getProdNo();
		return product;
	}

///////////////////////2022.04.27//////////////////////////////////
//	@RequestMapping("/listProduct.do")
//	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{

	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	
	@RequestMapping( value="json/listProduct" )
	public Map listProduct( @RequestBody Search search , HttpServletRequest request) throws Exception{

//		System.out.println("/listProduct.do");
		System.out.println("/product/json/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
//		model.addAttribute("list", map.get("list"));
//		model.addAttribute("resultPage", resultPage);
//		model.addAttribute("search", search);
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
//		return "forward:/product/listProduct.jsp";
		return map;
	}
	
	
	
	
	
	
	
/////////////////////////////////////////////////////////////////////////////	
	
	
	
	
	
	
	
	
}
