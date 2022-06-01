import oscP5.*;

class Face {
  int found;
  float poseScale;
  PVector posePosition = new PVector();
  PVector poseOrientation = new PVector();

  float mouthHeight, mouthWidth;
  float eyeLeft, eyeRight;
  float eyebrowLeft, eyebrowRight;
  float jaw;
  float nostrils;
  int i;
  int j;
  float[] cejas = new float[20];
  float[] boca = new float[20];

  Face() {
    i = 0;
    j = 0;
    for(int i = 0; i < cejas.length; i++){
     cejas[i] = 8.8; 
     boca[i] = 21;
    }
  }
  
  float meanCejas(){
    float mean = 0.0;
    for(int i = 0; i < cejas.length; i++){
      mean += cejas[i];
    }
    return (mean/cejas.length);
  }
  
  float meanBoca(){
    float mean = 0.0;
    for(int i = 0; i < boca.length; i++){
      mean += boca[i];
    }
    return (mean/boca.length);
  }
  
  void saveBoca(float value){
      boca[j] = value;
      j++;
      if(j >= boca.length) j = 0; 
  }

  boolean parseOSC(OscMessage m) {

    if(m.checkAddrPattern("/found")) {
        found = m.get(0).intValue();
        return true;
    }
    else if(m.checkAddrPattern("/pose/position")) {
        posePosition.x = m.get(0).floatValue();
        posePosition.y = m.get(1).floatValue();
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eyebrow/left")) {
        eyebrowLeft = m.get(0).floatValue();
        cejas[i] = m.get(0).floatValue();
        i++;
        if(i >= cejas.length) i = 0;
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eyebrow/right")) {
        eyebrowRight = m.get(0).floatValue();
        return true;
    }
    else if(m.checkAddrPattern("/gesture/jaw")) {
        jaw = m.get(0).floatValue();
        return true;
    }

    return false;
  }

  String toString() {
    return "found: " + found + "\n"
           + "pose" + "\n"
           + " scale: " + poseScale + "\n"
           + " position: " + posePosition.toString() + "\n"
           + " orientation: " + poseOrientation.toString() + "\n"
           + "gesture" + "\n"
           + " mouth: " + mouthWidth + " " + mouthHeight + "\n"
           + " eye: " + eyeLeft + " " + eyeRight + "\n"
           + " eyebrow: " + eyebrowLeft + " " + eyebrowRight + "\n"
           + " jaw: " + jaw + "\n"
           + " nostrils: " + nostrils + "\n";
  }
}
