package pe.com.suriados.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

public class Utilitarios {

	public static long obtenerTiempoBD(String tiempo) {

		long horas = Integer.parseInt(tiempo.substring(0, 2)) * 3600;
		long minutos = Integer.parseInt(tiempo.substring(3, 5)) * 60;
		long segundos = Integer.parseInt(tiempo.substring(6, 8));

		return horas + minutos + segundos;

	}

	public static String obtenerHoraExacta() {

		Date fecha1 = new Date();
		System.out.println(fecha1.toString());
		Calendar cal1 = Calendar.getInstance();

		return "" + cal1.get(Calendar.HOUR) + ":" + cal1.get(Calendar.MINUTE) + ":" + cal1.get(Calendar.SECOND);

	}

	public static String convertMinutesToHours(int minutes) {

		int horas = minutes / 60;

		int min = minutes - (horas * 60);

		return String.format("%02d", horas) + ":" + String.format("%02d", min);

	}

	public static int obtenerSegundos(int seconds) {

		int rem = seconds % 3600;
		int sec = rem % 60;

		return sec;

	}

	public static int obtenerMinutos(int seconds) {

		int rem = seconds % 3600;
		int mn = rem / 60;

		return mn;

	}

	public static int obtenerHoras(int seconds) {

		int hr = seconds / 3600;

		return hr;

	}

	/* metodos nuevos **/

	public static Calendar obtenerTiempoTranscurrido(String horaTranscurrido) {

		Calendar calFechaFinal = Calendar.getInstance();

		horaTranscurrido = horaTranscurrido.substring(11, horaTranscurrido.length() - 2);

		String fechaFinalTotal = diaActual() + " " + horaTranscurrido;

		System.out.println("-->" + fechaFinalTotal);

		Date fechaFinal = Utilitarios.StringToDate(fechaFinalTotal, "/", 0);

		calFechaFinal.setTime(fechaFinal);

		return calFechaFinal;

	}

	public static String diaActual() {

		Calendar fecha = new GregorianCalendar();
		int anho = fecha.get(Calendar.YEAR);
		int mes = fecha.get(Calendar.MONTH);
		int dia = fecha.get(Calendar.DAY_OF_MONTH);

		System.out.println(anho + "/" + (mes + 1) + "/" + dia);

		return anho + "/" + (mes + 1) + "/" + dia;
	}

	public static int diferenciaDias(String Finicial, String Ffinal) {
		int dias = 0;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		Date fechaInicial;
		try {
			fechaInicial = dateFormat.parse(Finicial);
			Date fechaFinal = dateFormat.parse(Ffinal);
			dias = (int) ((fechaFinal.getTime() - fechaInicial.getTime()) / 86400000);
			System.out.println("Hay " + dias + " dias de diferencia");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return dias;
	}

	public static long diferenciaHorasDias(Calendar fechaInicial, Calendar fechaFinal) {

		// Milisegundos al d�a
		long diferenciaHoras = 0;

		// Restamos a la fecha final la fecha inicial y lo dividimos entre el numero de
		// milisegundos al dia
		diferenciaHoras = (fechaFinal.getTimeInMillis() - fechaInicial.getTimeInMillis()) / (24 * 60 * 60 * 1000);

		if (diferenciaHoras > 0) {
			// Lo Multiplicaos por 24 por que estamos utilizando el formato militar
			diferenciaHoras *= 24;
		}

		return diferenciaHoras;
	}

	/*
	 * Metodo que calcula la diferencia de los minutos entre dos fechas
	 */
	public static long diferenciaMinutos(Calendar fechaInicial, Calendar fechaFinal) {

		long diferenciaHoras = 0;

		diferenciaHoras = (fechaFinal.get(Calendar.MINUTE) - fechaInicial.get(Calendar.MINUTE));

		return diferenciaHoras;
	}

	public static long diferenciaSegundos(Calendar fechaInicial, Calendar fechaFinal) {

		long diferenciaSegundos = 0;

		diferenciaSegundos = (fechaFinal.get(Calendar.SECOND) - fechaInicial.get(Calendar.SECOND));

		return diferenciaSegundos;
	}

	/*
	 * Metodo que devuelve el Numero total de minutos que hay entre las dos Fechas
	 */
	public static long cantidadTotalMinutos(Calendar fechaInicial, Calendar fechaFinal) {

		long totalMinutos = 0;

		totalMinutos = ((fechaFinal.getTimeInMillis() - fechaInicial.getTimeInMillis()) / 1000 / 60);

		return totalMinutos;

	}

	/* Metodo que devuelve el Numero total de horas que hay entre las dos Fechas */
	public static long cantidadTotalHoras(Calendar fechaInicial, Calendar fechaFinal) {

		long totalMinutos = 0;

		totalMinutos = ((fechaFinal.getTimeInMillis() - fechaInicial.getTimeInMillis()) / 1000 / 60 / 60);

		return totalMinutos;
	}

	/*
	 * Metodo que devuelve el Numero total de Segundos que hay entre las dos Fechas
	 */
	public static long cantidadTotalSegundos(Calendar fechaInicial, Calendar fechaFinal) {

		long totalMinutos = 0;

		totalMinutos = ((fechaFinal.getTimeInMillis() - fechaInicial.getTimeInMillis()) / 1000);

		return totalMinutos;

	}

	/* Metodo que calcula la diferencia de las horas entre dos fechas */
	public static long diferenciaHoras(Calendar fechaInicial, Calendar fechaFinal) {

		long diferenciaHoras = 0;

		diferenciaHoras = (fechaFinal.get(Calendar.HOUR_OF_DAY) - fechaInicial.get(Calendar.HOUR_OF_DAY));

		return diferenciaHoras;
	}

	public static Date StringToDate(String fecha, String caracter, int op) {
		String formatoHora = " HH:mm:ss";
		String formato = "yyyy" + caracter + "MM" + caracter + "dd" + formatoHora;
		if (op == 1)
			//
			formato = "yyyy" + caracter + "dd" + caracter + "MM" + formatoHora;
		else if (op == 2)
			formato = "MM" + caracter + "yyyy" + caracter + "dd" + formatoHora;
		else if (op == 3)
			formato = "MM" + caracter + "dd" + caracter + "yyyy" + formatoHora;
		else if (op == 4)
			formato = "dd" + caracter + "yyyy" + caracter + "MM" + formatoHora;
		else if (op == 5)
			formato = "dd" + caracter + "MM" + caracter + "yyyy" + formatoHora;
		SimpleDateFormat sdf = new SimpleDateFormat(formato, Locale.getDefault());
		Date fechaFormato = null;
		try {

			sdf.setLenient(false);
			fechaFormato = sdf.parse(fecha);
		} catch (ParseException ex) {

		}
		return fechaFormato;
	}

	public static String redondearDinero(double totalDia) {

		String val = totalDia + "";
		BigDecimal big = new BigDecimal(val);
		big = big.setScale(1, RoundingMode.HALF_UP);
		return big + "";
	}

	public static String obtenerDia() {

		java.util.Date fecha = new Date();

		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(fecha);
		System.out.println("dia--->" + cal.get(Calendar.DAY_OF_WEEK));

		int numeroDia = cal.get(Calendar.DAY_OF_WEEK);
		System.out.println("numero dia --->" + numeroDia);
		switch (numeroDia) {
		case 1:

			return "7";

		case 2:

			return "1";

		case 3:

			return "2";

		case 4:

			return "3";

		case 5:

			return "4";

		case 6:

			return "5";

		default:

			return "6";

		}

	}

	public static String estructurarFormato(String fechaInicio, String horaInicio) {

		System.out.println("la fecha es " + fechaInicio);

		// Date date = new Date(fechaInicio);

		// System.out.println(date);

		// Sat Dec 09 03:49:05 COT 2017

		// December 01 2017 23:59:59

		String dia = fechaInicio.substring(0, 4);
		String mes = fechaInicio.substring(5, 7);
		String anho = fechaInicio.substring(8, 10);

		System.out.println("el dia es " + dia);
		System.out.println("el mes es " + mes);
		System.out.println("el ano es " + anho);

		/*
		 * int mes=0;
		 * 
		 */
		String mesTexto = "";

		if (mes.equals("01")) {

			mesTexto = "January";

		} else if (mes.equals("02")) {

			mesTexto = "Februar";

		} else if (mes.equals("03")) {

			mesTexto = "March";

		} else if (mes.equals("04")) {

			mesTexto = "April";

		} else if (mes.equals("05")) {

			mesTexto = "May";

		} else if (mes.equals("06")) {

			mesTexto = "June";

		} else if (mes.equals("07")) {

			mesTexto = "July";

		} else if (mes.equals("08")) {

			mesTexto = "August";

		} else if (mes.equals("09")) {

			mesTexto = "September";

		} else if (mes.equals("10")) {

			mesTexto = "October";

		} else if (mes.equals("11")) {

			mesTexto = "November";

		} else if (mes.equals("12")) {

			mesTexto = "December";

		}

		return mesTexto + " " + dia + " " + anho + " " + horaInicio;

	}

	public static List<Integer> restarFechas(String fechaInicial, String fechaFinal) {
//		 	String fechaInicial = "20-07-2019 23:58:00";
//	        String fechaFinal = "21-07-2019 01:02:00";
	        
	        java.util.GregorianCalendar jCal = new java.util.GregorianCalendar();
	        java.util.GregorianCalendar jCal2 = new java.util.GregorianCalendar();
	        //jCal.set(year, month, date, hourOfDay, minute)
	        jCal.set(Integer.parseInt(fechaInicial.substring(6,10)), Integer.parseInt(fechaInicial.substring(3,5))-1, Integer.parseInt(fechaInicial.substring(0,2)), Integer.parseInt(fechaInicial.substring(11,13)),Integer.parseInt(fechaInicial.substring(14,16)), Integer.parseInt(fechaInicial.substring(17,19)));
	        jCal2.set(Integer.parseInt(fechaFinal.substring(6,10)), Integer.parseInt(fechaFinal.substring(3,5))-1, Integer.parseInt(fechaFinal.substring(0,2)), Integer.parseInt(fechaFinal.substring(11,13)),Integer.parseInt(fechaFinal.substring(14,16)), Integer.parseInt(fechaFinal.substring(17,19)));
	        
	        //System.out.println("Date format " + dateformat.format(jCal.getTime()) + "\n");
	        //System.out.println("Date format " + dateformat.format(jCal2.getTime()) + "\n");
	 
	        long diferencia = jCal2.getTime().getTime()-jCal.getTime().getTime();
	        double minutos = diferencia / (1000 * 60);
	        long horas = (long) (minutos / 60);
	        long minuto = (long) (minutos%60);
	        long segundos = (long) diferencia % 1000;
	        long dias = horas/24;
	        //Calcular meses...
	        //Crear vector para almacenar los diferentes dias maximos segun correponda
	        String[] mesesAnio = new String[12];
	        mesesAnio[0] = "31";
	        //validacion de los años bisiestos
	        if (jCal.isLeapYear(jCal.YEAR)){mesesAnio[1] = "29";}else{mesesAnio[1] = "28";}
	        mesesAnio[2] = "31";
	        mesesAnio[3] = "30";
	        mesesAnio[4] = "31";
	        mesesAnio[5] = "30";
	        mesesAnio[6] = "31";
	        mesesAnio[7] = "31";
	        mesesAnio[8] = "30";
	        mesesAnio[9] = "31";
	        mesesAnio[10] = "30";
	        mesesAnio[11] = "31";
	        int diasRestantes = (int) dias;
	        //variable almacenará el total de meses que hay en esos dias
	        int totalMeses = 0;
	        int mesActual = jCal.MONTH;
	        //Restar los dias de cada mes desde la fecha de ingreso hasta que ya no queden sufcientes dias para 
	        // completar un mes.
	        for (int i=0; i<=11; i++ ){
	            //Validar año, si sumando 1 al mes actual supera el fin de año, 
	            // setea la variable a principio de año 
	            if ((mesActual+1)>=12){
	                mesActual = i;
	            }
	            //Validar que el numero de dias resultantes de la resta de las 2 fechas, menos los dias
	            //del mes correspondiente sea mayor a cero, de ser asi totalMeses aumenta,continuar hasta 
	            //que ya nos se cumpla.
	            if ((diasRestantes -Integer.parseInt(mesesAnio[mesActual]))>=0){
	                totalMeses ++;
	                diasRestantes = diasRestantes- Integer.parseInt(mesesAnio[mesActual]);
	                mesActual ++;
	            }else{
	                break;
	            }
	        }
	        //Resto de horas despues de sacar los dias
	        horas = horas % 24;
	        String salida ="";
	        if (totalMeses > 0){
	            if (totalMeses > 1)
	                salida = salida+  String.valueOf(totalMeses)+" Meses,  ";
	            else
	                salida = salida+  String.valueOf(totalMeses)+" Mes, ";
	        }
	        if (diasRestantes > 0){
	            if (diasRestantes > 1)
	                salida = salida+  String.valueOf(diasRestantes)+" Dias, ";
	            else
	                salida = salida+  String.valueOf(diasRestantes)+" Dia, ";
	        }
	        List<Integer> lista = new ArrayList<Integer>();
	        lista.add(totalMeses);
	        lista.add(diasRestantes);
	        lista.add(Integer.parseInt(horas+""));
	        lista.add(Integer.parseInt(minuto+""));
	         //salida =salida +String.valueOf(horas)+"Hrs: "+String.valueOf(minuto)+"Min: "+String.valueOf(segundos)+ "Seg.";
	        return lista;
	        
	}
	
	public static Date fechayHoraActual() {

		Calendar currentdate = Calendar.getInstance();
		ZonedDateTime converted = currentdate.toInstant().atZone(ZoneId.of("America/Lima"))
				.withZoneSameLocal(ZoneOffset.UTC);
		Date fecha = Date.from(converted.toInstant());
		return fecha;
	}

}
