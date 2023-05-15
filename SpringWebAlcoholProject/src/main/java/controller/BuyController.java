package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.BuyDAO;
import dao.DetailViewDAO;
import util.Buy;
import util.NicePayKey;
import vo.CartVO;
import vo.FullViewVO;
import vo.OrderListVO;
import vo.ProducerVO;
import vo.UserVO;

@Controller
public class BuyController implements Buy, NicePayKey {

	@Autowired
	ServletContext app;

	@Autowired
	BuyDAO buydao;

	@Autowired
	DetailViewDAO productDao;

	@RequestMapping("/buy_product.do")
	@ResponseBody
	public int buyProduct(int idx) {
		return buydao.selectProduct(idx).getProduct_price();
	}

	@RequestMapping("/cartAdd.do")
	public void cartAdd(int idx, int amount, int price, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		List<OrderListVO> cart = (List<OrderListVO>) (session.getAttribute("cart"));

		if (cart == null) {
			cart = new ArrayList<OrderListVO>();
		}

		boolean isExist = false;
		for (OrderListVO item : cart) {
			if (item.getProduct_idx() == idx) {
				cart.remove(item);
				item.setProduct_amount(amount);
				item.setProduct_price((price - 3000) / amount);
				cart.add(item);
				isExist = true;
				break;
			}
		}
		if (!isExist) {
			OrderListVO cart_input = new OrderListVO();
			cart_input.setProduct_idx(idx);
			cart_input.setProduct_amount(amount);
			cart_input.setProduct_price(price / amount);
			cart.add(cart_input);
		}
		session.setAttribute("cart", cart);
		try {
			response.sendRedirect("cart.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/cart.do")
	public String Cart_In(HttpServletRequest request, Model model) {
		List<OrderListVO> cart = (List<OrderListVO>) (request.getSession().getAttribute("cart"));
		if (cart != null) {
			List<FullViewVO> cart_in = buydao.selectProducts(cart);
			for (FullViewVO i : cart_in) {
				for (OrderListVO j : cart) {
					if (i.getProduct_idx() == j.getProduct_idx())
						i.setProduct_amount(j.getProduct_amount());
				}
			}
			model.addAttribute("cart_in", cart_in);
		}
		return CART_IN;
	}

	@RequestMapping("/remove_cart_in.do")
	@ResponseBody
	public void Remove_Cart_In(int idx, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		List<OrderListVO> cart = (List<OrderListVO>) (session.getAttribute("cart"));
		for (OrderListVO item : cart) {
			if (item.getProduct_idx() == idx) {
				cart.remove(item);
				break;
			}
		}
		session.setAttribute("cart", cart);
	}

	@RequestMapping(value = "/findProdcerName.do", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String[] findProdcerName(@RequestBody Map<String, Object> data) {
		List<Integer> idxs = (ArrayList<Integer>) (data.get("idxs"));
		System.out.println(idxs.size());
		String[] names = new String[idxs.size()];
		for (int i = 0; i < idxs.size(); i++) {
			if (idxs.get(i) != 0) {
				names[i] = buydao.selectProducer(idxs.get(i)).getProducer_name();
			}
		}
		return names;
	}

	@RequestMapping("/fixAmount.do")
	@ResponseBody
	public void fixAmount(int idx, int amount, HttpServletRequest request) {
		HttpSession session = request.getSession();
		List<OrderListVO> cart = (List<OrderListVO>) (session.getAttribute("cart"));

		for (OrderListVO item : cart) {
			if (item.getProduct_idx() == idx) {
				cart.remove(item);
				item.setProduct_amount(amount);
				cart.add(item);
				break;
			}
		}

		session.setAttribute("cart", cart);
	}

	@RequestMapping("/pay_ready1.do")
	public String Buying(int amount, int idx, int price, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		HttpSession session = request.getSession();
		try {
			UserVO user = (UserVO) session.getAttribute("user1");
			Timestamp date = buydao.Sysdate();
			List<OrderListVO> cart = new ArrayList<OrderListVO>();
			OrderListVO item = new OrderListVO();
			item.setUser_idx(user.getUser1_idx());
			item.setOrderlist_date(date);
			item.setProduct_amount(amount);
			item.setProduct_idx(idx);
			item.setProduct_price((price - 3000) / amount);
			item.setOrderlist_addr(user.getUser1_addr());
			item.setOrderlist_phonenumber(user.getUser1_phonenumber());
			cart.add(item);
			buydao.insertOrder(cart);
			
			model.addAttribute("date", date);
			model.addAttribute("size", cart.size());
			model.addAttribute("name", buydao.selectProduct(idx).getProduct_name());
			model.addAttribute("cost", price);
			model.addAttribute("clientId", CLIENT_ID);
			model.addAttribute("orderId", UUID.randomUUID());
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.sendRedirect("login.do");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		return PAY_READY;
	}

	@RequestMapping("/pay_readys.do")
	public String Buying(int cost, HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();
		try {
			UserVO user = (UserVO) session.getAttribute("user1");
			Timestamp date = buydao.Sysdate();
			List<OrderListVO> cart = (List<OrderListVO>) (session.getAttribute("cart"));
			for (int i = 0; i < cart.size(); i++) {
				OrderListVO item = cart.get(i);
				item.setOrderlist_date(date);
				item.setUser_idx(user.getUser1_idx());
				item.setOrderlist_addr(user.getUser1_addr());
				item.setOrderlist_phonenumber(user.getUser1_phonenumber());
			}

			buydao.insertOrder(cart);
			session.removeAttribute("cart");
			model.addAttribute("date", date);
			model.addAttribute("size", cart.size());
			model.addAttribute("name", buydao.selectProduct(cart.get(0).getProduct_idx()).getProduct_name());
			model.addAttribute("cost", cost);
			model.addAttribute("clientId", CLIENT_ID);
			model.addAttribute("orderId", UUID.randomUUID());

		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.sendRedirect("login.do");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		return PAY_READY;

	}

	@RequestMapping(value = "pay_ready.do")
	public String Buying(int cost, Timestamp date, String name, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		System.out.println(date);
		request.setAttribute("date", date);
		model.addAttribute("date", date);
		model.addAttribute("size", 1);
		model.addAttribute("name", name);
		model.addAttribute("cost", cost);
		model.addAttribute("clientId", CLIENT_ID);
		model.addAttribute("orderId", UUID.randomUUID());

		return PAY_READY;

	}

	@RequestMapping("pay.do")
	public void Pay(String user1_phonenumber, String user1_addr, int cost, Timestamp orderdate,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("cost", cost);
		session.setAttribute("date", orderdate);
		UserVO user = (UserVO) session.getAttribute("user1");
		OrderListVO vo = new OrderListVO();
		vo.setOrderlist_addr(user1_addr);
		vo.setOrderlist_status(1);
		vo.setOrderlist_phonenumber(user1_phonenumber);
		List<OrderListVO> cart = buydao.selectOrderList(orderdate, user.getUser1_idx());
		for (int i = 0; i < cart.size(); i++) {
			OrderListVO item = cart.get(i);
			vo.setOrderlist_idx(item.getOrderlist_idx());
			cart.remove(item);
			item.setOrderlist_phonenumber(user1_phonenumber);
			item.setOrderlist_addr(user1_addr);
			item.setOrderlist_status(1);
			buydao.updateOrderList(vo);
			cart.add(item);
		}
	}

	@RequestMapping("pay_list.do")
	public String pay_list(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user1");
		int idx = user.getUser1_idx();
		List<OrderListVO> dates = buydao.selectDate(idx);
		if (dates.size() != 0) {
			List<CartVO> cart = new ArrayList<CartVO>();
			Map<Integer, FullViewVO> products = new HashMap<Integer, FullViewVO>();
			Map<Integer, ProducerVO> producers = new HashMap<Integer, ProducerVO>();

			for (OrderListVO OL : dates) {
				CartVO vo = new CartVO();
				vo.setCart(buydao.selectOrderList(OL.getOrderlist_date(), idx));
				vo.setName(buydao.selectProductName(vo.getCart().get(0).getProduct_idx()).getProduct_name());
				for (OrderListVO cal : vo.getCart()) {
					products.put(cal.getProduct_idx(), productDao.selectOne(cal.getProduct_idx()));

					int producer_idx = products.get(cal.getProduct_idx()).getProducer_idx();
					producers.put(producer_idx, buydao.selectProducer(producer_idx));

					if (!cal.getPay_id().equals("1"))
						vo.setId(cal.getPay_id());
				}

				vo.setOrderlist_status(vo.getCart().get(0).getOrderlist_status());
				if (vo.getOrderlist_status() < 2)
					vo.setId(UUID.randomUUID().toString());
				else {
					vo.setId(vo.getCart().get(0).getPay_id());
					vo.setTid(vo.getCart().get(0).getTid());
				}

				if (vo.getCart().size() > 1) {
					vo.setName(vo.getName() + " 외 " + (vo.getCart().size() - 1) + "종");
				}
				Comparator<OrderListVO> comparator1 = new Comparator<OrderListVO>() {
					@Override
					public int compare(OrderListVO cart1, OrderListVO cart2) {
						int idx1 = buydao.selectProduct(cart1.getProduct_idx()).getProducer_idx();
						int idx2 = buydao.selectProduct(cart2.getProduct_idx()).getProducer_idx();
						return Integer.compare(idx1, idx2); // 내림차순으로 변경
					}
				};
				int cost = 0;
				vo.sortCart(comparator1);
				for (OrderListVO Ol : vo.getCart()) {
					int producer_idx = 9999999;
					if (Ol.getProduct_amount() != 0) {
						cost += Ol.getProduct_price() * Ol.getProduct_amount();
						int pd_idx = products.get(Ol.getProduct_idx()).getProducer_idx();
						if (pd_idx != producer_idx) {
							producer_idx = pd_idx;
							cost += 3000;
						}
					}
				}
				vo.setCost(cost);
				cart.add(vo);
			}

			Comparator<CartVO> comparator2 = new Comparator<CartVO>() {
				@Override
				public int compare(CartVO cart1, CartVO cart2) {
					Timestamp date1 = cart1.getCart().get(0).getOrderlist_date();
					Timestamp date2 = cart2.getCart().get(0).getOrderlist_date();
					return date2.compareTo(date1); // 내림차순으로 변경
				}
			};
			cart.sort(comparator2);
			model.addAttribute("clientID", CLIENT_ID);
			model.addAttribute("carts", cart);
			model.addAttribute("products", products);
			model.addAttribute("producers", producers);

		}
		return PAY_RESPONSE;
	}

	@RequestMapping("removeBuy.do")
	@ResponseBody
	public void removeCart(Timestamp date, HttpServletResponse response, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user1");
		buydao.deleteCart(date, user.getUser1_idx());
	}
}