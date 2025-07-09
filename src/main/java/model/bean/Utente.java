package model.bean;

public class Utente {

	private int id;
	private String nome;
	private String cognome;
	private String email;
	private String password;
	private String indirizzo;
	private String telefono;
	private String ruolo;

	// Costruttore vuoto (richiesto per JavaBean)
	public Utente() {
	}

	// Costruttore completo con id
	public Utente(int id, String nome, String cognome, String email, String password, String indirizzo, String telefono,
			String ruolo) {
		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.password = password;
		this.indirizzo = indirizzo;
		this.telefono = telefono;
		this.ruolo = ruolo;
	}

	// Costruttore completo senza id (per inserimenti in DB con id autogenerato)
	public Utente(String nome, String cognome, String email, String password, String indirizzo, String telefono,
			String ruolo) {
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.password = password;
		this.indirizzo = indirizzo;
		this.telefono = telefono;
		this.ruolo = ruolo;
	}

	// Getter e Setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getRuolo() {
		return ruolo;
	}

	public void setRuolo(String ruolo) {
		this.ruolo = ruolo;
	}

	// Metodo toString senza password per sicurezza
	@Override
	public String toString() {
		return "Utente{" + "id=" + id + ", nome='" + nome + '\'' + ", cognome='" + cognome + '\'' + ", email='" + email
				+ '\'' + ", indirizzo='" + indirizzo + '\'' + ", telefono='" + telefono + '\'' + ", ruolo='" + ruolo
				+ '\'' + '}';
	}
}