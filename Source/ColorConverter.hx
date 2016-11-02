package ;

class ColorConverter 
{

    public static inline function toRGB(int:Int) : RGB
    {
        return {
            r: ((int >> 16) & 255) / 255,
            g: ((int >> 8) & 255) / 255,
            b: (int & 255) / 255,
        }
    }
    
    public static function rgb2hsv(rgb:RGB) : HSV
    {
        var max:Float = maxRGB(rgb);
        var min:Float = minRGB(rgb);
        var add:Float = max + min;
        var sub:Float = max - min;
        
        var h:Float = 0;
        var s:Float = 0;
        var v:Float = 0;

        // H
        if (max == min)
            h = 0;
        else if (max == rgb.r)
            h = (60 * (rgb.g - rgb.b) / sub + 360) % 360;
        else if (max == rgb.g)
            h = 60 * (rgb.b - rgb.r) / sub + 120;
        else if (max == rgb.b)
            h = 60 * (rgb.r - rgb.g) / sub + 240;
        
        // S
        if (max == 0)
            s = 0;
        else
            s = 1 - min / max;

        // V
        v = max;
        
        return {
            h: h,
            s: s,
            v: v,
        }
    }
    
    public static inline function maxRGB(rgb:RGB) : Float
    {
        return Math.max(rgb.r, Math.max(rgb.g, rgb.b));
    }
    
    public static inline function minRGB(rgb:RGB) : Float
    {
        return Math.min(rgb.r, Math.min(rgb.g, rgb.b));
    }
}

typedef RGB = {
    var r:Float;
    var g:Float;
    var b:Float;
}

typedef HSL = {
    var h:Float;
    var s:Float;
    var l:Float;
}

typedef HSV = {
    var h:Float;
    var s:Float;
    var v:Float;
}