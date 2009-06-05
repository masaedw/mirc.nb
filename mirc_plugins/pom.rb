# http://www.rubyist.net/~matz/20041028.html#p01

# modified by arm. thanks.

require 'time'

if (!defined?(EPOCH_MINUS_1970))
  EPOCH_MINUS_1970=(20 * 365 + 5 - 1) # 20 years, 5 leaps, back 1 day to Jan 0
  EPSILONg=279.403303         # solar ecliptic long at EPOCH
  RHOg=282.768422             # solar ecliptic long of perigee at EPOCH
  ECCEN=0.016713              # solar orbit eccentricity
  LZERO=318.351648            # lunar mean long at EPOCH
  Pzero=36.340410             # lunar mean long of perigee at EPOCH
  Nzero=318.510107            # lunar mean long of node at EPOCH
end

class Potm
  include Math

  def potm(days)
    n = 360 * days / 365.242191
    n = adj360(n)
    msol = n + EPSILONg - RHOg
    msol = adj360(msol)
    ec = 360 / PI * ECCEN * sin(dtor(msol))
    lambdasol = n + ec + EPSILONg
    lambdasol = adj360(lambdasol)
    l = 13.1763966 * days + LZERO
    l = adj360(l);
    mm = l - (0.1114041 * days) - Pzero
    mm = adj360(mm);
    nm = Nzero - (0.0529539 * days)
    nm = adj360(nm);
    ev = 1.2739 * sin(dtor(2*(l - lambdasol) - mm))
    ac = 0.1858 * sin(dtor(msol))
    a3 = 0.37 * sin(dtor(msol))
    mmprime = mm + ev - ac - a3
    ec = 6.2886 * sin(dtor(mmprime))
    a4 = 0.214 * sin(dtor(2 * mmprime))
    lprime = l + ev + ec - ac + a4
    v = 0.6583 * sin(dtor(2 * (lprime - lambdasol)))
    ldprime = lprime + v
    d = ldprime - lambdasol
    #    return(50.0 * (1 - cos(dtor(d))))
    return adj360(d - 6) # '6':adjust value
  end

  def dtofull(deg)
    return(50.0 * (1 - cos(dtor(deg))))
  end

  def dtor(deg)
    deg * Math::PI / 180
  end

  def adj360(deg)
    loop do
      if (deg < 0)
        deg += 360;
      elsif (deg > 360)
        deg -= 360;
      else
        return deg
      end
    end
  end
end

def pom_desc
  "pom>: 月の満ち欠けを知ります。"
end

def pom(msg)
  p = Potm.new
  tmpt = (ARGV[0] ? Time.parse(ARGV[0]) : Time.now).to_i
  days = (tmpt - EPOCH_MINUS_1970 * 86400) / 86400.0
  sprintf "%1.0f%% full", p.potm(days) + 0.5
  #  sprintf "%1.0f%% full", p.potm(days) + 0.5
  d = p.potm(days)
  sprintf "%1.1f days, %1.1f%% full", d * 30.0 / 360.0, p.dtofull(d) + 0.05
end
