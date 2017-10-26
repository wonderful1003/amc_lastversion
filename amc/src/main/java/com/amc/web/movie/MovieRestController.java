package com.amc.web.movie;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.amc.common.Page;
import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieComment;
import com.amc.service.domain.onetime.MovieJson;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.movie.MovieService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

//==> MovieAPI RestController
@RestController

@RequestMapping("/movie/*")
public class MovieRestController {

	/// Field
	@Autowired
	@Qualifier("movieServiceImpl")
	private MovieService movieService;
	private String dbFileNames;

	// setter Method ���� ����

	public MovieRestController() {
		System.out.println("MovieRestController default constructor call");
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	@RequestMapping(value = "json/getAPIMoiveList", method = RequestMethod.POST)
	public void getAPIMoiveList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<MovieList> list = movieService.getAPIMoiveList();

		MovieJson movieJson = new MovieJson();

		movieJson.setPage(1);
		movieJson.setTotal(12);
		movieJson.setRecords(10);
		movieJson.setRows(list);

		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(movieJson);

		System.out.println("json ====>>>>>  " + json);

		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");

		PrintWriter out = response.getWriter();
		out.write(json);
		out.flush();
		out.close();

	}

	@RequestMapping(value = "json/addMovie", method = RequestMethod.POST)
	public int addMovie(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Enumeration<?> em = request.getParameterNames();
		List<String> prodList = new ArrayList<String>();
		String oper = "";
		int rtn = 0;

		while (em.hasMoreElements()) {
			String parameterName = (String) em.nextElement();
			String parameterValue = request.getParameter(parameterName);

			System.out.println("parameterName ::" + parameterName);
			System.out.println("parameterValue ::" + parameterValue);

			String[] parameterValues = request.getParameterValues(parameterName);

			if (parameterValues != null) {
				for (int i = 0; i < parameterValues.length; i++) {
					System.out.println("array_" + parameterName + "=" + parameterValues[i]);

					System.out.println(parameterValues.length);

					// Operation del delete from ProductList
					if (parameterValues[i].equals("del")) {
						oper = parameterValues[i];
					} else if (parameterValues[i].equals("add")) {
						oper = parameterValues[i];
					} else if (parameterValues[i].equals("edit")) {
						oper = parameterValues[i];
					} else {

						String[] var = parameterValues[i].split(",");
						for (int j = 0; j < var.length; j++) {
							System.out.println("var :: " + var[j]);

							prodList.add((var[j]));
						}

						System.out.println("proList ===>" + prodList);
					}

				}

			} else {
				System.out.println(parameterName + "=" + parameterValue);
			}
		}

		System.out.println("prodList ::" + prodList);
		String prodList2 = prodList.toString();

		String itemList[] = prodList2.split(",");// Variables declare
		String movieCd = "";
		String delimeter = ",";
		String movieContry = "";
		String directorNms = "";
		String directorNm = "";
		String watchGradeNm = "";
		String movieName = "";
		String genreNms = "";
		String postUrl = "";
		String movieEndDate = "";
		String syonpsis = "";
		String trailer = "";

		for (int i = 0; i < itemList.length; i++) {
			System.out.println("itemList[" + i + "] : " + itemList[i]);
			movieCd = itemList[0].substring(1, 9);
			movieName = itemList[1];
			movieContry = itemList[2];
			movieEndDate = itemList[3];
			syonpsis = itemList[4];
			trailer = itemList[5];
		}

		System.out.println("movieCd : " + movieCd);
		System.out.println("movieName : " + movieName);
		System.out.println("movieContry : " + movieContry);
		System.out.println("movieEndDate : " + movieEndDate);
		System.out.println("syonpsis : " + syonpsis);
		System.out.println("trailer : " + trailer);

		// movieListResult.setMovieList((List<MovieList>) movieList);

		Movie movie = new Movie();
		movie.setMovieCd(movieCd);
		movie.setEndDt(movieEndDate);
		movie.setSynopsis(syonpsis);
		movie.setTrailer(trailer);

		if (oper.equals("del")) {
			System.out.println("/movie/json/delMovie : POST");
			// return productService.deleteProductBatch(prodList);
			return 0;

		} else if (oper.equals("add")) {
			System.out.println("/movie/json/addMovie : POST");
			return 0;
		} else

			return rtn = movieService.addMovie(movie);
	}

	private final String PATH = "C:/amcPoster/";

	@Autowired
	MappingJackson2JsonView jsonView;

	@RequestMapping(value = "json/upload", method = RequestMethod.POST, produces = "text/plain")
	public ModelAndView upload(MultipartHttpServletRequest request, final HttpServletRequest req) throws Exception {

		System.out.println("json/upload called RestControl ");

		ModelAndView model = new ModelAndView();
		model.setView(jsonView);

		Iterator<String> itr = request.getFileNames();
		String movieNo = req.getParameter("movieNo");

		System.out.println("request.getFileNames() :" + request.getFileNames().toString());

		if (itr.hasNext()) {
			List<MultipartFile> mpf = request.getFiles(itr.next());

			for (int i = 0; i < mpf.size(); i++) {

				System.out.println("mpf.size()" + mpf.size());

				String fileNames = mpf.get(i).getOriginalFilename();
				String delimeter = ",";

				fileNames = new String(fileNames.getBytes("8859_1"), "utf-8");

				dbFileNames += fileNames + delimeter;

				// File file = new File(PATH +
				// mpf.get(i).getOriginalFilename());

				// �ѱۃ��� ����
				File file = new File(PATH + fileNames);

				if (file.exists()) {
					System.out.println("file delete execute...");
					file.delete();

				} else {

					// logger.info(file.getAbsolutePath());
					mpf.get(i).transferTo(file);

					System.out.println("fileName :: " + fileNames);
				}
			}

			JSONObject json = new JSONObject();
			json.put("code", "true");
			model.addObject("result", json);

			System.out.println("dbFileNames testing....  " + dbFileNames);

			System.out.println("json value true ::" + json);
			return model;

		} else {

			JSONObject json = new JSONObject();
			json.put("code", "false");
			model.addObject("result", json);

			System.out.println("json value false ::" + json);
			return model;

		}
	}

	// �ظ� �߰�
	@RequestMapping(value = "json/addMovieComment", method = RequestMethod.POST)
	public int addMovieComment(@RequestBody MovieComment movieComment) {

		System.out.println("movieRestController�� addScreenContent���� ");

		System.out.println("1.screenContent ==> " + movieComment);

		/// screenService.addScreenContent(screenContent);
		System.out.println("screen/json/addScreenContent :: POST ��.....");

		return movieService.addMoiveComment(movieComment);

	};

	// �ظ� �߰�
	@RequestMapping(value = "json/getMovieComment/{movieCommentNo}", method = RequestMethod.GET)
	public MovieComment getMovieComment(@PathVariable int movieCommentNo) {

		System.out.println("movieRestController�� getMovieComment���� ");

		System.out.println("1.movieCommentNo ==> " + movieCommentNo);

		/// screenService.addScreenContent(screenContent);
		System.out.println("screen/json/getMovieComment :: POST ��.....");

		return movieService.getMovieComment(movieCommentNo);

	};

	// �ظ� �߰�
	@RequestMapping(value = "json/updateMovieComment", method = RequestMethod.POST)
	public int updateMovieComment(@RequestBody MovieComment movieComment) {

		System.out.println("movieRestController�� updateMovieComment���� ");

		System.out.println("1.movieComment ==> " + movieComment);

		/// screenService.addScreenContent(screenContent);
		System.out.println("screen/json/updateMovieComment :: POST ��.....");

		return movieService.updateMovieComment(movieComment);

	};

	// �ظ� �߰�
	@RequestMapping(value = "json/deleteMovieComment/{movieCommentNo}", method = RequestMethod.GET)
	public int deleteMovieComment(@PathVariable int movieCommentNo) {

		System.out.println("movieRestController�� deleteMovieComment���� ");

		System.out.println("1.movieCommentNo ==> " + movieCommentNo);

		/// screenService.addScreenContent(screenContent);
		System.out.println("screen/json/deleteMovieComment :: POST ��.....");

		return movieService.deleteMovieComment(movieCommentNo);

	};

	// �ظ� �߰�
	@RequestMapping(value = "json/blindMoiveComment", method = RequestMethod.POST)
	public int blindMoiveComment(@RequestBody MovieComment movieComment) {

		System.out.println("movieRestController�� blindMoiveComment���� ");

		System.out.println("1.movieCommentNo ==> " + movieComment);

		/// screenService.addScreenContent(screenContent);
		System.out.println("movieRestController�� blindMoiveComment :: POST ��.....");

		return movieService.blindMoiveComment(movieComment);

	};
	
	// �ظ� �߰�
	@RequestMapping(value = "json/getMovieCommentList/{movieNo}")
	public List<MovieComment> getMovieCommentList(@ModelAttribute("search") Search search, @PathVariable int movieNo) throws Exception {
		System.out.println("movieRestController�� getMovieCommentList���� ");
		System.out.println("1. search ==> "+ search);
		System.out.println("2. movieNo ==> "+ movieNo);
		System.out.println("movieRestController�� getMovieCommentList :: POST ��.....");
		Map<String, Object> map = movieService.getMovieCommentList(search, movieNo);
		System.out.println("3. map ==> "+ map); 
		
		List<MovieComment> list = (List<MovieComment>)map.get("list");
		
		System.out.println("4. list ==> " + list);
		return list;
	}

}
