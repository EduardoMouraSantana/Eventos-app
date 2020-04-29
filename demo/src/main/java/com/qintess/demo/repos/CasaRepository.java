package com.qintess.demo.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.qintess.demo.models.CasaShow;

public interface CasaRepository extends JpaRepository<CasaShow, Integer>{

	public CasaShow findByNome(String nome);
	
	public CasaShow findById(int id);
}
