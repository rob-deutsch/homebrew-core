class FasthenryWr < Formula
  desc "3D inductance computation program which handles superconducting conductors"
  homepage "http://www.wrcad.com/freestuff.html"
  url "http://www.wrcad.com/ftp/pub/fasthenry-3.0wr-071720.tar.gz"
  version "3.0-071720"
  sha256 "161943c7d63ac3cf7b615b048a33ed77a0d12164fde461859e34b61ca4e63a73"
  license "MIT"

  def install
    system "make", "all"
    bin.install "bin/fasthenry"
  end

  test do
    (testpath/"test.inp").write <<~EOS
      .units m
      .default sigma=5.8e7

      g1 x1=-10 y1=-10 z1=0 x2=11 y2=-10 z2=0 x3=11 y3=11 z3=0
      + file=NONE thick=0.01
      + contact decay_rect (1,1,0,0.2,0.2,0.1,0.1,20,20)
      *+ contact rect (1,1,0,0.5,0.5,0.1,0.1)
      *+ contact line (-2,-2,0,5,2,0,1,1)
      *+ contact point (1,1,0,0.1,0.1)
      + n_in (0.0,0,0)
      + n_out (1.0,1,0)

      .external n_in n_out
      .freq fmin=0 fmax=1e9 ndec=1
      .end
    EOS
    system bin/"fasthenry", "test.inp"
  end
end
