package com.app.models;

import lombok.*;

import java.io.Serializable;
import javax.persistence.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="runner")
public class Runner implements Serializable {

  @Id
  @Column(name="id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer id;

  @Column(name="name" )
  private String name;

  @Column(name="pb" )
  private Double pb;








}
