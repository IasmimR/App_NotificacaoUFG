package materiamobile.appmobileufg;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

@SuppressWarnings("unused")
public class Mensagem extends BroadcastReceiver {

	@SuppressWarnings("deprecation")
	@Override
	public void onReceive(Context contexto, Intent intent) {       
//		Log.d("TesteReceberMensagemBroadcast", "intent=" + intent);       
//		      
//		String chave = "mensagem";       
//		      
//		if(intent.getStringExtra(chave) != null){       
//		  String messagem = intent.getStringExtra(chave);             
//		  Toast.makeText(context, "ReceptorSimplesDeBroadCast recebeu a mensagem: " + messagem, Toast.LENGTH_SHORT).show();       
//		  Log.d("tagTesteBC", messagem);       
//		      
//		}       
//		else{       
//		  Log.d("tagTesteBC", "N�o foi poss�vel recuperar a mensagem!");       
//		}       
//		}
	       String textAviso = "Voc� recebeu uma mensagem";  
		   CharSequence titulo = "Androiano";  
		   CharSequence mensagem = "Exemplo de notifica��o";  
		    
		   //Configurando o gerenciador de notifica��o.  
		   NotificationManager nm = (NotificationManager) contexto.getSystemService(Context.NOTIFICATION_SERVICE);  
		   Notification n = new Notification(android.R.drawable.stat_notify_chat, textAviso,System.currentTimeMillis());  
		     
		   //Se o usu�rio selecionar a notifica��o chama uma activity  
		   PendingIntent p = PendingIntent.getActivity(contexto, 0, new Intent(contexto,MainActivity.class), 0);  
		     
		   //Vinculando o PedingIntent com a notifica��o  
		   n.setLatestEventInfo(contexto, titulo, mensagem, p);  
		     
		   //Espera 100, vibra 250, espera 100, vibra 500 
 
		   n.vibrate = new long[]{100,250,100,500};  
		     
		   nm.notify(R.string.app_name,n);  
		  } } 
	
