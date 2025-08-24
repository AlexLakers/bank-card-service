package com.alex.bank.card.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString(of = "username")
@EqualsAndHashCode(of = "username")
@Builder
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String firstname;
    private String lastname;
    @Column(name = "email")
    private String username;
    private String password;
    @Enumerated(EnumType.STRING)
    private Role role;

    @OneToMany(mappedBy = "account", orphanRemoval = true)
    @Builder.Default
    List<Card> cards = new ArrayList<>();


    public String getFullName() {
        return firstname + " " + lastname;
    }
}
