package pe.com.suriados.bean;

public class ProductosBean {
	
	private String codigoProducto;
	private String codigoCategoria;
	private String nombreProducto;
	private String barCode;
	private String unidadesXCaja;
	private String nroCajasCompradas;
	private String nroUnidadesCompradas;
	private String totalunidadesCompradas;
	private String precioXCaja;
	private String precioXUnidad;
	private String fecha;
		
	public ProductosBean() {
		super();
	}

	public String getCodigoProducto() {
		return codigoProducto;
	}

	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}



	public String getCodigoCategoria() {
		return codigoCategoria;
	}

	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}

	public String getNombreProducto() {
		return nombreProducto;
	}

	public void setNombreProducto(String nombreProducto) {
		this.nombreProducto = nombreProducto;
	}

	public String getUnidadesXCaja() {
		return unidadesXCaja;
	}

	public void setUnidadesXCaja(String unidadesXCaja) {
		this.unidadesXCaja = unidadesXCaja;
	}

	public String getNroCajasCompradas() {
		return nroCajasCompradas;
	}

	public void setNroCajasCompradas(String nroCajasCompradas) {
		this.nroCajasCompradas = nroCajasCompradas;
	}

	public String getNroUnidadesCompradas() {
		return nroUnidadesCompradas;
	}

	public void setNroUnidadesCompradas(String nroUnidadesCompradas) {
		this.nroUnidadesCompradas = nroUnidadesCompradas;
	}

	public String getTotalunidadesCompradas() {
		return totalunidadesCompradas;
	}

	public void setTotalunidadesCompradas(String totalunidadesCompradas) {
		this.totalunidadesCompradas = totalunidadesCompradas;
	}

	public String getPrecioXCaja() {
		return precioXCaja;
	}

	public void setPrecioXCaja(String precioXCaja) {
		this.precioXCaja = precioXCaja;
	}

	public String getPrecioXUnidad() {
		return precioXUnidad;
	}

	public void setPrecioXUnidad(String precioXUnidad) {
		this.precioXUnidad = precioXUnidad;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getbarCode() {
		return barCode;
	}

	public void setbarCode(String barCode) {
		this.barCode = barCode;
	}

}
