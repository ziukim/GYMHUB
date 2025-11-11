package com.kh.gymhub.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Product {
   private int productNo;
   private int gymNo;
   private int durationMonths;
   private String productType;
   private String productStartDate;
   private int productPrice;
   private String productStatus;
}
