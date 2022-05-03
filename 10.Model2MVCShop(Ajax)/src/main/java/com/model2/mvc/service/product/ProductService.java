package com.model2.mvc.service.product;


import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
/*
 * 회원관리를 추상화 캡슐화한 UserService Interface
 */
public interface ProductService {
	
	// 상품추가
	public void addProduct(Product product) throws Exception;
	
	// 상품 정보 확인
	public Product getProduct(int prodNo) throws Exception;
	
	// 상품정보 리스트
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	// 상품정보 수정
	public void updateProduct(Product product) throws Exception;
	
	
}