package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Date;

@Data
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