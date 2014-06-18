package materiamobile.appmobileufg;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class SendBroadNotifyActivity extends Activity {  
	 @Override  
	 public void onCreate(Bundle savedInstanceState) {  
	  super.onCreate(savedInstanceState);  
	  setContentView(R.layout.enviar_mensagem);  
	 }  
	  
	 //Define buttonClick em android:onClick do botão no XML  
	 public void buttonClick(View v) {  
	  sendBroadcast(new Intent("BROADCAST_NOTIFY"));  
	 }  
	}  