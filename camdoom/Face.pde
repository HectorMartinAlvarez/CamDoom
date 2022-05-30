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
  
  Face() {}

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
