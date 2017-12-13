require "rmagick"
require 'digest/md5'

include Magick
w=ARGV[0].to_i
h=ARGV[1].to_i
img = Image.new(w,h)
random=Random.new

split_num=4

require_code=ARGV[2]
hashed_code=Digest::MD5.digest(require_code)

r=0
g=0
b=0
c=0
hashed_code.each_byte do |byte|
  case c
  when 0 then r=byte
  when 1 then g=byte
  when 2 then b=byte
  end
  c=c+1
end



t=[r,g,b].max+[r,g,b].min
color = Magick::Pixel.new((r-t).abs*256,(g-t).abs*256,(b-t).abs*256)
for nh in 0..h
  for nw in 0..w
    img.pixel_color(nw,nh,color)
  end
end


#ランダムで資格を生成、使えない
#for x in 0...10
#  sh=random.rand(0 .. h)
#  sw=random.rand(0 .. w)
#  eh=random.rand(sh..h)
#  ew=random.rand(sw..w)
#  color = Magick::Pixel.new(random.rand(1..255)*256,random.rand(1..255)*256,random.rand(1..255)*256)
#  for nh in sh..eh
#    for nw in sw..ew
#      img.pixel_color(nw,nh,color)
#    end
#  end
#end

sh=0
sw=0
eh=sh+h/split_num
ew=sw+w/split_num
c=0
hashed_code.each_byte do |byte|
  #  printf("%d %d\n",sh,sw)
  if byte%2==1
    color = Magick::Pixel.new(r*256,g*256,b*256)
    for nh in sh..eh
      for nw in sw..ew
        img.pixel_color(nw,nh,color)
      end
    end
  end
  if c%4==0
    sw=0
    sh=eh
  else
    sw=ew
  end
  ew=sw+w/split_num
  eh=sh+h/split_num
  c=c+1
end

img.write("base1.jpg")
img_flop=img.flop
img_flip=img.flip
img_flip_flop=img_flop.flip
img_flop.write("base2.jpg")
img_flip.write("base3.jpg")
img_flip_flop.write("base4.jpg")

up_img = Magick::ImageList.new("base1.jpg","base2.jpg")
up_img=up_img.append(false)
up_img.write("base5.jpg")
down_img = Magick::ImageList.new("base3.jpg","base4.jpg")
down_img=down_img.append(false)
down_img.write("base6.jpg")

last_img = Magick::ImageList.new("base5.jpg","base6.jpg")
last_img=last_img.append(true)
last_img.write("res.jpg")

resize_img=Magick::Image.read("res.jpg").first
resize_img=resize_img.resize(w,h);
resize_img.write("res.jpg")
#finalize
for x in 1..6
  File.delete("./base#{x}.jpg")
end

