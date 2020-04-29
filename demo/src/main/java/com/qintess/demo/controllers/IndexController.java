package com.qintess.demo.controllers;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qintess.demo.models.Evento;
import com.qintess.demo.services.EventoService;

@Controller
@RequestMapping("eventos-app")

	public class IndexController {
		
		@Autowired
		private EventoService eventoService;
	
		@RequestMapping("")
		private String carrega(Model model) throws UnsupportedEncodingException {
			List<Evento> eventos = eventoService.buscaTodos();
			
			List<Evento> eventos_disponiveis = new ArrayList<Evento>();
			
			for(Evento evento: eventos) {
				byte[] encodeBase64 = Base64.getEncoder().encode(evento.getImageEvento());
				evento.setBase64(new String(encodeBase64,"UTF-8"));
			}
			
			model.addAttribute("eventos", eventos);
			return "index";
		}
		
		@RequestMapping("/detalhe/{id}")
		private String carregaDetalhe(Model model,
				@PathVariable(name = "id") int id) throws UnsupportedEncodingException {
			Evento evento = eventoService.buscaPorId(id);
			byte[] encodeBase64 = Base64.getEncoder().encode(evento.getImageEvento());
			String base64Encoded = new String(encodeBase64, "UTF-8");
			model.addAttribute("evento",eventoService.buscaPorId(id));
			model.addAttribute("imageEvento", base64Encoded);
			return "detalhes_evento";
		}
		
		@RequestMapping("/rodape")
		public String rodape() {
			return "rodape";
			
		}
		
}
