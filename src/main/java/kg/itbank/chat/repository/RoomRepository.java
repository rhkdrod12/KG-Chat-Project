package kg.itbank.chat.repository;

import kg.itbank.chat.dto.RoomInfoDto;
import kg.itbank.chat.model.Room;
import kg.itbank.chat.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface RoomRepository extends JpaRepository<Room, Long> {
    List<Room> findAllByOwnerId(long id);
    boolean existsById(long id);

    @Query(value = "SELECT category FROM Room GROUP BY category", nativeQuery = true)
    List<String> listCategories();

    List<Room> findTop8ByCategory(String category);

/*
    @Query(value = "SELECT category, projectName FROM projects", nativeQuery = true)
    public List<Room> ();*/
}
