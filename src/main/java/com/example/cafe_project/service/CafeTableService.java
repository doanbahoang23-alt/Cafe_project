package com.example.cafe_project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.cafe_project.domain.CafeTable;
import com.example.cafe_project.repository.CafeTableRepository;

@Service
public class CafeTableService {
    private final CafeTableRepository cafeTableRepository;

    public CafeTableService(CafeTableRepository cafeTableRepository) {
        this.cafeTableRepository = cafeTableRepository;
    }

    public CafeTable handleSaveCafeTable(CafeTable cafeTable) {
        return this.cafeTableRepository.save(cafeTable);
    }

    public List<CafeTable> getAllCafeTable() {
        return this.cafeTableRepository.findAll();
    }

    public CafeTable getCafeTableByCafeTableId(long cafeTableId) {
        return this.cafeTableRepository.findById(cafeTableId).orElse(null);
    }

    public void deleteCafeTableById(long cafeTableId) {
        this.cafeTableRepository.deleteById(cafeTableId);
    }

}
