package com.herokuapp.communion.webapp;

import com.herokuapp.communion.models.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Database {
	public static Connection getNewConnection() throws URISyntaxException, SQLException {
	    URI dbUri = new URI(System.getenv("DATABASE_URL"));

	    String username = dbUri.getUserInfo().split(":")[0];
	    String password = dbUri.getUserInfo().split(":")[1];
	    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();
	    return DriverManager.getConnection(dbUrl, username, password);
	}
	
	private static Connection connection;
	static {
		try{
			 connection = getNewConnection();
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public static Connection getConnection(){
		return connection;
	}
	/**
	 * static Singleton instance
	 */
	private static Database instance;

	/**
	 * Private constructor for singleton
	 */
	private Database() {  }

	/**
	 * Static getter method for retrieving the singleton instance
	 */
	public static Database getInstance() {
		if (instance == null) {
			instance = new Database();
		}
		return instance;
	}
	
	public List<Forum> topForums(int num) throws SQLException, URISyntaxException {
		ArrayList<Forum> res = new ArrayList<Forum>();
		String query = "select * from topForums(" + num + ");";
		Statement stmt = getConnection().createStatement();
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			res.add(new Forum(rs.getInt("forumid"), rs.getInt("userid"), rs.getString("title"), rs.getString("img"), rs.getString("about"), rs.getInt("public")));
		}
		return res;
	}
	
	public boolean newUser(User user) throws SQLException, URISyntaxException {
		Statement stmt = getConnection().createStatement();
		try{
			stmt.executeUpdate("INSERT INTO users(userId, hash, first_name, last_name, photo, photo_rec) values(" + user.getUserid() +", '" + user.getHash() + "', '" + user.getFirst_name() + "', '" + user.getLast_name() + "', '" + user.getPhoto() + "', '" + user.getPhoto_rec() + "');");
		}
		catch(Exception e){
			return false;
		}
		return true;
	}

	public List<Forum> getForums()
			throws SQLException, URISyntaxException {
		ArrayList<Forum> res = new ArrayList<Forum>();
		String query = "select * from forums";
		Statement stmt = getConnection().createStatement();
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			res.add(new Forum(rs.getInt("forumid"), rs.getInt("userid"), rs.getString("title"), rs.getString("img"), rs.getString("about"), rs.getInt("public")));
		}
		return res;
	}

	public boolean signin(User user) throws SQLException, URISyntaxException {
		Statement stmt = getConnection().createStatement();
		ResultSet rs = stmt.executeQuery("select count(*) as count from users where users.userId = " + user.getUserid() + ";");
		rs.next();
		return rs.getInt("count") > 0;
	}
	
	public User getUser(int userId) throws SQLException, URISyntaxException {
		ResultSet rs = getConnection().createStatement().executeQuery("select * from users where userId = " + userId);
		rs.next();
		return new User(rs.getInt("userId"), rs.getString("hash"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("photo"), rs.getString("photo_rec"),
				rs.getInt("age"),rs.getString("country"),rs.getString("region"),rs.getString("city"), rs.getString("about"), rs.getInt("Type"));
	}
	
	public Forum getForum(int forumId) throws SQLException, URISyntaxException {
		ResultSet rs = getConnection().createStatement().executeQuery("select * from forums where forumId = " + forumId);
		rs.next();
		return new Forum(rs.getInt("forumid"), rs.getInt("userid"), rs.getString("title"), rs.getString("img"), rs.getString("about"), rs.getInt("public"));
	}
	
	public void updateUser(int userId, String first_name, String last_name, String photo, String photo_rec, int age, String country,
			String region, String city, String about) throws SQLException, URISyntaxException {
		getConnection().createStatement().executeUpdate("update users set first_name='" + first_name +
				"', last_name='" + last_name +
				"', photo='" + photo +
				"', photo_rec='" + photo_rec +
				"', age=" + age +
				", country='" + country +
				"', region='" + region +
				"', city='" + city +
				"', about='" + about + "' where userId = " + userId + ";"); 
	}
	public void updateUser(int userId, String first_name, String last_name, int age, String country,
			String region, String city, String about) throws SQLException, URISyntaxException {
		getConnection().createStatement().executeUpdate("update users set first_name='" + first_name +
				"', last_name='" + last_name +
				"', age=" + age +
				", country='" + country +
				"', region='" + region +
				"', city='" + city +
				"', about='" + about + "' where userId = " + userId + ";");
	}
	public void updateUser(int userId, int age, String country,
			String region, String city, String about) throws SQLException, URISyntaxException {
		getConnection().createStatement().executeUpdate("update users set " +
				"age=" + age +
				", country='" + country +
				"', region='" + region +
				"', city='" + city +
				"', about='" + about + "' where userId = " + userId + ";");
	}
	
	public List<Forum> userForums(int userid)  throws SQLException, URISyntaxException{
		ArrayList<Forum> res = new ArrayList<Forum>();
		String query = "select * from userForums(" + userid + ");";
		Statement stmt = getConnection().createStatement();
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			res.add(new Forum(rs.getInt("forumid"), rs.getInt("userid"), rs.getString("title"), rs.getString("img"), rs.getString("about"), rs.getInt("public")));
		}
		return res; 
	}
	public List<User> forumUsers(int forumId) throws SQLException, URISyntaxException{
		ArrayList<User> res = new ArrayList<User>();
		String query = "select * from forumUsers(" + forumId + ");";
		Statement stmt = getConnection().createStatement();
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			res.add(new User(rs.getInt("userId"), rs.getString("hash"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("photo"), rs.getString("photo_rec"),
					rs.getInt("age"),rs.getString("country"),rs.getString("region"),rs.getString("city"), rs.getString("about")));
		}
		return res;
	}
	public List<Forum> searchForums(String key) throws SQLException, URISyntaxException{
		ArrayList<Forum> res = new ArrayList<Forum>();
		String query = "select * from searchForums('" + ((key != null) ? key : "") + "');";
		Statement stmt = getConnection().createStatement();
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			res.add(new Forum(rs.getInt("forumid"), rs.getInt("userid"), rs.getString("title"), rs.getString("img"), rs.getString("about"), rs.getInt("public")));
		}
		return res;
	}
	public List<Forum> searchForums(String key, int userId) throws SQLException, URISyntaxException{
		ArrayList<Forum> res = new ArrayList<Forum>();
		String query = "select * from searchUserForums('" + ((key != null) ? key : "") + "', " + userId + ");";
		Statement stmt = getConnection().createStatement();
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			res.add(new Forum(rs.getInt("forumid"), rs.getInt("userid"), rs.getString("title"), rs.getString("img"), rs.getString("about"), rs.getInt("public")));
		}
		return res;
	}

	public int userRole(int forumId, int userId) throws SQLException, URISyntaxException{
		int res = 4;
		try {
			String query = "select userrole(" + forumId + "," + userId + ")";
			Statement stmt = getConnection().createStatement();
			ResultSet rs = stmt.executeQuery(query);
			rs.next();
			res = rs.getInt("userrole");
		}
		catch (Exception e){

		}
		return res;
	}

    public ArrayList<Section> getForumSections(int forumId) throws SQLException, URISyntaxException{
        ArrayList<Section> res = new ArrayList<Section>();
        String query = "select * from forumSections(" + forumId + ");";
        Statement stmt = getConnection().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            res.add(new Section(rs.getInt("sectionId"), rs.getInt("forumId"), rs.getString("name"), rs.getInt("parent")));
        }
        return res;
    }

    public ArrayList<Section> getSubsections(Integer forumId, Integer section) throws SQLException, URISyntaxException{
        ArrayList<Section> res = new ArrayList<Section>();
        String query = "select * from subsections(" + forumId + ", " + section + ");";
        Statement stmt = getConnection().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            res.add(new Section(rs.getInt("sectionId"), rs.getInt("forumId"), rs.getString("name"), rs.getInt("parent")));
        }
        return res;
    }

    public Section getSection(Integer sectionId) throws SQLException, URISyntaxException{
	    Section res = null;
        String query = "select * from sections where sectionId = " + sectionId + ";";
        Statement stmt = getConnection().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next())
            res = new Section(rs.getInt("sectionId"), rs.getInt("forumId"), rs.getString("name"), rs.getInt("parent"));
        return res;
    }

    public ArrayList<Topic> getSecitonTopics(Integer section) throws SQLException, URISyntaxException{
        ArrayList<Topic> res = new ArrayList<Topic>();
        String query = "select * from sectiontopics(" + section + ");";
        Statement stmt = getConnection().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            res.add(new Topic(rs.getInt("topicId"), rs.getInt("userId"), rs.getInt("sectionId"), rs.getString("title"), rs.getDate("updated")));
        }
        return res;
    }

    public int sectionTopicsCount(int secitonId) throws SQLException, URISyntaxException{
        int res = 4;
        try {
            String query = "select sectiontopicscount(" + secitonId + ")";
            Statement stmt = getConnection().createStatement();
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            res = rs.getInt("sectiontopicscount");
        }
        catch (Exception e){

        }
        return res;
    }

    public int topicUsersCount(int topicId){
        int res = 4;
        try {
            String query = "select topicUsersCount(" + topicId + ")";
            Statement stmt = getConnection().createStatement();
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            res = rs.getInt("sectiontopicscount");
        }
        catch (Exception e){

        }
        return res;
    }

    public Topic getTopic(Integer topicId) throws SQLException, URISyntaxException{
        Topic res = null;
        String query = "select * from topics where topicId = " + topicId + ";";
        Statement stmt = getConnection().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next())
            res = new Topic(rs.getInt("topicId"), rs.getInt("userId"), rs.getInt("sectionId"),
                    rs.getString("title"),rs.getDate("updated"));
        return res;
    }

    public ArrayList<Post> getTopicPosts(int topicid) throws SQLException, URISyntaxException{
        ArrayList<Post> res = new ArrayList<Post>();
        String query = "select * from posts where topicId = " + topicid + ";";
        Statement stmt = getConnection().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            res.add(new Post(rs.getInt("postId"),rs.getInt("userId"), rs.getInt("topicId"),
                    rs.getString("postName"), rs.getString("post"),rs.getDate("postDate")));
        }
        return res;
    }

    public Updates getUpdates() throws SQLException, URISyntaxException{
        Updates updates= new Updates();
        ArrayList<Update> res = new ArrayList<Update>();
        String query = "select * from updates group by id order by id desc limit 500;";
        Statement stmt = getConnection().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            res.add(new Update(rs.getInt("id"),rs.getString("tablename"),
                    rs.getInt("idRow")));
        }
        updates.setUpdates(res);
        return updates;
    }

	public boolean newPost(Post p) throws SQLException, URISyntaxException{
        String query = "insert into posts()";
        Statement stmt = getConnection().createStatement();
        int rs = stmt.executeUpdate(query);
        return rs > 0;
	}

    public boolean newForum(Forum forum) throws SQLException, URISyntaxException{
        String query = "insert into forums(userId, title, img) values('" + forum.getUserid() + "', '" + forum.getTitle() +"'," +
                " '" + forum.getImg() +"');";
        Statement stmt = getConnection().createStatement();
        int rs = stmt.executeUpdate(query);
        return rs > 0;
    }

    public boolean newSection(Section section) throws SQLException, URISyntaxException {
        String query = "insert into sections(forumId, name" + ((section.getParent()>0) ? ", parent)  " : ") ")
        + "values(" + section.getForumid() + ", '" + section.getName()
                + "'" + ((section.getParent()>0) ? "," + section.getParent() +");" : ");");
        Statement stmt = getConnection().createStatement();
        int rs = stmt.executeUpdate(query);
        return rs > 0;
    }

    public Forum getForum(int userId, String title) throws SQLException, URISyntaxException{
		Forum res = null;
		String query = "select * from forums where userid = " + userId + " and title = '" + title + "';";
		Statement stmt = getConnection().createStatement();
		ResultSet rs = stmt.executeQuery(query);
		if (rs.next())
			res = new Forum(rs.getInt("forumid"), rs.getInt("userid"), rs.getString("title"), rs.getString("img"), rs.getString("about"), rs.getInt("public"));
		return res;
	}

    public boolean newTopic(Topic topic) throws SQLException, URISyntaxException {
        String query = "insert into topics(userId, sectionId, title) values(" + topic.getUserid() + ", " + topic.getSectionid()
                + ", '" + topic.getTitle() + "');";
        Statement stmt = getConnection().createStatement();
        int rs = stmt.executeUpdate(query);
        return rs > 0;
    }

    public boolean newFormUser(ForumUser forumUser) throws SQLException, URISyntaxException {
        String query = "insert into forumUsers(forumId, userId) values(" + forumUser.getForumId() + ", "
                + forumUser.getUserId() + ");";
        Statement stmt = getConnection().createStatement();
        int rs = stmt.executeUpdate(query);
        return rs > 0;
    }

    public Update getUpdate(int id)throws SQLException, URISyntaxException  {
        Updates updates= new Updates();
        ArrayList<Update> res = new ArrayList<Update>();
        String query = "select * from updates where id = " + id + ";";
        Statement stmt = getConnection().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next())
            return new Update(rs.getInt("id"),rs.getString("tablename"),
                    rs.getInt("idRow"));
        else return new Update(0,"",0);
    }
}
