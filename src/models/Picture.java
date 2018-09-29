package models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Table(name = "pictures")
@NamedQueries({
        @NamedQuery(name = "getAllPictures", query = "SELECT p FROM Picture AS p ORDER BY p.id DESC"),
        @NamedQuery(name = "getPicturesCount", query = "SELECT COUNT(p) FROM Picture AS p"),
        @NamedQuery(name = "getMyAllPictures", query = "SELECT p FROM Picture AS p WHERE p.diary = :diary ORDER BY p.id DESC"),
        @NamedQuery(name = "getMyPicturesCount", query = "SELECT COUNT(p) FROM Picture AS p WHERE p.diary = :diary")
})

/**
 * Entity implementation class for Entity: Image
 *
 */
@Entity

public class Picture implements Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "diary_id", nullable = false)
    private Diary diary;

    @Column(name = "name", nullable = false)
    private String name;

    @Lob
    @Column(name = "image", nullable = false)
    private byte[] image;

    private static final long serialVersionUID = 1L;

    public Picture() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public Diary getDiary() {
        return diary;
    }

    public void setDiary(Diary diary) {
        this.diary = diary;
    }

}