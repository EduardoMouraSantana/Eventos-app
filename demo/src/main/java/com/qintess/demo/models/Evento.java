package com.qintess.demo.models;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;


@Entity
public class Evento { 
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(nullable = false)
	private String nome;
	
	@Column(nullable = false)
	private String descricao;
	
	@ManyToOne
	private CasaShow casa_show;
	
	@Column(nullable = false)
	private Date data;
	
	@Column(nullable = false)
	private double preco;
	
	@Column(nullable = false)
	private int quantidade_ingresso;
	
	@Lob
	@Column(columnDefinition = "BLOB")
	private byte[] imageEvento;
	
	@Transient
	private String base64;
	
	public Evento() {
	}
	
	public Evento(String nome, String descricao, CasaShow casa_show, Date data, double preco,
			int quantidade_ingresso) {
		this.nome = nome;
		this.descricao = descricao;
		this.casa_show = casa_show;
		this.data = data;
		this.preco = preco;
		this.quantidade_ingresso = quantidade_ingresso;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public CasaShow getCasa_show() {
		return casa_show;
	}

	public void setCasa_show(CasaShow casa_show) {
		this.casa_show = casa_show;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public double getPreco() {
		return preco;
	}

	public void setPreco(double preco) {
		this.preco = preco;
	}

	public int getQuantidade_ingresso() {
		return quantidade_ingresso;
	}

	public void setQuantidade_ingresso(int quantidade_ingresso) {
		this.quantidade_ingresso = quantidade_ingresso;
	}

	public byte[] getImageEvento() {
		return imageEvento;
	}

	public void setImageEvento(byte[] imageEvento) {
		this.imageEvento = imageEvento;
	}

	public String getBase64() {
		return base64;
	}

	public void setBase64(String base64) {
		this.base64 = base64;
	}

	@Override
	public String toString() {
		return "Evento [id=" + id + ", nome=" + nome + ", descricao=" + descricao + ", casa_show=" + casa_show
				+ ", data=" + data + ", preco=" + preco + ", quantidade_ingresso=" + quantidade_ingresso + "]";
	}
	
	
}
