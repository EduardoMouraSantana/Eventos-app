package com.qintess.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.ui.Model;

import com.qintess.demo.models.Cliente;

import com.qintess.demo.services.ClienteService;

@Controller
@RequestMapping("/cliente")
public class ClienteController {

	@Autowired
	private ClienteService clienteService;

	@RequestMapping("")
	private String carrega(Model model) {
		model.addAttribute("clientes", clienteService.buscaTodos());
		model.addAttribute("cliente", new Cliente());
		return "cliente";
	}

	@RequestMapping("/salva")
	public String salva(@ModelAttribute Cliente cliente,
			@RequestParam(required = false, value = "cancela") String cancela,
			@RequestParam(required = false, value = "cpf") String cpf,
			@RequestParam(required = false, value = "nome") String nome,
			@RequestParam(required = false, value = "email") String email, RedirectAttributes redirectAtt) {

		if (cancela != null) {
			return "redirect:/cliente/";
		}

		if (nome == null | cpf == null | email == null) {
			redirectAtt.addFlashAttribute("messageError", "Erro! Os campos obrigatórios não foram preenchidos");
			return "redirect:/cliente/";
		}

		if (cliente.getId() == 0) {
			clienteService.insere(cliente);
			redirectAtt.addFlashAttribute("messageSuccess", "Cliente cadastrado com sucesso!");
		} else {
			clienteService.altera(cliente);
			redirectAtt.addFlashAttribute("messageSuccess", "Cliente alterado com sucesso!");
		}
		return "redirect:/cliente/";
	}

	@RequestMapping("/deleta/{id}")
	public String deleta(@PathVariable(name = "id") int id) {
		clienteService.remove(clienteService.buscaPorId(id));
		return "redirect:/cliente/";
	}

	@RequestMapping("/altera/{id}")
	public String carregaAlterar(@PathVariable(name = "id") int id, Model model) {
		model.addAttribute("clientes", clienteService.buscaTodos());
		model.addAttribute("cliente", clienteService.buscaPorId(id));
		return "cliente";
	}
}
