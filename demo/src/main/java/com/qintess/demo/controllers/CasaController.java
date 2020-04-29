package com.qintess.demo.controllers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
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

import com.qintess.demo.models.CasaShow;

import com.qintess.demo.services.CasaService;

@Controller
@RequestMapping("/casa")
public class CasaController {

	@Autowired
	private CasaService casaService;

	@RequestMapping("")
	public String carrega(Model model) {
		model.addAttribute("casas", casaService.buscaTodos());
		model.addAttribute("casa", new CasaShow());
		return "casa";
	}

	@RequestMapping("/salva")
	public String salva(@ModelAttribute CasaShow casa,
			@RequestParam(required = false, value = "cancela") String cancela,
			@RequestParam(required = false, value = "nome") String nome,
			@RequestParam(required = false, value = "capacidade") int capacidade,
			@RequestParam(required = false, value = "nome") String endereco,
			@RequestParam(required = false, value = "imagem") MultipartFile imagem, RedirectAttributes redirectAtt)
			throws IOException {

		byte[] bImagem;

		if (cancela != null) {
			return "redirect: ";
		}

		if (imagem != null && imagem.getSize() > 0) {
			bImagem = imagem.getBytes();
			casa.setImageCasa(bImagem);
		}

		if (nome == null | capacidade == 0 | endereco == null | casa.getImageCasa() == null) {
			redirectAtt.addFlashAttribute("messageError", "Erro! Os campos obrigatórios não foram preenchidos");
			return "redirect:/casa/";
		}
		
		if (casa.getId() == 0) {
			casaService.insere(casa);
			redirectAtt.addFlashAttribute("messageSuccess", "Casa cadastrada com sucesso!");
		} else {
			casaService.altera(casa);
			redirectAtt.addFlashAttribute("messageSuccess", "Casa alterada com sucesso!");
		}
		return "redirect:/casa/";
	}

	@RequestMapping("/deleta/{id}")
	public String deleta(@PathVariable(name = "id") int id) {
		casaService.remove(casaService.buscaPorId(id));
		return "redirect:/casa/";
	}

	@RequestMapping("/altera/{id}")
	public String carregaAlterar(@PathVariable(name = "id") int id, Model model, RedirectAttributes redirectAtt) {

		try {

			CasaShow casa = casaService.buscaPorId(id);
			byte[] encodeBase64 = Base64.getEncoder().encode(casa.getImageCasa());
			String base64Encoded = new String(encodeBase64, "UTF-8");

			model.addAttribute("casas", casaService.buscaTodos());
			model.addAttribute("casa", casa);
			model.addAttribute("imagemCasa", base64Encoded);

		} catch (UnsupportedEncodingException e) {
			redirectAtt.addFlashAttribute("messageError", "ERRO: " + e.getMessage());
		}
		return "casa";
	}
}
