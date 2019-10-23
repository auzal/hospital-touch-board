String [] MISTERY = {
"1_ANTES_1-01.png",
"2_1938_A-01.png",
"3_1955_A-01.png",
"4_1970_A-01.png",
"5_1984_A-01.png",
"6_2013_A-01.png",
"7_2018_A-01.png"
};

String [] FOOTPRINTS = {
"1_antes-01.png",
"2_1938-01.png",
"3_1955-01.png",
"4_1970-01.png",
"5_1984-01.png",
"6_2013-01.png",
"7_2018-01.png"
};

String [] COMPOSITES = {
"1_EstetoscopiosTodos-01.png",
"2_JeringasTodas-01.png",
"3_ambulanciasTodas-01.png",
"4_TensiometroTodos-01.png",
"5_AspirinasTodas-01.png"
};

String [] AMBULANCIAS = {
"1ambulanciaAntes-01.png",
"2ambulancia1938-01.png",
"3ambulancia1955-01.png",
"4ambulancia1970-01.png",
"5ambulancia1984-01.png",
"6ambulancia2013-01.png",
"7ambulancia2018-01.png"
};

String [] ASPIRINAS = {
"1aspirinasAntes-01.png",
"2aspirinas1938-01.png",
"3aspirinas1955-01.png",
"4aspirinas1970-01.png",
"5aspirinas1984-01.png",
"6aspirinas2013-01.png",
"7aspirinas2018-01.png",
};

String [] ESTETOSCOPIOS = {
"1EstetoscopioAntes-01.png",
"2Estetoscopio1938-01.png",
"3Estetoscopio1955-01.png",
"4Estetoscopio1970-01.png",
"5Estetoscopio1984-01.png",
"6Estetoscopio2013-01.png",
"7Estetoscopio2018-01.png"
};

String [] JERINGAS = {
"1JeringaAntes-01.png",
"2Jeringa1938-01.png",
"3Jeringa1955-01.png",
"4Jeringa1970-01.png",
"5Jeringa1984-01.png",
"6Jeringa2013-01.png",
"7Jeringa2018-01.png"
};

String [] TENSIOMETROS = {
"1TensiometroAntes-01.png",
"2Tensiometro1938-01.png",
"3Tensiometro1955-01.png",
"4Tensiometro1970-01.png",
"5Tensiometro1984-01.png",
"6Tensiometro2013-01.png",
"7Tensiometro2018-01.png",
};

  /** Provides a sinusoidal easing in function. Value starts slowly at t=0 and
     *  accelerates to a maximum value at t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float sinIn(float t)
    {
        return sinIn(t,1);
    }
      
    /** Provides a reversible sinusoidal easing in function. Value starts slowly at
     *  t=0 and accelerates to a maximum value at t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float sinIn(float t, float direction)
    {
        if (direction < 0)
        {
            // Reverse direction for a return journey.
            return sinOut(t,1);
        }
        return (float)(1-Math.cos(t*PConstants.HALF_PI));
    }

    /** Provides a sinusoidal easing out function. Value starts rapidly at t=0 and
     *  decelerates to a minimum value at t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float sinOut(float t)
    {
      return sinOut(t,1);
    }

    /** Provides a reversible sinusoidal easing out function. Value starts rapidly at
     *  t=0 and decelerates to a minimum value at t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float sinOut(float t, float direction)
    {
        if (direction<0)
        {
            return sinIn(t,1);
        }
        return (float)Math.sin(t*PConstants.HALF_PI);
    }
    
    /** Provides a sinusoidal easing in and out function. Value starts slowly at t=0, 
     *  accelerates towards t=0.5 and then decelerates towards t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float sinBoth(float t)
    {
        return (float)(1-Math.cos(t*PConstants.PI))/2f;
    }
    
    /** Provides a cubic easing in function. Value starts slowly at t=0 and  accelerates 
     *  to a maximum value at t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float cubicIn(float t)
    {
        return cubicIn(t,1);
    }
    
    /** Provides a reversible cubic easing in function. Value starts slowly at
     *  t=0 and accelerates to a maximum value at t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float cubicIn(float t, float direction)
    {
        if (direction < 0)
        {
            return cubicOut(t,1);
        }
        return t*t*t;
    }

    /** Provides a cubic easing out function. Value starts rapidly at t=0 and
     *  decelerates to a minimum value at t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float cubicOut(float t)
    {
      return cubicOut(t,1);
    }
    
    /** Provides a reversible cubic easing out function. Value starts rapidly at
     *  t=0 and decelerates to a minimum value at t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float cubicOut(float t, float direction)
    {
        if (direction < 0)
        {
            return cubicIn(t,1);
        } 
        float tPrime = 1-t;
        return 1-tPrime*tPrime*tPrime;
    }

    /** Provides a cubic easing in and out function. Value starts slowly at t=0, 
     *  accelerates towards t=0.5 and then decelerates towards t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float cubicBoth(float t)
    {
        if (t < 0.5)
        {
            float tPrime = t*2;
            return 0.5f*tPrime*tPrime*tPrime;
        }
      
        float tPrime = 2-t*2;
        return 0.5f*(2-tPrime*tPrime*tPrime);
    }
    
    /** Provides a quartic easing in function. Value starts slowly at t=0 and  accelerates 
     *  to a maximum value at t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float quarticIn(float t)
    {
        return quarticIn(t,1);
    }
    
    /** Provides a reversible quartic easing in function. Value starts slowly at
     *  t=0 and accelerates to a maximum value at t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float quarticIn(float t, float direction)
    {
        if (direction < 0)
        {
            return quarticOut(t,1);
        }
        return t*t*t*t;
    }

    /** Provides a quartic easing out function. Value starts rapidly at t=0 and
     *  decelerates to a minimum value at t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float quarticOut(float t)
    {
      return quarticOut(t,1);
    }
    
    /** Provides a reversible quartic easing out function. Value starts rapidly at
     *  t=0 and decelerates to a minimum value at t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float quarticOut(float t, float direction)
    {
        if (direction < 0)
        {
            return quarticIn(t,1);
        } 
        float tPrime = 1-t;
        return 1-tPrime*tPrime*tPrime*tPrime;
    }

    /** Provides a quartic easing in and out function. Value starts slowly at t=0, 
     *  accelerates towards t=0.5 and then decelerates towards t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float quarticBoth(float t)
    {
        if (t < 0.5)
        {
            float tPrime = t*2;
            return 0.5f*tPrime*tPrime*tPrime*tPrime;
        }
      
        float tPrime = 2-t*2;
        return 0.5f*(2-tPrime*tPrime*tPrime*tPrime);
    }
    
    /** Provides a quintic easing in function. Value starts slowly at t=0 and  accelerates 
     *  to a maximum value at t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float quinticIn(float t)
    {
        return quinticIn(t,1);
    }
    
    /** Provides a reversible quintic easing in function. Value starts slowly at
     *  t=0 and accelerates to a maximum value at t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float quinticIn(float t, float direction)
    {
        if (direction < 0)
        {
            return quinticOut(t,1);
        }
        return t*t*t*t*t;
    }

    /** Provides a quintic easing out function. Value starts rapidly at t=0 and
     *  decelerates to a minimum value at t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float quinticOut(float t)
    {
      return quinticOut(t,1);
    }
    
    /** Provides a reversible quintic easing out function. Value starts rapidly at
     *  t=0 and decelerates to a minimum value at t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float quinticOut(float t, float direction)
    {
        if (direction < 0)
        {
            return quinticIn(t,1);
        } 
        float tPrime = 1-t;
        return 1-tPrime*tPrime*tPrime*tPrime*tPrime;
    }

    /** Provides a quintic easing in and out function. Value starts slowly at t=0, 
     *  accelerates towards t=0.5 and then decelerates towards t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float quinticBoth(float t)
    {
        if (t < 0.5)
        {
            float tPrime = t*2;
            return 0.5f*tPrime*tPrime*tPrime*tPrime*tPrime;
        }
      
        float tPrime = 2-t*2;
        return 0.5f*(2-tPrime*tPrime*tPrime*tPrime*tPrime);
    }
    
    /** Provides a parabolic bouncing easing in function. From t=0 value starts with a small
     *  'bounce' that gets larger towards t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float bounceIn(float t)
    {
        return bounceIn(t,1);
    }

    /** Provides a reversible parabolic bouncing easing in function. From t=0 value starts
     *  with a small 'bounce' that gets larger towards t=1. If the <code>direction</code>
     *  parameter is negative, the direction of the function is reversed. This can 
     *  be useful for oscillating animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float bounceIn(float t, float direction)
    {
        if (direction < 0)
        {
            // Reverse direction for a return journey.
            return bounceOut(t);
        }
      
        float tPrime = 1-t;
      
        if (tPrime < 0.36364)            // 1/2.75
        {
            return 1- 7.5625f*tPrime*tPrime;
        }
        
        if (tPrime < 0.72727)            // 2/2.75
        {
            return 1- (7.5625f*(tPrime-=0.545454f)*tPrime + 0.75f);
        }
        
        if (tPrime < 0.90909)            // 2.5/2.75
        {
            return 1- (7.5625f*(tPrime-=0.81818f)*tPrime + 0.9375f);
        }
        
        return 1- (7.5625f*(tPrime-=0.95455f)*tPrime + 0.984375f); 
    }
    

    /** Provides a parabolic bouncing easing out function. From t=0 value starts with an
     *  accelerating motion until destination reached then it bounces back in increasingly
     *  small bounces finally settling at 1 when t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float bounceOut(float t)
    {
        return bounceOut(t,1);
    }
      
    /** Provides a reversible parabolic bouncing easing out function. From t=0 value starts with
     *  an accelerating motion until destination reached then it bounces back in increasingly
     *  small bounces finally settling at 1 when t=1. If the <code>direction</code> parameter is
     *  negative, the direction of the function is reversed. This can be useful for oscillating 
     *  animations.
     *  @param t Time value between 0-1.
     *  @param direction Direction of easing, forward if non-negative, or reverse if negative.
     *  @return Eased value at the given time step.
     */
    public static float bounceOut(float t, float direction)
    {
        if (direction < 0)
        {
            // Reverse direction for a return journey.
            return bounceIn(t);
        }
      
        float tPrime = t;
        
        if (tPrime < 0.36364)            // 1/2.75
        {
            return 7.5625f*tPrime*tPrime;
        }
        if (tPrime < 0.72727)            // 2/2.75
        {
            return 7.5625f*(tPrime-=0.545454f)*tPrime + 0.75f;
        }
        if (tPrime < 0.90909)            // 2.5/2.75
        {
            return 7.5625f*(tPrime-=0.81818f)*tPrime + 0.9375f;
        }
        
        return 7.5625f*(tPrime-=0.95455f)*tPrime + 0.984375f; 
    }

    /** Provides an elastic easing in function simulating a 'pinged' elastic. From t=0 value starts
     *  with a large perturbation damping down towards a value of 0.5 as t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float elasticIn(float t)
    {
        if (t <= 0)
        {
            return 0;
        }

        if (t >= 1)
        {
            return 0.5f;
        }

        float p = 0.25f;        // Period
        float a = 1.05f;        // Amplitude.
        float s = 0.0501716f;   // asin(1/a)*p/TWO_PI;
     
        return (float)Math.max(0,0.5 + a*Math.pow(2,-10*t)*Math.sin((t-s)*PConstants.TWO_PI/p));
    }

    /** Provides an elastic easing out function simulating an increasingly agitated elastic. From
     *  t=0 value starts at 0.5 with increasingly large perturbations ending at 1 when t=1.
     *  @param t Time value between 0-1.
     *  @return Eased value at the given time step.
     */
    public static float elasticOut(float t)
    {
        if (t <= 0)
        {
            return 0.5f;
        }

        if (t >= 1)
        {
            return 1;
        }

        float tPrime = 1-t;
        float p = 0.25f;        // Period
        float a = 1.05f;        // Amplitude.
        float s = 0.0501717f;   // asin(1/a)*p/TWO_PI;
     
        return (float)Math.min(1,0.5 - a*Math.pow(2,-10*tPrime)*Math.sin((tPrime-s)*PConstants.TWO_PI/p));
    }
