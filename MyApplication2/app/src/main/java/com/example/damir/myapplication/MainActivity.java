package com.example.damir.myapplication;
import android.Manifest;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.icu.text.IDNA;
import android.net.wifi.WifiManager;
import org.altbeacon.beacon.Identifier;
import org.altbeacon.beacon.powersave.BackgroundPowerSaver;
import android.os.Build;
import android.os.RemoteException;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.RequiresApi;
import android.support.v4.app.NotificationCompat;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.text.method.LinkMovementMethod;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.zip.InflaterOutputStream;

import android.util.Log;
import org.altbeacon.beacon.Beacon;
import org.altbeacon.beacon.BeaconConsumer;
import org.altbeacon.beacon.BeaconManager;
import org.altbeacon.beacon.BeaconParser;
import org.altbeacon.beacon.MonitorNotifier;
import org.altbeacon.beacon.RangeNotifier;
import org.altbeacon.beacon.Region;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import static android.icu.lang.UCharacter.GraphemeClusterBreak.T;


public class MainActivity extends AppCompatActivity implements BeaconConsumer {
    private static boolean update = false;
    private static boolean pushNotification = false;
    private static final int PERMISSION_REQUEST_COARSE_LOCATION = 1;
    private BackgroundPowerSaver backgroundPowerSaver;
    private static final String TAG = MainActivity.class.getSimpleName();
    private static List<BLEBeacon> ListOfBeacons = new ArrayList<BLEBeacon>();
    private static BluetoothAdapter BA;
    private static WifiManager wifi;
    private static ListView listView;
    private static BeaconManager beaconManager;
    private static BLEAdapter bleAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        BA = BluetoothAdapter.getDefaultAdapter();
        wifi = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        listView = (ListView) this.findViewById(R.id.listBle);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (this.checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                final AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle("This app needs location access");
                builder.setMessage("Please grant location access so this app can detect beacons.");
                builder.setPositiveButton(android.R.string.ok, null);
                builder.setOnDismissListener(new DialogInterface.OnDismissListener() {
                    @RequiresApi(api = Build.VERSION_CODES.M)
                    @Override
                    public void onDismiss(DialogInterface dialog) {
                        requestPermissions(new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, PERMISSION_REQUEST_COARSE_LOCATION);
                    }
                });
                builder.show();
            }
        }
        bleAdapter = new BLEAdapter(getApplicationContext(), R.layout.bles, ListOfBeacons);
        listView.setAdapter(bleAdapter);
        beaconManager = BeaconManager.getInstanceForApplication(this);
        beaconManager.getBeaconParsers().add(new BeaconParser().setBeaconLayout("m:0-3=4c000215,i:4-19,i:20-21,i:22-23,p:24-24"));
        backgroundPowerSaver = new BackgroundPowerSaver(this);
        beaconManager.bind(this);
        }
    @Override
    public void onRequestPermissionsResult(int requestCode,String permissions[], int[] grantResults) {
        switch (requestCode) {
            case PERMISSION_REQUEST_COARSE_LOCATION: {
                if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    Log.d(TAG, "coarse location permission granted");
                } else {
                    final AlertDialog.Builder builder = new AlertDialog.Builder(this);
                    builder.setTitle("Functionality limited");
                    builder.setMessage("Since location access has not been granted, this app will not be able to discover beacons when in the background.");
                    builder.setPositiveButton(android.R.string.ok, null);
                    builder.setOnDismissListener(new DialogInterface.OnDismissListener() {
                        @Override
                        public void onDismiss(DialogInterface dialog) {
                        }

                    });
                    builder.show();
                }
                return;
            }
        }
    }
    @Override
    public void onBackPressed() {
        moveTaskToBack(true);
        Log.i(TAG,"NAZAD");
        pushNotification = true;
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_bluetooth, menu);
        return true;
    }
    public int createID(){
        Date now = new Date();
        int id = Integer.parseInt(new SimpleDateFormat("ddHHmmss",  Locale.US).format(now));
        return id;
    }
    private void sendNotification(String message, String title) {
        int id=createID();
        NotificationCompat.Builder builder =
                new NotificationCompat.Builder(this)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setContentTitle(title)
                        .setContentText(message);
        builder.setAutoCancel(true);
        Intent notificationIntent = new Intent(this, MainActivity.class);
        PendingIntent contentIntent = PendingIntent.getActivity(this, id, notificationIntent,
                PendingIntent.FLAG_UPDATE_CURRENT);
        builder.setContentIntent(contentIntent);

        // Add as notification
        NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        manager.notify(id, builder.build());
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.bluetoothId:
                if (BA.isEnabled()) {
                    BA.disable();
                    Toast.makeText(this.getApplicationContext(), "Turned off Bluetooth", Toast.LENGTH_LONG).show();
                } else {
                    BA.enable();
                    Toast.makeText(getApplicationContext(), "Turned on Bluetooth", Toast.LENGTH_LONG).show();
                }
                break;
            case R.id.wifiId:
                if (wifi.isWifiEnabled()) {
                    wifi.setWifiEnabled(false);
                    Toast.makeText(this.getApplicationContext(), "Turned off Wireless", Toast.LENGTH_LONG).show();
                } else {
                    wifi.setWifiEnabled(true);
                    Toast.makeText(this.getApplicationContext(), "Turned on Wireless", Toast.LENGTH_LONG).show();

                }
                break;
            case R.id.clearListId:
                final AlertDialog.Builder builder = new AlertDialog.Builder(this);

                builder.setMessage("Are you sure you want to delete all the previous scans");
                builder.setTitle("Delete all");

                builder.setCancelable(false);
                builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        ListOfBeacons = new ArrayList<BLEBeacon>();
                        BLEAdapter bleAdapter = new BLEAdapter(getApplicationContext(), R.layout.bles, ListOfBeacons);
                        listView.setAdapter(bleAdapter);
                    }
                });
                builder.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.cancel();
                    }
                });

                AlertDialog alert = builder.create();
                alert.setTitle("Delete all");
                alert.show();
                break;
        }
        return super.onOptionsItemSelected(item);
    }

    public void onOff() {
        if (BA.isEnabled()) {
            BA.disable();
            Toast.makeText(this.getApplicationContext(), "Turned off", Toast.LENGTH_LONG).show();
        } else {
            BA.enable();
            Toast.makeText(getApplicationContext(), "Turned on", Toast.LENGTH_LONG).show();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        beaconManager.unbind(this);
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (beaconManager.isBound(this)){
            pushNotification = true;
            beaconManager.setBackgroundMode(true);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (beaconManager.isBound(this)){
            pushNotification = false;
            beaconManager.setBackgroundMode(false);
        }
    }
    @Override
    public void onBeaconServiceConnect() {
        try {
            beaconManager.startRangingBeaconsInRegion(new Region("myRangingUniqueId", null, null, null));

        } catch (RemoteException e) {
        }



        beaconManager.setRangeNotifier(new RangeNotifier() {
                                           @Override
                                           public void didRangeBeaconsInRegion(Collection<Beacon> beacons, Region region) {
                                               for (Beacon beacon: beacons) {
                                                   if (beacon.getDistance() < 5.0) {
                                                       Log.d(TAG, "I see a beacon that is less than 5 meters away.");
                                                       // Perform distance-specific action here
                                                   }
                                               }
                                           }
        }

        beaconManager.setRangeNotifier(new RangeNotifier() {
            @Override
            public void didRangeBeaconsInRegion(Collection<Beacon> beacons, Region region) {
                if (beacons.size() > 0) {
                    for (Beacon beacon : beacons) {
                        boolean exists = false;
                        for(int i = 0;i < ListOfBeacons.size(); ++i) {
                            if (ListOfBeacons.get(i).getUuid_().equals(beacon.getId1().toString()) && ListOfBeacons.get(i).getMajor_().equals(beacon.getId2().toString()) && ListOfBeacons.get(i).getMinor_().equals(beacon.getId3().toString())) {
                                ListOfBeacons.get(i).setDistance_(beacon.getDistance());
                                String currentDateandTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                                ListOfBeacons.get(i).setLast_update_(currentDateandTime);
                                update = true;
                                exists = true;
                                break;
                            }
                        }
                        if(!exists) {
                            update = true;
                            new GetBLEBeacon(beacon.getId1(), beacon.getId2(), beacon.getId3(), beacon.getDistance());
                        }
                }
                if(update){
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                              bleAdapter = new BLEAdapter(getApplicationContext(), R.layout.bles, ListOfBeacons);
                            listView.setAdapter(bleAdapter);
                       }
                    });
                        update = false;
                }
        }}

        });

        beaconManager.setMonitorNotifier(new MonitorNotifier() {

            @Override
            public void didEnterRegion(Region region) {
                Log.i(TAG, "I just saw an beacon for the first time!");
            }

            @Override
            public void didExitRegion(Region region) {
                Log.i(TAG, "I no longer see an beacon");
            }

            @Override
            public void didDetermineStateForRegion(int state, Region region) {
                Log.i(TAG, "I have just switched from seeing/not seeing beacons: " + state);
            }
        });

        try {
            beaconManager.startMonitoringBeaconsInRegion(new Region("myMonitoringUniqueId", null, null, null));

        } catch (RemoteException e) {
        }
    }
    class BLEAdapter extends ArrayAdapter {
        private List<BLEBeacon> bles;
        private int resource;
        private LayoutInflater inflater;

        public BLEAdapter(@NonNull Context context, int resource, @NonNull List<BLEBeacon> objects) {
            super(context, resource, objects);
            this.bles = objects;
            this.resource = resource;
            inflater = (LayoutInflater) this.getContext().getSystemService(LAYOUT_INFLATER_SERVICE);
        }

        @NonNull
        @Override
        public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
            if (convertView == null) {
                convertView = inflater.inflate(R.layout.bles, null);
            }
            TextView nameOfObject;
            TextView address;
            TextView type;
            TextView link;
            TextView information;
            TextView Distance;
            TextView last_update;
            ImageView imageView;
            nameOfObject = (TextView) convertView.findViewById(R.id.nameOfObjectId);
            address = (TextView) convertView.findViewById(R.id.addressId);
            type = (TextView) convertView.findViewById(R.id.typeId);
            link = (TextView) convertView.findViewById(R.id.linkId);
            Distance = (TextView) convertView.findViewById(R.id.distanceId);
            information = (TextView) convertView.findViewById(R.id.informationId);
            last_update = (TextView) convertView.findViewById(R.id.lastUpdateId);
            nameOfObject.setTextColor(Color.WHITE);
            nameOfObject.setText(bles.get(position).getNameOfObject_());
            Distance.setTextColor(Color.WHITE);
            String distanceM =String.format("%.2f",bles.get(position).getDistance_());
            Distance.setText(distanceM + " m");
            address.setText(bles.get(position).getAddress_());
            type.setText(bles.get(position).getType_());
            link.setText(bles.get(position).getLink_());
            information.setText(bles.get(position).getInformation_());
            last_update.setText(bles.get(position).getLast_update_());
            LinearLayout layout = convertView.findViewById(R.id.LayoutInformations);
            int size = bles.get(position).getInformations().size();
            for(int i=0;i<size;++i) {
                Information info = bles.get(position).getInformations().get(i);
                View informationView = inflater.inflate(R.layout.information, null);
                TextView date = (TextView) informationView.findViewById(R.id.dateId);
                TextView typeOfInformation = (TextView) informationView.findViewById(R.id.typeId);
                TextView textOfInformation = (TextView) informationView.findViewById(R.id.textOfInformationId);
                TextView linkOfInformation = (TextView) informationView.findViewById(R.id.linkId);

                ImageView imageview=(ImageView) informationView.findViewById(R.id.imageId);
                if(info.getType_().equals("Sale"))
                    imageview.setImageResource(R.drawable.ic_sale);
                else if(info.getType_().equals("Event"))
                    imageview.setImageResource(R.drawable.ic_event);
                else if(info.getType_().equals("Special offer"))
                    imageview.setImageResource(R.drawable.ic_special_offer);
                else
                    imageview.setImageResource(R.drawable.ic_type);
                if(!info.getDate_().equals("\\"))
                    date.setText(info.getDate_());
                if(!info.getLink_().equals("\\")) {
                    linkOfInformation.setText(
                            Html.fromHtml(
                                    "<a href=\""+info.getLink_()+"\">--></a> "));
                    linkOfInformation.setMovementMethod(LinkMovementMethod.getInstance());
                }
                typeOfInformation.setText(info.getType_());
                textOfInformation.setText(info.getText_());
                layout.addView(informationView);
            }
            return convertView;
        }
    }
    class GetBLEBeacon {
        Identifier uuid_;
        Identifier major_;
        Identifier minor_;
        double distance_;

        public GetBLEBeacon(Identifier id1, Identifier id2, Identifier id3, double distance) {
            uuid_ = id1;
            major_ = id2;
            minor_ = id3;
            distance_ = distance;
            this.execute();
        }
        protected Void execute() {
            HttpHandler sh = new HttpHandler();
            //String url = "http://192.168.0.101:7080/BLE_Beacon/main?uuid=" + uuid_ + "&major=" + major_ + "&minor=" + minor_ + "";
            String url = "http://192.168.43.95:7080/BLE_Beacon/main?uuid=" + uuid_ + "&major=" + major_ + "&minor=" + minor_ + "";
            Log.i(TAG, url);
            String jsonStr = sh.makeServiceCall(url);

            Log.e(TAG, "Response from url: " + jsonStr);
            if (jsonStr != null) try {
                JSONObject jsonObj = new JSONObject(jsonStr);
                if (!jsonObj.getString("successful").equals("false")) {
                    BLEBeacon bleBeacon = new BLEBeacon();
                    bleBeacon.setNameOfObject_(jsonObj.getString("nameOfObject"));
                    bleBeacon.setType_(jsonObj.getString("type"));
                    bleBeacon.setAddress_(jsonObj.getString("address"));
                    bleBeacon.setLink_(jsonObj.getString("link"));
                    bleBeacon.setInformation_(jsonObj.getString("information"));
                    bleBeacon.setMajor_(major_.toString());
                    bleBeacon.setMinor_(minor_.toString());
                    bleBeacon.setUuid_(uuid_.toString());
                    bleBeacon.setDistance_(distance_);
                    if (!jsonObj.getString("hasInformations").equals("false")) {
                        JSONArray informations = jsonObj.getJSONArray("informations");
                        for (int i = 0; i < informations.length(); ++i) {
                            JSONObject infObject = informations.getJSONObject(i);
                            Information information = new Information();
                            information.setText_(infObject.getString("text"));
                            information.setType_(infObject.getString("type"));
                            information.setLink_(infObject.getString("link"));
                            information.setDate_(infObject.getString("date"));
                            bleBeacon.addInformation(information);
                        }
                    }
                    String currentDateandTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                    bleBeacon.setLast_update_(currentDateandTime);
                    ListOfBeacons.add(bleBeacon);
                    if (pushNotification)
                        sendNotification(bleBeacon.getNameOfObject_() + " is nearby.", "New BLE Beacon");
                }
            } catch (final JSONException e) {
                Log.e(TAG, "Json parsing error: " + e.getMessage());
            }
            else {
                Log.e(TAG, "Couldn't get json from server.");
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getApplicationContext(),
                                "Can't Connect to Server",
                                Toast.LENGTH_LONG).show();
                    }
                });
            }
            return null;
        }
    }
}