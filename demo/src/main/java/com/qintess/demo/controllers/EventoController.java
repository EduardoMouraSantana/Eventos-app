package com.qintess.demo.controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qintess.demo.models.Evento;
import com.qintess.demo.services.CasaService;
import com.qintess.demo.services.EventoService;;

@Controller
@RequestMapping("/evento")
public class EventoController {

	@Autowired
	private EventoService eventoService;

	@Autowired
	private CasaService casaService;

	@RequestMapping("")
	public String carrega(Model model) {
		model.addAttribute("eventos", eventoService.buscaTodos());
		model.addAttribute("evento", new Evento());
		return "evento";
	}

	@RequestMapping("/salva")
	public String salva(@ModelAttribute Evento evento, Model model,
			@RequestParam(required = false, value = "cancela") String cancela,
			@RequestParam(value = "casa") String casa, @RequestParam(value = "nome") String nome,
			@RequestParam(value = "descricao") String descricao, @RequestParam(value = "data") Date data,
			@RequestParam(value = "preco") double preco, @RequestParam(value = "quantidade_ingresso") int qtd,
			@RequestParam(required = false, value = "imagem") MultipartFile imagem, RedirectAttributes redirectAtt){
		
		try {

			byte[] bImagem;

			if (cancela != null) {
				return "redirect:/evento/";
			}

			if (imagem != null && imagem.getSize() > 0) {
				bImagem = imagem.getBytes();
				evento.setImageEvento(bImagem);
			}

			if (nome == null | casa == null | descricao == null | data == null | preco == 0 | qtd == 0
					| evento.getImageEvento() == null) {
				redirectAtt.addFlashAttribute("messageError", "Erro! Os campos obrigatórios não foram preenchidos");
				return "redirect:/evento/";
			}
			
			if(casaService.buscaPorNome(casa)==null) {
				redirectAtt.addFlashAttribute("messageError","Erro: Essa casa de show não está cadastrada");
				return "redirect:/evento/";
			}

			if (evento.getId() == 0) {
				evento.setCasa_show(casaService.buscaPorNome(casa));
				eventoService.insere(evento);
				redirectAtt.addFlashAttribute("messageSuccess", "Evento cadastrado com sucesso!");
			} else {
				evento.setCasa_show(casaService.buscaPorNome(casa));
				eventoService.altera(evento);
				redirectAtt.addFlashAttribute("messageSuccess", "Evento alterado com sucesso!");
			}
		} catch (Exception e) {
			redirectAtt.addFlashAttribute("messageError", "ERRO: " + e.getMessage());
		}
		return "redirect:/evento/";

	}

	@RequestMapping("/deleta/{id}")
	public String deleta(@PathVariable(name = "id") int id) {
		eventoService.remove(eventoService.buscaPorId(id));
		return "redirect:/evento/";
	}

	@RequestMapping("/altera/{id}")
	public String carregaAlterar(@PathVariable(name = "id") int id, Model model, RedirectAttributes redirectAtt) {

		try {
			
			Evento evento = eventoService.buscaPorId(id);
			byte[] encodeBase64 = Base64.getEncoder().encode(evento.getImageEvento());
			String base64Encoded = new String(encodeBase64, "UTF-8");
			
			model.addAttribute("eventos", eventoService.buscaTodos());
			model.addAttribute("evento", evento);
			model.addAttribute("imagemEvento", base64Encoded);

		} catch (Exception e) {
			redirectAtt.addAttribute("messageError", "Erro: " + e.getMessage());
		}
		return "evento";
	}
}
