//1:黒
//2:青
//3:緑
//4:水色
//5:赤
//6:紫
//7:黄
//8:白
//9:紺


geodata = fromJSON("N03-19_09_190101.geojson","file");


//figure
//hold on

i = 1;
outline = geodata.features(i).geometry.coordinates;

if type(outline) == 15
  for j = 1:length(outline)
    lng = outline(j)(:,1);
    lat = outline(j)(:,2); 
    //plot(lng,lat,'Color',[0 0 0],'LineWidth',3);
    xfpoly(lng,lat,3);
  end
else
  lng = outline(:,1);
  lat = outline(:,2);
  
  poly_lng = lng;
  poly_lat = lat;
  
  
  //plot(lng,lat,'Color',[0 0 0],'LineWidth',3);
  xfpoly(lng,lat,3);
end


//宇都宮以外のポリゴンを表示
for i = 2:length(geodata.features)
  outline = geodata.features(i).geometry.coordinates;

  //disp(length(outline));
  //disp(type(outline));
	
  if type(outline) == 15
	for j = 1:length(outline)
		lng = outline(j)(:,1);
		lat = outline(j)(:,2);

		poly_lng = [poly_lng;lng];
  		poly_lat = [poly_lat;lat];

		//plot(lng,lat);
    end
  else
    lng = outline(:,1);
    lat = outline(:,2);
    
    poly_lng = [poly_lng;lng];
  	poly_lat = [poly_lat;lat];
    
    //plot(lng,lat);
  end
end


//ポリゴンを一つにしたいけどやり方不明
/*
unique_lng = unique(poly_lng);

for i = 1:length(unique_lng)
	unique_lat_min(i) = 1000;//1000より北緯は必ず小さい
	unique_lat_max(i) = 0;//0より北緯は必ず大きい
end

for i = 1:length(unique_lng)
	//何らかの方法でunique_lngのインデックスを探す
	j = find(poly_lng == unique_lng(i));
	//jが複数ある場合がある
	if unique_lat_min(i) > poly_lat(j(1))
		unique_lat_min(i) = poly_lat(j(1));
	end
	
	if unique_lat_max(i) < poly_lat(j(1))
		unique_lat_max(i) = poly_lat(j(1));
	end
end
*/


/*
%tochigi pref office
%DMS(Degree Minute Second) format
%139°53′01″
%36°33′57″
dms_lng = [139,53,01];
dms_lat = [36,33,57];
deg_lng = dms_lng(1) + dms_lng(2)/60 + dms_lng(3)/3600;
deg_lat = dms_lat(1) + dms_lat(2)/60 + dms_lat(3)/3600;
plot(deg_lng,deg_lat,'o');


hold off

%kanuma city office
%139°44′42″
%36°34′02″
%dms_lng = [139,44,42];%kanuma
%dms_lat = [36,34,02];%kanuma
%deg_lng = dms_lng(1) + dms_lng(2)/60 + dms_lng(3)/3600;
%deg_lat = dms_lat(1) + dms_lat(2)/60 + dms_lat(3)/3600;

target_lng = deg_lng;
target_lat = deg_lat;

outline = geodata.features(1).geometry.coordinates;
utsunomiya_lng = outline(:,1);
utsunomiya_lat = outline(:,2);

in_utsunomiya = inpolygon(target_lng,target_lat,utsunomiya_lng,utsunomiya_lat);
disp(in_utsunomiya);
*/



