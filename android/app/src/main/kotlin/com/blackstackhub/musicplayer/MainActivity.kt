package com.blackstackhub.musicplayer


import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


import android.Manifest
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

import android.media.AudioManager
import android.media.MediaPlayer
import android.os.Bundle
import android.widget.Toast
import android.os.Handler

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.blackstackhub/musicplayer"
    val mediaPlayer = MediaPlayer()
    private var handler: Handler = Handler()  
    private var pause:Boolean = false
    private var done:Boolean = false
    private var answer:Boolean = false

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if(call.method == "requestPermission") {
                val requestPermis = requestPermission()
                result.success(requestPermis)
            }else if(call.method == "checkPermission") {
                val checkPermis = checkPermission()
                result.success(checkPermis)
            }
            else if(call.method == "getAllAudioFiles") {
                val audioFiles = getAllAudioFiles()
                result.success(audioFiles)
            }else if(call.method == "getAudioAlbums") {
                val albums = getAudioAlbums()
                result.success(albums)
            }
            else if(call.method == "playMusic") {
                val audioUrl = call.argument<String>("audioUrl")!!
                val playing = playMusic(audioUrl)
                result.success(playing)
            }
            else if(call.method == "pauseMusic") {
                val paused = pauseMusic()
                result.success(paused)
            }
            else if(call.method == "playDone") {
                val playd = playDone()
                result.success(playd)
            }
            else {
                result.notImplemented()
            }
        }

    }
    
    private fun checkPermission(): Boolean{
        val permission = mutableListOf<String>()
        permission.add(Manifest.permission.WRITE_EXTERNAL_STORAGE)

        if (checkSelfPermission(android.Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED) {   
            answer = true         
        }
        else if (checkSelfPermission(android.Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_DENIED) {   
            answer = false         
        }
        else{
            ActivityCompat.requestPermissions(this, permission.toTypedArray(), 8)
            answer = true
        }
        return answer
    }
    
    private fun requestPermission(): Boolean{
        val permission = mutableListOf<String>()
        permission.add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
        ActivityCompat.requestPermissions(this, permission.toTypedArray(), 8)
        if (checkSelfPermission(android.Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED) {   
            answer = true        
        }
        else{
            answer = false
        }
        return answer
    }
    
    private fun getAllAudioFiles(): MutableList<String> {
        val song = mutableMapOf("id" to "id", "artist" to "artist")
        val songs: MutableList<String> = ArrayList()
        val selection = MediaStore.Audio.Media.IS_MUSIC + " != 0"
        val projection = arrayOf(
            MediaStore.Audio.Media._ID,
            MediaStore.Audio.Media.ARTIST,
            MediaStore.Audio.Media.TITLE,
            MediaStore.Audio.Media.DATA,
            MediaStore.Audio.Media.DURATION,
            MediaStore.Audio.Media.DATE_ADDED,
            MediaStore.Audio.Media.ALBUM,
            MediaStore.Audio.Media.SIZE
        )
        applicationContext.contentResolver.query(
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
            projection,
            selection,
            null,
            null
        )?.use{ cursor ->
            while (cursor.moveToNext()) {
                song["id"]=cursor.getString(0)
                song["artist"]=cursor.getString(1)
                song["title"]=cursor.getString(2)
                song["data"]=cursor.getString(3)
                song["duration"]=cursor.getString(4)
                song["date"]=cursor.getString(5)
                song["album"]=cursor.getString(6)
                song["size"]=cursor.getString(7)
                songs.add(song.toString())
            }
        }
        return songs
    }
    
    private fun getAllAudioAlbums(): MutableList<String> {
        val song = mutableMapOf("id" to "id", "artist" to "artist")
        val songs: MutableList<String> = ArrayList()
        val selection = MediaStore.Audio.Media.IS_MUSIC + " != 0"
        val projection = arrayOf(
            MediaStore.Audio.Media._ID,
            MediaStore.Audio.Media.ARTIST,
            MediaStore.Audio.Media.TITLE,
            MediaStore.Audio.Media.DATA,
            MediaStore.Audio.Media.DURATION,
            MediaStore.Audio.Media.DATE_ADDED,
            MediaStore.Audio.Media.ALBUM,
            MediaStore.Audio.Media.SIZE
        )
        applicationContext.contentResolver.query(
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
            projection,
            selection,
            null,
            null
        )?.use{ cursor ->
            while (cursor.moveToNext()) {
                song["id"]=cursor.getString(0)
                song["artist"]=cursor.getString(1)
                song["title"]=cursor.getString(2)
                song["data"]=cursor.getString(3)
                song["duration"]=cursor.getString(4)
                song["date"]=cursor.getString(5)
                song["album"]=cursor.getString(6)
                song["size"]=cursor.getString(7)
                songs.add(song.toString())
            }
        }
        return songs
    }

    private fun getAudioAlbums(): MutableList<String> {
        val albums: MutableList<String> = ArrayList()
        val selection = MediaStore.Audio.Media.IS_MUSIC + " != 0"
        val projection = arrayOf(
            MediaStore.Audio.Media.ALBUM
        )
        applicationContext.contentResolver.query(
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
            projection,
            selection,
            null,
            null
        )?.use{ cursor ->
            while (cursor.moveToNext()) {
                albums.add(cursor.getString(0))
            }
        }
        return albums
    }
    
    private fun playMusic(audioUrl: String){
            if(pause){
                mediaPlayer.seekTo(mediaPlayer.currentPosition)  
                mediaPlayer.start()
                pause = false  
                Toast.makeText(this,"media playing",Toast.LENGTH_SHORT).show()  
            }else{
                if(mediaPlayer != null){mediaPlayer.reset()}
                mediaPlayer.setDataSource(audioUrl)
                mediaPlayer.prepare()
                mediaPlayer.start()  
                Toast.makeText(this,"media playing",Toast.LENGTH_SHORT).show()  
  
            }  
            initializeSeekBar()
            mediaPlayer.setOnCompletionListener {
                Toast.makeText(this,"end",Toast.LENGTH_SHORT).show()  
            }
    }
    
    private fun playDone(): Boolean {
        if(mediaPlayer.isPlaying || pause){
            done = false
        }
        else{
            done = true
        }
        return done
    }
    
    private fun pauseMusic(){
            if(mediaPlayer.isPlaying){  
                mediaPlayer.pause()  
                pause = true
                Toast.makeText(this,"media pause",Toast.LENGTH_SHORT).show()  
            }
    }
     
    private fun stopMusic(){ 
            if(mediaPlayer.isPlaying || pause.equals(true)){  
                pause = false
                mediaPlayer.stop()  
                mediaPlayer.reset()
                mediaPlayer.release()
                Toast.makeText(this,"media stop",Toast.LENGTH_SHORT).show()  
            }
    }
     
    private fun seekMusic(i: Int) { 
        mediaPlayer.seekTo(i * 1000)
    }  
    
    private fun initializeSeekBar() {
  
        val result = "$mediaPlayer.currentSeconds"  
    }  

} 