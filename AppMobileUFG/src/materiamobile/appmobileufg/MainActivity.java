package materiamobile.appmobileufg;

import android.support.v7.app.*;
//import android.support.v7.app.ActionBarActivity;
//import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.app.Activity;
import android.app.NotificationManager;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
//import android.os.Build;
import android.os.*;

@SuppressWarnings("unused")
public class MainActivity extends ActionBarActivity {

	final Activity activity = this;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		 // TODO Auto-generated method stub  
		  super.onCreate(savedInstanceState);  
		    		
//		super.onCreate(savedInstanceState);
//		setContentView(R.layout.activity_main);
//
//		if (savedInstanceState == null) {
//			getSupportFragmentManager().beginTransaction()
//					.add(R.id.container, new PlaceholderFragment()).commit();
//		}
//		
//
//		Button btnEnviarMensagem =  (Button) findViewById(R.id.btnEnviarMensagem);
//		btnEnviarMensagem.setOnClickListener(new OnClickListener() {			
//			public void onClick(View v) {		
//
//				enviarMensagemBroadcast(activity); //Chama o método que envia a mensagem
//		}
//		}); 
		  //Define buttonClick em android:onClick do botão no XML  
	  
		  //Fechando a notificação  
		  NotificationManager nm = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);  
		  nm.cancel(R.string.app_name);      
		  TextView tv = new TextView(this);  
		  tv.setText("Esta é uma tela gerada pela notificação");  
		  setContentView(tv);      
		  
		//chamando os objetos
		final EditText edtnome = (EditText) findViewById(R.id.edtnome);
		final EditText edtsenha = (EditText) findViewById(R.id.edtsenha);
		Button btnok = (Button) findViewById(R.id.btnok);
		
		btnok.setOnClickListener(new View.OnClickListener() {
			
			@Override
		public void onClick(View v) {
				    String loginteste = "es110239"; //TESTANDO ACESSO
				    String senhateste = "123";
				    String strLogin = edtnome.getText().toString();
				    String strSenha = edtsenha.getText().toString();

					if (strLogin.equalsIgnoreCase(loginteste) && strSenha.equalsIgnoreCase(senhateste)){
					Toast.makeText(MainActivity.this, "Login com sucesso...", Toast.LENGTH_SHORT).show();
					setContentView(R.layout.enviar_mensagem); //CHAMA OUTRO LAYOUT - O DE ENVIAR MENSAGEM DE TESTE
					}
				else{
					Toast.makeText(MainActivity.this, "Erro no login", Toast.LENGTH_SHORT).show();
					edtnome.setText("");
					edtsenha.setText("");
				}
			}		
		
		}); }
	
	
//	private void enviarMensagemBroadcast(Activity activity)
//	{
//		//Criar uma intenção com uma ação
//		String acaoUnica = "appmobileufg.intents.testebroadcast";
//		Intent broadcastIntent = new Intent(acaoUnica);
//		broadcastIntent.putExtra("mensagem", "Mensagem de Teste UFG");
//		activity.sendBroadcast(broadcastIntent);
//	}


	@Override
	public boolean onCreateOptionsMenu(Menu menu) {

		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	/**
	 * A placeholder fragment containing a simple view.
	 */
	public static class PlaceholderFragment extends Fragment {

		public PlaceholderFragment() {
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
			View rootView = inflater.inflate(R.layout.fragment_main, container,
					false);
			return rootView;
		}
	}

}
