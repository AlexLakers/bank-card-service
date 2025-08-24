package com.alex.bank.card.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString(of = "numberHash")
@EqualsAndHashCode(of = "numberHash")
@Builder
public class Card {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private Account account;
    private String numberHash;
    private String lastFourDigits;
    private LocalDate expDate;
    private CardStatus status;
    private BigDecimal balance;

}