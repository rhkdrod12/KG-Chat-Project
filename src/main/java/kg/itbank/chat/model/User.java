package kg.itbank.chat.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(unique = true)
    private int kakaoId;

    @Lob
    @Column(unique = true)
    private String email;

    private String name;

    @Lob
    private String image;

    private String ageRange;

    private String gender;

    @CreationTimestamp
    private Timestamp createDate;
}
