package com.kh.gymhub.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Gym {
   private int gymNo;
   private String gymName;
   private String gymOwner;
   private String gymPhone;
   private String gymAddress;
   private String status;
   private Date gymCreateat;
   private Date gymUpdateat;
   private String gymPhotoPath;
   private int attCacheNo;
}
