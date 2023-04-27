package TrabajoIntegrador.Entrega2;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConexionBD {

	private String driver;
	private String servidor;
	private String usuario;
	private String pass;
	private String nombreBD;

	public ConexionBD() {
		Properties properties = new Properties();

		try {
			properties.load(new FileInputStream(new File("DatosConexionBD.properties")));
			this.driver = (String) properties.getProperty("driver");
			this.servidor = (String) properties.getProperty("servidor");
			this.usuario = (String) properties.getProperty("usuario");
			this.pass = (String) properties.getProperty("pass");
			this.nombreBD = (String) properties.getProperty("nombreBD");

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private Connection con;

	public void Conexion() {

		try {
			Class.forName(driver);

			con = DriverManager.getConnection(servidor + nombreBD, usuario, pass);

			System.out.println("----- La conexion fue exitosa ----- \n");

		} catch (ClassNotFoundException e) {
			System.out.println("----- La conexion ha fallado ----- \n" + e.getMessage());
		} catch (SQLException e) {
			System.out.println("----- La conexion ha fallado ----- \n" + e.getMessage());
		}
	}

	public Connection getConection() {
		Conexion();
		return con;
	}

}